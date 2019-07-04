#lang racket 

(module+ test
  (require (submod ".." foods test))
  (require (submod ".." friends test))
  (require (submod ".." enemies test)))

(module+ syntaxes
  (provide
    (all-from-out
      (submod ".." foods syntaxes)  
      (submod ".." friends syntaxes)  
      (submod ".." enemies syntaxes)))

  (require
    (submod ".." foods syntaxes)  
    (submod ".." friends syntaxes)  
    (submod ".." enemies syntaxes)))


(module foods racket
  (require ts-kata-util k2/lang/sea/foods)

  ; ==== SEA/FOODS
  ;day 1 start
  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/foods
                       sea-000
                       (start))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/foods
                       sea-001
                       (start yellow-fish
                              (pineapple)))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/foods
                       sea-002
                       (start crab
                              (kiwi)))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/foods
                       sea-003
                       (start red-fish
                              (broccoli tomato apple)))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/foods
                       sea-004
                       (start starfish
                              (pineapple rand rand)))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/foods
                       sea-005
                       (start rand
                              (rand rand rand)))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/foods
                       sea-006
                       (start rand
                              (pineapple broccoli kiwi tomato apple)))

  )

(module friends racket
  (require ts-kata-util k2/lang/sea/enemies)
  ; ==== SEA/ENEMIES
  ;Day 2

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/enemies
                       sea-007
                       (start ghost-fish
                              (strawberry)
                              (shark)))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/enemies
                       sea-008
                       (start jellyfish
                              ((potato 5))
                              (red-fish)))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/enemies
                       sea-009
                       (start rand
                              (cherries)
                              ((crab 5))))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/enemies
                       sea-010
                       (start shark
                              ((apple 3) (strawberry 2))
                              (crab jellyfish)))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/enemies
                       sea-011
                       (start strawberry
                              (orange-fish octopus)
                              ((banana 8))))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/enemies
                       sea-012
                       (start shark
                              ((shark 5))
                              ((shark 5))))

  ;Day 3

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/enemies
                       sea-013
                       (start octopus
                              (tomato kiwi)
                              ((orange-fish 3))))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/enemies
                       sea-014
                       (start rand
                              ((apple 10))
                              ((rand 10))))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/enemies
                       sea-015
                       (start jellyfish
                              (kiwi)
                              ((jellyfish red))))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/enemies
                       sea-016
                       (start rand
                              ((tomato purple 5))
                              ((shark green 5))))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/enemies
                       sea-017
                       (start rand
                              ((rand orange 3) (rand yellow 3))
                              ((rand blue 2) (rand purple 2))))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/enemies
                       sea-018
                       (start rand
                              (strawberry (potato yellow))
                              (orange-fish))
                       (start rand
                              (strawberry (potato yellow))
                              ((orange-fish 5))))


  )

(module enemies racket
  (require ts-kata-util k2/lang/sea/friends)
  ;==== SEA/FRIENDS ====
  ;Day 4

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/friends
                       sea-019
                       (start starfish
                              (octopus)))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/friends
                       sea-020
                       (start jellyfish
                              (green-fish orange-fish red-fish)))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/friends
                       sea-021
                       (start shark
                              ((yellow-fish 2) (ghost-fish 2))))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/friends
                       sea-022
                       (start crab
                              ((crab red) (crab green) (crab purple))))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/friends
                       sea-023
                       (start rand
                              ((rand 5))
                              (pineapple broccoli)))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/friends
                       sea-024
                       (start rand
                              ((yellow-fish 4))
                              ((apple 4)))
                       (start rand
                              ((yellow-fish 4) (rand 4))
                              ((apple blue 4))))

  ;Day 5

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/friends
                       sea-025
                       (start rand
                              (yellow-fish (shark blue) rand rand)))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/friends
                       sea-026
                       (start ghost-fish
                              ((rand purple 5))
                              ((mushroom orange 5))
                              (shark)))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/friends
                       sea-027
                       (start rand
                              (starfish orange-fish))
                       (start rand
                              (crab green-fish red-fish jellyfish)))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/friends
                       sea-028
                       (start rand
                              ((octopus green 4))
                              ((kiwi 4))
                              ((crab 4)))
                       (start rand
                              ((rand green 4))
                              ((rand 4))
                              ((rand 4))))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/friends
                       sea-029
                       (start rand
                              ((rand red) (rand orange) (rand yellow))
                              ((rand rand rand))
                              ((rand green) (rand blue) (rand purple))))

  (define-example-code #:with-test (test game-test)
                       k2/lang/sea/friends
                       sea-030
                       (start rand
                              ((starfish orange) (crab orange))
                              ((broccoli orange) (kiwi orange))
                              ((shark orange) (jellyfish orange)))
                       (start rand
                              ((orange-fish 3) (green-fish 3))
                              ((pineapple 3) (mushroom 3))
                              ((red-fish 3) (yellow-fish 3))))


  )

(provide (all-from-out 'foods 'friends 'enemies))
(require 'foods 'friends 'enemies)
