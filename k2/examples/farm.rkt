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
  (require ts-kata-util ;k2/lang/farm/foods
           ) 

  ; ==== FARM/FOODS -- day 1
  (define-example-code 
    ;#:with-test (test game-test)

    k2/lang/farm/foods
    farm-000
    (start))

  (define-example-code 
    ;#:with-test (test game-test)

    k2/lang/farm/foods
    farm-001
    (start chicken
           (apple)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/foods
                       farm-002
                       (start chicken
                              (broccoli)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/foods
                       farm-003
                       (start horse
                              (broccoli apple onion)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/foods
                       farm-004
                       (start horse
                              (potato rand rand)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/foods
                       farm-005
                       (start rand
                              (rand rand rand)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/foods
                       farm-006
                       (start rand
                              (apple broccoli grapes onion potato tomato)))


  )

(module coins racket
  (require ts-kata-util k2/lang/farm/coins) 
  ; ==== FARM/COINS -- day 2

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/coins
                       farm-007
                       (start cow
                              ((apple 5) (kiwi 5))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/coins
                       farm-008
                       (start llama
                              ((rand 3) (rand 5))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/coins
                       farm-009
                       (start cow
                              (rand (rand 2) (rand 3))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/coins
                       farm-010
                       (start rabbit
                              (apple)
                              (copper)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/coins
                       farm-011
                       (start cow
                              (kiwi)
                              (gold)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/coins
                       farm-012
                       (start rand
                              (rand)
                              (rand)))

  ; ==== FARM/COINS -- day 3

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/coins
                       farm-013
                       (start sheep
                              (kiwi rand)
                              (silver rand)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/coins
                       farm-014
                       (start rabbit
                              ((banana 5) (apple 5))
                              (gold)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/coins
                       farm-015
                       (start rand
                              ((kiwi 10))
                              (copper)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/coins
                       farm-016
                       (start rand
                              ((rand 3) (rand 5))
                              (rand rand)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/coins
                       farm-017
                       (start rand
                              (potato)
                              (rand rand)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/coins
                       farm-018
                       (start rand
                              (rand rand)
                              (copper silver gold)))


  )

(module enemies racket
  (require ts-kata-util k2/lang/farm/enemies) 
  ; ==== FARM/ENEMIES -- day 4

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/enemies
                       farm-019
                       (start sheep
                              (apple)
                              (silver)
                              (dog)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/enemies
                       farm-020
                       (start rand
                              (rand rand rand rand rand)
                              (rand rand rand rand rand)))


  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/enemies
                       farm-021
                       (start sheep
                              (kiwi grapes)
                              (silver)
                              (dog)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/enemies
                       farm-022
                       (start horse
                              (pepper kiwi)
                              (silver gold)
                              (dog wolf)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/enemies
                       farm-023
                       (start rand
                              ((apple 3) (rand 5))
                              (silver rand)
                              (rand)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/enemies
                       farm-024
                       (start wolf
                              (apple (grapes 10))
                              (kiwi pepper)
                              (sheep cow)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/enemies
                       farm-025
                       (start horse
                              ((pepper 3) (grapes 3) (kiwi 3))
                              (silver gold)
                              ((dog 3) wolf)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/enemies
                       farm-026
                       (start apple
                              ((apple 5))
                              (apple)
                              ((apple 2))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/enemies
                       farm-027
                       (start rand
                              ((rand 5) (rand 5))
                              (rand rand rand)
                              (rand rand rand rand)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/enemies
                       farm-028
                       (start rabbit
                              (apple)
                              (gold))
                       (start rabbit
                              (kiwi)
                              (silver)
                              (dog)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/enemies
                       farm-029
                       (start rand
                              ((apple 3) (grapes 5))
                              (silver gold))
                       (start rand
                              (apple grapes)
                              (copper silver)
                              (wolf)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/farm/enemies
                       farm-030
                       (start horse
                              ((apple 5) (grapes 5) (kiwi 5))
                              (gold)
                              (dog))
                       (start llama
                              ((apple 5) (grapes 5))
                              (silver)
                              ((dog 2) wolf))
                       (start rabbit
                              ((apple 5))
                              (copper)
                              ((wolf 3))))

  )

(provide (all-from-out 'foods 'coins 'enemies))
(require 'foods 'coins 'enemies)

