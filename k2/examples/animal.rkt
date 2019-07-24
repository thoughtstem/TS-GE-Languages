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
  

; -- section 3 - more friends
  
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
                              ((banana red))
                              ((wolf 2))
                              ((turkey 3))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-018
                       (start (dog green)
                             (rand rand rand)
                             (rand rand)
                             (rand)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-019
                       (start mushroom
                              ((pepper yellow 5) (pepper green 5))
                              ((kiwi banana))
                              ((onion red 3))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-020
                       (start rand
                              ((apple purple 5))
                              ((apple blue 5))
                              ((apple orange 5))))

  ; section 5 - more enemies
  
  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-021
                       (start cat
                              ((apple green 5)))
                       (start cat
                              ((apple yellow 5))
                              ((wolf 3))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-022
                       (start (horse blue)
                              ((pepper 8))
                              (rabbit))
                       (start (horse orange)
                              ((pepper 2))
                              ((rabbit 3))
                              (dog)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-023
                       (start sheep
                              ((banana red 2) (kiwi purple 3))
                              (sheep (wolf blue) (turkey red 2))
                              (rand))
                       (start rand
                              (rand rand)
                              (rand rand rand)
                              (rand rand rand rand)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-024
                       (start goat
                              (mushroom yellow 2))
                       (start goat
                              (banana)
                              (wolf green 4))
                       (start goat
                             (apple)
                             (sheep)
                             (dog red 3)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/enemies
                       animal-025
                       (start horse
                              ((horse green 2))
                              ((horse yellow 3))
                              ((horse red)))
                       (start wolf
                              ((wolf purple 4))
                              ((wolf blue 2))
                              ((wolf orange 3)))
                       (start banana
                              ((banana orange 2))
                              ((banana green 3))
                              ((banana red 4)))
    )
  )

(provide (all-from-out 'foods 'friends 'enemies))
(require 'foods 'friends 'enemies)

