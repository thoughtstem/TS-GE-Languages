#lang battle-arena

(define-kata-code battle-arena fortnite-melee-battle-simple
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name        "Spear"
                                      #:sprite      SPEAR-ICON
                                      #:dart        (spear)
                                      #:rapid-fire? #f)
                       (custom-weapon #:name        "Sword"
                                      #:sprite      SWORD-ICON
                                      #:dart        (sword #:damage     20
                                                           #:durability 50))
                       (custom-weapon #:name        "Paint Thrower"
                                      #:sprite      PAINT-THROWER-ICON
                                      #:dart        (paint #:damage     10
                                                           #:durability 20
                                                           #:range      20)
                                      #:fire-mode   'random
                                      #:fire-rate   30)
                       (custom-weapon #:name        "Flying Dagger Spell"
                                      #:sprite      FLYING-DAGGER-ICON
                                      #:dart        (flying-dagger)
                                      #:fire-mode   'spread
                                      #:fire-rate    1)
                       (custom-weapon #:name        "Ring of Fire Spell"
                                      #:sprite      RING-OF-FIRE-ICON
                                      #:dart        (ring-of-fire)
                                      #:fire-rate   30))))

