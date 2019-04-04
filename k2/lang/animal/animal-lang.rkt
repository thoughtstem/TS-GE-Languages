#lang racket

(provide start-a
         start-b
         start-c)

(require survival
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

    (survival-game #:bg           (custom-bg #:rows 2
                                             #:columns 2)
                   #:avatar       (custom-avatar #:sprite avatar-sprite)
                   #:food-list    food-list
                   #:score-prefix "Score"
                   )
    ))

;start-b = avatar + foods + coins
(define-syntax-rule (start-b avatar-sprite (food-sprite ...) (coin-sprite ...))
  (let ()
    (define food-list
      (list (app make-food food-sprite ) ...))
    (define coin-list
      (list (app make-coin coin-sprite ) ...))

    (survival-game #:bg           (custom-bg #:rows 2
                                             #:columns 2)
                   #:avatar       (custom-avatar #:sprite avatar-sprite)
                   #:food-list    food-list
                   #:coin-list    coin-list
                   #:score-prefix "Score"
                   )
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

    (survival-game #:bg           (custom-bg #:rows 2
                                             #:columns 2)
                   #:avatar       (custom-avatar #:sprite avatar-sprite)
                   #:food-list    food-list
                   #:enemy-list   enemy-list
                   #:coin-list    coin-list
                   #:score-prefix "Score"
                   )
    ))


(define-syntax-rule (top-level lines ...)
  (let ()
    (thread
      (thunk lines ...)) 
    "Please wait..."))
