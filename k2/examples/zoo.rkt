#lang racket 

#|(module+ test
  (require (submod ".." foods test))
  (require (submod ".." coins test))
  (require (submod ".." friends test)))
|#
(module+ syntaxes
  (provide
    (all-from-out
      (submod ".." foods syntaxes)  
      (submod ".." coins syntaxes)  
      (submod ".." friends syntaxes)))

  (require
    (submod ".." foods syntaxes)  
    (submod ".." coins syntaxes)  
    (submod ".." friends syntaxes)))


(module foods racket
  (require ts-kata-util ;k2/lang/zoo/foods
           )
  ; ==== ZOO/FOODS

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/foods
                       zoo-000
                       (start))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/foods
                       zoo-001
                       (start monkey
                              (banana)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/foods
                       zoo-002
                       (start elephant
                              (grapes)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/foods
                       zoo-003
                       (start hippo
                              (apple potato onion)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/foods
                       zoo-004
                       (start kangaroo
                              (apple rand rand)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/foods
                       zoo-005
                       (start rand
                              (rand rand rand)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/foods
                       zoo-006
                       (start rand
                              (apple banana grapes onion tomato)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/foods
                       zoo-007
                       (start hippo
                              ((apple 5) (banana 5))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/foods
                       zoo-008
                       (start hippo
                              ((apple 3) (rand 5))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/foods
                       zoo-009
                       (start monkey
                              ((banana red) (banana green) (banana blue))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/foods
                       zoo-010
                       (start hippo
                              ((rand purple 5))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/foods
                       zoo-011
                       (start penguin
                              ((fish green 3)
                               (fish red 5))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/foods
                       zoo-012
                       (start rand
                              ((rand blue 5)
                               (rand green 5))))
  )

(module coins racket
  (require ts-kata-util)

  ; ==== ZOO/FOOD+COINS DAY 2


  ; ==== ZOO/FARM+COINS DAY 3

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/coins
                       zoo-013
                       (start zookeeper
                              (apple)
                              (copper silver gold)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/coins
                       zoo-014
                       (start zookeeper
                              (apple banana)
                              ((gold 2) (silver 4) (copper 6))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/coins
                       zoo-015
                       (start rand
                              ((rand 10))
                              ((gold purple 10))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/coins
                       zoo-016
                       (start (penguin green)
                              ((fish blue 5))
                              ((gold red 10))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/coins
                       zoo-017
                       (start monkey
                              ((banana 10)))
                       (start monkey
                              ((banana 10))
                              ((silver 10))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/coins
                       zoo-018
                       (start rand
                              (rand rand)
                              ((copper 5)))
                       (start rand
                              (rand rand)
                              ((gold 10))
                              ))


  )

(module friends racket
  (require ts-kata-util k2/lang/zoo/friends)

  ;==== ZOO/FRIENDS DAY 4

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/friends
                       zoo-019
                       (start zookeeper
                              (monkey)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/friends
                       zoo-020
                       (start zookeeper
                              (monkey elephant giraffe)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/friends
                       zoo-021
                       (start zookeeper
                              (hippo kangaroo)))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/friends
                       zoo-022
                       (start zookeeper
                              ((penguin 3))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/friends
                       zoo-023
                       (start zookeeper
                              ((monkey 2) (elephant 2))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/friends
                       zoo-024
                       (start zookeeper
                              ((monkey 2) (elephant 2))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/friends
                       zoo-025
                       (start (zookeeper purple)
                              ((monkey 2) (elephant 4) (penguin 6))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/friends
                       zoo-026
                       (start (zookeeper red)
                              ((giraffe green 4) (giraffe purple 4))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/friends
                       zoo-027
                       (start zookeeper
                              ((rand red 4) (rand green 4) (rand blue 4))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/friends
                       zoo-028
                       (start zookeeper
                              ((monkey 5) (hippo 5))
                              ((apple 5) (banana 5))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/friends
                       zoo-029
                       (start zookeeper
                              ((monkey red 4) (monkey blue 4) (monkey green 4)))
                       (start zookeeper
                              ((giraffe orange 4) (giraffe yellow 4) (giraffe purple 4))))

  (define-example-code ;#:with-test (test game-test)
                       k2/lang/zoo/friends
                       zoo-030
                       (start zookeeper
                              ((monkey 2))
                              ((banana 2)))
                       (start zookeeper
                              ((penguin 4))
                              ((fish 4)))
                       (start zookeeper
                              ((hippo 6))
                              ((apple 6))))

  )

(provide (all-from-out 'foods 'coins 'friends))
(require 'foods 'coins 'friends)
