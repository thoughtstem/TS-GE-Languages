#lang racket

(provide
  start
  bind-start-to
  generic-start
  custom-bg
  make-instructions)

(require survival
         ratchet/util
         (for-syntax racket)
         (prefix-in a: animal-assets)
         syntax/parse/define
         (only-in common-icons question-mark))

(define-syntax (listify stx)
  (syntax-parse stx
    [(_ (things ...)) 
     #'(list things ...)]
    [(_ thing)
      #'(list thing)]))


(define start-f (make-parameter 
                  (thunk* 
                    (displayln "You need to set the start function with (bind-start-to ____)"))))

(define (bind-start-to f)
  (start-f f))

(define-syntax (start stx)
  (syntax-parse stx
    [(start) #'((start-f)) ]
    [(start avatar-sprite (things ...) ...)
     #'((start-f) (listify avatar-sprite)
                  (list (listify things) ...)
                  ...)]))


(define (generic-start
          #:bg (bg (custom-bg #:rows 2 #:columns 2))
          #:avatar-sprite (avatar-sprite 
                            (list question-mark))
          #:starvation-rate (starvation-rate 25)
          #:food-sprites (food-sprites '()) 
          #:enemy-sprites (enemy-sprites '()) 
          #:npc-sprites (npc-sprites '()) 
          #:score-prefix (score-prefix "Friends Healed")
          #:instructions (instructions
                           (make-instructions "ARROW KEYS to move"
                                              "SPACE to eat food and collect coins"
                                              "ENTER to close dialogs"
                                              "I to open these instructions"
                                              "M to open and close the map")))

  (define avatar
    (apply make-avatar avatar-sprite))

  (define food-list
    (map (curry apply make-food) food-sprites))
  (define enemy-list
    (map (curry apply make-enemy) enemy-sprites))
  (define npc-list
    (map (curry apply make-hurt-animal) npc-sprites))

  (survival-game #:bg          bg 
                 #:sky          #f
                 #:starvation-rate starvation-rate
                 #:avatar        avatar
                 #:food-list     food-list
                 #:enemy-list    enemy-list
                 #:score-prefix score-prefix 
                 #:instructions instructions)
  )



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
    [(fast-sprite-equal? (call-if-proc sprite) a:trash) (custom-coin #:sprite s
                                                                      #:value  10
                                                                      #:amount-in-world (or amount 1) 
                                                                      #:name "Trash Bag")]
    [(fast-sprite-equal? (call-if-proc sprite) a:can) (custom-coin #:sprite s
                                                                      #:value  5
                                                                      #:amount-in-world (or amount 5) 
                                                                      #:name "Aluminum Can")]
    [(fast-sprite-equal? (call-if-proc sprite) a:bottle) (custom-coin #:sprite s
                                                                      #:value  2
                                                                      #:amount-in-world (or amount 10) 
                                                                      #:name "Plastic Bottle")]
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
