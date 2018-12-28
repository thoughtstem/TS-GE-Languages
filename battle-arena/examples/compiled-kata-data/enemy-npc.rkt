#lang battle-arena
(define (enemy-npc level)
 (custom-enemy #:amount-in-world 28
               #:ai              level
               #:health          1
               #:shield          1


               #:weapon          (custom-weapon-system
                                  #:dart (custom-dart))))

(battle-arena-game
#:enemy-list (list (enemy-npc 'easy))


#:avatar    (custom-avatar #:sprite      (row->sprite (random-character-row))
                           #:key-mode    'wasd
                           #:mouse-aim?  #t
                           #:components
                           (storage "Weapon Slot" 1)
                           (on-key 1 (set-storage-named "Weapon Slot" 1))
                           (custom-weapon-system #:slot 1 #:mouse-fire-button 'left)))
