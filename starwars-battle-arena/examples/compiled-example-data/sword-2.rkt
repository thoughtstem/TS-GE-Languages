#lang starwars-battle-arena
(define (my-weapon-2)
 (custom-weapon #:name    "Sword"
                #:sprite  SWORD-ICON
                #:dart    (sword)
                #:rarity  'rare))

(starwars-game
#:weapon-list (list (my-weapon-2)))
