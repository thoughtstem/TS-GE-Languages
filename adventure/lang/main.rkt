#lang at-exp racket

(provide crafting-menu-set!
         known-recipes-list
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
                 
         repeater
         acid-spitter
         spear
         sword
         fire-magic
         ice-magic
         sword-magic
         ring-of-fire
         ring-of-ice
         ring-of-blades
         fireball
         
         acid-dart
         spear-dart
         sword-dart
         fire-dart
         ice-dart
         flying-dagger-dart
         ring-of-fire-dart
         fireball-dart

         acid-sprite
         ice-sprite
         basic-sprite

         fetch-quest
         craft-quest
         collect-quest
         hunt-quest
         loot-quest

         ensure-storable-with-id
         (rename-out (ensure-storable-with-id make-storable))

         random-player-dialog-with
         random-npc-response
         (rename-out (custom-sky basic-sky)
                     (custom-avatar basic-avatar)
                     (custom-weapon basic-weapon)
                     (custom-enemy basic-enemy)
                     (custom-crafter basic-crafter)
                     (custom-npc basic-npc)
                     (custom-bg basic-bg)
                     (custom-food basic-food)
                     (custom-coin basic-coin)
                     ;(custom-cutscene cutscene)
                     (cutscene basic-cutscene)
                     (custom-item basic-item)
                     (custom-product basic-product)
                     )
         )

(require scribble/srcdoc)

(require (for-doc racket/base scribble/manual ))

(require ts-kata-util
         (only-in racket/draw make-font)
         )

(require game-engine
         game-engine-demos-common
         (only-in lang/posn make-posn)
         )


; ==== START OF ERROR PORT HACK ====
(define default-error-handler (error-display-handler))

(define (new-error-handler msg trace)
  (displayln (first (shuffle (list "==== ERROR! YOUR CODE IS NOT PERFECT ===="
                                   "==== IT'S OK, WE ALL MAKE MISTAKES ===="
                                   "==== ARE YOU SURE THAT'S RIGHT? ===="
                                   "==== IF AT FIRST YOU DON'T SUCCEED, TRY, TRY AGAIN ===="
                                   "==== NEVER GIVE UP, NEVER SURRENDER ===="
                                   "==== OOPS! SOMETHING WENT WRONG ===="
                                   "==== AWESOME! A BUG! ===="
                                   "==== PRO DEBUGGERS ARE PRO CODERS ===="))))
  (default-error-handler msg trace)
  )

(error-display-handler new-error-handler)

; ==== END OF ERROR PORT HACK ====

(define STORABLE-ITEM-ID-COUNTER 0)

(define (next-storable-item-id)
  (set! STORABLE-ITEM-ID-COUNTER (add1 STORABLE-ITEM-ID-COUNTER))
  STORABLE-ITEM-ID-COUNTER)

(define-syntax-rule (define/log l head body ...)
  (define head
    (let ()
      (displayln l)
      body ...)))

