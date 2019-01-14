#lang at-exp racket

(provide crafting-menu-set!
         custom-crafter
         custom-npc
         custom-coin
         custom-food
         entity-cloner)

(require scribble/srcdoc)

(require (for-doc racket/base scribble/manual ))

(require ts-kata-util)

(require (except-in game-engine
                    change-health-by)
         game-engine-demos-common)

;(require "../scoring/score.rkt")

(define-syntax-rule (define/log l head body ...)
  (define head
    (let ()
      (displayln l)
      body ...)))


(define (WIDTH)       480)
(define (HEIGHT)      360)
(define (TOTAL-TILES) 9)

(define sprite? (or/c image? animated-sprite?))

(define rarity-level?
  (or/c 'common 'uncommon 'rare 'epic 'legendary))

(define fire-mode?    (or/c 'normal 'random 'spread 'homing))

; === ENTITY DEFINITIONS ===
(define (plain-bg-entity)
  (bg->backdrop-entity (rectangle 48 36 ;Can even be smaller...
                                  'solid 'darkgreen) 
                       #:scale 30))

; === EXAMPLE GAME DIALOG ===
(define (player-dialog)
  (list "Hello. What's your name?"
        "I'm lost and hungry, can you help me?"))

; Responses must have the same number of lists as items in the player-dialog
(define (npc1-response)
  (list (list "Oh, hello! My name is Jordan!"
              "It's dangerous out here."
              "You should be careful.")
        (list "Sorry, I don't have any food to spare."
              "If you look around though,\nyou might find carrots.")  ))

(define (npc1-response-sprites)
  (dialog->response-sprites npc1-response
                            #:game-width (WIDTH)
                            #:animated #t
                            #:speed 4))

(define (instructions-entity #:move-keys  [move-keys "ARROW KEYS"]
                             #:mouse-aim? [mouse-aim? #f])

  (define (instruction->sprite text offset)
    (new-sprite text #:y-offset offset #:color 'yellow))

  (define i-list (filter identity (list (~a move-keys " to move")
                                        (if mouse-aim?
                                            "MOVE MOUSE to aim"
                                            #f)
                                        "SPACE to interact/use"
                                        "ENTER to close dialogs"
                                        "I to open these instructions"
                                        "Z to pick up items"
                                        "X to drop items")))
  (define i-length (length i-list))
  
  (define bg (new-sprite (rectangle 1 1 'solid (make-color 0 0 0 100))))
  
  (define i
    (sprite->entity (~> bg
                        (set-x-scale 340 _)             
                        (set-y-scale (* 25 i-length) _) 
                        (set-y-offset 0 _))             
                    #:position   (posn 0 0)
                    #:name       "instructions"
                    #:components (layer "ui")
                                 (hidden)
                                 (on-start (do-many (go-to-pos 'center)
                                                    show))
                                 (on-key 'enter die)
                                 (on-key 'space die)
                                 (on-key "i" die)))

  (define last-y-pos (* 20 i-length))

  (add-components i (map instruction->sprite i-list (range (- (/ last-y-pos 2)) (/ last-y-pos 2) 20))
                  ))
     
; ==== NEW HELPER SYSTEMS ====
; todo: maybe put this in game-engine?
(define (entity-cloner entity amount)
  (map (thunk*
        (if (procedure? entity) (entity)
            (clone-entity entity) ))
       (range amount)))

(define/contract (clone-by-amount-in-world es)
  (-> (listof (or/c entity? procedure?)) (listof entity?))

  (define (f e)
    (define to-clone (if (procedure? e)
                         (e)
                         e) )
    
    (define n (if (get-storage "amount-in-world" to-clone)
                  (get-storage-data "amount-in-world" to-clone)
                  1))
    (entity-cloner  e n))

  (flatten (map f es)))

; ==== BORDERLANDS STYLE POP UPS =====
; todo: add to game-engine?
#|(define (go-to-entity name #:offset [offset (posn 0 0)])
  (lambda (g e)
    (define target? (get-entity name g))
    (if target?
        (update-entity e posn? (posn-add (get-component target? posn?) offset))
        e)))|#

#|(define (text/shadow message size color)
  (overlay/offset (freeze (text/font message size color "Arial" 'default 'normal 'normal #f))
                  -1 1
                  (freeze (text/font message size "black" "Arial" 'default 'normal 'normal #f))))|#

(define (player-toast-entity message #:color [color "yellow"])
  (define color-symbol (if (string? color)
                           (string->symbol color)
                           color))
  (sprite->entity (new-sprite message #:x-offset -1 #:y-offset 1 #:color 'black)
                  #:name       "player toast"
                  #:position   (posn 0 0)
                  #:components (hidden)
                               (layer "ui")
                               (new-sprite message #:color color-symbol)
                               (direction 270)
                               ;(physical-collider)
                               (speed 3)
                               (on-start (do-many (go-to-entity "player" #:offset (posn 0 -20))
                                                  (random-direction 240 300)
                                                  (random-speed 2 4)
                                                  show))
                               (every-tick (do-many (move)
                                                    (scale-sprite 1.05)))
                               (after-time 15 die)))


(define (has-gold? amount)
  (lambda (g e)
    (define gold (get-counter (get-entity "score" g)))
    (>= gold amount)))



; === WON AND LOST RULES ===
(define (won? g e)
  #f)

(define (kill-player-v2)
  (lambda (g e1 e2)
    ;(define dead-player-image (rotate -90 (pick-frame-original (get-component e2 animated-sprite?) 0)))
    
    (if (lost? g e2)
        ((do-many remove-on-key
                  (stop-animation)
                  ;(change-sprite (new-sprite dead-player-image))
                  (rotate-sprite 90)
                  ) g e2)
        e2)))

(define (lost? g e)
  (define player (get-entity "player" g))
  (define health (get-stat "health" player))
  (<= health 0))

;(define (lost? g e)
;  (and e
;       (health-is-zero? g e)))
    
(define (food->component f #:use-key [use-key 'space] #:max-health [max-health 100])
  (define item-name (get-name f))
  (define heal-amount (get-storage-data "heals-by" f))
  (if heal-amount
      (on-key use-key #:rule (and/r (player-is-near? item-name)
                                (nearest-entity-to-player-is? item-name))
          (do-many (change-health-by heal-amount #:max max-health)
                   (spawn (player-toast-entity (~a "+" heal-amount) #:color "green"))))
      #f))

(define (coin->component c #:use-key [use-key 'space])
  (define coin-name (get-name c))
  (define coin-value (get-storage-data "value" c))
  (define coin-toast-entity
    (player-toast-entity (~a "+" coin-value " GOLD")))

  
  (if coin-value
      (list 
            ;(precompiler coin-toast-entity)
         ;   (apply precompiler (map (λ (num) (draw-dialog (~a "Gold: " num))) (range 0 (add1 (* 100 coin-value)) coin-value)))
            (on-key use-key #:rule (and/r (player-is-near? coin-name)
                                          (nearest-entity-to-player-is? coin-name #:filter (has-component? on-key?)))
                    (do-many (change-counter-by coin-value)
                             (draw-counter-rpg #:prefix "Gold: ")
                             (spawn coin-toast-entity))))
      #f))

(define/contract/doc
  (custom-avatar #:sprite     [sprite (circle 10 'solid 'red)]
                 #:damage-processor [dp (filter-damage-by-tag #:filter-out '(friendly-team passive)
                                                              #:show-damage? #t
                                                              )]
                 #:position   [p   (posn 100 100)]
                 #:speed      [spd 10]
                 #:key-mode   [key-mode 'arrow-keys]
                 #:mouse-aim? [mouse-aim? #f]
                 #:components [c #f]
                               . custom-components)
  (->i ()
       (#:sprite [sprite sprite?]
        #:damage-processor [damage-processor damage-processor?]
        #:position [position posn?]
        #:speed [speed number?]
        #:key-mode [key-mode (or/c 'wasd 'arrow-keys)]
        #:mouse-aim? [mouse-aim boolean?]
        #:components [first-component component?]
        )
       #:rest (rest (listof component?))
       [returns entity?])

  @{Returns a custom avatar...}
  
  (define dead-frame (if (image? sprite)
                         (rotate -90 sprite)
                         (rotate -90 (render sprite))))
  (define base-avatar
    (sprite->entity sprite
                  #:name       "player"
                  #:position   p
                  #:components (physical-collider)
                               (sound-stream)
                               (damager 10 (list 'passive 'friendly-team))
                               ;(precompiler dead-frame)
                               (key-movement spd #:mode key-mode #:rule (and/r all-dialog-closed?
                                                                               (not/r lost?)))
                               (key-animator-system #:mode key-mode #:face-mouse? mouse-aim?)
                               (stop-on-edge)
                               (backpack-system #:components (observe-change backpack-changed? update-backpack))
                               (player-edge-system)
                               (observe-change lost? (kill-player-v2))
                               (counter 0)
                               (on-key 'enter #:rule player-dialog-open? (get-dialog-selection))
                               (on-rule (not/r all-dialog-closed?) (stop-movement))
                               (cons c custom-components)))
  (define health-bar (stat-progress-bar 'red
                                        #:width 100
                                        #:height 10
                                        #:max 100 
                                        #:after (λ(e) (~> e
                                                          (remove-component _ lock-to?)
                                                          (remove-component _ active-on-bg?)
                                                          (add-component _
                                                                         (on-start
                                                                          (go-to-pos-inside 'top-left
                                                                                            #:posn-offset (posn 10 20))))))))

  (define sheild-bar (stat-progress-bar 'blue
                                        #:width 100
                                        #:height 10
                                        #:max 100
                                        #:after (λ(e) (~> e
                                                          (remove-component _ lock-to?)
                                                          (remove-component _ active-on-bg?)
                                                          (add-component _
                                                                         (on-start
                                                                          (go-to-pos-inside 'top-left
                                                                                            #:posn-offset (posn 10 10))))))))

  (combatant
   #:stats (list (make-stat-config 'health 100 health-bar)
                 ;(make-stat-config 'shield 100 sheild-bar)
                 )
   #:damage-processor dp         
   base-avatar)
  )

(define/contract/doc (custom-weapon        #:name        [n "Repeater"]
                                           #:sprite      [s chest-sprite]
                                           #:dart        [b (custom-dart)]
                                           #:fire-mode   [fm 'normal]
                                           #:fire-rate   [fr 3]
                                           #:fire-key    [key 'f]
                                           #:mouse-fire-button [button 'left]
                                           #:point-to-mouse?   [ptm? #t]
                                           #:rapid-fire?       [rf? #t]
                                           #:rarity      [rarity 'common])
  (->i ()
       (#:name        [name string?]
        #:sprite      [sprite sprite?]
        #:dart      [dart entity?]
        #:fire-mode   [fire-mode fire-mode?]
        #:fire-rate   [fire-rate number?]
        #:fire-key    [fire-key symbol?]
        #:mouse-fire-button [button (or/c 'left 'right)]
        #:point-to-mouse?   [ptm? boolean?]
        #:rapid-fire?       [rf? boolean?]
        #:rarity      [rarity rarity-level?])
       [result entity?])

  @{Returns a custom weapon}


  (define updated-name (cond [(eq? rarity 'rare)      (~a "Rare " n)]
                             [(eq? rarity 'epic)      (~a "Epic " n)]
                             [(eq? rarity 'legendary) (~a "Legendary " n)]
                             [else n]))

  (define (add-tag-to-entity e tag)
    (define damager (get-component e damager?))
    (update-entity e damager? (add-damager-tag damager tag)))

  (define weapon-component (custom-weapon-system #:dart (add-tag-to-entity b (string->symbol updated-name))
                                                 #:fire-mode fm
                                                 #:fire-rate fr
                                                 #:fire-key  key
                                                 #:mouse-fire-button button
                                                 #:point-to-mouse? ptm?
                                                 #:rapid-fire? rf?
                                                 #:rule (and/r (weapon-is? updated-name)
                                                               (in-backpack? updated-name))))
  (sprite->entity s
                  #:name updated-name
                  #:position    (posn 0 0)
                  #:components  (active-on-bg 0)

                                (physical-collider)
                                (storage "Weapon" weapon-component)
                                (storage "Rarity" rarity)

                                (static)
                                (hidden)
                                (on-start (do-many (respawn 'anywhere)
                                                   (active-on-random)
                                                   show))
                                (storable)))

; ==== START OF CUSTOM ENEMY FUNCTIONS ====
(define (wander-but-defend #:weapon (weapon (custom-weapon))
                           #:range (range 150)
                           #:wander-speed (wspeed 1)
                           #:ticks-between-shots (ticks-between-shots 50))
  
  (define wander (apply state 'wander (wander-mode-components wspeed)))
  (define stand  (apply state 'stand (stand-and-shoot "player" weapon
                                                      #:ticks-between-shots ticks-between-shots)))

  (define wander->stand
    (transition #:rule (near? "player" range)
                wander stand))

  (define stand->wander
    (transition #:rule (not/r (near? "player" range))
                stand wander))
  
  (define ai-machine
    (state-machine wander
                   (list wander stand)
                   (list wander->stand stand->wander)))

  ai-machine)

(define (wander-mode-components spd)
  (list 
   (every-tick (move))
   (speed spd)
   (do-every 50 (random-direction 0 360))
   (on-edge 'left   (set-direction 0))
   (on-edge 'right  (set-direction 180))
   (on-edge 'top    (set-direction 90))
   (on-edge 'bottom (set-direction 270))))

(define (stand-and-shoot target w #:ticks-between-shots (ticks-between-shots 50))
  (list (speed 0)
        (use-weapon-against-player w #:ticks-between-shots ticks-between-shots)
        (every-tick (point-to target))))


(define (get-ai-from-level l weapon)
  (match l
    ['easy   (wander-but-defend #:weapon weapon
                                #:range 100
                                #:ticks-between-shots 50
                                #:wander-speed 1)]
    ['medium (wander-but-defend #:weapon weapon
                                #:range 150
                                #:ticks-between-shots 25
                                #:wander-speed 2)]
    ['hard   (wander-but-defend #:weapon weapon
                                #:range 200
                                #:ticks-between-shots 10
                                #:wander-speed 3)]))


(define (ai-level? v)
  (or/c 'easy 'medium 'hard))

(define/contract/doc (custom-enemy #:amount-in-world (amount-in-world 1)
                                   #:sprite (s (first (shuffle (list slime-sprite bat-sprite snake-sprite))))
                                   #:ai (ai-level 'medium)
                                   #:health (health 99)
                                   ;#:shield (shield 100)
                                   #:weapon (weapon (custom-weapon #:name "Spitter"
                                                                   #:dart (acid)))
                                   #:death-particles (particles (custom-particles))
                                   #:components (c #f)
                                   . custom-components
                                   )

  (->i () (#:amount-in-world [amount-in-world positive?]
           #:sprite [sprite sprite?]
           #:ai [ai ai-level?]
           #:health [health positive?]
           ;#:shield [shield positive?]
           #:weapon [weapon entity?]
           #:death-particles [death-particles entity?]
           #:components [first-component any/c])
       #:rest [more-components (listof any/c)]
       [returns entity?])

  @{Creates a custom enemy that can be used in the enemy list
         of @racket[survival-game].}
  

  
 
  ;Makes sure that we can run (custom-enemy) through (entity-cloner ...)
  ;  Works because combatant ids get assigned at runtime.
  ;(Otherwise, they'd all end up with the same combatant id, and a shared healthbar)
  (define (become-combatant g e)

    (define c (~> e
                  (combatant
                   #:stats (list (make-stat-config 'health health (stat-progress-bar 'red #:max health #:offset (posn 0 -15)))) ;(default-health+shields-stats health shield)
                   #:damage-processor (filter-damage-by-tag #:filter-out '(passive enemy-team))
                             _)
                  ))
 
    c)
  
  (define death-broadcast
    (sprite->entity empty-image
                    #:name "Enemy Death Broadcast"
                    #:position (posn 0 0)
                    #:components (on-start die)))
  
  (define (die-if-health-is-0)
    (on-rule (λ(g e)
               (define h (get-storage-data "health-stat" e))
               (and h (<= h 0)))
             (do-many
              (spawn-on-current-tile particles)
              (spawn death-broadcast)
              (λ(g e)
                (add-component e (after-time 2 die)))
              )))

  
  (custom-combatant #:name "Enemy"
                    #:sprite s
                    #:position (posn 0 0)
                    #:mode #f
                    ;#:components 

                    ;What is making these guys slow???
                    (die-if-health-is-0)
                    (damager 10 (list 'passive 'enemy-team 'bullet))
                    (hidden)
                    ;(active-on-bg 0) ;Don't leave this in
                    (on-start (do-many (respawn 'anywhere)
                                       (active-on-random)
                                 
                                       show
                                       become-combatant
                                       ))

                    ;Need to face player when attacking...

                    (storage "amount-in-world" amount-in-world)

                    (enemy-ai (get-ai-from-level ai-level (get-storage-data "Weapon" weapon)))
                    ;(enemy-ai (get-ai-from-level ai-level weapon))
                    (cons c custom-components)
                    ))


(define (custom-combatant #:sprite     [s (row->sprite (random-character-row) #:delay 4)]
                          #:position   [p (posn 0 0)]
                          #:name       [name (first (shuffle (list "Adrian" "Alex" "Riley"
                                                                   "Sydney" "Charlie" "Andy")))]
                          #:tile       [tile 0]
                          #:mode       [mode 'wander]
                          #:game-width [GAME-WIDTH 480]
                          #:speed      [spd 2]
                          #:target     [target "player"]
                          #:sound      [sound #t]
                          #:scale      [scale 1]
                          #:components [c #f] . custom-components )

  (define sprite (if (image? s)
                     (new-sprite s)
                     s))

  (sprite->entity sprite
                  #:name name
                  #:position p
                  #:components
                  (active-on-bg tile)
                  (speed spd)
                  (direction 0)
                  (rotation-style 'left-right)
                  (cons c custom-components)))

; ==== END OF CUSTOM ENEMY FUNCTIONS ====


(define/contract/doc
  (survival-game #:headless        [headless #f]
                 #:bg              [bg-ent (plain-bg-entity)]
                 #:avatar          [p         #f #;(custom-avatar)]
                 #:starvation-rate [sr 50]
                 #:npc-list        [npc-list  '() #;(list (random-npc (posn 200 200)))]
                 #:enemy-list      [e-list (list (custom-enemy))]
                 #:coin-list       [coin-list '() #;(list (coin #:entity (coin-entity) #:amount-in-world 10))]
                 #:food-list       [f-list    '() #;(list (food #:entity (carrot-entity) #:amount-in-world 10)
                                                         (food #:entity carrot-stew #:heals-by 20))]
                 #:crafter-list    [c-list    '() #;(list (custom-crafter))]
                 #:other-entities  [ent #f]
                                   . custom-entities)
  (->i ()
       (#:headless [headless boolean?]
        #:bg [bg entity?]
        #:avatar [avatar entity?]
        #:starvation-rate [starvation-rate number?]
        #:npc-list   [npc-list     (listof (or/c entity? procedure?))]
        #:enemy-list [enemy-list   (listof (or/c entity? procedure?))]
        #:coin-list  [coin-list    (listof (or/c entity? procedure?))]
        #:food-list  [food-list   (listof (or/c entity? procedure?))]
        #:crafter-list [crafter-list (listof (or/c entity? procedure?))]
        #:other-entities [other-entities (or/c #f entity?)])
       #:rest [rest (listof entity?)]
       [res () game?])

  @{The top-level function for the surival-game language.
         Can be run with no parameters to get a basic, default game
         with nothing in it!}
  
  (define move-keys (if (and p (eq? (get-key-mode p) 'wasd))
                        "WASD KEYS"
                        "ARROW KEYS"))

  (define (mouse-aim-component? c)
    (and (on-rule? c)
         (eq? (on-rule-rule? c) mouse-in-game?)
         (eq? (on-rule-func c) point-to-mouse)))

  (define mouse-aim? (and p
                          (get-component p mouse-aim-component?)))

  (define bg-with-instructions
    (add-components bg-ent (on-key "i" #:rule (λ (g e) (not (get-entity "instructions" g)))
                                   (spawn (instructions-entity #:move-keys move-keys
                                                               #:mouse-aim? mouse-aim?)
                                          #:relative? #f))))

  (define (food->toast-entity f)
    (define heal-amt (get-storage-data "heals-by" f))
    (player-toast-entity (~a "+" heal-amt) #:color "green"))

  (define starvation-period (max 1 (- 100 (min 100 sr))))

  (define food-img-list (map (λ (f) (render (get-component f animated-sprite?))) f-list))
  
  (define player-with-recipes
    (if p
        (add-components p (map recipe->system known-recipes-list)
                          ;(precompiler (player-toast-entity "-1" #:color "orangered"))
                          ;(apply precompiler (map food->toast-entity f-list))
                          ;(apply precompiler f-list)
                          (map food->component f-list)
                          (do-every starvation-period
                                    (do-many (change-health-by -1)
                                             (spawn (player-toast-entity "-1" #:color "orangered") #:relative? #f))))
        #f))

  (define (add-random-start-pos e)
    (define world-amt (get-storage-data "amount-in-world" e))
    (if (> world-amt 0) 
        (add-components e (hidden)
                          (on-start (do-many (active-on-random)
                                             (respawn 'anywhere)
                                             show)))
        e))

  

  
  #;(define (health-entity)
    (define max-health 100)

    (define e (health-bar-entity #:max 100
                                 #:starvation-period starvation-period
                                 #:change-by         -1))

    (~> e
        (update-entity _ posn? (posn 100 20))
        (add-components _
                        ;(precompiler (player-toast-entity "-1" #:color "orangered"))
                        ;(apply precompiler (map food->toast-entity f-list))
                        ;(apply precompiler f-list)
                       ; (precompiler all-backpack-stacks)
                        (map food->component f-list)
                        (do-every starvation-period
                                  (spawn (player-toast-entity "-1" #:color "orangered") #:relative? #f)))))

  (define (score-entity)
    (define bg (~> (rectangle 1 1 'solid (make-color 0 0 0 100))
                   (new-sprite _ #:animate #f)
                   (set-x-scale 75 _)
                   (set-y-scale 14 _)
                   ))
    
    (sprite->entity bg
                    #:name       "score"
                    #:position   (posn 380 20)
                    #:components (static)
                                 (new-sprite "Gold: 0" #:y-offset -7 #:scale 0.7 #:color 'yellow)
                                 (counter 0)
                                 (layer "ui")
                                 (map coin->component coin-list)))
  
  (define updated-food-list (map add-random-start-pos f-list))
  (define updated-coin-list (map add-random-start-pos coin-list))
  
  (define es (filter identity
                     (flatten
                      (list
                       (instructions-entity #:move-keys move-keys
                                            #:mouse-aim? mouse-aim?)
                       (if p (game-over-screen won? lost?) #f)
                       (if p (score-entity) #f)

                       ;(if p (health-entity) #f)

                       player-with-recipes
              
              
                       ;(pine-tree (posn 400 140) #:tile 2)
                       ;(pine-tree (posn 93 136) #:tile 4)
                       ;(round-tree (posn 322 59) #:tile 4)

                       npc-list
              
                       c-list
              
                       ;(map (λ (c) (entity-cloner c (get-storage-data "amount-in-world" c))) updated-coin-list)
                       ;(map (λ (f) (entity-cloner f (get-storage-data "amount-in-world" f))) updated-food-list)
                       
                       (clone-by-amount-in-world updated-coin-list)
                       (clone-by-amount-in-world updated-food-list)
                       (clone-by-amount-in-world e-list)

                       (cons ent custom-entities)
              
                       bg-with-instructions))))


  ;(displayln (~a "Score estimation for your game: " (score-game es)))
  
  (if headless
      (initialize-game es)
      (apply start-game es))
  
  )

#|(define/log "food"
  (food #:entity [entity (carrot-entity)] #:heals-by [heal-amt 5] #:amount-in-world [world-amt 0])
  (list entity heal-amt world-amt))

(define/log "coin"
  (coin #:entity entity #:value [val 10] #:amount-in-world [world-amt 10])
  (list entity val world-amt))
|#

(define known-recipes-list '())

(define/log "crafting-menu-set!"
  (crafting-menu-set! #:open-key     [open-key 'space]
                      #:open-sound   [open-sound #f]
                      #:select-sound [select-sound #f]
                      #:recipes r
                      . recipes)
  (set! known-recipes-list (append (cons r recipes) known-recipes-list))
  (crafting-menu #:open-key open-key
                 #:open-sound open-sound
                 #:select-sound select-sound
                 #:recipes r
                           recipes))

(define default-crafting-menu
  (crafting-menu-set! #:recipes (recipe #:product (carrot-stew-entity)
                                        #:build-time 30
                                        #:ingredients (list "Carrot"))))

(define (custom-crafter #:position   [p (posn 100 100)]
                        #:tile       [t 0]
                        #:name       [name "Crafter"]
                        #:sprite     [sprite cauldron-sprite]
                        #:menu       [menu  default-crafting-menu]
                        #:components [c #f] . custom-components)
  (crafting-chest p
                  #:sprite sprite
                  #:name   name
                  #:components (active-on-bg t)
                               (counter 0)
                               menu
                               (cons c custom-components)))


(define (custom-npc #:sprite     [s (row->sprite (random-character-row) #:delay 4)]
                    #:position   [p (posn 0 0)]
                    #:name       [name (first (shuffle (list "Adrian" "Alex" "Riley"
                                                             "Sydney" "Charlie" "Andy")))]
                    #:tile       [tile 0]
                    #:dialog     [d  #f]
                    #:mode       [mode 'wander]
                    #:game-width [GAME-WIDTH 480]
                    #:speed      [spd 2]
                    #:target     [target "player"]
                    #:sound      [sound #t]
                    #:scale      [scale 1]
                    #:components [c #f] . custom-components )
  
  (define dialog
    (if (not d)
        (dialog->sprites (first (shuffle (list (list "It's dangerous out here!")
                                               (list "You should find food to survive.")
                                               (list "Sorry, I don't have time to talk now.")
                                               (list "I'm hungry..."))))
                     #:game-width GAME-WIDTH
                     #:animated #t
                     #:speed 4)
        (if (string? (first d))
            (dialog->sprites d
                             #:game-width GAME-WIDTH
                             #:animated #t
                             #:speed    4)
            (dialog->response-sprites d
                                      #:game-width GAME-WIDTH
                                      #:animated #t
                                      #:speed 4))))
  
  (define sprite (if (image? s)
                     (new-sprite s)
                     s))
  
  (create-npc #:sprite      sprite
              #:name        name
              #:position    p
              #:active-tile tile
              #:dialog      dialog
              #:mode        mode
              #:speed       spd
              #:target      target
              #:sound       sound
              #:scale       scale
              #:components  (cons c custom-components)))

(define/contract/doc (custom-background #:bg-img     [bg FOREST-BG]
                                        #:rows       [rows 3]
                                        #:columns    [cols 3]
                                        #:start-tile [t 0]
                                        #:components [c #f]
                                        . custom-components)

  (->i ()
       (#:bg-img [bg-img image?]
        #:rows   [rows number?]
        #:columns [columns number?]
        #:start-tile [start-tile number?]
        #:components [first-component component?])
       #:rest [more-components (listof component?)]
       [result entity?])

  @{Returns a custom background}
  

  (bg->backdrop-entity (scale 0.25 bg)
                       #:rows       rows
                       #:columns    cols
                       #:start-tile t
                       #:scale 4))

(define (safe-update-entity e component-pred f)
  (if f
      (update-entity e component-pred f)
      e))

(define (custom-food #:entity           [base-entity (carrot-entity)]
                     #:sprite           [s #f]
                     #:position         [p #f]
                     #:name             [n #f]
                     #:tile             [t #f]
                     #:amount-in-world  [world-amt 0]
                     #:heals-by         [heal-amt 10]
                     #:respawn?         [respawn? #t]
                     #:components       [c #f]
                                        . custom-entities)
  (define sprite (cond [(image? s)           (new-sprite s)]
                       [(animated-sprite? s) s             ]
                       [else              #f]))
  (define name   (if n (entity-name n) #f))
  (define tile   (if t (active-on-bg t) #f))
  (define new-entity (~> base-entity
                         (safe-update-entity _ animated-sprite? sprite)
                         (safe-update-entity _ posn? p)
                         (safe-update-entity _ entity-name? name)
                         (safe-update-entity _ active-on-bg? tile)
                         (add-components _ (storage "amount-in-world" world-amt)
                                           (storage "heals-by"        heal-amt)
                                           (cons c custom-entities))))
  (if respawn?
      (add-components new-entity (on-key 'space #:rule (and/r near-player?
                                                              (nearest-to-player? #:filter (has-component? on-key?)))
                                         (do-many (respawn 'anywhere)
                                                  (active-on-random))))
      (add-components new-entity (on-key 'space #:rule (and/r near-player?
                                                              (nearest-to-player? #:filter (has-component? on-key?)))
                                         die))))

(define (custom-coin #:entity           [base-entity (coin-entity)]
                     #:sprite           [s #f]
                     #:position         [p #f]
                     #:name             [n #f]
                     #:tile             [t #f]
                     #:amount-in-world  [world-amt 10]
                     #:value            [val 10]
                     #:respawn?         [respawn? #t]
                     #:components       [c #f]
                                        . custom-entities)
  (define sprite (cond [(image? s)           (new-sprite s)]
                       [(animated-sprite? s) s             ]
                       [else              #f]))
  (define name   (if n (entity-name n) #f))
  (define tile   (if t (active-on-bg t) #f))
  (define new-entity (~> base-entity
                         (safe-update-entity _ animated-sprite? sprite)
                         (safe-update-entity _ posn? p)
                         (safe-update-entity _ entity-name? name)
                         (safe-update-entity _ active-on-bg? tile)
                         (add-components _ (storage "amount-in-world" world-amt)
                                           (storage "value"           val)
                                           (cons c custom-entities))))
  (if respawn?
      (add-components new-entity (on-key 'space #:rule (and/r near-player?
                                                              (nearest-to-player? #:filter (has-component? on-key?)))
                                         (do-many (respawn 'anywhere)
                                                  (active-on-random))))
      (add-components new-entity (on-key 'space #:rule (and/r near-player?
                                                              (nearest-to-player? #:filter (has-component? on-key?)))
                                         die))))
; ==== PREBUILT DARTS ====
(define (sword #:sprite     [s swinging-sword-sprite]
               #:damage     [dmg 50]
               #:durability [dur 20]
               #:speed      [spd 0]
               #:range      [rng 10])
  (custom-dart #:position (posn 10 0)
                 #:sprite     s
                 #:damage     dmg
                 #:durability dur
                 #:speed      spd
                 #:range      rng
                 #:components (every-tick (change-direction-by 15))))

(define (acid  #:sprite     [s   (overlay/offset (rotate -45 (rectangle 6 4 'solid 'green))
                                                 -3 3
                                                 (overlay (circle 10 'outline 'green)
                                                          (circle 10 'solid (make-color 180 200 0 128))))]
               #:damage     [dmg 10]
               #:durability [dur 5]
               #:speed      [spd 3]
               #:range      [rng 100])
  (custom-dart #:position (posn 25 0)
               #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng
               #:components (on-start (random-size 0.5 1))))

; ==== HEALTH HANDLERS ====
(define (set-health-to amt)
  (lambda (g e)
    (set-stat "health" e (max 0 (min 100 amt)))))

(define (change-health-by amt #:max [max 100])
  (lambda (g e)
    (define current-stat (get-stat "health" e))
    (if (<= current-stat (- max amt))
        (change-stat "health" e amt)
        (set-stat "health" e max))))

(module+ test
  (survival-game
   #:bg     (custom-background #:bg-img SNOW-BG)
   #:avatar (custom-avatar #:sprite (random-character-sprite))
   #:starvation-rate 20
   #:coin-list  (list (custom-coin))
   #:npc-list   (list (custom-npc))
   #:enemy-list (list (custom-enemy #:sprite bat-sprite
                                    #:ai 'medium
                                    #:amount-in-world 5)
                      (custom-enemy #:sprite slime-sprite
                                    #:ai 'easy
                                    #:amount-in-world 10)
                      ; adding curry allows each enemy to have a random sprite
                      (curry custom-enemy #:amount-in-world 10)
                      )
   #:food-list (list (custom-food #:name "Carrot"
                                  #:sprite carrot-sprite
                                  #:amount-in-world 30)
                     (custom-food #:name "Carrot Stew"
                                  #:sprite carrot-stew-sprite
                                  #:heals-by 40
                                  #:respawn? #f))
   #:crafter-list (list (custom-crafter))))








