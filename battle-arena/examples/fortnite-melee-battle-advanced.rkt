#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena fortnite-melee-battle-advanced
  (define (my-spear)
    (custom-dart #:position (posn 20 0)
                 #:sprite spear-sprite
                 #:damage 50
                 #:durability 50
                 #:speed 5
                 #:range 20
                 #:components (on-start (set-rotation-style 'normal))
                 (after-time 10 (bounce))))

  (define (my-sword)
    (custom-dart #:position (posn 10 0)
                 #:sprite swinging-sword-sprite
                 #:damage 50
                 #:durability 20
                 #:speed  0
                 #:range  10
                 #:components (every-tick (change-direction-by 15))))

  (define (my-paint)
    (custom-dart #:position (posn 25 0)
                 #:sprite paint-sprite
                 #:damage 5
                 #:durability 5
                 #:speed  3
                 #:range  15
                 #:components (on-start (set-size 0.5))
                 (every-tick (scale-sprite 1.1))
                 ))

  (define (my-flying-dagger)
    (custom-dart #:position (posn 20 0)
                 #:sprite   flying-sword-sprite
                 #:damage 10
                 #:speed  2
                 #:range  40
                 #:durability 20
                 #:components (on-start (do-many (set-size 0.5)))
                 (do-every 10 (random-direction 0 360))))

  (define (my-ring-of-fire)
    (custom-dart #:position   (posn 25 0)
                 #:sprite     flame-sprite
                 #:damage     5
                 #:durability 20
                 #:speed      10
                 #:range      36
                 #:components (on-start (set-size 0.5))
                 (every-tick (do-many (scale-sprite 1.05)
                                      (change-direction-by 10)))))

  (battle-arena-game
   #:bg              (custom-background)
   #:avatar          (custom-avatar #:sprite      (row->sprite (random-character-row))
                                    #:key-mode    'wasd       ;OPTIONAL
                                    #:mouse-aim?  #t          ;OPTIONAL
                                    )
   #:weapon-list     (list (custom-weapon #:name              "Spear"
                                          #:sprite            SPEAR-ICON
                                          #:mouse-fire-button 'left        ;OPTIONAL
                                          #:dart              (my-spear)
                                          #:rapid-fire?       #f           ;OPTIONAL
                                          #:rarity            'rare        ;OPTIONAL
                                          )
                           (custom-weapon #:name              "Sword"
                                          #:sprite            SWORD-ICON
                                          #:mouse-fire-button 'left        ;OPTIONAL
                                          #:dart              (my-sword)
                                          #:rapid-fire?       #f           ;OPTIONAL
                                          #:rarity            'rare        ;OPTIONAL
                                          )
                           (custom-weapon #:name              "Paint Thrower"
                                          #:sprite             PAINT-THROWER-ICON
                                          #:dart              (my-paint)
                                          #:mouse-fire-button 'left        ;OPTIONAL
                                          #:fire-mode         'random
                                          #:fire-rate          30
                                          #:rarity            'epic        ;OPTIONAL
                                          )
                           (custom-weapon #:name              "Flying Dagger Spell"
                                          #:sprite             FLYING-DAGGER-ICON
                                          #:dart              (my-flying-dagger)
                                          #:mouse-fire-button 'left        ;OPTIONAL
                                          #:fire-mode         'spread
                                          #:fire-rate          1
                                          #:rarity            'legendary   ;OPTIONAL
                                          )
                           (custom-weapon #:name              "Ring of Fire Spell"
                                          #:sprite             RING-OF-FIRE-ICON
                                          #:dart              (my-ring-of-fire)
                                          #:mouse-fire-button 'left        ;OPTIONAL
                                          #:fire-rate          30
                                          #:rarity            'legendary   ;OPTIONAL
                                          )))
  )
