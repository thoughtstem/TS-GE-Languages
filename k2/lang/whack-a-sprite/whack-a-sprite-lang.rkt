#lang racket

(provide start-whack-a-sprite
         (all-from-out racket))

(require adventure
         ratchet/util
         (for-syntax racket)
         (prefix-in a: "./asset-friendly-names.rkt"))

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

(define (make-collectible sprite . options)
  (define speed (or (findf number? options)
                    2))
  (define color (findf (or/c string? symbol?) options))
  (if (procedure? sprite)
      (λ ()
        (remove-component (basic-npc #:sprite (if color
                                                  (colorize-sprite color (sprite))
                                                  (sprite))
                                     #:name "collectible"
                                     #:speed speed
                                     #:mode 'wander
                                     #:components (hidden)
                                     (on-start (do-many (respawn 'anywhere)
                                                        (random-direction)
                                                        show))
                                     (on-sprite-click (do-many (spawn (custom-particles))
                                                               (spawn random-success-toast)
                                                               (do-after-time 1 die)))
                                     )
                          physical-collider?))
      (remove-component (basic-npc #:sprite (if color
                                                (colorize-sprite color sprite)
                                                sprite)
                                   #:name "collectible"
                                   #:speed speed
                                   #:mode 'wander
                                   #:components (on-start (do-many (respawn 'anywhere)
                                                                   (random-direction)
                                                                   show))
                                   (on-sprite-click (do-many (spawn (custom-particles))
                                                             (spawn random-success-toast)
                                                             (do-after-time 1 die)))
                                   )
                        physical-collider?)))

(define (make-avoidable sprite . options)
  (define speed (or (findf number? options)
                    2))
  (define color (findf (or/c string? symbol?) options))
  (if (procedure? sprite)
      (λ ()
        (remove-component (basic-npc #:sprite (if color
                                                  (colorize-sprite color (sprite))
                                                  (sprite))
                                     #:name "avoidable"
                                     #:speed speed
                                     #:mode 'follow
                                     #:target "pointer"
                                     #:components (hidden)
                                     (on-start (do-many (respawn 'anywhere)
                                                        (random-direction)
                                                        show))
                                     (on-sprite-click (do-many (spawn random-failure-toast)
                                                               (do-after-time 1 die)))
                                     (after-time 200 die)
                                     )
                          physical-collider?))
      (remove-component (basic-npc #:sprite (if color
                                                (colorize-sprite color sprite)
                                                sprite)
                                   #:name "avoidable"
                                   #:speed speed
                                   #:mode 'follow
                                   #:target "pointer"
                                   #:components (on-start (do-many (respawn 'anywhere)
                                                                   (random-direction)
                                                                   show))
                                   (on-sprite-click (do-many (spawn random-failure-toast)
                                                             (do-after-time 1 die)))
                                   (after-time 200 die)
                                   )
                        physical-collider?)))

(define (make-special sprite . options)
  (define value (or (findf number? options)
                    100))
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
                                     (on-sprite-click (do-many (spawn (toast-entity (~a "+" value " POINTS!")
                                                                                    #:color 'green))
                                                               (do-after-time 1 die)))
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
                                   (on-sprite-click (do-many (spawn (toast-entity (~a "+" value " POINTS!")
                                                                                  #:color 'green))
                                                             (do-after-time 1 die)))
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
       
       (define instructions
         (make-instructions "ARROW KEYS to move"
                            "SPACE to eat food and collect coins"
                            "ENTER to close dialogs"
                            "I to open these instructions"
                            "M to open and close the map"))

       (define tm-entity
         (time-manager-entity
          #:components (on-rule (and/r (reached-multiple-of? 10)
                                       (λ (g e) (not (get-entity "collectible" g))))
                                (do-many (spawn (λ()(first (shuffle collectibles-list))))

                                         ))
          (on-rule (reached-game-count? 500)
                   (λ (g e)
                     (add-components e
                                     (on-rule (reached-multiple-of? 100)
                                              (do-many (spawn (λ() (first (shuffle avoidables-list))))

                                                       ))
                                     )))))

       (define bg-entity
         (basic-bg #:image (crop 0 0 640 480 FOREST-BG)
                   #:rows 1
                   #:columns 1))

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

; === START-NPC: HEAL YOUR FRIENDS GAME ===

(define healed-broadcast
    (sprite->entity empty-image
                    #:name "NPC Healed Broadcast"
                    #:position (posn 0 0)
                    #:components (on-start die)))

(define (health-at-max? g e)
  (define h (get-health e))       ;(get-storage-data "health-stat" e))
  (define max-h (get-storage-data "max-health-stat" e))
  (and h
       (= h max-h)))

(define (spawn-message-when-healed)
  (define healed-toast (toast-entity "HEALED" #:color 'green))
  (precompile! healed-toast)
  (observe-change health-at-max?
                  (λ (g e1 e2)
                    (if (health-at-max? g e2)
                        ((do-many
                          (play-sound PICKUP-SOUND)
                          (spawn (custom-particles))
                          (spawn healed-toast)
                          (spawn healed-broadcast)) g e2)
                        e2))
                   ))

;start-npc = avatar + npc + healing? + food (optional) coin (optional) enemy (optional)
(define-syntax start-npc
  (syntax-rules ()
    [(start-npc avatar-sprite (npc-sprite ...) (food-sprite ...) (enemy-sprite ...))
     (let ()
       (define avatar
         (app make-healing-avatar avatar-sprite))
       (define npc-list
         (list (app make-hurt-animal npc-sprite) ...))
       (define food-list
         (list (app make-food food-sprite ) ...))
       (define enemy-list
         (list (app make-enemy enemy-sprite ) ...))

       (define instructions
         (make-instructions "ARROW KEYS to move"
                            "SPACE to eat food and talk"
                            "ENTER to close dialogs"
                            "H to heal animals"
                            "I to open these instructions"
                            "M to open and close the map"))

       (survival-game #:bg           (custom-bg #:rows 2
                                                #:columns 2)
                       #:sky          #f
                       #:starvation-rate 25
                       #:avatar       avatar
                       #:npc-list     npc-list
                       #:food-list    food-list
                       #:enemy-list   enemy-list
                       #:score-prefix "Animals Healed"
                       #:instructions instructions)
       )]
    [(start-npc)                                (start-npc a:question-icon () () ())]
    [(start-npc avatar-sprite)                  (start-npc avatar-sprite () () ())]
    [(start-npc avatar-sprite (npc-sprite ...)) (start-npc avatar-sprite (npc-sprite ...) () ())]
    [(start-npc avatar-sprite (npc-sprite ...)
                              (food-sprite ...)) (start-npc avatar-sprite (npc-sprite ...) (food-sprite ...) ())]))


(define-syntax-rule (top-level lines ...)
  (let ()
    (thread
      (thunk lines ...)) 
    "Please wait..."))

