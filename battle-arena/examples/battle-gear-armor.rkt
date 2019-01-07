#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena battle-gear-armor
  (battle-arena-game
   #:avatar         (custom-avatar #:sprite (random-character-sprite))
   #:enemy-list     (list (custom-enemy #:ai 'medium
                                        #:amount-in-world 10
                                        #:weapon (custom-weapon #:name "Light Repeater"
                                                                #:dart (custom-dart #:damage 20)))
                          (custom-enemy #:ai 'hard
                                        #:amount-in-world 10
                                        #:weapon (custom-weapon #:name "Heavy Sword"
                                                                #:dart (sword #:damage 50))))
   #:item-list      (list (custom-armor #:name          "Repeater Armor"
                                        #:sprite        (make-icon "RA")
                                        #:protects-from "Light Repeater"
                                        #:change-damage (divide-by 10)
                                        #:rarity         'rare
                                        )
                          (custom-armor #:name "Sword Armor"
                                        #:sprite (make-icon "SA")
                                        #:protects-from "Heavy Sword"
                                        #:change-damage (subtract-by 45)
                                        #:rarity 'rare
                                        )
                          )))







