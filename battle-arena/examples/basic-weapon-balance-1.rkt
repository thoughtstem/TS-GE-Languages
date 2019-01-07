#lang racket
(require ts-kata-util battle-arena)



(define-kata-code battle-arena basic-weapon-balance-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name "My Weapon"
                                      #:dart (custom-dart)
                                      #:rarity 'common))))
