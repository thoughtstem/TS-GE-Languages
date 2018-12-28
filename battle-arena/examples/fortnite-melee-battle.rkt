#lang battle-arena

(define-kata-code battle-arena fortnite-melee-battle
  ; ======= FORTNITE MELEE =======
  (define (my-sword-bullet)
    (custom-dart #:position (posn 10 0)
                 #:sprite sword-bullet-sprite
                 #:damage 50
                 #:durability 20
                 #:speed  0
                 #:range  10
                 #:components (every-tick (change-direction-by 15))))

  (define (my-paint-bullet)
    (custom-dart #:position (posn 25 0)
                 #:sprite paint-sprite
                 #:damage 5
                 #:durability 5
                 #:speed  3
                 #:range  15
                 #:components (on-start (set-size 0.5))
                 (every-tick (scale-sprite 1.1))))

  (battle-arena-game
   #:bg              (custom-background)
   #:avatar          (custom-avatar #:sprite      (row->sprite (random-character-row))
                                    #:key-mode    'wasd
                                    #:mouse-aim?  #t)
   #:weapon-list     (list (custom-weapon #:sprite SWORD-ICON
                                          #:dart (sword)
                                          #:rapid-fire? #f
                                          #:rarity 'common)
                           (custom-weapon #:sprite PAINT-THROWER-ICON
                                          #:dart (paint)
                                          #:fire-rate 30
                                          #:rarity 'legendary)
                           (custom-weapon #:sprite SPEAR-ICON
                                          #:dart (spear)
                                          #:rapid-fire? #f
                                          #:rarity 'uncommon))))