(define dialog-str? (or/c (listof string?) (listof (listof string?)) #f))

(define rarity-level?
  (or/c 'common 'uncommon 'rare 'epic 'legendary))

(define fire-mode?    (or/c 'normal 'random 'spread 'homing))

(define (name-eq? e1 e2)
  (eq? (get-name e1) (get-name e2)))

(define (render-eq? e1 e2)
  (define s1 (get-component e1 animated-sprite?))
  (define s2 (get-component e2 animated-sprite?))
  (equal? (render s1) (render s2)))

(define (do-nothing)
    (λ (g e) e))

(struct sky (color day-length day-start day-end max-alpha))

(define (mround-up num multiple)
  (define rounded-num (exact-round num))
  (define remainder (modulo rounded-num multiple))
  (cond [(= remainder 0) rounded-num]
        [else (+ rounded-num multiple (- remainder))]))

(define known-loot-list '())

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
         of @racket[adventure-game].}
  
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

;default sky is sized for 2x 480 by 360
(define (sky-sprite-with-light color #:scale [scale 1])
  (define sky-img (draw-sky-with-light color))
  (new-sprite sky-img #:scale (* scale 20.167)))

(define (night-sky-with-lighting #:color         [color 'black]
                                 #:max-alpha     [m-alpha 160]
                                 #:length-of-day [length-of-day 2400]
                                 #:scale         [scale 1])
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
    (define new-night-sky (sky-sprite-with-light (make-color r-val g-val b-val alpha-val) #:scale scale))
    (update-entity e animated-sprite? new-night-sky))
  (sprite->entity (sky-sprite-with-light (make-color r-val g-val b-val max-alpha) #:scale scale)
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

(define (instructions-entity #:move-keys  [move-keys "ARROW KEYS"]
                             #:mouse-aim? [mouse-aim? #f]
                             #:shoot-key  [shoot-key "F"])

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
                                        "B to open and close backpack"
                                        "M to open and close map")))
  (apply make-instructions i-list))
     
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
                  ;(draw-counter-rpg #:prefix (~a (string-titlecase prefix) ": "))
                  ;(do-font-fx)
                  (spawn coin-toast-entity)) g e2)
        e2))
  (observe-change (crafting? product-name) remove-gold))

; === WON AND LOST RULES ===
(define (won? g e)
  #f)

(define (kill-player-v2)
  (lambda (g e1 e2)
    (if (lost? g e2)
        ((do-many (stop-all-animations)
                  remove-all-but-basics
                  (stop-movement)
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

(define score-font (make-font #:size 13 #:face MONOSPACE-FONT-FACE #:family 'modern))
(define bold-font (make-font #:size 13 #:face MONOSPACE-FONT-FACE #:family 'modern #:weight 'bold))

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
                             ;(draw-counter-rpg #:prefix (~a (string-titlecase prefix) ": "))
                             ;(do-font-fx)
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
        #:components [first-component component-or-system?])
       #:rest       [more-components (listof component-or-system?)]
       [returns entity?])

  @{Returns a custom avatar, which will be placed in to the world
         automatically if it is passed into @racket[adventure-game]
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
                                        #:max max-health 
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

  (player-combatant
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
                                    #:rarity            [rarity 'common]
                                    #:on-store          [store-func (do-nothing)]
                                    #:on-drop           [drop-func (do-nothing)])
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
        #:rarity            [rarity rarity-level?]
        #:on-store          [store-func procedure?]
        #:on-drop           [drop-func procedure?])
       [result entity?])

  @{Returns a custom weapon, which will be placed in to the world
         automatically if it is passed into @racket[adventure-game]
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
  (define item-id (next-storable-item-id))
  
  (sprite->entity s
                  #:name updated-name
                  #:position    (posn 0 0)
                  #:components  (active-on-bg 0)
                  
                                (physical-collider)
                                (storage "Weapon" weapon-component)
                                (storage "Rarity" rarity)
                                (storage "item-id" item-id)
                                (storage "backpack-observer"
                                         (observe-change (in-backpack-by-id? item-id)
                                                         (if/r (in-backpack-by-id? item-id)
                                                               store-func
                                                               drop-func)))

                                (static)
                                (hidden)
                                (on-start (do-many ;(respawn 'anywhere)
                                                   ;(active-on-random)
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
                                   #:position [pos #f]
                                   #:tile [tile #f]
                                   #:sprite (s (first (shuffle (list slime-sprite bat-sprite snake-sprite))))
                                   #:ai (ai-level 'medium)
                                   #:health (health 100)
                                   ;#:shield (shield 100)
                                   #:weapon (weapon (custom-weapon #:name "Spitter"
                                                                   #:dart (acid-dart)))
                                   #:death-particles (particles (custom-particles))
                                   #:night-only? (night-only? #f)
                                   #:on-death  [death-func (do-nothing)]
                                   #:loot-list [loot-list '()]
                                   #:components (c #f)
                                   . custom-components
                                   )

  (->i () (#:amount-in-world [amount-in-world positive?]
           #:position [pos (or/c posn? #f)]
           #:tile   [tile (or/c number? #f)]
           #:sprite [sprite (or/c sprite? (listof sprite?))]
           #:ai [ai ai-level?]
           #:health [health positive?]
           ;#:shield [shield positive?]
           #:weapon [weapon entity?]
           #:death-particles [death-particles entity?]
           #:night-only?     [night-only? boolean?]
           #:on-death        [death-function procedure?]
           #:loot-list       [loot-list (listof (or/c entity? procedure?))]
           #:components [first-component component-or-system?])
       #:rest       [more-components (listof component-or-system?)]
       [returns entity?])

  @{Returns a custom enemy, which will be placed in to the world
         automatically if it is passed into @racket[adventure-game]
         via the @racket[#:enemy-list] parameter.}

  (apply precompile! loot-list)
  (precompile! s)

  (set! known-loot-list (append loot-list known-loot-list))
  
  ;Makes sure that we can run (custom-enemy) through (entity-cloner ...)
  ;  Works because combatant ids get assigned at runtime.
  ;(Otherwise, they'd all end up with the same combatant id, and a shared healthbar)
  (define (become-combatant g e)

    (define c (~> e
                  (combatant
                   #:stats (list (make-stat-config 'health
                                                   health
                                                   (stat-progress-bar-system 'red #:max health #:offset (posn 0 -30))
                                                   #:max-value health)) ;(default-health+shields-stats health shield)
                   #:damage-processor (filter-damage-by-tag #:filter-out '(passive enemy-team)
                                                            #:hit-sound HIT-SOUND)
                             _)
                  ))
 
    c)
  
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
                          ((apply do-many
                                  (flatten (list (play-sound EXPLOSION-SOUND)
                                                 (spawn particles)
                                                 (spawn death-broadcast)
                                                 death-func
                                                 (map spawn-on-current-tile loot-list)
                                                 (do-after-time 1 die)))) g e2)
                          e2))
                    ))
  
  (custom-combatant #:name "Enemy"
                    #:sprite s
                    #:position (or pos (posn 0 0))
                    #:tile (or tile 0)
                    ;#:mode #f
                    ;#:components 

                    ;What is making these guys slow???
                    (die-if-health-is-0)
                    (sound-stream)
                    (damager 10 (list 'passive 'enemy-team 'bullet))
                    (hidden)
                    ;(active-on-bg 0) ;Don't leave this in
                    (on-start (do-many ;(if pos (do-nothing) (respawn 'anywhere))
                                       ;(if tile (do-nothing) (active-on-random))
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


(define (custom-combatant #:sprite     [s (random-character-sprite)]
                          #:position   [p (posn 0 0)]
                          #:name       [name (first (shuffle (list "Adrian" "Alex" "Riley"
                                                                   "Sydney" "Charlie" "Andy")))]
                          #:tile       [tile 0]
                          ;#:mode       [mode 'wander]
                          ;#:game-width [GAME-WIDTH 480]
                          #:speed      [spd 2]
                          ;#:target     [target "player"]
                          ;#:sound      [sound #t]
                          ;#:scale      [scale 1]
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

(define (ensure-storable-with-id e)
  (add-components e (filter identity (list (if (get-storage "item-id" e)
                                               #f
                                               (storage "item-id" (next-storable-item-id)))
                                           (if (get-component e storable?)
                                               #f
                                               (storable))))))

; ===== QUEST FUNCTIONS =====
(define (fetch-quest #:item i
                     #:reward-amount [reward-amount #f]  
                     #:quest-complete-dialog [quest-complete-dialog (filter identity
                                                                            (list (~a "Thanks for finding my " (get-name i) ".")
                                                                                  (if reward-amount "Here's a reward for helping me out!" #f)))]
                     #:new-response-dialog   [new-response-dialog (list "Thanks again for helping me out!"
                                                                        "I don't know what I would do"
                                                                        (~a "without my " (get-name i) "."))]
                     #:cutscene              [cutscene #f])
  (define item (ensure-storable-with-id i))
  (flatten (list (storage (~a "fetch-reward-" (get-storage-data "item-id" item)) (list item reward-amount)) ;or should i just store the item-id or grab it from the name?
                 (quest #:rule (and/r (in-game-by-id? (get-storage-data "item-id" item))
                                      ;(near? "player") ;removing since observe change gets re-triggered by moving 
                                      )
                        #:quest-complete-dialog (dialog->sprites quest-complete-dialog #:game-width 480)
                        #:new-response-dialog (cond
                                                [((listof (listof string?)) new-response-dialog)
                                                 (dialog->response-sprites new-response-dialog #:game-width 480)]
                                                [((listof string?) new-response-dialog)
                                                 (dialog->sprites new-response-dialog #:game-width 480)]
                                                [else #f])
                        #:cutscene cutscene))))

(define (craft-quest #:item i
                     #:reward-amount [reward-amount #f]  
                     #:quest-complete-dialog [quest-complete-dialog (filter identity
                                                                            (list "Thanks for making me a ... "
                                                                                  (~a (get-name i) ".")
                                                                                  (if reward-amount "Here's a reward for helping me out!" #f)))]
                     #:new-response-dialog   [new-response-dialog (list "Thanks again for helping me out!"
                                                                        "I really needed that ... "
                                                                        (~a (get-name i) "."))]
                     #:cutscene              [cutscene #f])
  (define item (ensure-storable-with-id i))
  (flatten (list (storage (~a "craft-reward-" (get-storage-data "item-id" item)) (list item reward-amount)) ;or should i just store the item-id or grab it from the name?
                 (quest #:rule (and/r (in-game-by-id? (get-storage-data "item-id" item))
                                      ;(near? "player") ;removing since observe change gets re-triggered by moving 
                                      )
                        #:quest-complete-dialog (dialog->sprites quest-complete-dialog #:game-width 480)
                        #:new-response-dialog (cond
                                                [((listof (listof string?)) new-response-dialog)
                                                 (dialog->response-sprites new-response-dialog #:game-width 480)]
                                                [((listof string?) new-response-dialog)
                                                 (dialog->sprites new-response-dialog #:game-width 480)]
                                                [else #f])
                        #:cutscene cutscene))))

(define (loot-quest #:item item
                    #:reward-amount [reward-amount #f]  
                    #:quest-complete-dialog [quest-complete-dialog (filter identity
                                                                           (list (~a "Thanks for finding my " (get-name item) ".")
                                                                                 (if reward-amount "Here's a reward for helping me out!" #f)))]
                    #:new-response-dialog   [new-response-dialog (list "Thanks again for helping me out!"
                                                                       "I don't know what I would do"
                                                                       (~a "without my " (get-name item) "."))]
                    #:cutscene              [cutscene #f])
  (craft-quest #:item item
               #:reward-amount reward-amount
               #:quest-complete-dialog quest-complete-dialog
               #:new-response-dialog new-response-dialog
               #:cutscene cutscene))

(define (collect-quest #:collect-amount amount
                       #:reward-item [reward-item #f]
                       #:reward-amount [reward-amount #f]
                       #:quest-complete-dialog [quest-complete-dialog (filter identity
                                                                              (list (~a "Thanks for collecting them all!")
                                                                                    (if reward-amount
                                                                                        (~a "I'll let you keep " reward-amount ".") #f)
                                                                                    (if reward-item
                                                                                        (~a "Also, have this " (get-name reward-item) ".") #f))
                                                                                    )]
                       #:new-response-dialog   [new-response-dialog (list "Thanks again for helping me out!"
                                                                          "I'm not very good at finding things.")]
                       #:cutscene              [cutscene #f])
  (and reward-item (set! known-loot-list (append (list reward-item) known-loot-list)))
  (flatten (list (storage (~a "collect-reward-" amount) (list amount
                                                              (or reward-amount 0)))
                 (and reward-item
                      (item-reward-system #:rule (and/r (has-gold? amount)
                                                        ;npc-last-dialog? ; doesn't work because new-reponse is destructive
                                                        )
                                          #:reward-item reward-item))
                 (quest #:rule (has-gold? amount)
                        #:quest-complete-dialog (dialog->sprites quest-complete-dialog #:game-width 480)
                        #:new-response-dialog (cond
                                                [((listof (listof string?)) new-response-dialog)
                                                 (dialog->response-sprites new-response-dialog #:game-width 480)]
                                                [((listof string?) new-response-dialog)
                                                 (dialog->sprites new-response-dialog #:game-width 480)]
                                                [else #f])
                        #:cutscene cutscene))))

(define (enemies-killed? amount)
  (lambda (g e)
    (define kill-count (get-storage-data "kill-count" (get-entity "score" g)))
    (>= kill-count amount)))

(define (hunt-quest #:hunt-amount amount
                    #:reward-item [reward-item #f]
                    #:reward-amount [reward-amount #f]
                    #:quest-complete-dialog [quest-complete-dialog (filter identity
                                                                           (list (~a "Thanks for killing " amount " enemies!")
                                                                                 (if reward-amount
                                                                                        (~a "Take this payment of " reward-amount ".") #f)
                                                                                 (if reward-item
                                                                                     (~a "Also, have this " (get-name reward-item) ".") #f)))]
                    #:new-response-dialog   [new-response-dialog (list "Thanks again for helping me out!"
                                                                       "Those guys were realy causing trouble.")]
                    #:cutscene              [cutscene #f])
  (and reward-item (set! known-loot-list (append (list reward-item) known-loot-list)))
  (flatten (list (storage (~a "hunt-reward-" amount) (list amount
                                                           (or reward-amount 0)))
                 (and reward-item
                      (item-reward-system #:rule (and/r (enemies-killed? amount)
                                                        ;npc-last-dialog? ; doesn't work because new-reponse is destructive
                                                        )
                                          #:reward-item reward-item))
                 (quest #:rule (enemies-killed? amount)
                        #:quest-complete-dialog (dialog->sprites quest-complete-dialog #:game-width 480)
                        #:new-response-dialog (cond
                                                [((listof (listof string?)) new-response-dialog)
                                                 (dialog->response-sprites new-response-dialog #:game-width 480)]
                                                [((listof string?) new-response-dialog)
                                                 (dialog->sprites new-response-dialog #:game-width 480)]
                                                [else #f])
                        #:cutscene cutscene))))


; ===== END OF QUEST FUNCTIONS =====

(define basic-sprite (circle 10 'solid 'red))

(define/contract/doc
  (adventure-game #:headless        [headless #f]
                  #:bg              [bg-ent (plain-forest-bg)]
                  #:avatar          [p      (custom-avatar #:sprite basic-sprite)]
                  #:sky             [sky (custom-sky)]
                  #:intro-cutscene  [intro-cutscene #f]
                  #:death-cutscene  [death-cutscene #f]
                  #:npc-list        [npc-list  '()]
                  #:enemy-list      [e-list    '()]
                  #:coin-list       [coin-list '()]
                  #:food-list       [f-list    '()]
                  #:crafter-list    [c-list    '()]
                  #:score-prefix    [prefix "Gold"]
                  #:enable-world-objects? [world-objects? #f]
                  #:weapon-list     [weapon-list '()] ; adventure doesn't need weapons in the wild
                  #:instructions    [instructions #f]
                  #:other-entities  [ent #f]
                                   . custom-entities)
  (->i ()
       (#:headless         [headless boolean?]
        #:bg               [bg entity?]
        #:avatar           [avatar (or/c entity? #f)]
        #:sky              [sky (or/c sky? #f)]
        #:intro-cutscene   [intro-cutscene (or/c entity? #f)]
        #:death-cutscene   [death-cutscene (or/c entity? #f)]
        #:npc-list         [npc-list     (listof (or/c entity? procedure?))]
        #:enemy-list       [enemy-list   (listof (or/c entity? procedure?))]
        #:coin-list        [coin-list    (listof (or/c entity? procedure?))]
        #:food-list        [food-list    (listof (or/c entity? procedure?))]
        #:crafter-list     [crafter-list (listof (or/c entity? procedure?))]
        #:score-prefix     [prefix string?]
        #:enable-world-objects? [world-objects? boolean?]
        #:weapon-list      [weapon-list (listof (or/c entity? procedure?))]
        #:instructions     [instructions (or/c #f entity?)]
        #:other-entities   [other-entities (or/c #f entity? (listof #f) (listof entity?))])
       #:rest [rest (listof (or/c #f entity? (listof #f) (listof entity?)))]
       [res () game?])

  @{The top-level function for the adventure-game language.
         Can be run with no parameters to get a basic, default game.}

  (define GAME-WIDTH (sprite-width (get-component bg-ent animated-sprite?)))
  (define GAME-HEIGHT (sprite-height (get-component bg-ent animated-sprite?)))
  
  ; === AUTO INSTRUCTIONS ===

  (define (weapon-entity->player-system e)
    (get-storage-data "Weapon" e))

  (define (item-entity->backpack-observer e)
    (get-storage-data "backpack-observer" e))

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

  ;(define food-img-list (map (λ (f) (render (get-component f animated-sprite?))) f-list))

  (define known-products-list (map recipe-product known-recipes-list))

  (define known-weapons-list (filter (curry get-storage "Weapon") known-products-list))
  (define known-coins-list (filter (curry get-storage "value") known-products-list))

  (define (known-weapon? e)
    (member (get-name e) (map get-name known-weapons-list)))
  
  (define world-weapon-list (filter (not/c known-weapon?) weapon-list))

  (define weapons-from-loot (filter (curry get-storage "Weapon") known-loot-list))
  (define food-from-loot (filter (curry get-storage "heals-by") known-loot-list))
  (define coins-from-loot (filter (curry get-storage "value") known-loot-list))

  (define (fetch-reward-storage? c)
      (and (storage? c)
           (string-prefix? (storage-name c) "fetch-reward-")))

  (define (craft-reward-storage? c)
      (and (storage? c)
           (string-prefix? (storage-name c) "craft-reward-")))

  (define (collect-reward-storage? c)
      (and (storage? c)
           (string-prefix? (storage-name c) "collect-reward-")))

  (define (hunt-reward-storage? c)
      (and (storage? c)
           (string-prefix? (storage-name c) "hunt-reward-")))

  (define (npc->fetch-quest-items npc)
    (define reward-components (get-components npc fetch-reward-storage?))
    
    (and (not (empty? reward-components))
         (map (compose first
                       storage-data) reward-components)))
  
  (define item-list (filter identity (flatten (map npc->fetch-quest-items npc-list)))) ;only for fetch items that auto appear in world

  (define weapons-from-fetch-quests (filter (curry get-storage "Weapon") item-list))
  (define food-from-fetch-quests    (filter (curry get-storage "heals-by") item-list))
  (define coins-from-fetch-quests   (filter (curry get-storage "value") item-list))
  
  (define items-with-observers (filter (curry get-storage "backpack-observer") (append known-products-list
                                                                                       known-loot-list
                                                                                       world-weapon-list
                                                                                       updated-food-list
                                                                                       (flatten (cons ent custom-entities))
                                                                                       )))
                                                                                       
  (define player-with-recipes-and-weapons
    (if p
        (add-components p (map weapon-entity->player-system
                               (remove-duplicates
                                (append known-weapons-list
                                        world-weapon-list
                                        weapons-from-loot
                                        weapons-from-fetch-quests)
                                name-eq?))
                        
                          ;(map weapon-entity->player-system world-weapon-list)
                          ;(map weapon-entity->player-system weapons-from-loot)

                        
                          (begin (displayln (~a "==== KNOWN RECIPES ====\n"
                                                 known-recipes-list))
                                  (map recipe->system known-recipes-list))
                          (map food->component
                               (remove-duplicates
                                (append  updated-food-list
                                         food-from-loot
                                         food-from-fetch-quests
                                         (filter (curry get-storage "heals-by") known-products-list))
                                name-eq?))
                          (map item-entity->backpack-observer item-list)
                          (map item-entity->backpack-observer items-with-observers)
                          )
        #f))

  ;-------- This doesn't work since rapid-fire weapons use do-every with a mouse-down rule instead of an on-mouse
  (define shoot-key (if (and player-with-recipes-and-weapons (get-component player-with-recipes-and-weapons on-mouse?))
                        "LEFT-CLICK"
                        "F"))
  ;--------

  (define automated-instructions-entity
    (if instructions
        instructions
        (instructions-entity #:move-keys move-keys
                             #:mouse-aim? mouse-aim?
                             #:shoot-key shoot-key)))
  
  (define bg-with-instructions
    (add-components bg-ent (on-key "i" #:rule (λ (g e) (not (get-entity "instructions" g)))
                                   (spawn automated-instructions-entity
                                          #:relative? #f))
                           (on-key 'm (open-mini-map #:close-key 'm))
                    ))
  
  (define (add-random-start-pos e)
    ;(define world-amt (get-storage-data "amount-in-world" e))
    (define pos (get-posn e))
    (if ;(and (> world-amt 0)
     (equal? pos (posn 0 0))
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

  (define (has-reward? c)
    (not (false? (second (storage-data c)))))
  
  (define (npc->counter-quest-rewards npc)
    (define quest-giver-name (get-name npc))
    (define fetch-quest-rewards (map storage-data (get-components npc (and/c (or/c fetch-reward-storage?
                                                                                   craft-reward-storage?)
                                                                               has-reward?))))
    (define collect-quest-rewards (map storage-data (get-components npc (and/c collect-reward-storage?
                                                                               has-reward?))))
    (define hunt-quest-rewards (map storage-data (get-components npc (and/c hunt-reward-storage?
                                                                            has-reward?))))
    
    (define fetch-reward-components
      (map (λ (fr)
             (quest-reward #:quest-giver quest-giver-name
                           #:quest-item (first fr)
                           #:reward     (second fr)))
           fetch-quest-rewards))
    
    (define collect-reward-components
      (map (λ (cr)
             (counter-reward-system #:quest-giver-name quest-giver-name
                                    #:collect-amount  (first cr)
                                    #:reward-amount   (second cr)))
           collect-quest-rewards))

    (define hunt-reward-components
      (map (λ (hr)
             (hunt-reward-system #:quest-giver-name quest-giver-name
                                 #:hunt-amount     (first hr)
                                 #:reward-amount   (second hr)))
           hunt-quest-rewards))
    
    (append fetch-reward-components collect-reward-components hunt-reward-components))

  (define (start-dead-component? c)
    (and (on-start? c)
         (eq? (on-start-func c) die)))
  
  (define (enemy-died? g e)
    (define death-broadcast (get-entity "Enemy Death Broadcast" g))
    (and death-broadcast
         (get-component death-broadcast start-dead-component?)))

  (define (score-entity prefix)
    (define counter-sprite
      (append (list (new-sprite (~a (string-titlecase prefix) ": 0")
                        #:color 'yellow))
              (bordered-box-sprite (* 10 (+ 7 (string-length prefix))) 24)
                   ))

    (define (recipe-has-cost? r)
      (> (recipe-cost r) 0))

    (define (add1-to-kill-count)
      (lambda (g e)
        (set-storage "kill-count" e (add1 (get-storage-data "kill-count" e)))))
    
    (sprite->entity counter-sprite
                    #:name       "score"
                    #:position   (posn 330 20)
                    #:components (static)
                                 (counter 0)
                                 (storage "kill-count" 0)
                                 (layer "ui")
                                 (map (curryr coin->component prefix) (remove-duplicates (append updated-coin-list
                                                                                                 coins-from-loot
                                                                                                 coins-from-fetch-quests
                                                                                                 known-coins-list)
                                                                                         name-eq?))
                                 (map (curry recipe->coin-system #:prefix prefix) (filter recipe-has-cost? known-recipes-list))
                                 (map npc->counter-quest-rewards npc-list)
                                 (observe-change (λ (g e)
                                                   (get-counter e))
                                                 (λ (g e1 e2)
                                                   ((do-many (draw-counter-rpg #:prefix (~a (string-titlecase prefix) ": "))
                                                             (do-font-fx)) g e2)))
                                 (on-rule enemy-died? (add1-to-kill-count))
                                 ))

  (define (get-kill-count g)
    (get-storage-data "kill-count" (get-entity "score" g)))
 
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
                           (do-many (spawn (game-toast-entity "NIGHTTIME HAS BEGUN" #:position 'center #:duration 50 #:scale 1.5))
                                    (spawn-many-on-current-tile (map add-random-start-pos (filter night-only? enemies-with-night-code)))
                                    ))
                  (on-rule (reached-multiple-of? LENGTH-OF-DAY #:offset START-OF-DAYTIME)
                           (spawn (game-toast-entity "DAYTIME HAS BEGUN" #:position 'center #:duration 50 #:scale 1.5)))
                  (if intro-cutscene
                      (after-time 1 (spawn intro-cutscene #:relative? #f))
                      #f)
                  (if death-cutscene
                      (observe-change lost? (if/r lost?
                                              (do-after-time 50 (spawn death-cutscene #:relative? #f))))
                      #f)
                  ;(on-key 't (start-stop-game-counter)) ; !!!!! for testing only remove this later !!!!!!
     ))
  
  (define bg-component (get-component bg-ent backdrop?))
  
  (define columns-from-bg
    (backdrop-columns bg-component))
  
  (define rows-from-bg
    (/ (length (backdrop-tiles bg-component))
       columns-from-bg))
  
  (define es (filter identity
                     (flatten
                      (list
                       automated-instructions-entity
                       (if p (game-over-screen won? lost?) #f)
                       (if p (score-entity prefix) #f)

                       (tm-entity)
                       (if sky
                           (night-sky-with-lighting #:color         (sky-color sky)
                                                    #:max-alpha     (sky-max-alpha sky)
                                                    #:length-of-day (sky-day-length sky)
                                                    #:scale         (if (>= GAME-WIDTH GAME-HEIGHT)
                                                                        (/ GAME-WIDTH 480)
                                                                        (/ GAME-HEIGHT 360)))
                            #f)

                       ;(if p (health-entity) #f)

                       player-with-recipes-and-weapons

                       (map add-random-start-pos (clone-by-rarity weapon-list))
                       
                       (map add-random-start-pos npc-list)
                       
                       (map add-random-start-pos c-list)
                       (map add-random-start-pos item-list)
                       
                       (map add-random-start-pos updated-food-list)
                       (map add-random-start-pos updated-coin-list)
                       (map add-random-start-pos (filter-not night-only? enemies-with-night-code))
                       
                       (cons ent custom-entities)

                       (if world-objects?
                           (make-world-objects round-tree pine-tree
                                               #:rows    rows-from-bg
                                               #:columns columns-from-bg)
                           #f)

                       (mini-map bg-with-instructions #:close-key 'm)
              
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
  (set! known-recipes-list (remove-duplicates (append r-list known-recipes-list) recipe-eq?))
  (crafting-menu #:open-key open-key
                 #:open-sound open-sound
                 #:select-sound select-sound
                 #:recipe-list r-list
                 ;#:recipes r
                 ;          recipes
                           ))

(define/contract/doc (custom-crafter #:position   [p (posn 0 0)]
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
         automatically if it is passed into @racket[adventure-game]
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

;(define loose-component?
;  (or/c component? observe-change? #f))

;(define component-or-system?
;  (or/c loose-component? (listof loose-component?)))

(define/contract/doc (custom-npc #:sprite     [s (random-character-sprite)]
                                 #:position   [p (posn 0 0)]
                                 #:name       [name (first (shuffle (list "Adrian" "Alex" "Riley"
                                                                          "Sydney" "Charlie" "Andy")))]
                                 #:amount-in-world [world-amt 1]
                                 #:tile       [tile 0]
                                 #:dialog     [d  #f]
                                 #:mode       [mode 'wander]
                                 #:game-width [GAME-WIDTH 480]
                                 #:speed      [spd 2]
                                 #:target     [target "player"]
                                 #:sound      [sound #t]
                                 #:scale      [scale 1]
                                 #:quest-list [quests '()]
                                 #:components [c #f]
                                 . custom-components )

  (->i () (#:sprite     [sprite (or/c sprite? (listof sprite?))]
           #:position   [position posn?]
           #:name       [name string?]
           #:amount-in-world [world-amt number?]
           #:tile       [tile number?]
           #:dialog     [dialog dialog-str?]
           #:mode       [mode (or/c 'still 'wander 'pace 'follow)]
           #:game-width [game-width number?]
           #:speed      [speed number?]
           #:target     [target string?]
           #:sound      [sound any/c]
           #:scale      [scale number?]
           #:quest-list [quests (listof component-or-system?)]
           #:components [first-component component-or-system?])
       #:rest [more-components (listof component-or-system?)]
       [returns entity?])

 @{Returns a custom npc, which will be placed in to the world
         automatically if it is passed into @racket[adventure-game]
         via the @racket[#:npc-list] parameter.}
  
  (define dialog
    (if (not d)
        (dialog->sprites (first (shuffle (list (list "You must be new around here...")
                                               (list "Hey! I'm walkin' here!")
                                               (list "Sorry, I don't have time to talk.")
                                               (list "Be careful, I think I saw a dragon!"))))
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
  
  (create-npc #:sprite      s
              #:name        name
              #:position    p
              #:active-tile tile
              #:dialog      dialog
              #:mode        mode
              #:speed       spd
              #:target      target
              #:sound       sound
              #:scale       scale
              #:components  (list ;(on-start (respawn 'anywhere))
                                  (storage "amount-in-world" world-amt)
                                  quests
                                  (cons c custom-components))))

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
        #:components [first-component component-or-system?])
       #:rest [more-components (listof component-or-system?)]
       [result entity?])

  @{Returns a custom background, which will be used
         automatically if it is passed into @racket[adventure-game]
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

(define/contract/doc (custom-food  #:name              [n "Carrot"]
                                   #:sprite            [s carrot-sprite]
                                   #:tile              [tile 0]
                                   #:position          [pos (posn 0 0)]
                                   #:amount-in-world   [world-amt 1]
                                   #:storable?         [storable? #t]
                                   #:consumable?       [consumable? #t]
                                   #:value             [val    #f]
                                   #:heals-by          [heals-by 10]    ;only used if consumable is #t
                                   #:respawn?          [respawn? #t]    ;only used if consumable is #t
                                   #:on-pickup         [pickup-func (do-nothing)]
                                   #:on-store          [store-func (do-nothing)]
                                   #:on-drop           [drop-func (do-nothing)]
                                   #:components        [c #f]
                                   . custom-components)
  (->i () (#:name       [name string?]
           #:sprite     [sprite (or/c sprite? (listof sprite?))]
           #:tile       [tile number?]
           #:position   [position posn?]
           #:amount-in-world [amount-in-world number?]
           #:storable?  [storable? boolean?]
           #:consumable? [consumable? boolean?]
           #:value       [value (or/c number? #f)]
           #:heals-by    [heals-by (or/c number? #f)]
           #:respawn?    [respawn? boolean?]  
           #:on-pickup   [pickup-func procedure?]
           #:on-store    [store-func procedure?]
           #:on-drop     [drop-func procedure?]
           #:components  [first-component  component-or-system?])
       #:rest [more-components (listof component-or-system?)]
       [returns entity?])

  @{Returns a custom food, which will be placed into the world
              automatically if it is passed into @racket[adventure-game]
              via the @racket[#:food-list] parameter.}
  
  (custom-item  #:name              n
                #:sprite            s
                #:tile              tile
                #:position          pos
                #:amount-in-world   world-amt
                #:storable?         storable?
                #:consumable?       consumable?
                #:value             val
                #:heals-by          heals-by    
                #:respawn?          respawn? 
                #:on-pickup         pickup-func
                #:on-store          store-func 
                #:on-drop           drop-func 
                #:components        (cons c custom-components)))

(define/contract/doc (custom-product  #:name              [n "Carrot Stew"]
                                      #:sprite            [s carrotstew-sprite]
                                      #:tile              [tile 0]
                                      #:position          [pos (posn 0 0)]
                                      #:amount-in-world   [world-amt 1]
                                      #:storable?         [storable? #t]
                                      #:consumable?       [consumable? #t]
                                      #:value             [val    #f]
                                      #:heals-by          [heals-by 10]    ;only used if consumable is #t
                                      #:respawn?          [respawn? #f]    ;only used if consumable is #t
                                      #:on-pickup         [pickup-func (do-nothing)]
                                      #:on-store          [store-func (do-nothing)]
                                      #:on-drop           [drop-func (do-nothing)]
                                      #:components        [c #f]
                                      . custom-components)
  (->i () (#:name       [name string?]
           #:sprite     [sprite (or/c sprite? (listof sprite?))]
           #:tile       [tile number?]
           #:position   [position posn?]
           #:amount-in-world [amount-in-world number?]
           #:storable?  [storable? boolean?]
           #:consumable? [consumable? boolean?]
           #:value       [value (or/c number? #f)]
           #:heals-by    [heals-by (or/c number? #f)]
           #:respawn?    [respawn? boolean?]  
           #:on-pickup   [pickup-func procedure?]
           #:on-store    [store-func procedure?]
           #:on-drop     [drop-func procedure?]
           #:components  [first-component  component-or-system?])
       #:rest [more-components (listof component-or-system?)]
       [returns entity?])

  @{Returns a custom product, which can be used to create a 
              recipe product if it is passed into @racket[recipe]
              via the @racket[#:product] parameter.}
  
  (custom-item  #:name              n
                #:sprite            s
                #:tile              tile
                #:position          pos
                #:amount-in-world   world-amt
                #:storable?         storable?
                #:consumable?       consumable?
                #:value             val
                #:heals-by          heals-by    
                #:respawn?          respawn? 
                #:on-pickup         pickup-func
                #:on-store          store-func 
                #:on-drop           drop-func 
                #:components        (cons c custom-components)))

(define/contract/doc (custom-coin #:entity           [base-entity (copper-coin)]
                                  #:sprite           [s #f]
                                  #:position         [p #f]
                                  #:name             [n #f]
                                  #:tile             [t #f]
                                  #:amount-in-world  [world-amt 10]
                                  #:value            [val 10]
                                  #:respawn?         [respawn? #t]
                                  #:on-pickup        [pickup-function (λ (g e) e)]
                                  #:cutscene         [cutscene #f]
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
            #:on-pickup [pickup-function procedure?]
            #:cutscene   [cutscene (or/c entity? #f)]
            #:components [first-component component-or-system?])
       #:rest [more-components (listof component-or-system?)]
        [returns entity?])

  @{Returns a custom coin, which will be placed into the world
              automatically if it is passed into @racket[adventure-game]
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
                                                              (nearest-to-player? #:filter (and/c (has-component? on-key?)
                                                                                                  (not/c bg?))))
                                         (do-many (respawn 'anywhere)
                                                  (active-on-random))))
      (add-components new-entity (on-key 'space #:rule (and/r near-player?
                                                              (nearest-to-player? #:filter (and/c (has-component? on-key?)
                                                                                                  (not/c bg?))))
                                         (do-many pickup-function
                                                  (if cutscene
                                                      (spawn cutscene #:relative? #f)
                                                      (λ (g e) e)
                                                      )
                                                  (do-after-time 1 die) ; 1 tick delay incase function is spawn
                                                  )))))

; ==== CUSTOM ITEM DEFINITION ====
(define/contract/doc (custom-item #:name              [n "Chest"]
                                  #:sprite            [s chest-sprite]
                                  #:tile              [tile #f]
                                  #:position          [pos #f]
                                  #:amount-in-world   [world-amt 1]
                                  #:storable?         [storable? #t]
                                  #:consumable?       [consumable? #f]
                                  #:value             [val 10]      ;only used if consumable is #t
                                  #:heals-by          [heals-by #f]
                                  #:respawn?          [respawn? #t] ;only used if consumable is #t
                                  #:on-pickup         [pickup-func (do-nothing)]
                                  #:on-store          [store-func (do-nothing)]
                                  #:on-drop           [drop-func (do-nothing)]
                                  #:components        [c #f]
                                  . custom-components)
  (->i () (#:name            [name string?]
           #:sprite          [sprite (or/c sprite? (listof sprite?))]
           #:tile            [tile (or/c number? #f)]
           #:position        [position (or/c posn? #f)]
           #:amount-in-world [amount-in-world number?]
           #:storable?       [storable? boolean?]
           #:consumable?     [consumable? boolean?]
           #:value           [value (or/c number? #f)]
           #:heals-by        [heals-by (or/c number? #f)]
           #:respawn?        [respawn? boolean?]  
           #:on-pickup       [pickup-func procedure?]
           #:on-store        [store-func procedure?]
           #:on-drop         [drop-func procedure?]
           #:components      [first-component  component-or-system?])
       #:rest [more-components (listof component-or-system?)]
       [returns entity?])

  @{Returns a custom item, which has a unique item id and can be
              used in npc quests.}
  
  (define (pickup-component)
    (on-key 'space #:rule (and/r near-player?
                                 (nearest-to-player? #:filter (and/c (has-component? on-key?)
                                                                     (not/c bg?))))
            (do-many pickup-func
                     (if respawn?
                         (do-after-time 1 (do-many (respawn 'anywhere)
                                                   (active-on-random)))
                         (do-after-time 1 die) ; 1 tick delay in case function is spawn
                         ))))
  
  (define item-id (next-storable-item-id))
  
  (sprite->entity s
                  #:name n
                  #:position    (or pos (posn 0 0))
                  #:components  (active-on-bg (or tile 0))
                                (physical-collider)
                                (hidden)
                                (storage "amount-in-world" world-amt)
                                (if val (storage "value" val) #f)
                                (if heals-by (storage "heals-by" heals-by) #f)
                                (on-start (do-many ;(if pos  (do-nothing) (respawn 'anywhere))
                                                   ;(if tile (do-nothing) (active-on-random))
                                                   show))
                                (if storable? (storable) #f)
                                (if consumable? (pickup-component) #f)
                                (storage "item-id" item-id)
                                (storage "backpack-observer"
                                         (observe-change (in-backpack-by-id? item-id)
                                                         (if/r (in-backpack-by-id? item-id)
                                                               store-func
                                                               drop-func)))
                                (cons c custom-components)
                                ))

; ==== PREBUILT WEAPONS & DARTS ====

(define (repeater #:name              [n "Repeater"]
                  #:color             [c "green"]
                  #:sprite            [ds (rectangle 10 2 "solid" c)]
                  #:icon              [i (make-fancy-icon ds)]
                  #:speed             [spd 10]
                  #:damage            [dmg 10]
                  #:range             [rng 1000]
                  #:dart              [d (custom-dart #:sprite ds
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
                  #:rarity            [rarity 'common]
                  #:on-store          [store-func (do-nothing)]
                  #:on-drop           [drop-func (do-nothing)])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity
                 #:on-store          store-func
                 #:on-drop           drop-func))

(define (spear #:name              [n "Spear"]
               #:sprite            [s spear-sprite]
               #:icon              [i (make-fancy-icon s)]
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
               #:rarity            [rarity 'common]
               #:on-store          [store-func (do-nothing)]
               #:on-drop           [drop-func (do-nothing)])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity
                 #:on-store          store-func
                 #:on-drop           drop-func))

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
               #:sprite            [s swinging-sword-sprite]
               #:icon              [i (make-fancy-sword-icon s)]
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
               #:rarity            [rarity 'common]
               #:on-store          [store-func (do-nothing)]
               #:on-drop           [drop-func (do-nothing)])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity
                 #:on-store store-func
                 #:on-drop  drop-func))

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
                       #:sprite            [s   acid-sprite]
                       #:icon              [icon (make-fancy-icon s)]
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
                       #:rarity            [rarity 'common]
                       #:on-store          [store-func (do-nothing)]
                       #:on-drop           [drop-func (do-nothing)])
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
                 #:rarity            rarity
                 #:on-store          store-func
                 #:on-drop           drop-func))

(define (fireball-dart  #:sprite     [s   flame-sprite]
                        #:damage     [dmg 10]
                        #:durability [dur 5]
                        #:speed      [spd 3]
                        #:range      [rng 100])
  (custom-dart #:position (posn 25 0)
               #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng))

(define (fireball  #:name              [n "Fireball"]
                   #:sprite            [s   flame-sprite]
                   #:icon              [icon (make-fancy-icon s)]
                   #:damage            [dmg 10]
                   #:durability        [dur 5]
                   #:speed             [spd 3]
                   #:range             [rng 100]
                   #:dart              [d (fireball-dart #:sprite s
                                                         #:damage dmg
                                                         #:durability dur
                                                         #:speed spd
                                                         #:range rng)]
                   #:fire-mode         [fm 'normal]
                   #:fire-rate         [fr 3]
                   #:fire-key          [key 'f]
                   #:fire-sound        [fire-sound FIRE-MAGIC-SOUND]
                   #:mouse-fire-button [button #f]
                   #:point-to-mouse?   [ptm? #f]
                   #:rapid-fire?       [rf? #t]
                   #:rarity            [rarity 'common]
                   #:on-store          [store-func (do-nothing)]
                   #:on-drop           [drop-func (do-nothing)])
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
                 #:rarity            rarity
                 #:on-store          store-func
                 #:on-drop           drop-func))

(define (fire-magic #:name              [n "Fire Magic"]
                    #:sprite            [s flame-sprite]
                    #:icon              [i (make-triple-icon s)]
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
                    #:rarity            [rarity 'common]
                    #:on-store          [store-func (do-nothing)]
                    #:on-drop           [drop-func (do-nothing)])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity
                 #:on-store          store-func
                 #:on-drop           drop-func))

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
               (every-tick (simple-scale-sprite 1.1))))

(define (ice-magic #:name              [n "Ice Magic"]
                   #:sprite            [s ice-sprite]
                   #:icon              [i (make-triple-icon s)]
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
                   #:rarity            [rarity 'common]
                   #:on-store          [store-func (do-nothing)]
                   #:on-drop           [drop-func (do-nothing)])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity
                 #:on-store store-func
                 #:on-drop drop-func))

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
               (every-tick (simple-scale-sprite 1.1))))

(define (sword-magic #:name              [n "Sword Magic"]
                     #:sprite            [s flying-sword-sprite]
                     #:icon              [i (make-triple-icon s)]
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
                     #:rarity            [rarity 'common]
                    #:on-store          [store-func (do-nothing)]
                    #:on-drop           [drop-func (do-nothing)])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity
                 #:on-store          store-func
                 #:on-drop           drop-func))

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
                        #:sprite            [s flying-sword-sprite]
                        #:icon              [i (make-ring-icon s)]
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
                        #:rarity            [rarity 'common]
                        #:on-store          [store-func (do-nothing)]
                        #:on-drop           [drop-func (do-nothing)])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity
                 #:on-store          store-func
                 #:on-drop           drop-func))

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
                      #:sprite            [s flame-sprite]
                      #:icon              [i (make-ring-icon s)]
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
                      #:rarity            [rarity 'common]
                      #:on-store          [store-func (do-nothing)]
                      #:on-drop           [drop-func (do-nothing)])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity
                 #:on-store          store-func
                 #:on-drop           drop-func))

(define (ring-of-ice #:name              [n "Ring of Ice"]
                     #:sprite            [s ice-sprite]
                     #:icon              [i (make-ring-icon s)]
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
                     #:rarity            [rarity 'common]
                    #:on-store          [store-func (do-nothing)]
                    #:on-drop           [drop-func (do-nothing)])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity
                 #:on-store          store-func
                 #:on-drop           drop-func))

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
               (every-tick (do-many (simple-scale-sprite 1.05)
                                    (change-direction-by 10)))))

; ==== PREBUILT FOOD AND RECIPES ===
(define (carrot #:name             [n "Carrot"]
                #:sprite           [s carrot-sprite]
                #:tile             [t 0]
                #:position         [p (posn 0 0)]
                #:amount-in-world  [world-amt 1]
                #:storable?        [storable? #t]
                #:consumable?      [consumable? #t]
                #:value            [val    #f]
                #:heals-by         [heal-amt 10]
                #:respawn?         [respawn? #t]
                #:on-pickup        [pickup-func (do-nothing)]
                #:on-store         [store-func (do-nothing)]
                #:on-drop          [drop-func (do-nothing)]
                #:components       [c #f]
                . custom-entities)
  (custom-food  #:sprite           s 
                #:position         p 
                #:name             n
                #:tile             t
                #:amount-in-world  world-amt
                #:storable?        storable?
                #:consumable?      consumable?
                #:value            val
                #:heals-by         heal-amt
                #:respawn?         respawn?
                #:on-pickup        pickup-func
                #:on-store         store-func
                #:on-drop          drop-func
                #:components       (cons c custom-entities)))

(define (fish #:name             [n "Fish"]
              #:sprite           [s fish-sprite]
              #:tile             [t 0]
              #:position         [p (posn 0 0)]
              #:amount-in-world  [world-amt 1]
              #:storable?        [storable? #t]
              #:consumable?      [consumable? #t]
              #:value            [val    #f]
              #:heals-by         [heal-amt 20]
              #:respawn?         [respawn? #t]
              #:on-pickup        [pickup-func (do-nothing)]
              #:on-store         [store-func (do-nothing)]
              #:on-drop          [drop-func (do-nothing)]                    
              #:components       [c #f]
              . custom-entities)
  (custom-food  #:sprite           s 
                #:position         p 
                #:name             n
                #:tile             t
                #:amount-in-world  world-amt
                #:storable?        storable?
                #:consumable?      consumable?
                #:value            val
                #:heals-by         heal-amt
                #:respawn?         respawn?
                #:on-pickup        pickup-func
                #:on-store         store-func
                #:on-drop          drop-func
                #:components       (cons c custom-entities)))

(define (carrot-stew #:name             [n "Carrot Stew"]
                     #:sprite           [s carrotstew-sprite]
                     #:tile             [t 0]
                     #:position         [p (posn 0 0)]
                     #:amount-in-world  [world-amt 0]
                     #:storable?        [storable? #t]
                     #:consumable?      [consumable? #t]
                     #:value            [val    #f]
                     #:heals-by         [heal-amt 40]
                     #:respawn?         [respawn? #f]
                     #:on-pickup        [pickup-func (do-nothing)]
                     #:on-store         [store-func (do-nothing)]
                     #:on-drop          [drop-func (do-nothing)]
                     #:components       [c #f]
                     . custom-entities)
  (custom-food  #:sprite           s 
                #:position         p 
                #:name             n
                #:tile             t
                #:amount-in-world  world-amt
                #:storable?        storable?
                #:consumable?      consumable?
                #:value            val
                #:heals-by         heal-amt
                #:respawn?         respawn?
                #:on-pickup        pickup-func
                #:on-store         store-func
                #:on-drop          drop-func
                #:components       (cons c custom-entities)))

(define carrot-stew-recipe
  (recipe #:product (carrot-stew)
          #:build-time 30
          #:ingredients (list "Carrot")))

; We could use some more naturally occuring food like
;  seeds, berries, nuts, fruit, etc
(define (random-food #:amount-in-world [amt 1]
                     #:position        [p (posn 0 0)]
                     #:tile            [t 0]
                     #:storable?       [storable? #t]
                     #:consumable?     [consumable? #t]
                     #:value           [val    #f]
                     #:respawn?        [respawn? #f]
                     #:on-pickup       [pickup-func (do-nothing)]
                     #:on-store        [store-func (do-nothing)]
                     #:on-drop         [drop-func (do-nothing)]
                     #:components      [c #f]
                     . custom-components)
  (define food-sets (list (list "Carrot" carrot-sprite 10)
                          (list "Fish"  fish-sprite 20)
                          (list "Carrot Stew" carrotstew-sprite 30)))
  (define choice (random (length food-sets)))
  (custom-food #:name            (first (list-ref food-sets choice))
               #:sprite          (second (list-ref food-sets choice))
               #:heals-by        (third (list-ref food-sets choice))
               #:amount-in-world amt
               #:position        p
               #:tile            t
               #:storable?       storable?
               #:respawn?        respawn?
               #:on-pickup       pickup-func
               #:on-store        store-func
               #:on-drop         drop-func
               #:components      (cons c custom-components)))

(define (random-coin #:amount-in-world [amt 1]
                     #:position        [p (posn 0 0)]
                     #:tile            [t 0]
                     #:respawn?        [respawn? #t]
                     #:storable?       [storable? #t]
                     #:consumable?     [consumable? #f]
                     #:on-pickup       [pickup-function (do-nothing)]
                     #:on-store        [store-func (do-nothing)]
                     #:on-drop         [drop-func (do-nothing)]
                     #:components      [c #f]
                     . custom-components)
  (define coin-sets (list (list "Copper Coin" coppercoin-sprite 1)
                          (list "Silver Coin" silvercoin-sprite 10)
                          (list "Gold Coin"   goldcoin-sprite   25)))
  (define choice (random (length coin-sets)))
  (custom-coin #:name            (first (list-ref coin-sets choice))
               #:sprite          (second (list-ref coin-sets choice))
               #:value           (third (list-ref coin-sets choice))
               #:amount-in-world amt
               #:position        p
               #:tile            t
               #:respawn?        respawn?
               #:storable        storable?
               #:consumable?     consumable?
               #:on-pickup       pickup-function
               #:on-store        store-func
               #:on-drop         drop-func
               #:components      (cons c custom-components)))

(define/contract (random-player-dialog-with name)
  (-> string? component-or-system?)
  
  ;@{Returns a collection of 3 random questions that the player will
    ;output with interacting with the npc with @racket[name].}

  (define options
    (list "What's your name?"
          "Where's the nearest town?"
          "Are you lost?"
          "Do you need help?"
          "Do I know you?"
          "Do you have some food?"
          "Can I borrow a sword from you?"
          "Do you have a quest for me?"
          "What is the meaning of life?"
          "Will you be my friend?"))

  (player-dialog-with name
                      #:dialog-list (take (shuffle options) 3)))


(define/contract (random-npc-response #:num-of-responses [num 3])
  (->* () (#:num-of-responses positive?) dialog-str?)

  (define options
    (list (list "WATCH OUT BEHIND YOU!!"
                "-- Wait! Nevermind."
                "Everything is fine.")
          (list "..."
                "Huh? Sorry, did you say something?")
          (list "..."
                "..."
                "Oh, are you talking to me?")
          (list "Huh..."
                "That's an interesting question!")
          (list "How DARE you ask me that!"
                "I'm offended!")
          (list "I -- I really don't know.")
          (list "...Hmmmmm..."
                "...HMMMMMM..."
                "...HMMMMMMMMMM..."
                "...what were we talking about?")
          (list "Hahahaha!"
                "You are too funny!")
          (list "How should I know??")
          (list "Ha ha..."
                "...This is awkward...")))

  (take (shuffle options) num))

  
(module test racket
  (displayln "TEST!!!")
  )

