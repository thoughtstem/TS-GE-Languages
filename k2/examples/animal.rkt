#lang racket

(require ts-kata-util)

#|(module+ test
  (require (submod ".." foods test))
  (require (submod ".." friends test))
  (require (submod ".." enemies test)))
|#
(module+ syntaxes
  (provide
    (all-from-out
      (submod ".." foods syntaxes)  
      (submod ".." friends syntaxes)  
      (submod ".." enemies syntaxes)))

  (require
    (submod ".." foods syntaxes)  
    (submod ".." friends syntaxes)  
    (submod ".." enemies syntaxes))
  )

(module foods racket
  (require ts-kata-util  ;k2/lang/animal/foods
           )

  ; === ANIMAL/FOODS
  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/foods
                       animal-000
                       (start))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/foods
                       animal-001
                       (start dog))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/foods
                       animal-002
                       (start cat (apple)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/foods
                       animal-003
                       (start onion (cat rand)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/foods
                       animal-004
                       (start rabbit (potato kiwi tomato)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/foods
                       animal-005
                       (start rand (rand rand rand)))
  )

  ; === ANIMAL/FRIENDS

(module friends racket
  (require ts-kata-util  ;k2/lang/animal/friends
           )
  
  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/friends
                       animal-006
                       (start dog
                              (potato)
                              (goat)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/friends
                       animal-007
                       (start horse
                              (mushroom onion)
                              (rabbit sheep)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/friends
                       animal-008
                       (start (horse purple)
                              (kiwi broccoli)
                              (cat)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/friends
                       animal-009
                       (start (sheep green)
                              (onion apple)
                              (turkey rand)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/friends
                       animal-010
                       (start (rand orange)
                              (rand rand)
                              (rand rand rand)))
  

; -- section 3
  
  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/friends
                       animal-011
                       (start turkey
                              ((apple 5))
                              ((goat 5))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/friends
                       animal-012
                       (start (dog blue)
                              ((apple green))
                              ((horse red))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/friends
                       animal-013
                       (start cat
                              ((apple blue 4) (potato red 2))
                              ((turkey green 3))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/friends
                       animal-014
                       (start apple
                              ((broccoli red 5))
                              ((kiwi 3) (mushroom orange))))
  
  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/friends
                       animal-015
                       (start (rand purple)
                              ((mushroom red) (potato green) (apple 2))
                              ((goat 2) (rand blue))))

  )

(module enemies racket
  (require ts-kata-util ;k2/lang/animal/enemies
           )
  
  ; === ANIMAL/ENEMIES
  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-016
                       (start cat
                              ((apple 5))
                              ((sheep 5))
                              (wolf)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-017
                       (start rand
                              ((pineapple purple))
                              ((gold green 5))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-018
                       (start rand
                             (rand rand rand)
                             (rand rand rand)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-019
                       (start mushroom
                              ((rabbit green 5) (wolf yellow 2))
                              ((silver 10) (gold 4))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-020
                       (start rand
                              ((apple purple 10))
                              ((copper 5) (silver 3) (gold purple))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-021
                       (start cat ((rand green 3)) ((gold 4))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-022
                       (start horse
                              ((apple 8))
                              ((copper 10))
                              (wolf)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-023
                       (start rabbit
                              ((wolf green 4))
                              ((wolf yellow 3))
                              ((wolf red 5))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-024
                       (start rand
                              (rand)
                              (rand rand)
                              (rand rand rand)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-025
                       (start dog
                              ((apple green 2))
                              (copper gold)
                              (turkey))
                       (start cat
                              ((rabbit 3))
                              ((silver 3))
                              ((dog 3))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-026
                       (start rand
                              (rand rand rand)
                              (rand rand rand)
                              (rand rand rand))
                       (start wolf
                              (turkey rabbit cat)
                              ((onion orange) (mushroom purple))
                              (copper silver gold)))
  
  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-027
                       (start copper
                              ((copper blue 5))
                              ((copper green 3))
                              ((copper purple))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-028
                       (start rabbit
                              ((mushroom red 5))
                              ((copper 5) (silver 5))
                              ((rabbit red 5)))
                       (start onion
                              (rand rand)
                              (rand rand)
                              (rand rand)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-029
                       (start rand (rand))
                       (start rand () (rand))
                       (start rand () () (rand)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-030
                       (start cat
                              ((apple green 4) (mushroom 3))
                              (copper silver gold)
                              ((turkey 4) (wolf 6)))
                       (start dog
                              (rand (onion 4) (pepper red 2))
                              ((gold 10))
                              (cat horse rabbit turkey wolf))
                       (start mushroom
                              ((mushroom 4))
                              ((pepper red 3)(apple orange 2))
                              (copper silver gold)))
)

(provide (all-from-out 'foods 'friends 'enemies))
(require 'foods 'friends 'enemies)

