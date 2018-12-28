#lang racket

(require game-engine
         game-engine-demos-common)

(provide battle-arena-game
         custom-weapon-entity
         spear
         sword
         paint

         custom-enemy
         custom-avatar)


(define (wander-but-defend #:weapon (weapon (custom-weapon))
                           #:range (range 150)
                           #:wander-speed (wspeed 1)
                           #:ticks-between-shots (ticks-between-shots 50))
  
  (define wander (apply state 'wander (wander-mode-components wspeed)))
  (define stand  (apply state 'stand (stand-and-shoot "follow" weapon
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
        (every-tick (point-to "player"))))



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




(define/contract (custom-enemy #:amount-in-world (amount-in-world 10)
                               #:sprite (s (row->sprite (random-character-row) #:delay 4))
                               #:ai (ai-level 'easy)
                               #:health (health 100)
                               #:shield (shield 100)
                               #:weapon (weapon (custom-weapon))
                               #:death-particles (particles (custom-particles)))

  (->* () (#:amount-in-world positive?
           #:sprite any/c
           #:ai symbol?
           #:health positive?
           #:shield positive?
           #:weapon component?
           #:death-particles entity? ) entity?)

  
 
  ;Makes sure that we can run (custom-enemy) through (entity-cloner ...)
  ;  Works because combatant ids get assigned at runtime.
  ;(Otherwise, they'd all end up with the same combatant id, and a shared healthbar)
  (define (become-combatant g e)

    (define c (~> e
                  (combatant
                   #:stats (default-health+shields-stats health shield)
                   #:damage-processor (divert-damage #:filter-out '(passive enemy-team))
                             _)
                  ))
 
    c)

  (define (die-if-health-is-0)
    (on-rule (λ(g e)
               (define h (get-storage-data "health-stat" e))
               (and h (<= h 0)))
             (do-many
              (spawn-on-current-tile particles)
              (λ(g e)
                (add-component e (after-time 2 die)))
              )))

  
  (custom-npc #:name "Enemy"
              #:sprite s
              #:position (posn 0 0)
              #:mode #f
             ; #:dialog (list (list))
              #:components 
              (die-if-health-is-0)
              (damager 10 (list 'passive 'enemy-team))
              (movable)
              (hidden)
              (on-start (do-many (respawn 'anywhere)
                                 show
                                 become-combatant))

              (storage "amount-in-world" amount-in-world)
                         
              (enemy-ai (get-ai-from-level ai-level weapon))  ))


(define (custom-npc #:sprite     [s (row->sprite (random-character-row) #:delay 4)]
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
  
  (create-npc #:sprite      sprite
              #:name        name
              #:position    p
              #:active-tile tile
              #:dialog      (list (list))
              #:mode        mode
              #:speed       spd
              #:target      target
              #:sound       sound
              #:scale       scale
              #:components  (cons c custom-components)))



; ===== GAME DEFINITIONS ====


(define (instructions-entity #:move-keys  [move-keys "ARROW KEYS"]
                             #:mouse-aim? [mouse-aim? #f]
                             #:shoot-key  [shoot-key "F"])

  (define (instruction->sprite text offset)
    (new-sprite text #:y-offset offset #:color 'yellow))

  (define i-list (filter identity (list (~a move-keys " to move")
                                        (if mouse-aim?
                                            "MOVE MOUSE to aim"
                                            #f)
                                        (~a shoot-key " to shoot")
                                        "NUM KEYS to select weapon"
                                        "SPACE to interact"
                                        "ENTER to close dialogs"
                                        "I to open these instructions"
                                        "Z to pick up items"
                                        "X to drop items")))
  (define i-length (length i-list))
  
  (define bg (new-sprite (rectangle 1 1 'solid (make-color 0 0 0 100))))
  
  (define i
    (sprite->entity (~> bg
                        (set-x-scale 340 _)             ;260
                        (set-y-scale (* 25 i-length) _) ;150
                        (set-y-offset 0 _))             ;60
                    #:position   (posn 0 0) ;(posn (/ (WIDTH) 2) 50)
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

; === WON AND LOST RULES ===
(define (won? g e)
  #f)

(define (lost? g e)
  #f)

(define (custom-weapon-entity #:name        [n "Weapon"]
                              #:sprite      [s chest-sprite]
                              #:bullet      [b (custom-bullet)]
                              #:fire-mode   [fm 'normal]
                              #:fire-rate   [fr 3]
                              #:fire-key    [key 'f]
                              #:mouse-fire-button [button #f]
                              #:rapid-fire?       [rf? #t]
                              #:rarity      [rarity 'common])
  (define weapon-component (custom-weapon #:bullet b
                                          #:fire-mode fm
                                          #:fire-rate fr
                                          #:fire-key  key
                                          #:mouse-fire-button button
                                          #:rapid-fire? rf?
                                          #:rule (and/r (weapon-is? n)
                                                        (in-backpack? n))))
  (sprite->entity s
                  #:name n
                  #:position    (posn 0 0)
                  #:components  (active-on-bg 0)
                                (physical-collider)
                                (storage "Weapon" weapon-component)
                                (static)
                                (hidden)
                                (on-start (do-many (respawn 'anywhere)
                                                   (active-on-random)
                                                   show))
                                (storable)))

(define (entity-cloner entity amount)
  (map (thunk*
        (if (procedure? entity) (entity) entity ))
       (range amount)))


(define/contract (clone-by-amount-in-world es)
  (-> (listof entity?) (listof (listof entity?)))

  (define (f e)
    (define to-clone (if (procedure? e)
                         (e)
                         e) )
    
    (define n (if (get-storage "amount-in-world" to-clone)
                  (get-storage-data "amount-in-world" to-clone)
                  1))
    (entity-cloner to-clone n))

  (map f es))

(define (custom-background #:bg-img     [bg FOREST-BG]
                           #:rows       [rows 3]
                           #:columns    [cols 3]
                           #:start-tile [t 0]
                           #:components [c #f]
                                        . custom-components)
  (define backdrop
    (bg->backdrop bg #:rows rows #:columns cols #:start-tile t))
  (sprite->entity (render-tile backdrop)
                  #:name "bg"
                  #:position (posn 0 0)
                  #:components backdrop
                               (cons c custom-components)))

(define (custom-avatar #:sprite     [sprite (circle 10 'solid 'red)]
                 #:position   [p   (posn 100 100)]
                 #:speed      [spd 10]
                 #:key-mode   [key-mode 'arrow-keys]
                 #:mouse-aim? [mouse-aim? #f]
                 #:components [c #f]
                               . custom-components)
  (define dead-frame (if (image? sprite)
                         (rotate -90 sprite)
                         (rotate -90 (render sprite))))

  (define base-avatar
    (sprite->entity sprite
                  #:name       "player"
                  #:position   p
                  #:components (physical-collider)
                               (sound-stream)
                               (precompiler dead-frame)
                               (key-movement spd #:mode key-mode #:rule (and/r all-dialog-closed?
                                                                               (not/r lost?)))
                               (key-animator-system #:mode key-mode #:face-mouse? mouse-aim?)
                               (stop-on-edge)
                               (backpack-system #:components (observe-change backpack-changed? update-backpack))
                               (player-edge-system)
                               (counter 0)
                               (cons c custom-components)
                               ))

  (define health-bar (stat-progress-bar 'red
                                        #:max 100 #:offset (posn 0 -40)
                                        #:after (λ(e) (remove-component e lock-to?))))

  (define sheild-bar (stat-progress-bar 'orange
                                        #:max 100 #:offset (posn 0 -35)
                                        #:after (λ(e) (remove-component e lock-to?))))

  (combatant
   #:stats (list (make-stat-config 'health 100 health-bar)
                 (make-stat-config 'shield 100 sheild-bar))
   #:damage-processor (divert-damage #:filter-out '(passive))         
   base-avatar)
  )

(define/contract (battle-arena-game #:bg             [bg-ent (custom-background)]
                           #:avatar         [p (custom-avatar)]
                           #:enemy-list     [e-list (list (custom-enemy))]
                           #:weapon-list    [weapon-list '()]
                           #:other-entities [ent #f]
                           . custom-entities)
  (->* () (#:bg entity?
           #:avatar entity?
           #:enemy-list (listof entity?)
           #:weapon-list (listof entity?)
           #:other-entities (or/c #f (listof entity?)))
       
       #:rest (listof entity?) game?)

  (define (weapon-entity->player-system e)
    (get-storage-data "Weapon" e))
    
  (define player-with-weapons
    (add-components p (weapon-selector #:slots 3)
                      (map weapon-entity->player-system weapon-list)))

  (define move-keys (if (eq? (get-key-mode p) 'wasd)
                        "WASD KEYS"
                        "ARROW KEYS"))

  (define shoot-key (if (get-component player-with-weapons on-mouse?)
                        "LEFT-CLICK"
                        "F"))

  (define (mouse-aim-component? c)
    (and (on-rule? c)
         (eq? (on-rule-rule? c) mouse-in-game?)
         (eq? (on-rule-func c) point-to-mouse)))

  (define mouse-aim? (get-component p mouse-aim-component?))

  (define (add-random-start-pos e)
    (define world-amt (get-storage-data "amount-in-world" e))
    (if (> world-amt 0) 
        (add-components e (hidden)
                          (on-start (do-many (active-on-random)
                                             (respawn 'anywhere)
                                             show)))
        e))
  

  (define (enemy-counter-entity)
    (define bg (~> (rectangle 1 1 'solid (make-color 0 0 0 100))
                   (new-sprite _ #:animate #f)
                   (set-x-scale 100 _)
                   (set-y-scale 14 _)
                   ))
    
    (sprite->entity bg
                    #:name       "score"
                    #:position   (posn 380 20)
                    #:components (static)
                                 (new-sprite "Enemies Left: 30" #:y-offset -7 #:scale 0.7 #:color 'yellow)
                                 (counter 30)
                                 (layer "ui")))

   (define bg-with-instructions
    (add-components bg-ent (on-key "i" #:rule (λ (g e) (not (get-entity "instructions" g)))
                                   (spawn (instructions-entity #:move-keys move-keys #:shoot-key shoot-key #:mouse-aim? mouse-aim?) #:relative? #f))))
 
  (define es (filter identity
                     (flatten
                      (list
                       (instructions-entity #:move-keys move-keys #:shoot-key shoot-key #:mouse-aim? mouse-aim?)
                       (if p (game-over-screen won? lost?) #f)
                       (if p (enemy-counter-entity) #f)


                       player-with-weapons
              
              
                       (pine-tree (posn 400 140) #:tile 2 (damager 5 (list 'passive)))
                       (pine-tree (posn 93 136)  #:tile 4 (damager 5 (list 'passive)))
                       (round-tree (posn 322 59) #:tile 4 (damager 5 (list 'passive)))

                       (map (λ (w) (entity-cloner w 3)) weapon-list)

                       (clone-by-amount-in-world (flatten e-list))

                       (cons ent custom-entities)
              
                       bg-with-instructions))))

  
  (apply start-game es))

; ==== PREBUILT BULLETS ====
(define (spear #:sprite     [s spear-bullet-sprite]
               #:damage     [dmg 50]S-Automation-Backend in AWS EC2 console
               #:durability [dur 20]
               #:speed      [spd 5]
               #:range      [rng 20])
  (custom-bullet #:position (posn 20 0)
                 #:sprite spear-bullet-sprite
                 #:damage dmg
                 #:durability dur
                 #:speed spd
                 #:range rng
                 #:components (after-time (/ rng 2) (do-many (bounce)
                                                             (horizontal-flip-sprite)))))

(define (sword #:sprite     [s swinging-sword-sprite]
               #:damage     [dmg 50]
               #:durability [dur 20]
               #:speed      [spd 0]
               #:range      [rng 10])
  (custom-bullet #:position (posn 10 0)
                 #:sprite     s
                 #:damage     dmg
                 #:durability dur
                 #:speed      spd
                 #:range      rng
                 #:components (every-tick (change-direction-by 15))))

(define (paint #:sprite     [s   paint-sprite]
               #:damage     [dmg 5]
               #:durability [dur 5]
               #:speed      [spd 3]
               #:range      [rng 15])
  (custom-bullet #:position (posn 25 0)
                 #:sprite     s
                 #:damage     dmg
                 #:durability dur
                 #:speed      spd
                 #:range      rng
                 #:components (on-start (set-size 0.5))
                              (every-tick (scale-sprite 1.1))))


(module+ test
  (battle-arena-game
   #:bg              (custom-background)
   #:avatar          (custom-avatar #:sprite      (row->sprite (random-character-row))
                                    #:key-mode    'wasd
                                    #:mouse-aim?  #t)
   #:weapon-list     (list (custom-weapon-entity #:name "Light Repeater" #:mouse-fire-button 'left #:fire-mode 'random #:fire-rate 10)
                           (custom-weapon-entity #:name "Spread Shot"    #:mouse-fire-button 'left #:fire-mode 'spread #:rapid-fire? #f))))

