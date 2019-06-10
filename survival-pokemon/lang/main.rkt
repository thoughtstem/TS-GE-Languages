 #lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual))

(require ts-kata-util
         "../assets.rkt"
         survival)

(language-mappings survival          survival-pokemon
                   [basic-bg        basic-town]
                   [basic-avatar    basic-pokemon]
                   [basic-npc       basic-friend]
                   [basic-enemy     basic-trainer]
                   [basic-coin      basic-stone]
                   [basic-weapon    basic-attack]
                   [survival-game    pokemon-game]
                   [#:bg             #:town]
                   [#:avatar         #:pokemon]
                   [#:npc-list       #:friend-list]
                   [#:enemy-list     #:trainer-list]
                   [#:coin-list      #:stone-list]
                   [#:weapon-list    #:attack-list])

(provide pokeball
         fire-blast
         aqua-jet
         fire-spin
         waterfall
         bubble
         
         fire-blast-icon
         aqua-jet-icon
         fire-spin-icon
         waterfall-icon
         bubble-icon

         (rename-out
           (custom-town basic-town)
           (custom-pokemon basic-pokemon)
           (custom-friend basic-friend)
           (custom-trainer basic-trainer)
           (custom-stone basic-stone)
           (custom-attack basic-attack)))


(define bg-list
  (list FOREST-BG SNOW-BG DESERT-BG LAVA-BG))

; ---------   Custom Town
(define/contract/doc (custom-town #:image      [img (first (shuffle bg-list))]
                                  #:rows       [rows 3]
                                  #:columns    [cols 3]
                                  #:start-tile [t 0]
                                  #:hd?        [hd? #f]
                                  #:components [c #f]
                                  . custom-components)

  (->i ()
       (#:image      [img image?]
        #:rows       [rows number?]
        #:columns    [columns number?]
        #:start-tile [start-tile number?]
        #:hd?        [high-def? boolean?]
        #:components [first-component component-or-system?])
       #:rest [more-components (listof component-or-system?)]
       [result entity?])

  @{Returns a custom town, which will be used
         automatically if it is passed into @racket[pokemon-game]
         via the @racket[#:town] parameter.}
  
  (custom-bg #:image      img
             #:rows       rows
             #:columns    cols
             #:start-tile t
             #:hd?        hd?
             #:components (cons c custom-components)))

; ---------   Custom Pokemon
(define/contract/doc (custom-pokemon #:sprite           [sprite (first (shuffle (list bulbasaur-sprite
                                                                                      squirtle-sprite
                                                                                      charmander-sprite)))]
                                     #:damage-processor [dp (filter-damage-by-tag #:filter-out  '(friendly-team passive)
                                                                                  #:show-damage? #t
                                                                                  #:hit-sound HIT-SOUND
                                                                                  )]
                                     #:position         [p   (posn 100 100)]
                                     #:speed            [spd 10]
                                     #:key-mode         [key-mode 'arrow-keys]
                                     #:mouse-aim?       [mouse-aim? #f]
                                     #:health           [health 100]
                                     #:max-health       [max-health 100]
                                     #:components       [c #f]
                                     . custom-components)
  
  (->i ()
       (#:sprite [sprite (or/c sprite? (listof sprite?) string? (listof string?))]
        #:damage-processor [damage-processor damage-processor?]
        #:position [position posn?]
        #:speed [speed number?]
        #:key-mode [key-mode (or/c 'wasd 'arrow-keys)]
        #:mouse-aim? [mouse-aim boolean?]
        #:health     [health number?]
        #:max-health [max-health number?]
        #:components [first-component component-or-system?]
        )
       #:rest (rest (listof component-or-system?))
       [returns entity?])

@{Returns a custom pokemon, which will be placed in to the world
         automatically if it is passed into @racket[pokemon-game]
         via the @racket[#:pokemon] parameter.}
  
  (custom-avatar
   #:sprite           sprite 
   #:damage-processor dp
   #:position         p
   #:speed            spd
   #:key-mode         key-mode
   #:mouse-aim?       mouse-aim?
   #:health           health
   #:max-health       max-health
   #:components       (cons c custom-components)))

; ---------   Custom Friend
(define/contract/doc (custom-friend #:sprite     [s bulbasaur-sprite]
                                    #:position   [p (posn 0 0)]
                                    #:name       [name "Bulbasaur"]
                                    #:tile       [tile 0]
                                    #:dialog     [d  (first (shuffle (list (list "It's dangerous out here!")
                                                                           (list "You should find food to survive.")
                                                                           (list "Watch out for those trainers!")
                                                                           (list "Go collect some Evolution Stones."))))]
                                    #:mode       [mode 'wander]
                                    #:game-width [GAME-WIDTH 480]
                                    #:speed      [spd 2]
                                    #:target     [target "player"]
                                    #:sound      [sound #t]
                                    #:scale      [scale 1]
                                    #:components [c #f]
                                    . custom-components )

  (->i () (#:sprite     [sprite (or/c sprite? (listof sprite?) string? (listof string?))]
           #:position   [position posn?]
           #:name       [name string?]
           #:tile       [tile number?]
           #:dialog     [dialog dialog-str?]
           #:mode       [mode (or/c 'still 'wander 'pace 'follow)]
           #:game-width [game-width number?]
           #:speed      [speed number?]
           #:target     [target string?]
           #:sound      [sound any/c]
           #:scale      [scale number?]
           #:components [first-component component-or-system?])
       #:rest [more-components (listof component-or-system?)]
       [returns entity?])

  @{Returns a custom friend, which will be placed in to the world
         automatically if it is passed into @racket[pokemon-game]
         via the @racket[#:friend-list] parameter.}
  
  (custom-npc #:sprite     s
              #:position   p
              #:name       name
              #:tile       tile
              #:dialog     d
              #:game-width GAME-WIDTH
              #:mode       mode
              #:speed      spd
              #:target     target
              #:sound      sound
              #:scale      scale
              #:components (cons c custom-components)))

; ---------   Custom Trainer
(define (pokeball-style n)
  (define new-list (map (curry rotate 90) (sheet->costume-list pokeball2-sheet 8 17 (* 8 17))))
  (~> new-list
      (drop _ (* (- n 1) 8))
      (take _ 8)
      (new-sprite _ 2 #:animate #t))
   )

(define (pokeball  #:sprite            [s   (pokeball-style (random 1 18))]
                   #:damage            [dmg 10]
                   #:durability        [dur 5]
                   #:speed             [spd 3]
                   #:range             [rng 100]
                   #:name              [n "Pokeball"]
                   #:fire-mode         [fm 'normal]
                   #:fire-rate         [fr 3]
                   #:fire-key          [key 'f]
                   #:mouse-fire-button [button #f]
                   #:point-to-mouse?   [ptm? #f]
                   #:rapid-fire?       [rf? #t]
                   #:rarity            [rarity 'common])

  (define pokeball-dart
    (custom-dart #:position    (posn 25 0)
                 #:sprite      s
                 #:damage      dmg
                 #:durability  dur
                 #:speed       spd
                 #:range       rng))
  
  (custom-weapon #:sprite            (make-icon "PB")
                 #:dart              pokeball-dart
                 #:fire-mode         fm
                 #:fire-rate         fr
                 #:fire-key          key
                 #:mouse-fire-button button
                 #:point-to-mouse?   ptm?
                 #:rapid-fire?       rf?
                 #:rarity            rarity))


(define/contract/doc (custom-trainer #:amount-in-world (amount-in-world 1)
                                     #:sprite          (s (first (shuffle (list jessie-sprite
                                                                                james-sprite))))
                                     #:ai              (ai-level 'medium)
                                     #:health          (health 100)
                                     #:weapon          (w  (pokeball))
                                     #:death-particles (particles (custom-particles))
                                     #:night-only?     (night-only? #f)
                                     #:components      (c #f)
                                     . custom-components)

  (->i () (#:amount-in-world [amount-in-world positive?]
           #:sprite          [sprite (or/c sprite? (listof sprite?) string? (listof string?))]
           #:ai              [ai ai-level?]
           #:health          [health positive?] 
           #:weapon          [w entity?]
           #:death-particles [death-particles entity?]
           #:night-only?     [night-only? boolean?]
           #:components      [first-component any/c])
       #:rest [more-components (listof any/c)]
       [returns entity?])

  @{Returns a custom trainer, which will be placed in to the world
         automatically if it is passed into @racket[pokemon-game]
         via the @racket[#:trainer-list] parameter.}
  
  (custom-enemy #:amount-in-world amount-in-world
                #:sprite          s 
                #:ai              ai-level
                #:health          health
                #:weapon          w
                #:death-particles particles
                #:night-only?     night-only?
                #:components      (cons c custom-components)))

; ---------   Custom Stone
(define/contract/doc (custom-stone #:type             [type (copper-coin)]
                                   #:sprite           [s thunderstone-sprite]
                                   #:position         [p #f]
                                   #:name             [n "Thunder Stone"]
                                   #:tile             [t #f]
                                   #:amount-in-world  [world-amt 10]
                                   #:value            [val 1]
                                   #:respawn?         [respawn? #t]
                                   #:components       [c #f]
                                   . custom-entities)

   (->i () (#:type       [type entity?]
            #:sprite     [sprite (or/c sprite? (listof sprite?) string? (listof string?))]
            #:position   [position posn?]
            #:name       [name string?]
            #:tile       [tile number?]
            #:amount-in-world [amount-in-world number?]
            #:value      [value number?]
            #:respawn?   [respawn boolean?]
            #:components [first-component component-or-system?])
        #:rest [more-components (listof component-or-system?)]
        [returns entity?])

  @{Returns a custom stone, which will be placed into the world
          automatically if it is passed into @racket[pokemon-game]
          via the @racket[#:stone-list] parameter.}
  
  (custom-coin #:entity            type
               #:sprite          s 
               #:position        p
               #:name            n
               #:tile            t 
               #:amount-in-world world-amt
               #:value           val
               #:respawn?        respawn?
               #:components      (cons c custom-entities)))

;--------- Custom Attack
(define/contract/doc (custom-attack #:name              [n "Thunderbolt"]
                                    #:sprite            [s chest-sprite]
                                    #:dart-sprite       [ds (rectangle 10 2 "solid" "yellow")]
                                    #:speed             [spd 10]
                                    #:damage            [dmg 10]
                                    #:range             [rng 1000]
                                    #:dart              [b (custom-dart #:sprite ds
                                                                        #:speed spd
                                                                        #:damage dmg
                                                                        #:range rng)]
                                    #:fire-mode         [fm 'spread]
                                    #:fire-rate         [fr 3]
                                    #:fire-key          [key 'f]
                                    #:fire-sound        [fire-sound #f]
                                    #:mouse-fire-button [button 'left]
                                    #:point-to-mouse?   [ptm? #t]
                                    #:rapid-fire?       [rf? #t]
                                    #:rarity            [rarity 'common])
  (->i ()
       (#:name              [name string?]
        #:sprite            [sprite (or/c sprite? (listof sprite?) string? (listof string?))]
        #:dart-sprite       [dart-sprite (or/c sprite? (listof sprite?))]
        #:speed             [speed  number?]
        #:damage            [damage number?]
        #:range             [range  number?]
        #:dart              [dart entity?]
        #:fire-mode         [fire-mode fire-mode?]
        #:fire-rate         [fire-rate number?]
        #:fire-key          [fire-key symbol?]
        #:fire-sound        [fire-sound (or/c rsound? #f '())]
        #:mouse-fire-button [button (or/c 'left 'right false?)]
        #:point-to-mouse?   [ptm? boolean?]
        #:rapid-fire?       [rf? boolean?]
        #:rarity            [rarity rarity-level?])
       [result entity?])

  @{Returns a custom attack, which will be placed in to the world
         automatically if it is passed into @racket[pokemon-game]
         via the @racket[#:attack-list] parameter.}

  (custom-weapon #:name              n
                 #:sprite            s
                 #:dart-sprite       ds
                 #:speed             spd
                 #:damage            dmg 
                 #:range             rng
                 #:dart              b
                 #:fire-mode         fm
                 #:fire-rate         fr
                 #:fire-key          key
                 #:fire-sound        fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse?   ptm?
                 #:rapid-fire?       rf?
                 #:rarity            rarity))



; ---------   Pokemon Main Game

(define (random-forest)
  (change-img-hue (random 360) (draw-plain-forest-bg)))


(define/contract/doc
  (pokemon-game #:headless        [headless #f]
                #:town            [town-ent (plain-forest-bg #:image (random-forest))]
                #:pokemon         [pokemon (custom-pokemon #:sprite (circle 10 'solid 'red))]
                #:starvation-rate [sr 50]
                #:sky             [sky (custom-sky)]
                #:friend-list     [friend-list  '()]
                #:trainer-list    [trainer-list '()] 
                #:stone-list      [stone-list  '() ]
                #:food-list       [f-list    '() ]
                #:crafter-list    [c-list    '() ]
                #:score-prefix    [prefix    "Stones"]
                #:attack-list     [attack-list '()]
                #:enable-world-objects? [world-objects? #f]
                #:instructions    [instructions #f]
                #:other-entities  [ent #f]
                . custom-entities)
  (->i ()
       (#:headless        [headless boolean?]
        #:town            [town-ent entity?]
        #:pokemon         [pokemon (or/c entity? #f)]
        #:starvation-rate [starvation-rate (or/c number? #f)]
        #:sky             [sky sky?]
        #:friend-list     [friend-list    (listof (or/c entity? procedure?))]
        #:trainer-list    [trainer-list   (listof (or/c entity? procedure?))]
        #:stone-list      [stone-list     (listof (or/c entity? procedure?))]
        #:food-list       [food-list      (listof (or/c entity? procedure?))]
        #:crafter-list    [crafter-list   (listof (or/c entity? procedure?))]
        #:score-prefix    [prefix         string?]
        #:attack-list     [attack-list    (listof (or/c entity? procedure?))]
        #:enable-world-objects? [world-objects? boolean?]
        #:instructions   [instructions (or/c #f entity?)]
        #:other-entities  [other-entities (or/c #f entity? (listof #f) (listof entity?))])
       #:rest  [rest (listof entity?)]
       [res () game?])

  @{The top-level function for the minecraft-game language.
         Can be run with no parameters to get a basic, default game
         with nothing in it!}
  
  (survival-game
   #:headless        headless
   #:bg              town-ent
   #:avatar          pokemon
   #:starvation-rate sr
   #:sky             sky
   #:npc-list        friend-list
   #:enemy-list      trainer-list
   #:coin-list       stone-list
   #:food-list       f-list
   #:crafter-list    c-list
   #:score-prefix    prefix
   #:weapon-list     attack-list
   #:enable-world-objects? world-objects?
   #:instructions   instructions
   #:other-entities  (filter identity (flatten (cons ent custom-entities)))))

; ===== PREBUILT ATTACKS =====

(define fire-blast-icon (list (new-sprite flame-sprite
                                          #:scale 0.75
                                          #:x-offset 5
                                          #:y-offset -5)
                              (new-sprite flame-sprite
                                          #:scale 0.75)
                              (new-sprite flame-sprite
                                          #:scale 0.75
                                          #:x-offset -5
                                          #:y-offset 5)
                              (make-icon "" )))

(define (fire-blast #:name              [n "Fire Blast"]
                    #:icon              [i fire-blast-icon]
                    #:sprite            [s flame-sprite]
                    #:damage            [dmg 5]
                    #:durability        [dur 5]
                    #:speed             [spd 3]
                    #:range             [rng 20]
                    #:dart              [d (fire-dart #:sprite s
                                                      #:damage dmg
                                                      #:durability dur
                                                      #:speed spd
                                                      #:range rng)]
                    #:fire-mode         [fm 'random]
                    #:fire-rate         [fr 10]
                    #:fire-key          [key 'f]
                    #:mouse-fire-button [button #f]
                    #:point-to-mouse?   [ptm? #f]
                    #:rapid-fire?       [rf? #t]
                    #:rarity            [rarity 'common])
  (fire-magic #:name n
              #:icon i
              #:dart d
              #:fire-mode fm
              #:fire-rate fr
              #:mouse-fire-button button
              #:point-to-mouse? ptm?
              #:rapid-fire? rf?
              #:rarity rarity))

(define aqua-jet-icon (list (new-sprite ice-sprite
                                        #:scale 0.75
                                        #:x-offset 5
                                        #:y-offset -5)
                            (new-sprite ice-sprite
                                        #:scale 0.75)
                            (new-sprite ice-sprite
                                        #:scale 0.75
                                        #:x-offset -5
                                        #:y-offset 5)
                            (make-icon "" )))

(define (aqua-jet #:name              [n "Aqua Jet"]
                  #:icon              [i aqua-jet-icon]
                  #:sprite            [s ice-sprite]
                  #:damage            [dmg 5]
                  #:durability        [dur 5]
                  #:speed             [spd 3]
                  #:range             [rng 20]
                  #:dart              [d (ice-dart #:sprite s
                                                   #:damage dmg
                                                   #:durability dur
                                                   #:speed spd
                                                   #:range rng)]
                  #:fire-mode         [fm 'random]
                  #:fire-rate         [fr 10]
                  #:fire-key          [key 'f]
                  #:mouse-fire-button [button #f]
                  #:point-to-mouse?   [ptm? #f]
                  #:rapid-fire?       [rf? #t]
                  #:rarity            [rarity 'common])
  (ice-magic #:name n
             #:icon i
             #:dart d
             #:fire-mode fm
             #:fire-rate fr
             #:mouse-fire-button button
             #:point-to-mouse? ptm?
             #:rapid-fire? rf?
             #:rarity rarity))

(define fire-spin-icon (list (new-sprite flame-sprite
                                         #:scale 0.75
                                         #:x-offset -5
                                         #:y-offset 0)
                             (new-sprite flame-sprite
                                         #:scale 0.75
                                         #:x-offset 5
                                         #:y-offset 0)
                             (new-sprite flame-sprite
                                         #:scale 0.75
                                         #:x-offset 0
                                         #:y-offset -5)
                             (new-sprite flame-sprite
                                         #:scale 0.75
                                         #:x-offset 0
                                         #:y-offset 5)
                             (make-icon "" )))

(define (fire-spin #:name              [n "Fire Spin"]
                   #:icon              [i fire-spin-icon]
                   #:sprite            [s flame-sprite]
                   #:damage            [dmg 5]
                   #:durability        [dur 20]
                   #:speed             [spd 10]
                   #:duration          [rng 36]
                   #:dart              [d (ring-of-fire-dart #:sprite s
                                                             #:damage dmg
                                                             #:durability dur
                                                             #:speed spd
                                                             #:duration rng)]
                   #:fire-mode         [fm 'normal]
                   #:fire-rate         [fr 10]
                   #:fire-key          [key 'f]
                   #:mouse-fire-button [button #f]
                   #:point-to-mouse?   [ptm? #f]
                   #:rapid-fire?       [rf? #t]
                   #:rarity            [rarity 'common])
  (ring-of-fire #:name n
                #:icon i
                #:dart d
                #:fire-mode fm
                #:fire-rate fr
                #:mouse-fire-button button
                #:point-to-mouse? ptm?
                #:rapid-fire? rf?
                #:rarity rarity))

(define waterfall-icon (list (new-sprite ice-sprite
                                         #:scale 0.75
                                         #:x-offset -5
                                         #:y-offset 0)
                             (new-sprite ice-sprite
                                         #:scale 0.75
                                         #:x-offset 5
                                         #:y-offset 0)
                             (new-sprite ice-sprite
                                         #:scale 0.75
                                         #:x-offset 0
                                         #:y-offset -5)
                             (new-sprite ice-sprite
                                         #:scale 0.75
                                         #:x-offset 0
                                         #:y-offset 5)
                             (make-icon "" )))

(define (waterfall #:name              [n "Waterfall"]
                   #:icon              [i waterfall-icon]
                   #:sprite            [s ice-sprite]
                   #:damage            [dmg 5]
                   #:durability        [dur 20]
                   #:speed             [spd 10]
                   #:duration          [rng 36]
                   #:dart              [d (ring-of-fire-dart #:sprite s
                                                             #:damage dmg
                                                             #:durability dur
                                                             #:speed spd
                                                             #:duration rng)]
                   #:fire-mode         [fm 'normal]
                   #:fire-rate         [fr 10]
                   #:fire-key          [key 'f]
                   #:mouse-fire-button [button #f]
                   #:point-to-mouse?   [ptm? #f]
                   #:rapid-fire?       [rf? #t]
                   #:rarity            [rarity 'common])
  (ring-of-ice #:name n
               #:icon i
               #:dart d
               #:fire-mode fm
               #:fire-rate fr
               #:mouse-fire-button button
               #:point-to-mouse? ptm?
               #:rapid-fire? rf?
               #:rarity rarity))

(define (bubble-icon)
  (list (set-sprite-color 'blue acid-sprite)
        (make-icon "" #;'lightgoldenrodyellow)))

(define (bubble  #:name              [n "Bubble"]
                 #:icon              [i (bubble-icon)]
                 #:sprite            [s   (set-sprite-color 'blue acid-sprite)]
                 #:damage            [dmg 10]
                 #:durability        [dur 5]
                 #:speed             [spd 3]
                 #:range             [rng 100]
                 #:dart              [d (acid-dart #:sprite s
                                                   #:damage dmg
                                                   #:durability dur
                                                   #:speed spd
                                                   #:range rng)]
                 #:fire-mode         [fm 'random]
                 #:fire-rate         [fr 3]
                 #:fire-key          [key 'f]
                 #:mouse-fire-button [button #f]
                 #:point-to-mouse?   [ptm? #f]
                 #:rapid-fire?       [rf? #t]
                 #:rarity            [rarity 'common])
  (acid-spitter #:name n
                #:icon i
                #:dart   d
                #:fire-mode fm
                #:fire-rate fr
                #:fire-key key
                #:mouse-fire-button button
                #:point-to-mouse?   ptm?
                #:rapid-fire?       rf?
                #:rarity            rarity))
