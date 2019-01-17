#lang battle-arena-starwars
(starwars-game
#:avatar         (custom-jedi #:sprite (random-character-sprite)
                                #:item-slots 3)
#:enemy-list     (list (custom-enemy #:ai 'easy
                                     #:amount-in-world 10)
                       (custom-enemy #:ai 'hard
                                     #:amount-in-world 10))
#:weapon-list    (list (custom-weapon #:name "Rocket Tower"
                                      #:sprite (make-icon "RKT")
                                      #:dart (rocket-tower-builder
                                              #:fire-mode 'homing
                                              #:fire-rate 1
                                              #:damage 100
                                              #:speed 3
                                              #:range 200))
                       (custom-weapon #:name "Repeater Tower"
                                      #:sprite (make-icon "RPT")
                                      #:dart (repeater-tower-builder
                                              #:fire-mode 'random
                                              #:fire-rate 8
                                              #:damage 5
                                              #:speed 15
                                              #:range 500))
                       (custom-weapon #:name "Dagger Tower"
                                      #:sprite (make-icon "DGT")
                                      #:dart (dagger-tower-builder
                                              #:fire-mode 'spread
                                              #:fire-rate 0.5
                                              #:damage 200
                                              #:speed 8
                                              #:range 500))))

