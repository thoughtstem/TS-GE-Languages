#lang racket

(provide start-whack-a-sprite
         (all-from-out racket))

(require game-engine
         game-engine-demos-common
         (only-in adventure page)
         ratchet/util
         (for-syntax racket)
         (prefix-in a: "./asset-friendly-names.rkt")
         (only-in racket/gui make-font))

(define (fast-sprite-equal? s1 s2)
    (fast-equal? (current-fast-frame s1) (current-fast-frame s2)))

; Color a sprite by setting hue and saturation but not brightness
; UPDATE: Commenting out saturation for now.
;         Settting both sat and hue seems to result in scary red eyes.
(define/contract (colorize-sprite color-name sprite)
  (-> (or/c string? symbol?) animated-sprite? animated-sprite?)
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

(define (make-collectible sprite . options)
  (define speed (or (findf number? options)
                    2))
  (define color (findf (or/c string? symbol?) options))
  (if (procedure? sprite)
      (λ ()
        (remove-component (create-npc #:sprite (if color
                                                  (colorize-sprite color (sprite))
                                                  (sprite))
                                     #:name        "collectible"
                                     #:position    (posn 0 0)
                                     #:active-tile 0
                                     #:dialog (dialog->sprites (list "Hello") #:game-width 640)
                                     #:speed       speed
                                     #:mode        'wander
                                     #:components  (hidden)
                                     (on-start (do-many (respawn 'anywhere)
                                                        (random-direction)
                                                        show))
                                     (on-sprite-click (do-many (spawn (custom-particles))
                                                               (spawn random-success-toast)
                                                               (spawn collect-broadcast)
                                                               (do-after-time 1 die)))
                                     (observe-change freeze-clicked? (if/r freeze-clicked?
                                                                           (do-many (freeze-entity)
                                                                                    (do-after-time 100 (un-freeze-entity)))))
                                     (observe-change slow-clicked? (if/r slow-clicked?
                                                                         (do-many (slow-entity)
                                                                                  (do-after-time 100 (un-slow-entity)))))
                                     )
                          physical-collider?))
      (remove-component (create-npc #:sprite (if color
                                                (colorize-sprite color sprite)
                                                sprite)
                                   #:name        "collectible"
                                   #:position    (posn 0 0)
                                   #:active-tile 0
                                   #:dialog (dialog->sprites (list "Hello") #:game-width 640)
                                   #:speed       speed
                                   #:mode        'wander
                                   #:components  (hidden)
                                   (on-start (do-many (respawn 'anywhere)
                                                      (random-direction)
                                                      show))
                                   (on-sprite-click (do-many (spawn (custom-particles))
                                                             (spawn random-success-toast)
                                                             (spawn collect-broadcast)
                                                             (do-after-time 1 die)))
                                   (observe-change freeze-clicked? (if/r freeze-clicked?
                                                                         (do-many (freeze-entity)
                                                                                  (do-after-time 100 (un-freeze-entity)))))
                                   (observe-change slow-clicked? (if/r slow-clicked?
                                                                       (do-many (slow-entity)
                                                                                (do-after-time 100 (un-slow-entity)))))
                                   )
                        physical-collider?)))

(define (make-avoidable sprite . options)
  (define speed (or (findf number? options)
                    2))
  (define color (findf (or/c string? symbol?) options))
  (if (procedure? sprite)
      (λ ()
        (remove-component (create-npc #:sprite (if color
                                                  (colorize-sprite color (sprite))
                                                  (sprite))
                                     #:name "avoidable"
                                     #:position (posn 0 0)
                                     #:active-tile 0
                                     #:dialog      (dialog->sprites (list "Hello") #:game-width 640)
                                     #:speed speed
                                     #:mode 'follow
                                     #:target "pointer"
                                     #:components (hidden)
                                     (on-start (do-many (respawn 'anywhere)
                                                        (random-direction)
                                                        show))
                                     (on-sprite-click (do-many (spawn random-failure-toast)
                                                               (spawn avoid-broadcast)
                                                               (do-after-time 1 die)))
                                     (observe-change freeze-clicked? (if/r freeze-clicked?
                                                                           (do-many (freeze-entity)
                                                                                    (do-after-time 100 (un-freeze-entity)))))
                                     (observe-change slow-clicked? (if/r slow-clicked?
                                                                         (do-many (slow-entity)
                                                                                  (do-after-time 100 (un-slow-entity)))))
                                     (after-time 200 die)
                                     )
                          physical-collider?))
      (remove-component (create-npc #:sprite (if color
                                                (colorize-sprite color sprite)
                                                sprite)
                                   #:name "avoidable"
                                   #:position (posn 0 0)
                                   #:active-tile 0
                                   #:dialog      (dialog->sprites (list "Hello") #:game-width 640)
                                   #:speed speed
                                   #:mode 'follow
                                   #:target "pointer"
                                   #:components (hidden)
                                   (on-start (do-many (respawn 'anywhere)
                                                      (random-direction)
                                                      show))
                                   (on-sprite-click (do-many (spawn random-failure-toast)
                                                             (spawn avoid-broadcast)
                                                             (do-after-time 1 die)))
                                   (observe-change freeze-clicked? (if/r freeze-clicked?
                                                                         (do-many (freeze-entity)
                                                                                  (do-after-time 100 (un-freeze-entity)))))
                                   (observe-change slow-clicked? (if/r slow-clicked?
                                                                       (do-many (slow-entity)
                                                                                (do-after-time 100 (un-slow-entity)))))
                                   (after-time 200 die)
                                   )
                        physical-collider?)))

(define (make-special sprite . options)
  (define value (cond [(fast-sprite-equal? sprite (new-sprite (make-icon "FRZ" 'cyan))) "freeze"]
                      [(fast-sprite-equal? sprite (new-sprite (make-icon "SLO" 'cyan))) "slow"]
                      [(fast-sprite-equal? sprite chest-sprite) "chest"]
                      [else (or (findf number? options)
                                100)]))
  (define color (findf (or/c string? symbol?) options))
  (if (procedure? sprite)
      (λ ()
        (sprite->entity (if color
                            (colorize-sprite color (sprite))
                            (sprite))
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
                                                                                                 [else                 (~a "+" value " POINTS!")])
                                                                                           #:color 'green))
                                                                      (spawn (special-broadcast value))
                                                                      #|(if (eq? value "chest")
                                                                          (list
                                                                           (spawn (~> (random-special)
                                                                                      (remove-components _ (or/c on-start? hidden?))
                                                                                      (update-entity _ posn? (posn (random -40 40)
                                                                                                                   (random -40 40)))))
                                                                           (spawn (~> (random-special)
                                                                                      (remove-components _ (or/c on-start? hidden?))
                                                                                      (update-entity _ posn? (posn (random -40 40)
                                                                                                                   (random -40 40)))))
                                                                           (spawn (~> (random-special)
                                                                                      (remove-components _ (or/c on-start? hidden?))
                                                                                      (update-entity _ posn? (posn (random -40 40)
                                                                                                                   (random -40 40)))))
                                                                           )
                                                                          #f)|#
                                                                      (do-after-time 1 die))))))
                       (after-time 200 die)
                       ))
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
                                                                                            [else                 (~a "+" value " POINTS!")])
                                                                                      #:color 'green))
                                                                 (spawn (special-broadcast value))
                                                                 #|(if (eq? value "chest")
                                                                     (list
                                                                      (spawn (~> (random-special)
                                                                                 (remove-components _ (or/c on-start? hidden?))
                                                                                 (update-entity _ posn? (posn (random -40 40)
                                                                                                              (random -40 40)))))
                                                                      (spawn (~> (random-special)
                                                                                 (remove-components _ (or/c on-start? hidden?))
                                                                                 (update-entity _ posn? (posn (random -40 40)
                                                                                                              (random -40 40)))))
                                                                      (spawn (~> (random-special)
                                                                                 (remove-components _ (or/c on-start? hidden?))
                                                                                 (update-entity _ posn? (posn (random -40 40)
                                                                                                              (random -40 40)))))
                                                                      )
                                                                     #f)|#
                                                                 (do-after-time 1 die))))))
                  (after-time 200 die)
                  )))
                 
