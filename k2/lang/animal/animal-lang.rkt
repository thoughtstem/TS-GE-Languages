#lang racket

(provide start-a
         start-b
         start-c
         start-npc
         start-ocean-a
         (all-from-out racket))

(require survival
         ratchet/util
         (prefix-in a: "./animal-asset-friendly-names.rkt"))

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

(define (make-food sprite)
  (custom-food #:sprite sprite)) 

(define (make-friend sprite)
  (custom-npc #:sprite sprite
              #:tile (random 0 4)))

(define (make-enemy sprite)
  (custom-enemy #:sprite sprite
                #:weapon (custom-weapon #:name "Evilness"
                                        #:dart (growl-dart))))

(define (make-coin sprite)
  (cond
    [(equal? sprite a:gold) (custom-coin #:sprite sprite
                                         #:value  3
                                         #:amount-in-world 1
                                         #:name "Gold")]
    [(equal? sprite a:silver) (custom-coin #:sprite sprite
                                           #:value  2
                                           #:amount-in-world 5
                                           #:name "Silver")]
    [else  (custom-coin #:sprite sprite
                        #:value 1)])) 

(define-syntax (app stx)
  (syntax-case stx ()
    [(_ f (args ...)) #'(f args ...)] 

    [(_ f arg) #'(f arg)] ) )

;start-a = avatar + foods
(define-syntax-rule (start-a avatar-sprite (food-sprite ...))
  (let ()
    (define food-list
      (list (app make-food food-sprite ) ...))

    (launch-for-ratchet
      (survival-game #:bg           (custom-bg #:rows 2
                                               #:columns 2)
                     #:sky          #f
                     #:avatar       (custom-avatar #:sprite avatar-sprite)
                     #:food-list    food-list
                     #:score-prefix "Score"))))

;start-b = avatar + foods + coins
(define-syntax-rule (start-b avatar-sprite (food-sprite ...) (coin-sprite ...))
  (let ()
    (define food-list
      (list (app make-food food-sprite ) ...))
    (define coin-list
      (list (app make-coin coin-sprite ) ...))

    (launch-for-ratchet
      (survival-game #:bg           (custom-bg
                                     #:rows 2
                                               #:columns 2)
                     #:sky          #f
                     #:avatar       (custom-avatar #:sprite avatar-sprite)
                     #:food-list    food-list
                     #:coin-list    coin-list
                     #:score-prefix "Score"))
    
    ))

;start-c = avatar + foods + coins + enemies
(define-syntax-rule (start-c avatar-sprite (food-sprite ...) (coin-sprite ...) (enemy-sprite ...) )
  (let ()
    (define food-list
      (list (app make-food food-sprite ) ...))
    (define coin-list
      (list (app make-coin coin-sprite ) ...))
    (define enemy-list
      (list (app make-enemy enemy-sprite ) ...))

    (launch-for-ratchet
      (survival-game #:bg           (custom-bg #:rows 2
                                               #:columns 2)
                     #:sky          #f
                     #:avatar       (custom-avatar #:sprite avatar-sprite)
                     #:food-list    food-list
                     #:enemy-list   enemy-list
                     #:coin-list    coin-list
                     #:score-prefix "Score"))
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
  (observe-change health-at-max?
                  (λ (g e1 e2)
                    (if (health-at-max? g e2)
                        ((do-many
                          (play-sound PICKUP-SOUND)
                          (spawn (custom-particles))
                          (spawn (toast-entity "HEALED" #:color 'green))
                          (spawn healed-broadcast)) g e2)
                        e2))
                   ))

(define (make-hurt-animal sprite)
  (define health 10)
  (define max-health 100)
  ; is this actually faster than equal?
  (define (fast-sprite-equal? s1 s2)
    (fast-equal? (current-fast-frame s1) (current-fast-frame s2)))
  (define name-and-dialog (cond ;[(fast-sprite-equal? sprite a:lion)     (list "Lion"     "RoaAaRR!")]
                                [(fast-sprite-equal? sprite a:monkey)   (list "Monkey"   "*screams*")]
                                [(fast-sprite-equal? sprite a:elephant) (list "Elephant" "*trumpet sound*")]
                                [(fast-sprite-equal? sprite a:giraffe)  (list "Giraffe"  "...")]
                                [(fast-sprite-equal? sprite a:hippo)    (list "Hippo"    "Growl!")]
                                [(fast-sprite-equal? sprite a:kangaroo) (list "Kangaroo" "Phmpt!")]
                                [(fast-sprite-equal? sprite a:penguin)  (list "Penguin"  "...")]
                                [(fast-sprite-equal? sprite a:zebra)    (list "Zebra"    "Barrk!")]
                                ;[(fast-sprite-equal? sprite a:tiger)    (list "Tiger"    "RoaAr!")]
                                [else                                   (list "Animal"   "...")]))
                                
  (define (become-combatant g e)
    (define c (~> e
                  (combatant
                   #:stats (list (make-stat-config 'health
                                                   health
                                                   (stat-progress-bar 'red #:max max-health #:offset (posn 0 -30))
                                                   #:max-value max-health))
                   #:damage-processor (filter-damage-by-tag #:filter-out '(passive enemy-team)
                                                            #:hit-sound SHORT-BLIP-SOUND)
                   _)
                  ))
    c)
  
  (custom-npc #:sprite sprite
              #:tile (random 0 4)
              #:name (first name-and-dialog)
              #:dialog (list (second name-and-dialog))
              #:components (damager 10 (list 'passive 'enemy-team 'bullet))
                           (spawn-message-when-healed)
                           (on-start become-combatant)
              ))

;start-npc = avatar + npc + healing?
(define-syntax-rule (start-npc avatar-sprite (npc-sprite ...))
  (let ()
    (define npc-list
      (list (app make-hurt-animal npc-sprite) ...))

    (launch-for-ratchet
      (survival-game #:bg           (custom-bg #:rows 2
                                               #:columns 2)
                     #:sky          #f
                     #:starvation-rate -1000
                     #:avatar       (custom-avatar #:sprite avatar-sprite
                                                   #:components (custom-weapon-system
                                                                 #:dart (ice-dart #:sprite (new-sprite "+" #:color 'lightgreen)
                                                                                  #:damage -10
                                                                                  #:speed 5)
                                                                 #:fire-mode 'random
                                                                 #:fire-rate 10
                                                                 #:fire-key  'h
                                                                 #:fire-sound BUBBLE-SOUND))
                     #:npc-list     npc-list
                     #:score-prefix "Animals Healed"))
    ))

;start-ocean-a = avatar + foods
(define-syntax-rule (start-ocean-a avatar-sprite (food-sprite ...))
  (let ()
    (define food-list
      (list (app make-food food-sprite ) ...))

    (launch-for-ratchet
      (survival-game #:bg           (custom-bg #:image a:ocean-bg
                                               #:rows 2
                                               #:columns 2)
                     #:sky          #f
                     #:avatar       (custom-avatar #:sprite avatar-sprite)
                     #:food-list    food-list
                     #:score-prefix "Score"))))


(define-syntax-rule (top-level lines ...)
  (let ()
    (thread
      (thunk lines ...)) 
    "Please wait..."))

