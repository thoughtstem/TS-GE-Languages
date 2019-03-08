 #lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require ts-kata-util
         "../assets.rkt"
         survival)

(language-mappings survival          survival-pokemon
                   [custom-bg        custom-town]
                   [custom-avatar    custom-pokemon]
                   [custom-npc       custom-friend]
                   [custom-enemy     custom-trainer]
                   [custom-coin      custom-stone]
                   [custom-weapon    custom-power]
                   [survival-game    pokemon-game]
                   [#:bg             #:town-bg]
                   [#:avatar         #:pokemon]
                   [#:npc-list       #:friend-list]
                   [#:enemy-list     #:trainer-list]
                   [#:coin-list      #:stone-list]
                   [#:weapon-list    #:power-list]
                   )

(provide pokeball
         )


(define bg-list
  (list FOREST-BG SNOW-BG DESERT-BG LAVA-BG))

; ---------   Custom Town
(define/contract/doc (custom-town #:image      [img (first (shuffle bg-list))]
                                  #:rows       [rows 3]
                                  #:columns    [cols 3]
                                  #:start-tile [t 0]
                                  #:components [c #f]
                                  . custom-components)

  (->i ()
       (#:image      [img image?]
        #:rows       [rows number?]
        #:columns    [columns number?]
        #:start-tile [start-tile number?]
        #:components [first-component component-or-system?])
       #:rest [more-components (listof component-or-system?)]
       [result entity?])

  @{Returns a custom town, which will be used
         automatically if it is passed into @racket[pokemon-game]
         via the @racket[#:town-bg] parameter.}
  
  (custom-bg #:image      img
             #:rows       rows
             #:columns    cols
             #:start-tile t 
             #:components (cons c custom-components)))

; ---------   Custom Pokemon
(define/contract/doc (custom-pokemon #:sprite           [sprite pikachu-sprite]
                                     #:damage-processor [dp (filter-damage-by-tag #:filter-out  '(friendly-team passive)
                                                                                  #:show-damage? #t
                                                                                  )]
                                     #:position         [p   (posn 100 100)]
                                     #:speed            [spd 10]
                                     #:key-mode         [key-mode 'arrow-keys]
                                     #:mouse-aim?       [mouse-aim? #f]
                                     #:components       [c #f]
                                     . custom-components)
  
  (->i ()
       (#:sprite [sprite sprite?]
        #:damage-processor [damage-processor damage-processor?]
        #:position [position posn?]
        #:speed [speed number?]
        #:key-mode [key-mode (or/c 'wasd 'arrow-keys)]
        #:mouse-aim? [mouse-aim boolean?]
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
   #:components       (cons c custom-components)))

; ---------   Custom Friend
(define/contract/doc (custom-friend #:sprite     [s bulbasaur-sprite]
                                    #:position   [p (posn 0 0)]
                                    #:name       [name "Bulbasaur"]
                                    #:tile       [tile 0]
                                    #:dialog     [d  #f]
                                    #:mode       [mode 'wander]
                                    #:game-width [GAME-WIDTH 480]
                                    #:speed      [spd 2]
                                    #:target     [target "player"]
                                    #:sound      [sound #t]
                                    #:scale      [scale 1]
                                    #:components [c (on-start (respawn 'anywhere))] . custom-components )

  (->i () (#:sprite     [sprite sprite?]
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

  (define dialog
    (if (not d)
        (dialog->sprites (first (shuffle (list (list "It's dangerous out here!")
                                               (list "You should find food to survive.")
                                               (list "Watch out for those trainers!")
                                               (list "Go collect some Evolution Stones."))))
                     #:game-width GAME-WIDTH
                     #:animated #t
                     #:speed 4)
        (if (string? (first d))
            (dialog->sprites d
                             #:game-width GAME-WIDTH
                             #:animated #t
                             #:speed    4)
            (dialog->response-sprites d
                                      #:game-width GAME-WIDTH
                                      #:animated #t
                                      #:speed 4))))
  
  (create-npc #:sprite      s
              #:name        name
              #:position    p
              #:active-tile tile
              #:dialog      dialog
              #:mode        mode
              #:speed       spd
              #:target      target
              #:sound       sound
              #:scale       scale
              #:components  (cons c custom-components)))

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
           #:sprite          [sprite sprite?]
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
(define/contract/doc (custom-stone #:type             [type (thunderstone)]
                                   #:sprite           [s #f]
                                   #:position         [p #f]
                                   #:name             [n #f]
                                   #:tile             [t #f]
                                   #:amount-in-world  [world-amt 10]
                                   #:value            [val 1]
                                   #:respawn?         [respawn? #t]
                                   #:components       [c #f]
                                   . custom-entities)

   (->i () (#:type       [type entity?]
            #:sprite     [sprite sprite?]
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

;--------- Custom Power
(define/contract/doc (custom-power #:name              [n "Thunderbolt"]
                                   #:sprite            [s chest-sprite]
                                   #:dart-sprite       [ds (rectangle 10 2 "solid" "yellow")]
                                   #:speed             [spd 10]
                                   #:damage            [dmg 10]
                                   #:range             [rng 1000]
                                   #:dart              [b (custom-dart #:sprite ds
                                                                       #:speed spd
                                                                       #:damage dmg
                                                                       #:range rng)]
                                   #:fire-mode         [fm 'normal]
                                   #:fire-rate         [fr 3]
                                   #:fire-key          [key 'f]
                                   #:mouse-fire-button [button 'left]
                                   #:point-to-mouse?   [ptm? #t]
                                   #:rapid-fire?       [rf? #t]
                                   #:rarity            [rarity 'common])
  (->i ()
       (#:name              [name string?]
        #:sprite            [sprite sprite?]
        #:dart-sprite       [dart-sprite sprite?]
        #:speed             [speed  number?]
        #:damage            [damage number?]
        #:range             [range  number?]
        #:dart              [dart entity?]
        #:fire-mode         [fire-mode fire-mode?]
        #:fire-rate         [fire-rate number?]
        #:fire-key          [fire-key symbol?]
        #:mouse-fire-button [button (or/c 'left 'right false?)]
        #:point-to-mouse?   [ptm? boolean?]
        #:rapid-fire?       [rf? boolean?]
        #:rarity            [rarity rarity-level?])
       [result entity?])

  @{Returns a custom power, which will be placed in to the world
         automatically if it is passed into @racket[pokemon-game]
         via the @racket[#:power-list] parameter.}

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
                 #:mouse-fire-button button
                 #:point-to-mouse?   ptm?
                 #:rapid-fire?       rf?
                 #:rarity            rarity))

; ---------   Minecraft Main Game

(define (random-forest)
  (change-img-hue (random 360) (draw-plain-forest-bg)))


(define/contract/doc
  (pokemon-game #:headless        [headless #f]
                #:town-bg         [town-ent (plain-forest-bg #:image (random-forest))]
                #:pokemon         [pokemon (custom-pokemon #:sprite (circle 10 'solid 'red))]
                #:starvation-rate [sr 50]
                #:sky             [sky (custom-sky)]
                #:friend-list     [friend-list  '()]
                #:trainer-list    [trainer-list '()] 
                #:stone-list      [stone-list  '() ]
                #:food-list       [f-list    '() ]
                #:crafter-list    [c-list    '() ]
                #:score-prefix    [prefix    "Stones"]
                #:power-list      [power-list '()]
                #:other-entities  [ent #f]
                . custom-entities)
  (->i ()
       (#:headless        [headless boolean?]
        #:town-bg         [town-ent entity?]
        #:pokemon         [pokemon (or/c entity? #f)]
        #:starvation-rate [starvation-rate number?]
        #:sky             [sky sky?]
        #:friend-list     [friend-list    (listof (or/c entity? procedure?))]
        #:trainer-list    [trainer-list       (listof (or/c entity? procedure?))]
        #:stone-list      [stone-list       (listof (or/c entity? procedure?))]
        #:food-list       [food-list      (listof (or/c entity? procedure?))]
        #:crafter-list    [crafter-list   (listof (or/c entity? procedure?))]
        #:score-prefix    [prefix string?]
        #:power-list      [power-list (listof (or/c entity? procedure?))]
        #:other-entities  [other-entities (or/c #f entity?)])
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
   #:weapon-list     power-list
   #:other-entities  (cons ent custom-entities)))