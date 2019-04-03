#lang racket

(module farm-stuff racket

  (require survival
           "farm-assets.rkt")

  (provide start-a
           start-b
           start-c
           
           cat
           dog
           chicken
           cow
           goat
           llama
           pig 
           rabbit
           sheep
           turkey
           horse
           wolf

           apple
           banana
           brocolli
           cherries
           eggplant
           grapes
           kiwi
           mushroom
           onion
           pepper
           pineapple
           potato
           strawberry
           tomato

           copper
           silver
           gold)

  (define cat     blackcat-sprite)
  (define dog     browndog-sprite)
  (define chicken chicken-sprite)
  (define cow     cow-sprite)
  (define goat    goat-sprite)
  (define llama   llama-sprite)
  (define pig     pig-sprite)
  (define rabbit  rabbit-sprite)
  (define sheep   sheep-sprite)
  (define turkey  turkey-sprite)
  (define horse   goldenhorse-sprite)
  (define wolf    wolf-sprite)

  (define apple        apple-sprite)
  (define banana       banana-sprite)
  (define brocolli     brocolli-sprite)
  (define cherries     cherries-sprite)
  (define eggplant     eggplant-sprite)
  (define grapes       greengrapes-sprite)
  (define kiwi         kiwi-sprite)
  (define mushroom     mushroom-sprite)
  (define onion        onion-sprite)
  (define pepper       pepper-sprite)
  (define pineapple    pineapple-sprite)
  (define potato       potato-sprite)
  (define strawberry   strawberry-sprite)
  (define tomato       tomato-sprite)

  (define copper coppercoin-sprite)
  (define silver silvercoin-sprite)
  (define gold   goldcoin-sprite)

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
      [(equal? sprite gold) (custom-coin #:sprite sprite
                                         #:value  3
                                         #:amount-in-world 1
                                         #:name "Gold")]
      [(equal? sprite silver) (custom-coin #:sprite sprite
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
      "Please wait...")))

(require 'farm-stuff)
(provide (all-from-out racket 'farm-stuff))
