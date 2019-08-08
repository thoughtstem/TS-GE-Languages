#lang racket

(provide start-animal
         start-animal-asp
         start-npc
         start-sea
         start-sea-npc
         (all-from-out racket))

(require survival
         ratchet/util
         (for-syntax racket)
         (prefix-in a: "./animal-asset-friendly-names.rkt"))

(define (fast-sprite-equal? s1 s2)
    (fast-equal? (current-fast-frame s1) (current-fast-frame s2)))

(define growl-sprite
  (overlay/offset (rotate -45 (rectangle 6 4 'solid 'black))
                  -3 3
                  (overlay (circle 10 'outline 'black)
                           (circle 10 'solid (make-color 128 128 128 128)))))

(define (growl-dart  #:sprite     [s   growl-sprite]
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

(define (make-avatar sprite . options)
  (define color (findf (or/c string? symbol?) options))
  (define s (call-if-proc sprite))
  (custom-avatar #:sprite (if color
                              (colorize-sprite color s)
                              s)))

(define (make-healing-avatar sprite . options)
  (define color (findf (or/c string? symbol?) options))
  (define s (call-if-proc sprite))
  (custom-avatar #:sprite (if color
                              (colorize-sprite color s)
                              s)
                 #:components (custom-weapon-system
                               #:dart (ice-dart #:sprite (new-sprite "+" #:color 'lightgreen)
                                                #:damage -10
                                                #:speed 5)
                               #:fire-mode 'random
                               #:fire-rate 10
                               #:fire-key  'h
                               #:fire-sound BUBBLE-SOUND)))
                 
(define (make-food sprite . options)
  (define amount (or (findf number? options)
                     1))
  (define color (findf (or/c string? symbol?) options))
  
  (if (procedure? sprite)
      (λ ()
        (custom-food #:sprite (if color
                                  (colorize-sprite color (sprite))
                                  (sprite))
                     #:amount-in-world amount))
      (custom-food #:sprite (if color
                                (colorize-sprite color sprite)
                                sprite)
                   #:amount-in-world amount)))

;NOTE: amount-in-world for custom-npc has not been implemented yet
(define (make-friend sprite . options)
  (define amount (or (findf number? options)
                     1))
  (define color (findf (or/c string? symbol?) options))
  (if (procedure? sprite)
      (λ ()
        (custom-npc #:sprite (if color
                                  (colorize-sprite color (sprite))
                                  (sprite))
              #:tile (random 0 4)))
      (custom-npc #:sprite (if color
                                (colorize-sprite color sprite)
                                sprite)
                  #:tile (random 0 4))))

(define (make-enemy sprite . options)
  (define amount (or (findf number? options)
                     1))
  (define color (findf (or/c string? symbol?) options))
  
  (if (procedure? sprite)
      (λ ()
        (custom-enemy #:sprite (if color
                                  (colorize-sprite color (sprite))
                                  (sprite))
                      #:amount-in-world amount
                      #:weapon (custom-weapon #:name "Evilness"
                                              #:dart (growl-dart))))
      (custom-enemy #:sprite (if color
                                (colorize-sprite color sprite)
                                sprite)
                    #:amount-in-world amount
                    #:weapon (custom-weapon #:name "Evilness"
                                            #:dart (growl-dart)))))

(define (make-coin sprite . options)
  (define amount (findf number? options))
  (define color (findf (or/c string? symbol?) options))
  
  (define s (if (procedure? sprite)
                (if color
                    (colorize-sprite color (sprite))
                    (sprite))
                (if color
                    (colorize-sprite color sprite)
                    sprite)))
  (cond
    [(fast-sprite-equal? (call-if-proc sprite) a:gold) (custom-coin #:sprite s
                                                                    #:value  3
                                                                    #:amount-in-world (or amount 1)
                                                                    #:name "Gold")]
    [(fast-sprite-equal? (call-if-proc sprite) a:silver) (custom-coin #:sprite s
                                                                      #:value  2
                                                                      #:amount-in-world (or amount 5) 
                                                                      #:name "Silver")]
    [else  (custom-coin #:sprite s
                        #:value 1
                        #:amount-in-world (or amount 10))]))

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

;start-animal = avatar + foods (optional) + coins (optional) + enemies (optional)
(define-syntax start-animal
  (syntax-rules ()
    [(start-animal avatar-sprite (food-sprite ...) (coin-sprite ...) (enemy-sprite ...))
     (let ()
       (define avatar
         (app make-avatar avatar-sprite))
       (define food-list
         (list (app make-food food-sprite ) ...))
       (define coin-list
         (list (app make-coin coin-sprite ) ...))
       (define enemy-list
         (list (app make-enemy enemy-sprite ) ...))

       (define instructions
         (make-instructions "ARROW KEYS to move"
                            "SPACE to eat food and collect coins"
                            "ENTER to close dialogs"
                            "I to open these instructions"
                            "M to open and close the map"))

       (survival-game #:bg           (custom-bg #:rows 2
                                                #:columns 2)
                       #:sky          #f
                       #:starvation-rate 25
                       #:avatar        avatar
                       #:food-list     food-list
                       #:coin-list     coin-list
                       #:enemy-list    enemy-list
                       #:score-prefix "Score"
                       #:instructions instructions)
       )]
    [(start-animal)                                 (start-animal a:question-icon () () ())]
    [(start-animal avatar-sprite)                   (start-animal avatar-sprite () () ())]
    [(start-animal avatar-sprite (food-sprite ...)) (start-animal avatar-sprite (food-sprite ...) () ())]
    [(start-animal avatar-sprite (food-sprite ...)
                                 (coin-sprite ...)) (start-animal avatar-sprite (food-sprite ...) (coin-sprite ...) ())]
    ))

;start-animal-asp = avatar + foods (optional) + hurt-npc (optional) + enemies (optional)
(define-syntax start-animal-asp
  (syntax-rules ()
    [(start-animal avatar-sprite (food-sprite ...) (npc-sprite ...) (enemy-sprite ...))
     (let ()
       (define avatar
         (app make-healing-avatar avatar-sprite))
       (define food-list
         (list (app make-food food-sprite ) ...))
       (define npc-list
         (list (app make-hurt-animal npc-sprite ) ...))
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
                       #:avatar        avatar
                       #:food-list     food-list
                       #:npc-list      npc-list
                       #:enemy-list    enemy-list
                       #:score-prefix "Animals Healed"
                       #:instructions instructions)
       )]
    [(start-animal)                                 (start-animal a:question-icon () () ())]
    [(start-animal avatar-sprite)                   (start-animal avatar-sprite () () ())]
    [(start-animal avatar-sprite (food-sprite ...)) (start-animal avatar-sprite (food-sprite ...) () ())]
    [(start-animal avatar-sprite (food-sprite ...)
                                 (npc-sprite ...)) (start-animal avatar-sprite (food-sprite ...) (npc-sprite ...) ())]
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

(define (make-hurt-animal s . options)
  (define amount (or (findf number? options)
                     1))
  (define color (findf (or/c string? symbol?) options))
  (define sprite (call-if-proc s))
  (define health 10)
  (define max-health 100)
  
  (define name-and-dialog (cond ;[(fast-sprite-equal? sprite a:lion)     (list "Lion"     "RoaAaRR!")]
                                [(fast-sprite-equal? sprite a:monkey)   (list "Monkey"   "*screams*")]
                                [(fast-sprite-equal? sprite a:elephant) (list "Elephant" "*trumpet sound*")]
                                [(fast-sprite-equal? sprite a:giraffe)  (list "Giraffe"  "Hello!")]
                                [(fast-sprite-equal? sprite a:hippo)    (list "Hippo"    "Growl!")]
                                [(fast-sprite-equal? sprite a:kangaroo) (list "Kangaroo" "Phmpt!")]
                                [(fast-sprite-equal? sprite a:penguin)  (list "Penguin"  "Hello!")]
                                [(fast-sprite-equal? sprite a:zebra)    (list "Zebra"    "Barrk!")]
                                ;[(fast-sprite-equal? sprite a:tiger)    (list "Tiger"    "RoaAr!")]
                                ;adding sea animals
                                [(fast-sprite-equal? sprite a:ghost-fish)  (list "Ghost Fish" "Boo!")]
                                [(fast-sprite-equal? sprite a:green-fish)  (list "Gladys"     "Gluub")]
                                [(fast-sprite-equal? sprite a:jellyfish)   (list "Jelly"      "Bloop")]
                                [(fast-sprite-equal? sprite a:orange-fish) (list "Orville"    "Blubb")]
                                [(fast-sprite-equal? sprite a:red-fish)    (list "Ronald"     "*swish*")]
                                [(fast-sprite-equal? sprite a:shark)       (list "Bruce"      "*chomp!*")]
                                [(fast-sprite-equal? sprite a:yellow-fish) (list "Matilda"    "Gloop?")]
                                [(fast-sprite-equal? sprite a:starfish)    (list "Patrick"    "HI!!")]
                                [(fast-sprite-equal? sprite a:octopus)     (list "Octavia"    "Fwoosh")]
                                [(fast-sprite-equal? sprite a:crab)        (list "Christoph"  "*snip snip*")]
                                
                                [else                                      (list "Animal"   "Hello!")]))
                                
  (define (become-combatant g e)
    (define c (~> e
                  (combatant
                   #:stats (list (make-stat-config 'health
                                                   health
                                                   (stat-progress-bar-system 'red
                                                                             #:max max-health
                                                                             #:starting-value health
                                                                             #:offset (posn 0 -30))
                                                   #:max-value max-health))
                   #:damage-processor (filter-damage-by-tag #:filter-out '(passive enemy-team)
                                                            #:hit-sound SHORT-BLIP-SOUND)
                   _)
                  ))
    c)
  
  (custom-npc #:sprite (if color
                           (colorize-sprite color sprite)
                           sprite)
              #:tile (random 0 4)
              #:name (first name-and-dialog)
              #:dialog (list (second name-and-dialog))
              #:components (damager 10 (list 'passive 'enemy-team 'bullet))
                           (spawn-message-when-healed)
                           (on-start become-combatant)
                           (storage "amount-in-world" amount)
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

; ==== basic games with sea bg =====
;note: sea bg is ugly. find a better one?

;start-sea = avatar + foods + enemies + coins (no katas, hidden option) ... with sea bg
(define-syntax start-sea
  (syntax-rules ()
    [(start-sea avatar-sprite (food-sprite ...) (enemy-sprite ...) (coin-sprite ...))
     (let ()
       (define avatar
         (app make-avatar avatar-sprite))
       (define food-list
         (list (app make-food food-sprite ) ...))
       (define enemy-list
         (list (app make-enemy enemy-sprite ) ...))
       (define coin-list
         (list (app make-coin coin-sprite ) ...))

       (define instructions
         (make-instructions "ARROW KEYS to move"
                            "SPACE to eat food"
                            "ENTER to close dialogs"
                            "I to open these instructions"
                            "M to open and close the map"))

       (survival-game #:bg           (custom-bg #:image a:sea-bg
                                                 #:rows 2
                                                 #:columns 2)
                       #:sky          #f
                       #:avatar       avatar
                       #:food-list    food-list
                       #:enemy-list   enemy-list
                       #:score-prefix "Score"
                       #:instructions instructions))]
    
    [(start-sea)                                  (start-sea a:question-icon () () ())]
    [(start-sea avatar-sprite)                    (start-sea avatar-sprite () () ())]
    [(start-sea avatar-sprite (food-sprite ...))  (start-sea avatar-sprite (food-sprite ...) () ())]
    [(start-sea avatar-sprite (food-sprite ...)
                              (enemy-sprite ...)) (start-sea avatar-sprite (food-sprite ...) (enemy-sprite ...) ())]
    [(start-sea avatar-sprite (food-sprite ...)
                              (enemy-sprite ...)
                              (coin-sprite ...))  (start-sea avatar-sprite (food-sprite ...) (enemy-sprite ...) (coin-sprite ...))]
    ))

;start-sea-npc = avatar + npc + food + enemy + coin ... with sea bg
(define-syntax start-sea-npc
  (syntax-rules ()
    [(start-sea-npc avatar-sprite (npc-sprite ...) (food-sprite ...) (enemy-sprite ...)(coin-sprite ...))
     (let ()
       (define avatar
         (app make-healing-avatar avatar-sprite))
       (define npc-list
         (list (app make-hurt-animal npc-sprite) ...))
       (define food-list
         (list (app make-food food-sprite ) ...))
       (define enemy-list
         (list (app make-enemy enemy-sprite ) ...))
       (define coin-list
         (list (app make-coin coin-sprite ) ...))

       (define instructions
         (make-instructions "ARROW KEYS to move"
                            "SPACE to eat food and talk"
                            "ENTER to close dialogs"
                            "H to heal"
                            "I to open these instructions"
                            "M to open and close the map"))

       (survival-game #:bg           (custom-bg #:image a:sea-bg
                                                 #:rows 2
                                                 #:columns 2)
                       #:sky          #f
                       #:starvation-rate -1000
                       #:avatar       avatar
                       #:npc-list     npc-list
                       #:food-list    food-list
                       #:enemy-list   enemy-list
                       #:coin-list    coin-list
                       #:score-prefix "Animals Healed"
                       #:instructions instructions))]

    [(start-sea-npc)                    (start-sea-npc a:question-icon () () () ())]
    [(start-sea-npc avatar-sprite)      (start-sea-npc avatar-sprite () () () ())]
    [(start-sea-npc avatar-sprite
                    (npc-sprite ...))   (start-sea-npc avatar-sprite (npc-sprite ...) () () ())]
    [(start-sea-npc avatar-sprite
                    (npc-sprite ...)
                    (food-sprite ...))  (start-sea-npc avatar-sprite (npc-sprite ...) (food-sprite ...) () ())]
    [(start-sea-npc avatar-sprite
                    (npc-sprite ...)
                    (food-sprite ...)
                    (enemy-sprite ...)) (start-sea-npc avatar-sprite (npc-sprite ...) (food-sprite ...) (enemy-sprite ...) ())]
    [(start-sea-npc avatar-sprite
                    (npc-sprite ...)
                    (food-sprite ...)
                    (enemy-sprite ...)
                    (coin-sprite ...))  (start-sea-npc avatar-sprite (npc-sprite ...) (food-sprite ...) (enemy-sprite ...) (coin-sprite ...))]
    ))



(define-syntax-rule (top-level lines ...)
  (let ()
    (thread
      (thunk lines ...)) 
    "Please wait..."))

