#lang battle-arena

; ======= FORTNITE BATTLE GEAR - PAINTBALL WEAPONS =======
#;(fortnite2d-game
 #:bg              (custom-background)
 #:avatar          (custom-avatar #:sprite      (row->sprite (random-character-row))
                                  #:key-mode    'wasd
                                  #:mouse-aim?  #t
                                  #:weapon-slots 3)
 #:enemy-list      (list (custom-enemy #:sprite (row->sprite (random-character-row))
                                       #:amount-in-world 10
                                       #:ai     'easy
                                       #:weapon (heavy-repeater)
                                       #:health 200)
                         (custom-enemy #:sprite (row->sprite (random-character-row))
                                       #:amount-in-world 20
                                       #:ai 'hard))
 #:weapon-list     (list (custom-weapon #:name "Light Sword"
                                        #:sprite sword-sprite
                                        #:bullet (sword )
                                        #:rapid-fire? #f
                                        #:rarity 'common)
                         (custom-weapon #:name "Legendary Heavy Spear"
                                        #:sprite spear-sprite
                                        #:bullet (spear-bullet #:damage 100 #:durabiity 50)
                                        #:rapid-fire? #f
                                        #:rarity 'legendary)
                         (custom-weapon #:name "Light Repeater"
                                        #:sprite repeater-sprite
                                        #:bullet (custom-bullet #:damage 5 #:durability 20)
                                        #:fire-rate 10
                                        #:rarity 'uncommon)
                         (custom-weapon #:name "Epic Rocket Launcher"
                                        #:sprite rocket-launcher-sprite
                                        #:bullet (rocket #:damage 50 #:durability 10)
                                        #:fire-rate 1.5
                                        #:fire-mode 'homing
                                        #:rarity 'epic)
                         (custom-weapon #:name      "Ring of Fire Spell"
                                        #:sprite    spell-book-sprite
                                        #:bullet    (flame #:damage 5 #:durability 20)
                                        #:fire-rate 30
                                        #:fire-mode 'random
                                        #:rarity    'rare)))
