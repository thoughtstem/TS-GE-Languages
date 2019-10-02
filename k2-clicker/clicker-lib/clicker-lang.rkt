#lang racket

(provide start-forest
         start-desert
         start-snow
         start-lava
         start-pink

         define-start

         sprite->pointer-tree)

(require game-engine
         game-engine-demos-common
         syntax/parse/define
         (only-in adventure page)
         ratchet/util
         (for-syntax racket)
         (prefix-in a: animal-assets)
         (prefix-in a: "./assets.rkt")
         (only-in lang/posn make-posn))

(define (fast-sprite-equal? s1 s2)
  (and
    (sprite? s1)
    (sprite? s2)
    (fast-equal? (current-fast-frame s1) (current-fast-frame s2))))

; Color a sprite by setting hue and saturation but not brightness
; UPDATE: Commenting out saturation for now.
;         Settting both sat and hue seems to result in scary red eyes.
(define/contract (colorize-sprite color-name sprite-maybe)
                 (-> (or/c string? symbol?) (or/c animated-sprite? image?) animated-sprite?)

                 (define sprite (if (image? sprite-maybe)
                                  (new-sprite sprite-maybe)
                                  sprite-maybe))

                 (define c-hsb (name->color-hsb color-name))
                 (define h (color-hsb-hue c-hsb))
                 ;(define s (color-hsb-sat c-hsb))
                 (apply-image-function ;(compose (curry set-img-sat s)
                   ;         (curry set-img-hue h))
                   (curry set-img-hue h)
                   sprite))

(define (make-pointer sprite . options)
  (define color (findf (or/c string? symbol?) options))
  (define s (call-if-proc sprite))
  (sprite->entity (if color
                    (colorize-sprite color s)
                    s)
                  #:name "pointer"
                  #:position (posn 0 0)
                  #:components (layer "ui")
                  (on-rule mouse-in-game? go-to-mouse)))

