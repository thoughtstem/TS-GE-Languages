#lang racket

(require ts-kata-util)

#|(module+ test
  (require (submod ".." foods test))
  (require (submod ".." coins test))
  (require (submod ".." enemies test)))
|#
(module+ syntaxes
  (provide
    (all-from-out
      (submod ".." foods syntaxes)  
      (submod ".." coins syntaxes)  
      (submod ".." enemies syntaxes)))

  (require
    (submod ".." foods syntaxes)  
    (submod ".." coins syntaxes)  
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

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/foods
                       animal-006
                       (start dog ((potato 3)(strawberry 3))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/foods
                       animal-007
                       (start horse ((banana 5) rand)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/foods
                       animal-008
                       (start rand ((kiwi 10) (tomato 2))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/foods
                       animal-009
                       (start dog ((onion 4) (apple 2)))
                       (start onion ((dog 5))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/foods
                       animal-010
                       (start goat (mushroom apple rand rand))
                       (start rand (onion (rand 5))))
)

(module coins racket
  (require ts-kata-util ;k2/lang/animal/coins
           )

  ; === ANIMALS/COINS
  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/coins
                       animal-011
                       (start cat ((apple 5) (rand 3))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/coins
                       animal-012
                       (start dog ((apple green) rand)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/coins
                       animal-013
                       (start cat ((apple blue 4)) (copper)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/coins
                       animal-014
                       (start silver ((dog red 5)) ((mushroom 10))))
  
  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/coins
                       animal-015
                       (start rand
                              ((mushroom red) (pineapple green) (apple 2))
                              ((copper 10) (silver 5) (gold 2))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/coins
                       animal-016
                       (start dog
                              ((apple 5))
                              (copper silver gold)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/coins
                       animal-017
                       (start rand
                              ((pineapple purple))
                              ((gold green 5))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/coins
                       animal-018
                       (start rand
                             (rand rand rand)
                             (rand rand rand)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/coins
                       animal-019
                       (start mushroom
                              ((rabbit green 5) (wolf yellow 2))
                              ((silver 10) (gold 4))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/animal/coins
                       animal-020
                       (start rand
                              ((apple purple 10))
                              ((copper 5) (silver 3) (gold purple))))
)

(module enemies racket
  (require ts-kata-util ;k2/lang/animal/enemies
           )
  
  ; === ANIMAL/ENEMIES
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

(provide (all-from-out 'foods 'coins 'enemies))
(require 'foods 'coins 'enemies)