(define (call-if-proc p)
  (if (procedure? p)
      (p)
      p))

(define-syntax (app stx)
  (syntax-case stx ()
    [(_ f (args ...)) #'(f args ...)] 

    [(_ f arg) #'(f arg)] ) )

(define-syntax (provide-string stx)
  (define id (second (syntax->datum stx)))
  (datum->syntax stx
                 `(begin
                    (provide ,id)
                    (define ,id ,(~a id)))))

(define-syntax-rule (provide-strings s ...)
  (begin (provide-string s) ...))

(provide-strings red orange yellow green blue purple
                 pink lightgreen lightblue cyan magenta salmon)

;start-whack-a-sprite = pointer + collectibles (optional) + avoidables (optional) + specials (optional)
(define-syntax start-whack-a-sprite
  (syntax-rules ()
    [(start-whack-a-sprite pointer-sprite (collectible-sprite ...) (avoidable-sprite ...) (special-sprite ...))
     (let ()
       (define pointer
         (app make-pointer pointer-sprite))
       (define collectibles-list
         (list (app make-collectible collectible-sprite ) ...))
       (define avoidables-list
         (list (app make-avoidable avoidable-sprite ) ...))
       (define specials-list
         (list (app make-special special-sprite ) ...))

       (apply precompile! (append collectibles-list
                                  avoidables-list
                                  specials-list))
       
       (define instructions-entity
         (make-instructions "CLICK on the good things."
                            "AVOID the bad things."
                            "WIN by getting 1000 points."
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
                                              (do-many (if (empty? collectibles-list)
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
                                              (do-many (if (empty? collectibles-list)
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

       (define bg-entity
         (sprite->entity (crop 0 0 640 480 FOREST-BG)
                         #:name "bg"
                         #:position (posn 0 0)
                         #:components (on-key "i" #:rule (λ (g e) (not (get-entity "instructions" g)))
                                              (spawn instructions-entity
                                                     #:relative? #f)))
         )
         
       (define trees-list
         (map (curryr remove-component physical-collider?)
              (filter (λ(e)
                        (and (<= (posn-x (get-posn e)) 700)
                             (<= (posn-y (get-posn e)) 540)))
                      (make-world-objects round-tree pine-tree
                                          #:rows    1
                                          #:columns 1))))
       
       (apply start-game
              (flatten (list tm-entity
                             (score-entity) ;note: use #:prefix for future skinning
                             instructions-entity
                             pointer
                             trees-list
                             bg-entity)))
       )]
    [(start-whack-a-sprite)                                         (start-whack-a-sprite a:question-icon () () ())]
    [(start-whack-a-sprite pointer-sprite)                          (start-whack-a-sprite pointer-sprite () () ())]
    [(start-whack-a-sprite pointer-sprite (collectible-sprite ...)) (start-whack-a-sprite pointer-sprite (collectible-sprite ...) () ())]
    [(start-whack-a-sprite pointer-sprite (collectible-sprite ...)
                           (avoidable-sprite ...)) (start-whack-a-sprite pointer-sprite (collectible-sprite ...) (avoidable-sprite ...) ())]
    ))

(define-syntax-rule (top-level lines ...)
  (let ()
    (thread
      (thunk lines ...)) 
    "Please wait..."))