(define (random-success-toast)
  (toast-entity (first (shuffle (list "Awesome!"
                                      "Great!"
                                      "Fantastic!"
                                      "Good Job!"
                                      "You got it!"
                                      "Keep it up!"))) #:color 'green))

(define (random-failure-toast)
  (toast-entity (first (shuffle (list "Oops!"
                                      "Try again!"
                                      "Oh no!"
                                      "Avoid those!"
                                      "Better luck next time!"))) #:color 'orangered))
(define collect-broadcast
  (sprite->entity empty-image
                  #:name "Collect Broadcast"
                  #:position (posn 0 0)
                  #:components (on-start die)))

(define avoid-broadcast
  (sprite->entity empty-image
                  #:name "Avoid Broadcast"
                  #:position (posn 0 0)
                  #:components (on-start die)))

(define (special-broadcast value)
  (sprite->entity empty-image
                  #:name "Special Broadcast"
                  #:position (posn 0 0)
                  #:components (storage "Value" value)
                  (on-start die)))

(define (freeze-clicked? g e)
  (define special-broadcast (get-entity "Special Broadcast" g))
  (and special-broadcast
       (eq? (get-storage-data "Value" special-broadcast) "freeze")))

(define (slow-clicked? g e)
  (define special-broadcast (get-entity "Special Broadcast" g))
  (and special-broadcast
       (eq? (get-storage-data "Value" special-broadcast) "slow")))

(define (chest-clicked? g e)
  (define special-broadcast (get-entity "Special Broadcast" g))
  (and special-broadcast
       (eq? (get-storage-data "Value" special-broadcast) "chest")))

(define (light-clicked? g e)
  (define special-broadcast (get-entity "Special Broadcast" g))
  (and special-broadcast
       (eq? (get-storage-data "Value" special-broadcast) "light")))

(define (freeze-sprite)
  (lambda (g e)
    (define og-sprite (get-component e animated-sprite?))
    (define frozen-sprite (apply-image-function (curry tint-img 'cyan) (first (get-components e animated-sprite?))))
    (~> e
        (update-entity _ animated-sprite? frozen-sprite)
        (add-components _ (storage "stored-sprite" og-sprite)))
    ))

(define (restore-sprite)
  (lambda (g e)
    (define stored-sprite (and (get-storage "stored-sprite" e)
                               (get-storage-data "stored-sprite" e)))
    (if stored-sprite
      (~> e
          (update-entity _ animated-sprite? stored-sprite)
          (remove-storage "stored-sprite" _))
      e)))

(define (slow-entity)
  (lambda (g e)
    (define s (get-ai-speed e))
    (~> e
        (update-entity _ speed? (speed 1))
        (add-components _ (storage "stored-speed" s)))))

(define (un-slow-entity)
  (lambda (g e)
    (define old-speed (and (get-storage "stored-speed" e)
                           (get-storage-data "stored-speed" e)))
    (if old-speed
      (~> e
          (update-entity _ speed? (speed old-speed))
          (remove-storage "stored-speed" _))
      e)))

(define (make-collectible sprite-or-proc . options)
  (define spd (or (findf number? options)
                    2))
  (define color (findf (or/c string? symbol?) options))

  (define (wander-move-components)
    (list (every-tick (move))
          (do-every 50 (random-direction 0 360))
          (on-edge 'left   (set-direction 0))
          (on-edge 'right  (set-direction 180))
          (on-edge 'top    (set-direction 90))
          (on-edge 'bottom (set-direction 270))))
  
  (define sprite
    (if (procedure? sprite-or-proc)
      (sprite-or-proc)
      sprite-or-proc))

  (sprite->entity  (if color
                       (colorize-sprite color sprite)
                       sprite)
                   #:name        "collectible"
                   #:position    (posn 0 0)
                   #:components  (speed spd)
                   (direction 0)
                   (rotation-style 'left-right)
                   (stop-on-edge)
                   (wander-move-components)
                   (hidden)
                   (on-start (do-many (respawn 'anywhere)
                                      (random-direction)
                                      show))
                   (on-sprite-click (do-many (spawn (custom-particles #:amount-of-particles 5
                                                                      #:particle-time-to-live 10))
                                             (spawn random-success-toast)
                                             (spawn collect-broadcast)
                                             (do-after-time 1 die)))
                   (observe-change freeze-clicked? (if/r freeze-clicked?
                                                         (do-many (freeze-entity)
                                                                  (freeze-sprite)
                                                                  (do-after-time 100 (do-many (un-freeze-entity)
                                                                                              (restore-sprite))))))
                   (observe-change slow-clicked? (if/r slow-clicked?
                                                       (do-many (slow-entity)
                                                                (freeze-sprite)
                                                                (do-after-time 100 (do-many (un-slow-entity)
                                                                                            (restore-sprite))))))
                   ))

(define (make-avoidable sprite-or-proc . options)
  (define spd (or (findf number? options)
                    2))
  (define color (findf (or/c string? symbol?) options))
  (define sprite
    (if (procedure? sprite-or-proc)
      (sprite-or-proc)
      sprite-or-proc))
  (sprite->entity (if color
                      (colorize-sprite color sprite)
                      sprite)
                      #:name "avoidable"
                      #:position (posn 0 0)
                      #:components (speed spd)
                      (direction 0)
                      (rotation-style 'left-right)
                      (stop-on-edge)
                      (every-tick (move))
                      (follow "pointer")
                      (hidden)
                      (on-start (do-many (respawn 'anywhere)
                                         (random-direction)
                                         show))
                      (on-sprite-click (do-many (spawn random-failure-toast)
                                                (spawn avoid-broadcast)
                                                (do-after-time 1 die)))
                      (observe-change freeze-clicked? (if/r freeze-clicked?
                                                            (do-many (freeze-entity)
                                                                     (freeze-sprite)
                                                                     (do-after-time 100 (do-many (un-freeze-entity)
                                                                                                 (restore-sprite))))))
                      (observe-change slow-clicked? (if/r slow-clicked?
                                                          (do-many (slow-entity)
                                                                   (freeze-sprite)
                                                                   (do-after-time 100 (do-many (un-slow-entity)
                                                                                               (restore-sprite))))))
                      (after-time 200 die)
                      ))

(define (make-special sprite-or-proc . options)
  (define color (findf (or/c string? symbol?) options))
  (define sprite
    (if (procedure? sprite-or-proc)
      (sprite-or-proc)
      sprite-or-proc))
  (define value (cond [(fast-sprite-equal? sprite a:freeze) "freeze"]
                      [(fast-sprite-equal? sprite a:slow) "slow"]
                      [(fast-sprite-equal? sprite a:light) "light"]
                      [(fast-sprite-equal? sprite chest-sprite) "chest"]
                      [else (or (findf number? options)
                                100)]))
  (sprite->entity (if color
                         (colorize-sprite color sprite)
                         sprite)
                       #:name "special"
                       #:position (posn 0 0)
                       #:components (hidden)
                       (on-start (do-many (respawn 'anywhere)
                                          show))
                       (on-sprite-click (apply do-many
                                               (filter identity
                                                       (flatten (list (spawn (toast-entity (cond [(eq? value "freeze") "==== FREEZE ===="]
                                                                                                 [(eq? value "slow")   "==== SLOW ===="]
                                                                                                 [(eq? value "chest")  "==== LOOT ===="]
                                                                                                 [(eq? value "light")  "==== LIGHT ===="]
                                                                                                 [else                 (~a "+" value " POINTS!")])
                                                                                           #:color 'green))
                                                                      (spawn (special-broadcast value))
                                                                      (do-after-time 1 die))))))
                       (after-time 200 die)
                       ))

(define (call-if-proc p)
  (if (procedure? p)
    (p)
    p))

(define (start-clicker pointer-sprite collectible-sprites avoidable-sprites special-sprites 
                       #:bg-sprite     [bg-sprite (crop 0 0 640 480 FOREST-BG)]
                       #:world-objects [world-objects '()] )

  (define pointer
    (call-if-proc (apply make-pointer (flatten pointer-sprite))))
  (define collectibles-list
    (map 
      (compose call-if-proc (curry apply make-collectible)) 
      collectible-sprites ))
  (define avoidables-list
    (map 
      (compose call-if-proc (curry apply make-avoidable)) 
      avoidable-sprites))
  (define specials-list
    (map 
      (compose call-if-proc (curry apply make-special)) 
      special-sprites))


  (apply precompile! (append collectibles-list
                             avoidables-list
                             specials-list
                             (map (curry apply-image-function (curry tint-img 'cyan))
                                  (append collectibles-list
                                          avoidables-list
                                          specials-list))))
  (define instructions-entity
    (make-instructions "CLICK on the good things."
                       "AVOID the bad things."
                       "WIN by getting 2000 points."
                       "PRESS I to open these instructions."))

  (define tm-entity
    (time-manager-entity
      #:components
      (on-rule (and/r (reached-multiple-of? 20)
                      (λ (g e) (not (get-entity "collectible" g))))
               (do-many (if (empty? collectibles-list)
                          (λ (g e) e)
                          (spawn (λ()(first (shuffle collectibles-list)))))

                        ))
      (on-rule (reached-game-count? 500)
               (λ (g e)
                  (add-components e
                                  (spawn-once (toast-entity "==== LEVEL 2 ===="))
                                  (on-rule (reached-multiple-of? 200)
                                           (do-many (if (empty? avoidables-list)
                                                      (λ (g e) e)
                                                      (spawn (λ() (first (shuffle avoidables-list)))))
                                                    ))
                                  (on-rule (and/r (reached-multiple-of? 20)
                                                  (λ (g e) (< (length (get-entities "collectible" g)) 1)))
                                           (if (empty? collectibles-list)
                                             (λ (g e) e)
                                             (spawn (λ() (first (shuffle collectibles-list)))))))
                  ))

      (on-rule (reached-game-count? 1000)
               (λ (g e)
                  (add-components e
                                  (spawn-once (toast-entity "==== LEVEL 3 ===="))
                                  (on-rule (reached-multiple-of? 200)
                                           (do-many (if (empty? avoidables-list)
                                                      (λ (g e) e)
                                                      (spawn (λ() (first (shuffle avoidables-list)))))
                                                    (if (empty? specials-list)
                                                      (λ (g e) e)
                                                      (spawn (λ() (first (shuffle specials-list)))))
                                                    ))
                                  (on-rule (and/r (reached-multiple-of? 20)
                                                  (λ (g e) (< (length (get-entities "collectible" g)) 1)))
                                           (if (empty? collectibles-list)
                                             (λ (g e) e)
                                             (spawn (λ() (first (shuffle collectibles-list)))))))
                  ))

      ))

  (define make-font (dynamic-require 'racket/gui 'make-font))

  ; ======= START OF SCORE CODE =========
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


  (define (start-dead-component? c)
    (and (on-start? c)
         (eq? (on-start-func c) die)))

  (define (collectible-clicked? g e)
    (define collect-broadcast (get-entity "Collect Broadcast" g))
    (and collect-broadcast
         (get-component collect-broadcast start-dead-component?)))

  (define (avoidable-clicked? g e)
    (define avoid-broadcast (get-entity "Avoid Broadcast" g))
    (and avoid-broadcast
         (get-component avoid-broadcast start-dead-component?)))

  (define (special-clicked? g e)
    (define special-broadcast (get-entity "Special Broadcast" g))
    (and special-broadcast
         (get-component special-broadcast start-dead-component?)))

  (define (score-entity [prefix "Points"])
    (define counter-sprite
      (append (list (new-sprite (~a (string-titlecase prefix) ": 0")
                                #:color 'yellow))
              (bordered-box-sprite (* 10 (+ 7 (string-length prefix))) 24)
              ))
    (define (special-update-counter g e)
      (define special-broadcast (get-entity "Special Broadcast" g))
      (define special-value (get-storage-data "Value" special-broadcast))
      (if (number? special-value)
        ((change-counter-by special-value) g e)
        e))

    (define (game-won? g e)
      (>= (get-counter e) 2000))

    (define win-page
      (remove-components
        (page (text-sprite "YOU WIN!" #:font-size 24 #:color 'green)
              ""
              ""
              ""
              (list (text-sprite  "(This game will self destruct in     seconds)")
                    (text-sprite (list
                                   "                                             "
                                   "                                 10          "
                                   "                                 10          "
                                   "                                  9          "
                                   "                                  9          "
                                   "                                  8          "
                                   "                                  8          "
                                   "                                  7          "
                                   "                                  7          "
                                   "                                  6          "
                                   "                                  6          "
                                   "                                  5          "
                                   "                                  5          "
                                   "                                  4          "
                                   "                                  4          "
                                   "                                  3          "
                                   "                                  3          "
                                   "                                  2          "
                                   "                                  2          "
                                   "                                  1          "
                                   "                                  1          ")
                                 #:font-weight 'bold
                                 #:mode 'blink
                                 #:delay 10))
              #:duration 240)
        on-key?))

    (precompile! win-page)

    (sprite->entity counter-sprite
                    #:name       "score"
                    #:position   (posn 330 20)
                    #:components (static)
                    (counter 0)
                    (layer "ui")
                    (observe-change (λ (g e)
                                       (get-counter e))
                                    (λ (g e1 e2)
                                       ((do-many (draw-counter-rpg #:prefix (~a (string-titlecase prefix) ": "))
                                                 (do-font-fx)) g e2)))
                    (on-rule collectible-clicked? (change-counter-by 100))
                    (on-rule avoidable-clicked? (change-counter-by -50))
                    (on-rule special-clicked? special-update-counter)
                    (observe-change game-won?
                                    (if/r game-won?
                                          (do-many (spawn win-page)
                                                   (do-after-time 240 (λ (g e) (/ 0 0)))
                                                   )))
                    ))
  ; ======= END OF SCORE CODE =========
  (define (mround-up num multiple)
    (define rounded-num (exact-round num))
    (define remainder (modulo rounded-num multiple))
    (cond [(= remainder 0) rounded-num]
          [else (+ rounded-num multiple (- remainder))]))

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
                    (lock-to "pointer")
                    (on-edge 'right (go-to-pos 'right))
                    (on-edge 'left (go-to-pos 'left))
                    (on-edge 'top (go-to-pos 'top))
                    (on-edge 'bottom (go-to-pos 'bottom))
                    ;(apply precompiler
                    ;       (map (λ (a)(freeze (draw-sky-with-light (make-color r-val g-val b-val a))))
                    ;            (range 0 (+ max-alpha 2 1) update-multiplier)))
                    (on-start (do-many (go-to-pos 'center)
                                       show))
                    ;(do-every update-interval update-night-sky)
                    (observe-change light-clicked? (if/r light-clicked?
                                                         (do-many hide
                                                                  (do-after-time 100 show))))
                    ))

  (define bg-entity
    (reduce-quality (sprite->entity bg-sprite 
                                    #:name "bg"
                                    #:position (posn 0 0)
                                    #:components (on-key "i" #:rule (λ (g e) (not (get-entity "instructions" g)))
                                                         (spawn instructions-entity
                                                                #:relative? #f))))
    )

  (define trees-list
    (map (curryr remove-component (or/c physical-collider?
                                             active-on-bg?
                                             on-key?
                                             damager?
                                             size-val?
                                             hue-val?
                                             static?))
         (filter (λ(e)
                   (and (<= (posn-x (get-posn e)) 640)
                        (<= (posn-y (get-posn e)) 480)))
                 world-objects 
                 )))

  (apply start-game
         (flatten (list tm-entity
                        (night-sky-with-lighting #:scale (/ 640 480))
                        (score-entity) ;note: use #:prefix for future skinning
                        instructions-entity
                        pointer
                        (if (>= (length trees-list) 2)
                            (take (shuffle trees-list) 2)
                            trees-list)
                        bg-entity))))


(define (sprite->pointer-tree  bottom
                               [top (circle 1 'solid 'transparent)]
                               #:y-offset [y-offset -40])
  ; JL: This is the old way of doing things and it includes many unsused components that will get
  ;     filtered out in the trees-list above. We can now just have a tree and tree-top as sprites
  ;     with differet layers in the same entity via (new-sprite ... #:layer "tops").
  ;     As a work around, spawn-top-from-entity now takes only the sprite component from
  ;     the tree top entity, sets the sprite x and y offset, and adds it to the base entity.
  (define (constructor [p (posn 0 0)] #:tile [tile 0] #:hue [hue 0] #:size [size 1] #:components (c #f) . custom-components )
    (define top-entity
      (sprite->entity  
        (sprite-map (curry scale size)
                    (sprite-map (curry change-img-hue hue) (new-sprite top)))
        #:name       "Tree Top"
        #:position   (posn 0 y-offset)
        #:components (layer "tops")
        (active-on-bg tile)
        (hue-val hue)
        (size-val size)))
    (generic-entity (new-sprite bottom)
                    p
                    #:name "Tree Base"
                    #:tile tile
                    #:hue hue
                    #:size size
                    #:components (append
                                   (list (precompiler top-entity)
                                         (storage "Top" top-entity)
                                         (on-start spawn-top-from-storage))
                                   (cons c custom-components)))  )
  constructor)









(define-syntax-rule (bind-start start-name bind-to-f)
  (...
    (define-syntax-rule (start-name stuff ...) 
      (begin
        (bind-start-to bind-to-f) 
        (start stuff ...)))))

;Defines something called name that just calls start-clicker with extra parameters.  They must, of course, be ones that start-clicker actually takes.
(define-syntax-rule (define-start name extra ...)
  (begin
    (define (temp (pointer-sprite a:pointer)
                  (collectible-sprites '()) 
                  (avoidable-sprites '()) 
                  (special-sprites '()))
      (start-clicker pointer-sprite
                     collectible-sprites
                     avoidable-sprites
                     special-sprites
                     extra ...))
    (bind-start name temp)))


(define start-f (make-parameter #f))

(define (bind-start-to f)
  (start-f f))

(define-syntax (start stx)
  (syntax-parse stx
    [(start) #'((start-f)) ]
    [(start avatar-sprite (things ...) ...)
     #'((start-f) (listify avatar-sprite)
                  (list (listify things) ...)
                  ...)]))

(define-syntax (listify stx)
  (syntax-parse stx
    [(_ (things ...)) 
     #'(list things ...)]
    [(_ thing)
     #'(list thing)]))

(define-start start-pink
              #:bg-sprite (crop 0 0 640 480 PINK-BG)
              #:world-objects
              (make-world-objects candy-cane-tree candy-cane-tree
                                  #:rows    1
                                  #:columns 1))

(define-start start-lava
              #:bg-sprite (crop 0 0 640 480 LAVA-BG)
              #:world-objects
              (make-world-objects large-gray-rock random-gray-rock
                                  #:rows    1
                                  #:columns 1))

(define-start start-forest
              #:bg-sprite (crop 0 0 640 480 FOREST-BG)
              #:world-objects
              (make-world-objects round-tree pine-tree
                                  #:rows 1
                                  #:columns 1))

(define-start start-desert
              #:bg-sprite (crop 0 0 640 480 DESERT-BG)
              #:world-objects
              (make-world-objects large-brown-rock random-brown-rock
                                  #:rows    1
                                  #:columns 1))

(define-start start-snow
              #:bg-sprite (crop 0 0 640 480 SNOW-BG)
              #:world-objects
              (make-world-objects snow-pine-tree random-gray-rock
                                  #:rows    1
                                  #:columns 1))
