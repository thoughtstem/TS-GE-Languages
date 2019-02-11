#lang at-exp racket

(provide crafting-menu-set!
         entity-cloner
         player-toast-entity
         acid
         plain-bg
         plain-color-bg
         plain-forest-bg
         carrot
         carrot-stew
         carrot-stew-recipe
         fish
         acid-spitter
         sky?
         plain-forest-bg
         draw-plain-forest-bg
         ai-level?
         dialog-str?
         sword

         witch-sprite
         darkelf-sprite
         lightelf-sprite
         madscientist-sprite
         monk-sprite
         pirate-sprite
         wizard-sprite)

(require scribble/srcdoc)

(require (for-doc racket/base scribble/manual ))

(require ts-kata-util
         "../assets.rkt")

(require (except-in game-engine
                    change-health-by)
         game-engine-demos-common
         (only-in lang/posn make-posn))

(define-syntax-rule (define/log l head body ...)
  (define head
    (let ()
      (displayln l)
      body ...)))

(define (WIDTH)       480)
(define (HEIGHT)      360)
(define (TOTAL-TILES) 9)


(define dialog-str? (or/c (listof string?) (listof (listof string?))))

(define rarity-level?
  (or/c 'common 'uncommon 'rare 'epic 'legendary))

(define fire-mode?    (or/c 'normal 'random 'spread 'homing))

(struct sky (color day-length day-start day-end max-alpha))

(define (mround-up num multiple)
  (define rounded-num (exact-round num))
  (define remainder (modulo rounded-num multiple))
  (cond [(= remainder 0) rounded-num]
        [else (+ rounded-num multiple (- remainder))]))

(define/contract/doc (custom-sky #:night-sky-color  [color      'black]
                                 #:length-of-day    [day-length 2400]
                                 #:start-of-daytime [day-start #f]
                                 #:end-of-daytime   [day-end   #f]
                                 #:max-darkness     [max-alpha 160])
  (->i () (#:night-sky-color  [color (or/c string? symbol?)]
           #:length-of-day    [day-length number?]
           #:start-of-daytime [day-start  number?]
           #:end-of-daytime   [day-end    number?]
           #:max-darkness     [max-darkness number?])
       [returns sky?])

  @{Creates a custom sky that can be used in the sky parameter
         of @racket[survival-game].}
  
  (define ds (if day-start
                 (min day-length (max 0 day-start))
                 (exact-round (* 0.25 day-length))))
  (define de (if day-end
                 (min day-length (max 0 day-end))
                 (exact-round (* 0.75 day-length))))
  (define ma (min 255 (max 1 max-alpha)))
  (sky color day-length ds de ma))

(define (night-sky #:color         [color 'black]
                   #:max-alpha     [max-alpha 160]
                   #:length-of-day [length-of-day 2400])
  (define update-multiplier 2)
  (define update-interval (* update-multiplier (/ length-of-day 2 max-alpha)))
  (define c (name->color color))
  (define r-val (color-red c))
  (define g-val (color-green c))
  (define b-val (color-blue c))
  (define (update-night-sky g e)
    (define game-count (get-counter (get-entity "time manager" g)))
    (define time-of-day (modulo game-count length-of-day))
    (define alpha-val (mround-up (abs (* (- (/ time-of-day length-of-day) .5) 2 max-alpha)) update-multiplier))
    (define new-night-sky (~> (new-sprite (square 1 'solid (make-color r-val g-val b-val alpha-val)))
                              (set-x-scale 480 _)
                              (set-y-scale 360 _)))
    (update-entity e animated-sprite? new-night-sky))
  (sprite->entity (~> (new-sprite (square 1 'solid (make-color r-val g-val b-val max-alpha)))
                      (set-x-scale 480 _)
                      (set-y-scale 360 _))
                  #:position (posn 0 0)
                  #:name "night sky"
                  #:components (layer "tops")
                  (hidden)
                  (apply precompiler
                         (map (λ (a)(square 1 'solid (make-color r-val g-val b-val a)))
                              (range 0 (+ max-alpha update-multiplier 1) update-multiplier)))
                  (on-start (do-many (go-to-pos 'center)
                                     show))
                  (do-every update-interval update-night-sky)
                  ))

(define (draw-sky-with-light color)
  (place-images (list (circle 24 'outline (pen color 36 'solid 'round 'bevel))
                      ;(circle 24 'outline (pen color 37 'solid 'round 'bevel))
                      (circle 24 'outline (pen color 38 'solid 'round 'bevel))
                      ;(circle 24 'outline (pen color 39 'solid 'round 'bevel))
                      (circle 24 'outline (pen color 40 'solid 'round 'bevel)))
                (list (make-posn 24 18)
                      ;(make-posn 24 18)
                      (make-posn 24 18)
                      ;(make-posn 24 18)
                      (make-posn 24 18))
                (rectangle 48 36 'outline 'transparent)))

(define (draw-sky-with-light-small color)
  (place-images (list (circle 12 'outline (pen color 18 'solid 'round 'bevel))
                      (circle 12 'outline (pen color 19 'solid 'round 'bevel))
                      (circle 12 'outline (pen color 20 'solid 'round 'bevel)))
                (list (make-posn 12 9)
                      (make-posn 12 9)
                      (make-posn 12 9))
                (rectangle 24 18 'outline 'transparent)))

(define (sky-sprite-with-light color)
  (define sky-img (draw-sky-with-light color))
  (new-sprite sky-img #:scale 20.167))

(define (sky-sprite-with-light-small color)
  (define sky-img (draw-sky-with-light-small color))
  (new-sprite sky-img #:scale 40.333))

(define (night-sky-with-lighting #:color         [color 'black]
                                 #:max-alpha     [m-alpha 160]
                                 #:length-of-day [length-of-day 2400])
  (define max-alpha (exact-round (* m-alpha 0.56)))
  (define update-multiplier 2)
  (define update-interval (* update-multiplier (/ length-of-day 2 max-alpha)))
  (define c (name->color color))
  (define r-val (color-red c))
  (define g-val (color-green c))
  (define b-val (color-blue c))
  (define (update-night-sky g e)
    (define game-count (get-counter (get-entity "time manager" g)))
    (define time-of-day (modulo game-count length-of-day))
    (define alpha-val (mround-up (abs (* (- (/ time-of-day length-of-day) .5) 2 max-alpha)) update-multiplier))
    ;(displayln (~a "TIME-OF-DAY: " time-of-day ", ALPHA: " alpha-val))
    (define new-night-sky (sky-sprite-with-light (make-color r-val g-val b-val alpha-val)))
    (update-entity e animated-sprite? new-night-sky))
  (sprite->entity (sky-sprite-with-light (make-color r-val g-val b-val max-alpha))
                  #:position (posn 0 0)
                  #:name "night sky"
                  #:components (layer "tops")
                  (hidden)
                  (lock-to "player")
                  (apply precompiler
                         (map (λ (a)(draw-sky-with-light (make-color r-val g-val b-val a)))
                              (range 0 (+ max-alpha 2 1) update-multiplier)))
                  (on-start (do-many (go-to-pos 'center)
                                     show))
                  (do-every update-interval update-night-sky)
                  ))

; === ENTITY DEFINITIONS ===
(define (plain-bg #:bg-img     [bg (rectangle 4 3
                                  'solid 'darkgreen)]
                  #:scale      [scale 360] ; should scale to 3x 480 by 360 or 1440 by 1080
                  #:rows       [rows 3]
                  #:columns    [cols 3]
                  #:start-tile [t 0]
                  #:components [c #f]
                  . custom-components)
  (add-components (bg->backdrop-entity bg
                       #:rows       rows
                       #:columns    cols
                       #:start-tile t
                       #:scale scale)
                  (cons c custom-components)))

(define (draw-color-bg)
  (above (beside (rectangle 4 3 'solid (color 0 128 0))
                 (rectangle 4 3 'solid (color 143 151 8))
                 (rectangle 4 3 'solid (color 141 104 0)))
         (beside (rectangle 4 3 'solid (color 151 57 8))
                 (rectangle 4 3 'solid (color 128 0 21))
                 (rectangle 4 3 'solid (color 110 8 151)))
         (beside (rectangle 4 3 'solid (color 0 3 141))
                 (rectangle 4 3 'solid (color 7 74 141))
                 (rectangle 4 3 'solid (color 8 151 118)))))

(define (plain-color-bg #:bg-img     [bg (draw-color-bg)]
                        #:scale      [scale 120] ; should scale to 3x 480 by 360 or 1440 by 1080
                        #:rows       [rows 3]
                        #:columns    [cols 3]
                        #:start-tile [t 0]
                        #:components [c #f]
                        . custom-components)
  (add-components (bg->backdrop-entity bg
                       #:rows       rows
                       #:columns    cols
                       #:start-tile t
                       #:scale scale)
                  (cons c custom-components)))

(define (draw-plain-forest-bg)
  (foldl (λ (image base)
           (place-image image
                        (random 24) (random 18)
                        base))
         (rectangle 24 18 'solid (color 190 143 82))
         (list (ellipse (random 20 30) (random 20 30) 'solid (color 53 137 55 120))
               (ellipse (random 20 30) (random 20 30) 'solid (color 53 137 55 120))
               (ellipse (random 10 30) (random 10 30) 'solid (color 53 137 55 120))
               (ellipse (random 10 20) (random 10 20) 'solid (color 2 89 61 120))
               (ellipse (random 10 20) (random 10 20) 'solid (color 2 89 61 120))
               (ellipse (random 10 15) (random 10 15) 'solid (color 2 89 61 120))
               (ellipse (random 10 15) (random 10 15) 'solid (color 100 164 44 120))
               (ellipse (random 10 15) (random 10 15) 'solid (color 100 164 44 120))
               (ellipse (random 5 10) (random 5 10) 'solid (color 190 143 82 120))
               (ellipse (random 5 10) (random 5 10) 'solid (color 190 143 82 120))
               )))

(define (plain-forest-bg #:bg-img     [bg (draw-plain-forest-bg)]
                         #:scale      [scale 60] ; should scale to 3x 480 by 360 or 1440 by 1080
                         #:rows       [rows 3]
                         #:columns    [cols 3]
                         #:start-tile [t 0]
                         #:components [c #f]
                         . custom-components)
  (add-components (bg->backdrop-entity bg
                                       #:rows       rows
                                       #:columns    cols
                                       #:start-tile t
                                       #:scale scale)
                  (cons c custom-components)))

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

(define (tops? e)
  (and ((has-component? layer?) e)
       (eq? (get-layer e) "tops")))
    
(define (food->component f #:use-key [use-key 'space] #:max-health [max-health 100])
  (define item-name (get-name f))
  (define heal-amount (get-storage-data "heals-by" f))
  (if heal-amount
      (on-key use-key #:rule (and/r (player-is-near? item-name)
                                    (nearest-entity-to-player-is? item-name #:filter (and/c (has-component? on-key?)
                                                                                            (not/c tops?)
                                                                                            (not/c ui?))))
          (do-many (change-health-by heal-amount #:max max-health)
                   (spawn (player-toast-entity (~a "+" heal-amount) #:color "green"))))
      #f))

(define (coin->component c #:use-key [use-key 'space])
  (define coin-name (get-name c))
  (define coin-value (get-storage-data "value" c))
  (define coin-toast-entity
    (player-toast-entity (~a "+" coin-value " GOLD")))

  
  (if coin-value
      (list (on-key use-key #:rule (and/r (player-is-near? coin-name)
                                          (nearest-entity-to-player-is? coin-name #:filter (and/c (has-component? on-key?)
                                                                                                  (not/c tops?)
                                                                                                  (not/c ui?))))
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
        #:components [first-component (or/c component-or-system? false? (listof false?))]
        )
       #:rest (rest (listof component-or-system?))
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
        #:mouse-fire-button [button (or/c 'left 'right false?)]
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
                                   #:night-only? (night-only? #f)
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
           #:night-only?     [night-only? boolean?]
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
                   #:stats (list (make-stat-config 'health health (stat-progress-bar 'red #:max health #:offset (posn 0 -30)))) ;(default-health+shields-stats health shield)
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
                    (storage "night-only?" night-only?)

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
                 #:bg              [bg-ent (plain-forest-bg)]
                 #:avatar          [p         #f #;(custom-avatar)]
                 #:starvation-rate [sr 50]
                 #:sky             [sky (custom-sky)]
                 #:npc-list        [npc-list  '() #;(list (random-npc (posn 200 200)))]
                 #:enemy-list      [e-list (list (custom-enemy))]
                 #:coin-list       [coin-list '() #;(list (coin #:entity (coin-entity) #:amount-in-world 10))]
                 #:food-list       [f-list    '() #;(list (food #:entity (carrot-entity) #:amount-in-world 10)
                                                         (food #:entity carrot-stew #:heals-by 20))]
                 #:crafter-list    [c-list    '() #;(list (custom-crafter))]
                 #:other-entities  [ent #f]
                                   . custom-entities)
  (->i ()
       (#:headless         [headless boolean?]
        #:bg               [bg entity?]
        #:avatar           [avatar (or/c entity? #f)]
        #:starvation-rate  [starvation-rate number?]
        #:sky              [sky sky?]
        #:npc-list         [npc-list     (listof (or/c entity? procedure?))]
        #:enemy-list       [enemy-list   (listof (or/c entity? procedure?))]
        #:coin-list        [coin-list    (listof (or/c entity? procedure?))]
        #:food-list        [food-list   (listof (or/c entity? procedure?))]
        #:crafter-list     [crafter-list (listof (or/c entity? procedure?))]
        #:other-entities   [other-entities (or/c #f entity? (listof #f))])
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

  (define known-products-list (map recipe-product known-recipes-list))
  
  (define player-with-recipes
    (if p
        (add-components p (map recipe->system known-recipes-list)
                          (apply precompiler f-list)
                          (map food->component (append f-list known-products-list))
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

  (define LENGTH-OF-DAY    (sky-day-length sky))
  (define START-OF-DAYTIME (sky-day-start sky))
  (define END-OF-DAYTIME   (sky-day-end sky))

    ; === DAY/NIGHT FUNCTIONS FOR ENEMY ===
  (define (store-birth-time g e)
    (define game-count (get-counter (get-entity "time manager" g)))
    (add-components e (storage "birth-time" game-count)))

  ; typically between 6am (600) and 6pm (1800)
  (define (daytime? g e)
    (define game-count (get-counter (get-entity "time manager" g)))
    (define time-of-day (modulo game-count LENGTH-OF-DAY))
    (and (> time-of-day START-OF-DAYTIME)
         (< time-of-day END-OF-DAYTIME)))

  (define (should-be-dead? g e)
    (define game-count (get-counter (get-entity "time manager" g)))
    (define birth-time (get-storage-data "birth-time" e))
    (and birth-time
         (>= (- game-count birth-time) (- END-OF-DAYTIME START-OF-DAYTIME))))

  (define (maybe-add-night-only e)
    (define ent (if (procedure? e) (e)e))
    (if (get-storage-data "night-only?" ent)
        (add-components ent (on-start store-birth-time)
                            (on-rule daytime? die)
                            (on-rule should-be-dead? die))
        ent))

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
  (define updated-enemy-list (map maybe-add-night-only e-list))

  (define (spawn-many-on-current-tile e-list)
    (apply do-many (map spawn-on-current-tile (clone-by-amount-in-world e-list))))

  (define (night-only? e)
    (define ent (if (procedure? e)
                    (e)
                    e))
    (get-storage-data "night-only?" ent))

  (define (tm-entity)
    (time-manager-entity
     #:components (on-start (set-counter START-OF-DAYTIME))
                  (on-rule (reached-multiple-of? LENGTH-OF-DAY #:offset END-OF-DAYTIME)
                           (do-many (spawn (toast-entity "NIGHTTIME HAS BEGUN"))
                                    (spawn-many-on-current-tile (filter night-only? updated-enemy-list))
                                    ))
                  (on-rule (reached-multiple-of? LENGTH-OF-DAY #:offset START-OF-DAYTIME)
                           (spawn (toast-entity "DAYTIME HAS BEGUN")))
                  ;(on-key 't (start-stop-game-counter)) ; !!!!! for testing only remove this later !!!!!!
     ))
  
  (define es (filter identity
                     (flatten
                      (list
                       (instructions-entity #:move-keys move-keys
                                            #:mouse-aim? mouse-aim?)
                       (if p (game-over-screen won? lost?) #f)
                       (if p (score-entity) #f)

                       (tm-entity)
                       (night-sky-with-lighting #:color         (sky-color sky)
                                                #:max-alpha     (sky-max-alpha sky)
                                                #:length-of-day (sky-day-length sky)) 

                       ;(if p (health-entity) #f)

                       player-with-recipes
                           
                       ;(pine-tree (posn 400 140) #:tile 2)
                       ;(pine-tree (posn 93 136) #:tile 4)
                       ;(round-tree (posn 322 59) #:tile 4)

                       npc-list
              
                       c-list
              
                       (clone-by-amount-in-world updated-coin-list)
                       (clone-by-amount-in-world updated-food-list)
                       (clone-by-amount-in-world updated-enemy-list)

                       (cons ent custom-entities)
              
                       bg-with-instructions))))
  
  (if headless
      (initialize-game es)
      (apply start-game es))
  
  )

(define known-recipes-list '())

(define/log "crafting-menu-set!"
  (crafting-menu-set! #:open-key     [open-key 'space]
                      #:open-sound   [open-sound #f]
                      #:select-sound [select-sound #f]
                      ;#:recipes r . recipes
                      #:recipe-list  [r-list '()]
                      )
  (set! known-recipes-list (append r-list known-recipes-list))
  (crafting-menu #:open-key open-key
                 #:open-sound open-sound
                 #:select-sound select-sound
                 #:recipe-list r-list
                 ;#:recipes r
                 ;          recipes
                           ))

(define/contract/doc (custom-crafter #:position   [p (posn 100 100)]
                                     #:tile       [t 0]
                                     #:name       [name "Crafter"]
                                     #:sprite     [sprite cauldron-sprite]
                                     #:recipe-list [r-list (list (recipe #:product (carrot-stew)
                                                                         #:build-time 30
                                                                         ))]
                                     #:components [c #f] . custom-components)
  (->i ()
       (#:position   [position posn?]
        #:tile       [tile number?]
        #:name       [name string?]
        #:sprite     [sprite sprite?]
        #:recipe-list [recipe-list (listof recipe?)]
        #:components [first-component component-or-system?])
       #:rest       [more-components (listof component-or-system?)]
       [result entity?])

  @{Returns a custom crafter}
  
  (crafting-chest p
                  #:sprite sprite
                  #:name   name
                  #:components (active-on-bg t)
                               (counter 0)
                               (crafting-menu-set! #:recipe-list r-list)
                               (cons c custom-components)))


(define/contract/doc (custom-npc #:sprite     [s (row->sprite (random-character-row) #:delay 4)]
                                 #:position   [p (posn 200 200)]
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
                                 #:components [c (on-start (respawn 'anywhere))]
                                 . custom-components )

  (->i () (#:sprite     [sprite sprite?]
           #:position   [position posn?]
           #:name       [name string?]
           #:tile       [tile number?]
           #:dialog     [dialog dialog-str?]
           #:mode       [mode (or/c 'still 'wander 'pace 'follow)]
           #:game-width [game-width number?]
           #:speed      [speed number?]
           #:target     [target string?]
           #:sound      [sound any/c]
           #:scale      [scale number?]
           #:components [first-component component-or-system?])
       #:rest [more-components (listof component-or-system?)]
       [returns entity?])

  @{Creates a custom npc that can be used in the npc list
         of @racket[survival-game].}
  
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
        #:components [first-component (or/c component-or-system? #f (listof #f))])
       #:rest [more-components (listof component-or-system?)]
       [result entity?])

  @{Returns a custom background}
  

  (add-components (bg->backdrop-entity (scale 0.25 bg)
                       #:rows       rows
                       #:columns    cols
                       #:start-tile t
                       #:scale 4)
                  (cons c custom-components)))

(define (safe-update-entity e component-pred f)
  (if f
      (update-entity e component-pred f)
      e))

(define/contract/doc (custom-food #:entity           [base-entity (carrot-entity)]
                                  #:sprite           [s #f]
                                  #:position         [p #f]
                                  #:name             [n #f]
                                  #:tile             [t #f]
                                  #:amount-in-world  [world-amt 1]
                                  #:heals-by         [heal-amt 10]
                                  #:respawn?         [respawn? #t]
                                  #:components       [c #f]
                                  . custom-entities)
  (->i () (#:entity     [entity entity?]
           #:sprite     [sprite sprite?]
           #:position   [position posn?]
           #:name       [name string?]
           #:tile       [tile number?]
           #:amount-in-world [amount-in-world number?]
           #:heals-by   [heal-amt number?]
           #:respawn?   [respawn? boolean?]
           #:components [first-component (or/c component-or-system?
                                               false?
                                               (listof false?))])
       #:rest [more-components (listof component-or-system?)]
       [returns entity?])

  @{Returns a custom food, which will be placed into the world
              automatically if it is passed into @racket[battle-arena-game]
              via the @racket[#:coin-food] parameter.}
  
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
                                           ;(static)
                                           (cons c custom-entities))))
  (if respawn?
      (add-components new-entity (on-key 'space #:rule (and/r near-player?
                                                              (nearest-to-player? #:filter (has-component? on-key?)))
                                         (do-many (respawn 'anywhere)
                                                  (active-on-random))))
      (add-components new-entity (on-key 'space #:rule (and/r near-player?
                                                              (nearest-to-player? #:filter (has-component? on-key?)))
                                         die))))

(define/contract/doc (custom-coin #:entity           [base-entity (copper-coin-entity)]
                                  #:sprite           [s #f]
                                  #:position         [p #f]
                                  #:name             [n #f]
                                  #:tile             [t #f]
                                  #:amount-in-world  [world-amt 10]
                                  #:value            [val 10]
                                  #:respawn?         [respawn? #t]
                                  #:components       [c #f]
                                  . custom-entities)


  ;change contracts to accept #f
   (->i () (#:entity   [entity entity?]
            #:sprite   [sprite (or/c sprite? #f)]
            #:position [position (or/c posn? #f)]
            #:name     [name (or/c string? #f)]
            #:tile     [tile (or/c number? #f)]
            #:amount-in-world [amount-in-world number?]
            #:value    [value number?]
            #:respawn? [respawn boolean?]
            #:components [first-component (or/c component-or-system?
                                                false?
                                                (listof false?))])
        #:rest [more-components (listof component-or-system?)]
        [returns entity?])

  @{Returns a custom coin, which will be placed into the world
              automatically if it is passed into @racket[battle-arena-game]
              via the @racket[#:coin-list] parameter.}
  
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

(define (acid-spitter  #:sprite     [s   (overlay/offset (rotate -45 (rectangle 6 4 'solid 'green))
                                                 -3 3
                                                 (overlay (circle 10 'outline 'green)
                                                          (circle 10 'solid (make-color 180 200 0 128))))]
                       #:damage      [dmg 10]
                       #:durability  [dur 5]
                       #:speed       [spd 3]
                       #:range       [rng 100]
                       #:name              [n "Acid Spitter"]
                       #:fire-mode         [fm 'normal]
                       #:fire-rate         [fr 3]
                       #:fire-key          [key 'f]
                       #:mouse-fire-button [button #f]
                       #:point-to-mouse?   [ptm? #f]
                       #:rapid-fire?       [rf? #t]
                       #:rarity            [rarity 'common])
  (define acid-dart
    (custom-dart #:position (posn 25 0)
                 #:sprite     s
                 #:damage     dmg
                 #:durability dur
                 #:speed      spd
                 #:range      rng
                 #:components (on-start (random-size 0.5 1))))
  (custom-weapon #:sprite (make-icon "AS")
                 #:dart   acid-dart
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-key key
                 #:mouse-fire-button button
                 #:point-to-mouse?   ptm?
                 #:rapid-fire?       rf?
                 #:rarity            rarity))

; ==== PREBUILT FOOD AND RECIPES ===
(define (carrot #:sprite           [s carrot-sprite]
                #:position         [p (posn 100 100)]
                #:name             [n "Carrot"]
                #:tile             [t 0]
                #:amount-in-world  [world-amt 1]
                #:heals-by         [heal-amt 20]
                #:respawn?         [respawn? #t]
                #:components       [c #f]
                . custom-entities)
  (custom-food  #:sprite           s 
                #:position         p 
                #:name             n
                #:tile             t
                #:amount-in-world  world-amt
                #:heals-by         heal-amt
                #:respawn?         respawn?
                #:components       (cons c custom-entities)))

(define (fish #:sprite           [s fish-sprite]
              #:position         [p (posn 100 100)]
              #:name             [n "Fish"]
              #:tile             [t 0]
              #:amount-in-world  [world-amt 1]
              #:heals-by         [heal-amt 20]
              #:respawn?         [respawn? #t]
              #:components       [c #f]
              . custom-entities)
  (custom-food  #:sprite           s 
                #:position         p 
                #:name             n
                #:tile             t
                #:amount-in-world  world-amt
                #:heals-by         heal-amt
                #:respawn?         respawn?
                #:components       (cons c custom-entities)))

(define (carrot-stew #:sprite           [s carrot-stew-sprite]
                     #:position         [p (posn 100 100)]
                     #:name             [n "Carrot Stew"]
                     #:tile             [t 0]
                     #:amount-in-world  [world-amt 0]
                     #:heals-by         [heal-amt 40]
                     #:respawn?         [respawn? #f]
                     #:components       [c #f]
                     . custom-entities)
  (custom-food  #:sprite           s 
                #:position         p 
                #:name             n
                #:tile             t
                #:amount-in-world  world-amt
                #:heals-by         heal-amt
                #:respawn?         respawn?
                #:components       (cons c custom-entities)))

(define carrot-stew-recipe
  (recipe #:product (carrot-stew)
          #:build-time 30
          #:ingredients (list "Carrot")))

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

(module test racket
  (displayln "TEST!!!")
  )

;===== ASSETS ========

(define (witch-sprite)
  (sheet->sprite witch-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define (darkelf-sprite)
  (sheet->sprite darkelf-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define (lightelf-sprite)
  (sheet->sprite lightelf-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define (madscientist-sprite)
  (sheet->sprite madscientist-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define (monk-sprite)
  (sheet->sprite monk-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define (pirate-sprite)
  (sheet->sprite pirate-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define (wizard-sprite)
  (sheet->sprite wizard-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))




