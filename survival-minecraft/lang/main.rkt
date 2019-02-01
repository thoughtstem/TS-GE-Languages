 #lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require ts-kata-util
         ;2htdp/image
         "../assets.rkt"
         survival)

(language-mappings survival            survival-minecraft
                   [custom-background  custom-biome]
                   [custom-avatar      custom-skin]
                   [custom-npc         custom-entity]
                   [custom-enemy       custom-mob]
                   [custom-coin        custom-ore]
                   [survival-game      minecraft-game])



(define bg-list
  (list FOREST-BG SNOW-BG DESERT-BG LAVA-BG))


;======== custom-biome to replace custom-background ========

(define/contract/doc (custom-biome #:biome-img  [img (first (shuffle bg-list))]
                                   #:rows       [rows 3]
                                   #:columns    [cols 3]
                                   #:start-tile [t 0]
                                   #:components [c #f]
                                   . custom-components)

  (->i ()
       (#:biome-img  [img image?]
        #:rows       [rows number?]
        #:columns    [columns number?]
        #:start-tile [start-tile number?]
        #:components [first-component component-or-system?])
       #:rest [more-components (listof component-or-system?)]
       [result entity?])

  @{Returns a custom background}
  
  (custom-background #:bg-img     img
                     #:rows       rows
                     #:columns    cols
                     #:start-tile t 
                     #:components (cons c custom-components)))

;======== custom-skin to replace custom-avatar ========

(define/contract/doc
  (custom-skin #:sprite           [sprite (sheet->sprite steve-animated
                                                         #:rows    1
                                                         #:columns 2
                                                         #:delay   3 )]
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

  @{Returns a custom avatar...}
  
  (custom-avatar
   #:sprite           sprite 
   #:damage-processor dp
   #:position         p
   #:speed            spd
   #:key-mode         key-mode
   #:mouse-aim?       mouse-aim?
   #:components       (cons c custom-components)))

;======== custom-entity to replace custom-npc ========
;create more custom entities?

(define/contract/doc (custom-entity #:sprite     [s (row->sprite chicken-sheet
                                                                 #:columns 4
                                                                 #:delay 4)]
                                    #:position   [p (posn 0 0)]
                                    #:name       [name (first (shuffle (list "Adrian" "Alex" "Riley"
                                                                             "Sydney" "Charlie" "Andy")))]
                                    ;edit names?
                                    #:tile       [tile 0]
                                    #:dialog     [d  #f]
                                    #:mode       [mode 'wander]
                                    #:game-width [GAME-WIDTH 480]
                                    #:speed      [spd 2]
                                    #:target     [target "player"]
                                    #:sound      [sound #t]
                                    #:scale      [scale 1]
                                    #:components [c #f] . custom-components )

  (->i () (#:sprite     [sprite sprite?]
           #:position   [position posn?]
           #:name       [name string?]
           #:tile       [tile number?]
           #:dialog     [dialog dialog?]
           #:mode       [mode (or/c 'still 'wander 'pace 'follow)]
           #:game-width [game-width number?]
           #:speed      [speed number?]
           #:target     [target string?]
           #:sound      [sound any/c]
           #:scale      [scale number?]
           #:components [first-component component-or-system?])
       #:rest [more-components (listof component-or-system?)]
       [returns entity?])

  
  @{Creates a custom npc that can be used in the npc list
         of survival-game}
  ;broken???
 @;@racket[survival-game].}

  (define dialog
    (if (not d)
        (dialog->sprites (first (shuffle (list (list "bwaawk bwawk bwawk bwaawk")
                                               (list "That's a nice diamond sword you got there.")
                                               (list "baKAWK")
                                               (list "bwawk bwawk bwawwwk"))))
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



;========= custom-mob to replace custom-enemy ==========
;need default mob asset (creeper?) (skeleton with arrows)
;(ghast w/ fireball) (wither w/) (enderdragon w/ fireball)

(define/contract/doc (custom-mob #:amount-in-world (amount-in-world 1)
                                 ;edit default sprite to animated creeper
                                 #:sprite          (s (first (shuffle (list slime-sprite bat-sprite snake-sprite))))
                                 #:ai              (ai-level 'medium)
                                 #:health          (health 100)
                                 #:weapon          (weapon (custom-weapon #:name "Spitter"
                                                                          #:dart (acid)))
                                 
                                 #:death-particles (particles (custom-particles))
                                 #:night-only?     (night-only? #t)
                                 #:components      (c #f)
                                                   . custom-components)

  (->i () (#:amount-in-world [amount-in-world positive?]
           #:sprite          [sprite sprite?]
           #:ai              [ai ai-level?]
           #:health          [health positive?] 
           #:weapon          [weapon entity?]
           #:death-particles [death-particles entity?]
           #:night-only?     [night-only? boolean?]
           #:components      [first-component any/c])
       #:rest [more-components (listof any/c)]
       [returns entity?])

  @{Creates a custom enemy that can be used in the enemy list
         of survival-game.}
  ;broken??
  @;@racket[survival-game].}
  
  (custom-enemy #:amount-in-world amount-in-world
                #:sprite          s 
                #:ai              ai-level
                #:health          health
                #:weapon          weapon
                #:death-particles particles
                #:night-only?     night-only?
                #:components      (cons c custom-components)))

;custom-ore-entity for default #:entity in custom-ore

(define (ore-entity)
  (sprite->entity iron-ore
                  #:position   (posn 0 0)
                  #:name       "Iron Ore"
                  #:components (active-on-bg 0)
                  ;does it need a physical collider?
                               (physical-collider)))

;======== custom-ore to replace custom-coin ========
;need default ore asset (iron?)
;would be nice to have a bunch of assets for this -- iron, copper, gold, diamond, etc

(define/contract/doc (custom-ore #:entity           [base-entity (ore-entity)]
                                 #:sprite           [s #f]
                                 ;or replace sprite? make that the default?
                                 #:position         [p #f]
                                 #:name             [n #f]
                                 #:tile             [t #f]
                                 #:amount-in-world  [world-amt 10]
                                 #:value            [val 10]
                                 #:respawn?         [respawn? #t]
                                 #:components       [c #f]
                                                    . custom-entities)

   (->i () (#:entity     [entity entity?]
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

  @{Returns a custom coin, which will be placed into the world
          automatically if it is passed into battle-arena-game
          @;broken?
          @;@racket[battle-arena-game]
          via the #:coin-list
          @;broken?
          @;@racket[#:coin-list]
          parameter.}
  
  (custom-coin #:entity    base-entity
               #:sprite    s 
               #:position  p
               #:name      n
               #:tile      t 
               #:amount-in-world  world-amt
               #:value     val
               #:respawn?  respawn?
               #:components (cons c custom-entities)))


;random color background for default
(define (random-forest)
  (change-img-hue (random 360) (draw-plain-forest-bg)))

;minecraft-game to replace survival-game
(define/contract/doc
  (minecraft-game #:headless        [headless #f]
                  #:biome           [biome-ent (plain-forest-bg #:bg-img (random-forest))]
                  #:skin            [skin #f]
                  #:starvation-rate [sr 50]
                  #:sky             [sky (custom-sky)]
                  #:entity-list     [entity-list  '()]
                  #:mob-list        [mob-list (list (custom-enemy))] ; starting with enemy??
                  #:ore-list        [ore-list  '() ]
                  #:food-list       [f-list    '() ]
                  #:crafter-list    [c-list    '() ]
                  #:other-entities  [ent #f]
                  . custom-entities)
  (->i ()
       (#:headless        [headless boolean?]
        #:biome           [biome-ent entity?]
        #:skin            [skin (or/c entity? #f)]
        #:starvation-rate [starvation-rate number?]
        #:sky             [sky sky?]
        #:entity-list     [entity-list    (listof (or/c entity? procedure?))]
        #:mob-list        [mob-list       (listof (or/c entity? procedure?))]
        #:ore-list        [ore-list       (listof (or/c entity? procedure?))]
        #:food-list       [food-list      (listof (or/c entity? procedure?))]
        #:crafter-list    [crafter-list   (listof (or/c entity? procedure?))]
        #:other-entities  [other-entities (or/c #f entity?)])
       #:rest  [rest (listof entity?)]
       [res () game?])

  @{The top-level function for the survival-game language.
         Can be run with no parameters to get a basic, default game
         with nothing in it!}
  (survival-game
   #:headless        headless
   #:bg              biome-ent
   #:avatar          skin
   #:starvation-rate sr
   #:sky             sky
   #:npc-list        entity-list
   #:enemy-list      mob-list
   #:coin-list       ore-list
   #:food-list       f-list
   #:crafter-list    c-list
   #:other-entities  (cons ent custom-entities)))