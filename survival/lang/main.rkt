#lang at-exp racket

(provide crafting-menu-set!
         entity-cloner
         player-toast-entity
         plain-bg
         plain-color-bg
         plain-forest-bg
         carrot
         carrot-stew
         carrot-stew-recipe
         fish
         
         sky?
         draw-sky-with-light
         plain-forest-bg
         draw-plain-forest-bg
         ai-level?
         fire-mode?
         rarity-level?
         safe-update-entity
         random-food
         random-coin
         has-gold?
         dialog-str?
                 
         acid-spitter
         spear
         sword
         fire-magic
         ice-magic
         sword-magic
         ring-of-fire
         ring-of-ice
         ring-of-blades
         
         acid-dart
         spear-dart
         sword-dart
         fire-dart
         ice-dart
         flying-dagger-dart
         ring-of-fire-dart

         acid-sprite
         ice-sprite
         )

(require scribble/srcdoc)

(require (for-doc racket/base scribble/manual ))

(require ts-kata-util
         (only-in racket/draw make-font)
         "../assets.rkt")

(require game-engine
         game-engine-demos-common
         (only-in lang/posn make-posn)
         )

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

(define (name-eq? e1 e2)
  (eq? (get-name e1) (get-name e2)))

(define (render-eq? e1 e2)
  (define s1 (get-component e1 animated-sprite?))
  (define s2 (get-component e2 animated-sprite?))
  (equal? (render s1) (render s2)))

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

  @{Creates a custom sky that can be used in the @racket[#:sky] parameter
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
                  #:components (layer "sky")
                               (hidden)
                               (apply precompiler
                                      (map (λ (a) (freeze (square 1 'solid (make-color r-val g-val b-val a))))
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
                  #:components (layer "sky")
                  (hidden)
                  (lock-to "player")
                  (apply precompiler
                         (map (λ (a)(freeze (draw-sky-with-light (make-color r-val g-val b-val a))))
                              (range 0 (+ max-alpha 2 1) update-multiplier)))
                  (on-start (do-many (go-to-pos 'center)
                                     show))
                  (do-every update-interval update-night-sky)
                  ))

; === ENTITY DEFINITIONS ===
(define (plain-bg #:image     [bg (rectangle 4 3
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

(define (plain-color-bg #:image     [bg (draw-color-bg)]
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

(define (plain-forest-bg #:image     [bg (draw-plain-forest-bg)]
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
                             #:mouse-aim? [mouse-aim? #f]
                             #:shoot-key  [shoot-key "F"])

  (define (instruction->sprite text offset)
    (new-sprite text #:y-offset offset #:color 'yellow))

  (define i-list (filter identity (list (~a move-keys " to move")
                                        (if mouse-aim?
                                            "MOVE MOUSE to aim"
                                            #f)
                                        "SPACE to interact/use"
                                        "ENTER to close dialogs"
                                        "F to fire/use weapon"
                                        "I to open these instructions"
                                        "Z to pick up items"
                                        "X to drop items"
                                        "B to open and close backpack")))
  (define i-length (length i-list))
  
  (define bg (new-sprite (rectangle 1 1 'solid (make-color 0 0 0 100))))
  
  (define i
    (sprite->entity (~> bg
                        (set-x-scale 340 _)             
                        (set-y-scale (* 26 i-length) _) 
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

  (add-components i (map instruction->sprite i-list (range (- (/ last-y-pos 2)) (add1 (/ last-y-pos 2)) (/ last-y-pos (sub1 i-length))))
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

(define/contract (clone-by-rarity es)
  (-> (listof (or/c procedure? entity?)) (listof entity?))

  (define (f e)
    (define to-clone (if (procedure? e)
                         (e)
                         e) )
    
    (define rarity (if (get-storage "Rarity" to-clone)
                       (get-storage-data "Rarity" to-clone)
                       'common))
    
    (define n (cond [(eq? rarity 'common)    5]
                    [(eq? rarity 'uncommon)  4]
                    [(eq? rarity 'rare)      3]
                    [(eq? rarity 'epic)      2]
                    [(eq? rarity 'legendary) 1]))
    (entity-cloner e n))

  (flatten (map f es)))

(define (player-toast-entity message #:color [color "yellow"])
  (sprite->entity (list (new-sprite message #:color color)
                        (new-sprite message #:x-offset -1 #:y-offset 1 #:color 'black))
                  #:name       "player toast"
                  #:position   (posn 0 0)
                  #:components (hidden)
                               (layer "ui")
                               (direction 270)
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

(define (recipe->coin-system r #:prefix [prefix "Gold"])
  (define product-name (get-name (recipe-product r)))
  (define product-cost (recipe-cost r))
  (define coin-toast-entity
    (player-toast-entity (~a "-" product-cost " " (string-upcase prefix))))
  (define (remove-gold g e1 e2)
    (if ((crafting? product-name) g e2)
        ((do-many (change-counter-by (- product-cost))
                  (draw-counter-rpg #:prefix (~a (string-titlecase prefix) ": "))
                  (do-font-fx)
                  (spawn coin-toast-entity)) g e2)
        e2))
  (observe-change (crafting? product-name) remove-gold))

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
  (define health (get-health player))
  (<= health 0))

(define (bg? e)
  (eq? (get-name e) "bg"))
    
(define (food->component f #:use-key [use-key 'space])
  (define item-name (get-name f))
  (define heal-amount (get-storage-data "heals-by" f))
  (if heal-amount
      (on-key use-key #:rule (and/r (player-is-near? item-name)
                                    (nearest-entity-to-player-is? item-name #:filter (and/c (has-component? on-key?)
                                                                                            (not/c bg?))))
          (do-many (change-health-by heal-amount)
                   (spawn (player-toast-entity (~a "+" heal-amount) #:color "green"))))
      #f))

(define score-font (make-font #:size 13 #:face "DejaVu Sans Mono" #:family 'modern))
(define bold-font (make-font #:size 13 #:face "DejaVu Sans Mono" #:family 'modern #:weight 'bold))

(register-fonts! bold-font)

(define (change-text-sprite s)
  (lambda (g e)
    (define current-sprite (get-component e string-animated-sprite?))
    (update-entity e (is-component? current-sprite)
                   s)))

(define (do-font-fx)
  (lambda (g e)
    (define current-sprite (get-component e string-animated-sprite?))
    (define current-text-frame (render-text-frame current-sprite))
    (define regular-text-frame (~> current-text-frame
                                   (set-text-frame-font score-font _)
                                   (set-text-frame-color 'yellow _)))
    (define bold-text-frame (~> current-text-frame
                                (set-text-frame-font bold-font _)
                                (set-text-frame-color 'white _)))
    (~> e
        (update-entity _ (is-component? current-sprite)
                       (new-sprite (list bold-text-frame
                                         regular-text-frame)
                                   10
                                   #:scale 1.1
                                   ))
        (add-components _ (after-time 20 (change-text-sprite (new-sprite regular-text-frame)))))))

(define (coin->component c prefix #:use-key [use-key 'space])
  (define coin-name (get-name c))
  (define coin-value (get-storage-data "value" c))
  (define coin-toast-entity
    (player-toast-entity (~a "+" coin-value " " (string-upcase prefix))))

  
  (if coin-value
      (list (on-key use-key #:rule (and/r (player-is-near? coin-name)
                                          (nearest-entity-to-player-is? coin-name #:filter (and/c (has-component? on-key?)
                                                                                                  (not/c bg?))))
                    (do-many (change-counter-by coin-value)
                             (draw-counter-rpg #:prefix (~a (string-titlecase prefix) ": "))
                             (do-font-fx)
                             (spawn coin-toast-entity))))
      #f))

(define/contract/doc
  (custom-avatar #:sprite           [sprite (random-character-sprite)]
                 #:damage-processor [dp (filter-damage-by-tag #:filter-out '(friendly-team passive)
                                                              #:show-damage? #t
                                                              #:hit-sound HIT-SOUND)]
                 #:position         [p   (posn 100 100)]
                 #:speed            [spd 10]
                 #:key-mode         [key-mode 'arrow-keys]
                 #:mouse-aim?       [mouse-aim? #f]
                 #:health           [health     100]
                 #:max-health       [max-health 100]
                 #:components       [c #f]
                                    . custom-components)
  (->i ()
       (#:sprite           [sprite sprite?]
        #:damage-processor [damage-processor damage-processor?]
        #:position         [position posn?]
        #:speed            [speed number?]
        #:key-mode         [key-mode (or/c 'wasd 'arrow-keys)]
        #:mouse-aim?       [mouse-aim boolean?]
        #:health           [health     number?]
        #:max-health       [max-health number?]
        #:components       [first-component (or/c component-or-system? false? (listof false?))]
        )
       #:rest (rest (listof component-or-system?))
       [returns entity?])

  @{Returns a custom avatar, which will be placed in to the world
         automatically if it is passed into @racket[survival-game]
         via the @racket[#:avatar] parameter.}
  
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
                               (backpack-system #:pickup-sound   PICKUP-SOUND
                                                #:drop-sound     SHORT-BLIP-SOUND
                                                #:backpack-sound BLIP-SOUND
                                                #:components (observe-change backpack-changed? update-backpack))
                               (player-edge-system)
                               (observe-change lost? (kill-player-v2))
                               (counter 0)
                               (weapon-selector #:slots 10 #:select-sound BLIP-SOUND)
                               (on-key 'enter #:rule player-dialog-open? (get-dialog-selection))
                               (on-rule (not/r all-dialog-closed?) (stop-movement))
                               (cons c custom-components)))
  (define health-bar (stat-progress-bar 'red
                                        #:width 100
                                        #:height 10
                                        #:max max-health ;100 
                                        #:after (λ(e) (~> e
                                                          (remove-component _ lock-to?)
                                                          (remove-component _ active-on-bg?)
                                                          (add-component _
                                                                         (on-start
                                                                          (go-to-pos-inside 'top-left
                                                                                            #:posn-offset (posn 10 10))))))))

  #|(define sheild-bar (stat-progress-bar 'blue
                                        #:width 100
                                        #:height 10
                                        #:max 100
                                        #:after (λ(e) (~> e
                                                          (remove-component _ lock-to?)
                                                          (remove-component _ active-on-bg?)
                                                          (add-component _
                                                                         (on-start
                                                                          (go-to-pos-inside 'top-left
                                                                                            #:posn-offset (posn 10 10))))))))|#

  (combatant
   #:stats (list (make-stat-config 'health health health-bar #:max-value max-health)
                 ;(make-stat-config 'shield 100 sheild-bar)
                 )
   #:damage-processor dp         
   base-avatar)
  )

(define/contract/doc (custom-weapon #:name              [n "Repeater"]
                                    #:sprite            [s chest-sprite]
                                    #:dart-sprite       [ds (rectangle 10 2 "solid" "green")]
                                    #:speed             [spd 10]
                                    #:damage            [dmg 10]
                                    #:range             [rng 1000]
                                    #:dart              [b (custom-dart #:sprite ds
                                                                        #:speed spd
                                                                        #:damage dmg
                                                                        #:range rng)]
                                    #:fire-mode         [fm 'normal]
                                    #:fire-rate         [fr 3]
                                    #:fire-key          [key 'f]
                                    #:fire-sound        [fire-sound LASER-SOUND]
                                    #:mouse-fire-button [button #f]
                                    #:point-to-mouse?   [ptm? #f]
                                    #:rapid-fire?       [rf? #t]
                                    #:rarity            [rarity 'common])
  (->i ()
       (#:name              [name string?]
        #:sprite            [sprite (or/c sprite? (listof sprite?))]
        #:dart-sprite       [dart-sprite (or/c sprite? (listof sprite?))]
        #:speed             [speed  number?]
        #:damage            [damage number?]
        #:range             [range  number?]
        #:dart              [dart entity?]
        #:fire-mode         [fire-mode fire-mode?]
        #:fire-rate         [fire-rate number?]
        #:fire-key          [fire-key symbol?]
        #:fire-sound        [fire-sound (or/c rsound? procedure? '() #f)]
        #:mouse-fire-button [button (or/c 'left 'right false?)]
        #:point-to-mouse?   [ptm? boolean?]
        #:rapid-fire?       [rf? boolean?]
        #:rarity            [rarity rarity-level?])
       [result entity?])

  @{Returns a custom weapon, which will be placed in to the world
         automatically if it is passed into @racket[survival-game]
         via the @racket[#:weapon-list] parameter.}


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
                                                 #:fire-sound fire-sound
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
                                   #:health (health 100)
                                   ;#:shield (shield 100)
                                   #:weapon (weapon (custom-weapon #:name "Spitter"
                                                                   #:dart (acid-dart)))
                                   #:death-particles (particles (custom-particles))
                                   #:night-only? (night-only? #f)
                                   #:components (c #f)
                                   . custom-components
                                   )

  (->i () (#:amount-in-world [amount-in-world positive?]
           #:sprite [sprite (or/c sprite? (listof sprite?))]
           #:ai [ai ai-level?]
           #:health [health positive?]
           ;#:shield [shield positive?]
           #:weapon [weapon entity?]
           #:death-particles [death-particles entity?]
           #:night-only?     [night-only? boolean?]
           #:components [first-component any/c])
       #:rest [more-components (listof any/c)]
       [returns entity?])

  @{Returns a custom enemy, which will be placed in to the world
         automatically if it is passed into @racket[survival-game]
         via the @racket[#:enemy-list] parameter.}
  
  ;Makes sure that we can run (custom-enemy) through (entity-cloner ...)
  ;  Works because combatant ids get assigned at runtime.
  ;(Otherwise, they'd all end up with the same combatant id, and a shared healthbar)
  (define (become-combatant g e)

    (define c (~> e
                  (combatant
                   #:stats (list (make-stat-config 'health health (stat-progress-bar 'red #:max health #:offset (posn 0 -30))
                                                   #:max-value health))
                   #:damage-processor (filter-damage-by-tag #:filter-out '(passive enemy-team)
                                                            #:hit-sound HIT-SOUND)
                             _)
                  ))
 
    c)

  ; Deaths are not tracked in survival but remains an option if needed
  (define death-broadcast
    (sprite->entity empty-image
                    #:name "Enemy Death Broadcast"
                    #:position (posn 0 0)
                    #:components (on-start die)))
  
  (define (health-is-zero? g e)
    (define h (get-health e))
    (and h (<= h 0)))
  
  (define (die-if-health-is-0)
    (observe-change health-is-zero?
                    (λ (g e1 e2)
                      (if (health-is-zero? g e2)
                          ((do-many
                            (play-sound EXPLOSION-SOUND)
                            (spawn particles)
                            (spawn death-broadcast)
                            (do-after-time 1 die)) g e2)
                          e2))
                    ))
  
  (custom-combatant #:name "Enemy"
                    #:sprite s
                    #:position (posn 0 0)
                    #:mode #f
                    ;#:components 

                    ;What is making these guys slow???
                    (die-if-health-is-0)
                    (sound-stream)
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
                 #:avatar          [p      (custom-avatar #:sprite (circle 10 'solid 'red))]
                 #:starvation-rate [sr 50]
                 #:sky             [sky (custom-sky)]
                 #:npc-list        [npc-list  '()]
                 #:enemy-list      [e-list    '()]
                 #:coin-list       [coin-list '()]
                 #:food-list       [f-list    '()]
                 #:crafter-list    [c-list    '()]
                 #:score-prefix    [prefix "Gold"]
                 #:enable-world-objects? [world-objects? #f]
                 #:weapon-list     [weapon-list '()] ; survival doesn't need weapons in the wild
                 #:other-entities  [ent #f]
                                   . custom-entities)
  (->i ()
       (#:headless         [headless boolean?]
        #:bg               [bg entity?]
        #:avatar           [avatar (or/c entity? #f)]
        #:starvation-rate  [starvation-rate number?]
        #:sky              [sky (or/c sky? #f)]
        #:npc-list         [npc-list     (listof (or/c entity? procedure?))]
        #:enemy-list       [enemy-list   (listof (or/c entity? procedure?))]
        #:coin-list        [coin-list    (listof (or/c entity? procedure?))]
        #:food-list        [food-list    (listof (or/c entity? procedure?))]
        #:crafter-list     [crafter-list (listof (or/c entity? procedure?))]
        #:score-prefix     [prefix string?]
        #:enable-world-objects? [world-objects? boolean?]
        #:weapon-list      [weapon-list (listof (or/c entity? procedure?))] 
        #:other-entities   [other-entities (or/c #f entity? (listof #f) (listof entity?))])
       #:rest [rest (listof entity?)]
       [res () game?])

  @{The top-level function for the survival-game language.
         Can be run with no parameters to get a basic, default game.}

  ; === AUTO INSTRUCTIONS ===

  (define (weapon-entity->player-system e)
    (get-storage-data "Weapon" e))

  ;------------------
  (define move-keys (if (and p (eq? (get-key-mode p) 'wasd))
                        "WASD KEYS"
                        "ARROW KEYS"))

  (define (mouse-aim-component? c)
    (and (on-rule? c)
         (eq? (on-rule-rule? c) mouse-in-game?)
         (eq? (on-rule-func c) point-to-mouse)))

  (define mouse-aim? (and p
                          (get-component p mouse-aim-component?)))

  (define updated-food-list  (clone-by-amount-in-world f-list))
  (define updated-coin-list  (clone-by-amount-in-world coin-list))
  (define updated-enemy-list (clone-by-amount-in-world e-list))

  (define (food->toast-entity f)
    (define heal-amt (get-storage-data "heals-by" f))
    (player-toast-entity (~a "+" heal-amt) #:color "green"))

  (define starvation-period (max 1 (- 100 (min 100 sr))))

  ;(define food-img-list (map (λ (f) (render (get-component f animated-sprite?))) f-list))

  (define known-products-list (map recipe-product known-recipes-list))

  (define known-weapons-list (filter (curry get-storage "Weapon") known-products-list))

  (define (known-weapon? e)
    (member (get-name e) (map get-name known-weapons-list)))
  
  (define world-weapon-list (filter (not/c known-weapon?) weapon-list))
  
  (define player-with-recipes-and-weapons
    (if p
        (add-components p (map weapon-entity->player-system known-weapons-list) ;added weapon stuff
                          (map weapon-entity->player-system world-weapon-list)
                          (map recipe->system known-recipes-list)
                          ;(apply precompiler (remove-duplicates updated-food-list render-eq?))                                ;f-list
                          (map food->component
                               (append (remove-duplicates updated-food-list
                                                          name-eq?)
                                       (filter-not (curry get-storage "Weapon") known-products-list)))                  ;f-list
                          (do-every starvation-period
                                    (do-many (change-health-by -1)
                                             (spawn (player-toast-entity "-1" #:color "orangered") #:relative? #f))))
        #f))

  ;--------
  (define shoot-key (if (and player-with-recipes-and-weapons (get-component player-with-recipes-and-weapons on-mouse?))
                        "LEFT-CLICK"
                        "F"))
  ;--------

  (define bg-with-instructions
    (add-components bg-ent (on-key "i" #:rule (λ (g e) (not (get-entity "instructions" g)))
                                   (spawn (instructions-entity #:move-keys move-keys
                                                               #:mouse-aim? mouse-aim?
                                                               #:shoot-key shoot-key)
                                          #:relative? #f))))
  
  (define (add-random-start-pos e)
    (define world-amt (get-storage-data "amount-in-world" e))
    (if (> world-amt 0) 
        (add-components e (hidden)
                          (on-start (do-many (active-on-random)
                                             (respawn 'anywhere)
                                             show)))
        e))

  (define LENGTH-OF-DAY    (if sky (sky-day-length sky) 2400))
  (define START-OF-DAYTIME (if sky (sky-day-start sky) 0))
  (define END-OF-DAYTIME   (if sky (sky-day-end sky) 2400))

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

  (define (score-entity prefix)
    (define counter-sprite
      (append (list (new-sprite (~a (string-titlecase prefix) ": 0")
                        #:color 'yellow))
              (bordered-box-sprite (* 10 (+ 7 (string-length prefix))) 24)
                   ))

    (define (recipe-has-cost? r)
      (> (recipe-cost r) 0))

    (define (start-dead-component? c)
      (and (on-start? c)
           (eq? (on-start-func c) die)))
  
    ;Add more checks to this.
    (define (npc-healed? g e)
      (define healed-broadcast (get-entity "NPC Healed Broadcast" g))
      (and healed-broadcast
           (get-component healed-broadcast start-dead-component?))) ; This is still read twice in the same tick
    
    (sprite->entity counter-sprite
                    #:name       "score"
                    #:position   (posn 330 20)
                    #:components (static)
                                 (counter 0)
                                 (layer "ui")
                                 (on-rule npc-healed? (do-many (change-counter-by 1) ; double counting fixed!
                                                               (draw-counter-rpg #:prefix (~a prefix ": ") #:exact-floor? #t)
                                                               (do-font-fx)
                                                               ))
                                 (map (curryr coin->component prefix) (remove-duplicates updated-coin-list name-eq?))
                                 (map (curry recipe->coin-system #:prefix prefix) (filter recipe-has-cost? known-recipes-list))))
 
  (define (spawn-many-on-current-tile e-list)
    (apply do-many (map spawn-on-current-tile e-list)))

  (define (night-only? e)
    (define ent (if (procedure? e)
                    (e)
                    e))
    (get-storage-data "night-only?" ent))

  (define enemies-with-night-code
    (map maybe-add-night-only updated-enemy-list))

  (define (tm-entity)
    (time-manager-entity
     #:components (on-start (set-counter START-OF-DAYTIME))
                  (on-rule (reached-multiple-of? LENGTH-OF-DAY #:offset END-OF-DAYTIME)
                           (do-many (spawn (toast-entity "NIGHTTIME HAS BEGUN"))
                                    (spawn-many-on-current-tile (filter night-only? enemies-with-night-code))
                                    ))
                  (on-rule (reached-multiple-of? LENGTH-OF-DAY #:offset START-OF-DAYTIME)
                           (spawn (toast-entity "DAYTIME HAS BEGUN")))
                  ;(on-key 't (start-stop-game-counter)) ; !!!!! for testing only remove this later !!!!!!
     ))
  
  (define es (filter identity
                     (flatten
                      (list
                       (instructions-entity #:move-keys move-keys
                                            #:mouse-aim? mouse-aim?
                                            #:shoot-key shoot-key)
                       (if p (game-over-screen won? lost?) #f)
                       (if p (score-entity prefix) #f)

                       (tm-entity)
                       (if sky
                           (night-sky-with-lighting #:color         (sky-color sky)
                                                    #:max-alpha     (sky-max-alpha sky)
                                                    #:length-of-day (sky-day-length sky))
                            #f)

                       ;(if p (health-entity) #f)

                       player-with-recipes-and-weapons

                       (clone-by-rarity weapon-list) ; surival doesn't need weapons in the wild
                       
                       npc-list
                       
                       c-list
                       
                       (map add-random-start-pos updated-food-list)
                       (map add-random-start-pos updated-coin-list)
                       enemies-with-night-code
                       
                       (cons ent custom-entities)

                       (if world-objects?
                           (make-world-objects round-tree pine-tree)
                           #f)
              
                       bg-with-instructions))))
  
  (if headless
      (initialize-game (map (curryr remove-component sound-stream?) es))
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
                                     #:open-key     [open-key 'space]
                                     #:open-sound   [open-sound OPEN-DIALOG-SOUND]
                                     #:select-sound [select-sound BLIP-SOUND]
                                     #:recipe-list [r-list (list (recipe #:product (carrot-stew)
                                                                         #:build-time 30
                                                                         ))]
                                     #:components [c #f] . custom-components)
  (->i ()
       (#:position   [position posn?]
        #:tile       [tile number?]
        #:name       [name string?]
        #:sprite     [sprite (or/c sprite? (listof sprite?))]
        #:open-key     [open-key (or/c string? symbol?)]
        #:open-sound   [open-sound (or/c rsound? procedure? '() #f)]
        #:select-sound [select-sound (or/c rsound? procedure? '() #f)]
        #:recipe-list [recipe-list (listof recipe?)]
        #:components [first-component component-or-system?])
       #:rest       [more-components (listof component-or-system?)]
       [result entity?])

  @{Returns a custom crafter, which will be placed in to the world
         automatically if it is passed into @racket[survival-game]
         via the @racket[#:crafter-list] parameter.}
  
  (crafting-chest p
                  #:sprite sprite
                  #:name   name
                  #:components (active-on-bg t)
                               (counter 0)
                               (crafting-menu-set! #:open-key     open-key
                                                   #:open-sound   open-sound
                                                   #:select-sound select-sound
                                                   #:recipe-list r-list)
                               (apply precompiler (map (λ (r) (recipe-product r)) r-list))
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

  (->i () (#:sprite     [sprite (or/c sprite? (listof sprite?))]
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
           #:components [first-component (or/c component-or-system? observe-change?)])
       #:rest [more-components (listof (or/c component-or-system? observe-change?))]
       [returns entity?])

 @{Returns a custom npc, which will be placed in to the world
         automatically if it is passed into @racket[survival-game]
         via the @racket[#:npc-list] parameter.}
  
  (define dialog
    (if (not d)
        (dialog->sprites (first (shuffle (list (list "It's dangerous out here!")
                                               (list "You should find food to survive.")
                                               (list "Sorry, I don't have time to talk now.")
                                               (list "I'm hungry..."))))
                     #:game-width GAME-WIDTH
                     #:animated #t
                     #:speed 2)
        (if (string? (first d))
            (dialog->sprites d
                             #:game-width GAME-WIDTH
                             #:animated #t
                             #:speed    2)
            (dialog->response-sprites d
                                      #:game-width GAME-WIDTH
                                      #:animated #t
                                      #:speed 2))))
  
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

(define/contract/doc (custom-bg #:image      [bg FOREST-BG]
                                #:rows       [rows 3]
                                #:columns    [cols 3]
                                #:start-tile [t 0]
                                #:hd?        [hd? #f]
                                #:components [c #f]
                                . custom-components)

  (->i ()
       (#:image [bg-img image?]
        #:rows   [rows number?]
        #:columns [columns number?]
        #:start-tile [start-tile number?]
        #:hd?        [high-def? boolean?]
        #:components [first-component (or/c component-or-system? #f (listof #f))])
       #:rest [more-components (listof component-or-system?)]
       [result entity?])

  @{Returns a custom background, which will be used
         automatically if it is passed into @racket[survival-game]
         via the @racket[#:bg] parameter.}

  (define bg-base-entity
    (if hd?
        (bg->backdrop-entity bg
                             #:rows       rows
                             #:columns    cols
                             #:start-tile t)
        (bg->backdrop-entity (scale 0.25 bg)
                             #:rows       rows
                             #:columns    cols
                             #:start-tile t
                             #:scale 4)))
  
  (add-components bg-base-entity
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
           #:sprite     [sprite (or/c sprite? (listof sprite?))]
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
              automatically if it is passed into @racket[survival-game]
              via the @racket[#:food-list] parameter.}
  
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
            #:sprite   [sprite (or/c sprite? (listof sprite?) #f)]
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
              automatically if it is passed into @racket[survival-game]
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

; ==== PREBUILT WEAPONS & DARTS ====
(define (spear #:name              [n "Spear"]
               #:icon              [i [make-icon "SP" 'brown]]
               #:sprite            [s spear-sprite]
               #:damage            [dmg 25]
               #:durability        [dur 20]
               #:speed             [spd 5]
               #:range             [rng 20]
               #:dart              [d (spear-dart #:sprite s
                                                  #:damage dmg
                                                  #:durability dur
                                                  #:speed spd
                                                  #:range rng)]
               #:fire-mode         [fm 'normal]
               #:fire-rate         [fr 3]
               #:fire-key          [key 'f]
               #:fire-sound        [fire-sound random-woosh-sound] ; TODO: Create a default melee sound
               #:mouse-fire-button [button #f]
               #:point-to-mouse?   [ptm? #f]
               #:rapid-fire?       [rf? #f]
               #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define (spear-dart #:sprite     [s spear-sprite]
                    #:damage     [dmg 25]
                    #:durability [dur 20]
                    #:speed      [spd 5]
                    #:range      [rng 20])
  (custom-dart #:position (posn 20 0)
               #:sprite s
               #:damage dmg
               #:durability dur
               #:speed spd
               #:range rng
               #:components (after-time (/ rng 2) (do-many (bounce)
                                                           (horizontal-flip-sprite)))))

(define (sword #:name              [n "Sword"]
               #:icon              [i [make-icon "SW" 'silver]]
               #:sprite            [s swinging-sword-sprite]
               #:damage            [dmg 25]
               #:durability        [dur 20]
               #:speed             [spd 0]
               #:duration          [rng 10]
               #:dart              [d (sword-dart #:sprite s
                                                  #:damage dmg
                                                  #:durability dur
                                                  #:speed spd
                                                  #:duration rng)]
               #:fire-mode         [fm 'normal]
               #:fire-rate         [fr 3]
               #:fire-key          [key 'f]
               #:fire-sound        [fire-sound random-slash-sound]
               #:mouse-fire-button [button #f]
               #:point-to-mouse?   [ptm? #f]
               #:rapid-fire?       [rf? #f]
               #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define (sword-dart #:sprite     [s swinging-sword-sprite]
                    #:damage     [dmg 50]
                    #:durability [dur 20]
                    #:speed      [spd 0]
                    #:duration   [rng 10])
  (custom-dart #:position (posn 10 0)
               #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng
               #:components (every-tick (change-direction-by 15))))

(define acid-sprite
  (overlay/offset (rotate -45 (rectangle 6 4 'solid 'green))
                  -3 3
                  (overlay (circle 10 'outline 'green)
                           (circle 10 'solid (make-color 180 200 0 128)))))

(define (acid-dart  #:sprite     [s   acid-sprite]
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

(define (acid-spitter  #:name              [n "Acid Spitter"]
                       #:icon              [icon (make-icon "AS")]
                       #:sprite            [s   acid-sprite]
                       #:damage            [dmg 10]
                       #:durability        [dur 5]
                       #:speed             [spd 3]
                       #:range             [rng 100]
                       #:dart              [d (acid-dart #:sprite s
                                                         #:damage dmg
                                                         #:durability dur
                                                         #:speed spd
                                                         #:range rng)]
                       #:fire-mode         [fm 'normal]
                       #:fire-rate         [fr 3]
                       #:fire-key          [key 'f]
                       #:fire-sound        [fire-sound #f] ; TODO: Create a bubble sound
                       #:mouse-fire-button [button #f]
                       #:point-to-mouse?   [ptm? #f]
                       #:rapid-fire?       [rf? #t]
                       #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite icon
                 #:dart   d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-key key
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse?   ptm?
                 #:rapid-fire?       rf?
                 #:rarity            rarity))

(define (fire-magic #:name              [n "Fire Magic"]
                    #:icon              [i [make-icon "FM" 'red]]
                    #:sprite            [s flame-sprite]
                    #:damage            [dmg 5]
                    #:durability        [dur 5]
                    #:speed             [spd 3]
                    #:range             [rng 20]
                    #:dart              [d (fire-dart #:sprite s
                                                       #:damage dmg
                                                       #:durability dur
                                                       #:speed spd
                                                       #:range rng)]
                    #:fire-mode         [fm 'random]
                    #:fire-rate         [fr 10]
                    #:fire-key          [key 'f]
                    #:fire-sound        [fire-sound FIRE-MAGIC-SOUND]
                    #:mouse-fire-button [button #f]
                    #:point-to-mouse?   [ptm? #f]
                    #:rapid-fire?       [rf? #t]
                    #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define (fire-dart #:sprite     [s   flame-sprite]
                   #:damage     [dmg 5]
                   #:durability [dur 5]
                   #:speed      [spd 3]
                   #:range      [rng 20])
  (custom-dart #:position (posn 25 0)
               #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng
               #:components (on-start (set-size 0.5))
               (every-tick (scale-sprite 1.1))))

(define (ice-magic #:name              [n "Ice Magic"]
                   #:icon              [i [make-icon "IM" 'lightcyan]]
                   #:sprite            [s ice-sprite]
                   #:damage            [dmg 5]
                   #:durability        [dur 5]
                   #:speed             [spd 3]
                   #:range             [rng 20]
                   #:dart              [d (ice-dart #:sprite s
                                                    #:damage dmg
                                                    #:durability dur
                                                    #:speed spd
                                                    #:range rng)]
                   #:fire-mode         [fm 'random]
                   #:fire-rate         [fr 10]
                   #:fire-key          [key 'f]
                   #:fire-sound        [fire-sound ICE-MAGIC-SOUND]
                   #:mouse-fire-button [button #f]
                   #:point-to-mouse?   [ptm? #f]
                   #:rapid-fire?       [rf? #t]
                   #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define ice-sprite
  (overlay (circle 5 "solid" "white")
           (circle 6 "solid" "cyan")
           (circle 7 "solid" "blue")))

(define (ice-dart #:sprite     [s   ice-sprite]
                  #:damage     [dmg 5]
                  #:durability [dur 5]
                  #:speed      [spd 3]
                  #:range      [rng 20])
  (custom-dart #:position (posn 25 0)
               #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng
               #:components (on-start (set-size 0.5))
               (every-tick (scale-sprite 1.1))))

(define (sword-magic #:name              [n "Sword Magic"]
                     #:icon              [i [make-icon "SM" 'silver]]
                     #:sprite            [s flying-sword-sprite]
                     #:damage            [dmg 10]
                     #:durability        [dur 20]
                     #:speed             [spd 4]
                     #:range             [rng 40]
                     #:dart              [d (flying-dagger-dart #:sprite s
                                                                #:damage dmg
                                                                #:durability dur
                                                                #:speed spd
                                                                #:range rng)]
                     #:fire-mode         [fm 'spread]
                     #:fire-rate         [fr 1]
                     #:fire-key          [key 'f]
                     #:fire-sound        [fire-sound random-woosh-sound]
                     #:mouse-fire-button [button #f]
                     #:point-to-mouse?   [ptm? #f]
                     #:rapid-fire?       [rf? #t]
                     #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define (flying-dagger-dart #:position   [p   (posn 20 0)]
                            #:sprite     [s   flying-sword-sprite]
                            #:damage     [dmg 10]
                            #:durability [dur 20]
                            #:speed      [spd 4]
                            #:range      [rng 40])
  (custom-dart #:position p
               #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng
               #:components (on-start (do-many (set-size 0.5)))
               (do-every 10 (change-direction-by-random -25 25))))

(define (ring-of-blades #:name              [n "Ring of Blades"]
                        #:icon              [i (make-icon "RoB" 'silver)]
                        #:sprite            [s flying-sword-sprite]
                        #:damage            [dmg 10]
                        #:durability        [dur 20]
                        #:speed             [spd 10]
                        #:duration          [rng 36]
                        #:dart              [d (ring-of-blades-dart #:sprite s
                                                                    #:damage dmg
                                                                    #:durability dur
                                                                    #:speed spd
                                                                    #:duration rng)]
                        #:fire-mode         [fm 'normal]
                        #:fire-rate         [fr 6]
                        #:fire-key          [key 'f]
                        #:fire-sound        [fire-sound random-woosh-sound]
                        #:mouse-fire-button [button #f]
                        #:point-to-mouse?   [ptm? #f]
                        #:rapid-fire?       [rf? #t]
                        #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define (ring-of-blades-dart #:sprite     [s   flying-sword-sprite]
                             #:damage     [dmg 10]
                             #:durability [dur 20]
                             #:speed      [spd 10]
                             #:duration   [rng 36])
  (custom-dart #:position   (posn 25 0)
               #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng
               #:components (on-start (set-size 0.5))
               (every-tick (do-many ;(scale-sprite 1.05)
                                    (change-direction-by 10)))))


(define (ring-of-fire #:name              [n "Ring of Fire"]
                      #:icon              [i (make-icon "RoF" 'red)]
                      #:sprite            [s flame-sprite]
                      #:damage            [dmg 5]
                      #:durability        [dur 20]
                      #:speed             [spd 10]
                      #:duration          [rng 36]
                      #:dart              [d (ring-of-fire-dart #:sprite s
                                                                #:damage dmg
                                                                #:durability dur
                                                                #:speed spd
                                                                #:duration rng)]
                      #:fire-mode         [fm 'normal]
                      #:fire-rate         [fr 10]
                      #:fire-key          [key 'f]
                      #:fire-sound        [fire-sound FIRE-MAGIC-SOUND]
                      #:mouse-fire-button [button #f]
                      #:point-to-mouse?   [ptm? #f]
                      #:rapid-fire?       [rf? #t]
                      #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define (ring-of-ice #:name              [n "Ring of Ice"]
                     #:icon              [i (make-icon "RoI" 'lightcyan)]
                     #:sprite            [s ice-sprite]
                     #:damage            [dmg 5]
                     #:durability        [dur 20]
                     #:speed             [spd 10]
                     #:duration          [rng 36]
                     #:dart              [d (ring-of-fire-dart #:sprite s
                                                               #:damage dmg
                                                               #:durability dur
                                                               #:speed spd
                                                               #:duration rng)]
                     #:fire-mode         [fm 'normal]
                     #:fire-rate         [fr 10]
                     #:fire-key          [key 'f]
                     #:fire-sound        [fire-sound ICE-MAGIC-SOUND]
                     #:mouse-fire-button [button #f]
                     #:point-to-mouse?   [ptm? #f]
                     #:rapid-fire?       [rf? #t]
                     #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define (ring-of-fire-dart #:sprite     [s   flame-sprite]
                           #:damage     [dmg 5]
                           #:durability [dur 20]
                           #:speed      [spd 10]
                           #:duration   [rng 36])
  (custom-dart #:position   (posn 25 0)
               #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng
               #:components (on-start (set-size 0.5))
               (every-tick (do-many (scale-sprite 1.05)
                                    (change-direction-by 10)))))

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

; We could use some more naturally occuring food like
;  seeds, berries, nuts, fruit, etc
(define (random-food #:amount-in-world [amt 1]
                     #:position        [p (posn 100 100)]
                     #:tile            [t 0]
                     #:respawn?        [respawn? #f]
                     #:components      [c #f]
                     . custom-components)
  (define food-sets (list (list "Carrot" carrot-sprite 10)
                          (list "Fish"  fish-sprite 20)
                          (list "Carrot Stew" carrot-stew-sprite 30)))
  (define choice (random (length food-sets)))
  (custom-food #:name     (first (list-ref food-sets choice))
               #:sprite   (second (list-ref food-sets choice))
               #:heals-by (third (list-ref food-sets choice))
               #:amount-in-world amt
               #:position p
               #:tile t
               #:respawn? respawn?
               #:components (cons c custom-components)))

(define (random-coin #:amount-in-world [amt 1]
                     #:position        [p (posn 100 100)]
                     #:tile            [t 0]
                     #:respawn?        [respawn? #f]
                     #:components      [c #f]
                     . custom-components)
  (define coin-sets (list (list "Copper Coin" copper-coin-sprite 1)
                          (list "Silver Coin" silver-coin-sprite 10)
                          (list "Gold Coin"   gold-coin-sprite   25)))
  (define choice (random (length coin-sets)))
  (custom-coin #:name     (first (list-ref coin-sets choice))
               #:sprite   (second (list-ref coin-sets choice))
               #:value    (third (list-ref coin-sets choice))
               #:amount-in-world amt
               #:position p
               #:tile t
               #:respawn? respawn?
               #:components (cons c custom-components)))

(module test racket
  (displayln "TEST!!!")
  )

