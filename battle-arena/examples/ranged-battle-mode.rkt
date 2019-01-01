#lang battle-arena

(define-kata-code battle-arena ranged-battle-mode
  (battle-arena-game
   #:avatar         (custom-avatar #:sprite (random-character-sprite)
                                   #:item-slots 3)
   #:enemy-list     (list (custom-enemy #:ai 'easy
                                        #:amount-in-world 10)
                          (custom-enemy #:ai 'medium
                                        #:amount-in-world 10))
   #:weapon-list    (list (custom-weapon #:name "Single Shot"
                                         #:sprite (make-icon "SS")
                                         #:rapid-fire? #f         ;click as fast as you can to shoot
                                         #:dart (custom-dart
                                                 #:sprite (rectangle 10 2 'solid 'cyan)
                                                 #:damage 10
                                                 #:speed 10
                                                 #:range 50)
                                          #:rarity 'common)
                          (custom-weapon #:name "Spread Shot"
                                         #:sprite (make-icon "SPR")
                                         #:fire-mode 'spread      ;options 'normal, 'random, 'homing, 'spread
                                         #:fire-rate 2
                                         #:dart (custom-dart
                                                 #:sprite (rectangle 10 2 'solid 'orange)
                                                 #:damage 20
                                                 #:durability 20   ;will die after hitting second enemy
                                                 #:speed 15
                                                 #:range 15)
                                         #:rarity 'rare)
                          (custom-weapon #:name "Homing Repeater"
                                         #:sprite (make-icon "HR")
                                         #:fire-mode 'homing
                                         #:fire-rate 5
                                         #:dart (custom-dart
                                                 #:sprite (rectangle 10 2 'solid 'pink)
                                                 #:damage 15
                                                 #:speed 8
                                                 #:range 40)
                                          #:rarity 'epic)
                          )))