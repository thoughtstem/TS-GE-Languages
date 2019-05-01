 #lang at-exp racket

(provide bow
         arrow-sprite
         arrow-dart
         fireball
         fireball-sprite
         fireball-dart)

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require ts-kata-util
         "../assets.rkt"
         survival)

(language-mappings survival          survival-minecraft
                   [custom-bg        custom-biome]
                   [custom-avatar    custom-skin]
                   [custom-npc       custom-entity]
                   [custom-enemy     custom-mob]
                   [custom-coin      custom-ore]
                   [custom-weapon    custom-tool]
                   [survival-game    minecraft-game]
                   [#:avatar         #:skin]
                   [#:bg             #:biome]
                   [#:enemy-list     #:mob-list]
                   [#:npc-list       #:entity-list]
                   [#:coin-list      #:ore-list]
                   [#:weapon-list    #:tool-list]
                   )



(define bg-list
  (list FOREST-BG SNOW-BG DESERT-BG LAVA-BG))


;======== custom-biome to replace custom-bg ========

(define/contract/doc (custom-biome #:image      [img (first (shuffle bg-list))]
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

  @{Returns a custom biome, which will be used
         automatically if it is passed into @racket[minecraft-game]
         via the @racket[#:biome] parameter.}
  
  (custom-bg #:image      img
             #:rows       rows
             #:columns    cols
             #:start-tile t
             #:hd?        hd?
             #:components (cons c custom-components)))

;======== custom-skin to replace custom-avatar ========

(define/contract/doc
  (custom-skin #:sprite           [sprite steve-sprite]
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

  @{Returns a custom skin (player), which will be placed in to the world
         automatically if it is passed into @racket[survival-game]
         via the @racket[#:skin] parameter.}
  
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

;======== custom-entity to replace custom-npc ========
;create more custom entities?

(define/contract/doc (custom-entity #:sprite     [s chicken-sprite]
                                    #:position   [p (posn 0 0)]
                                    #:name       [name "Chicken"]
                                    #:tile       [tile 0]
                                    #:dialog     [d  (first (shuffle (list (list "bwaawk bwawk bwawk bwaawk")
                                                                           (list "Sorry, I don't have anything to trade."
                                                                                 "I'm a chicken.")
                                                                           (list "baKAWK")
                                                                           (list "bwawk bwawk bwawwwk"))))]
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
           #:sound      [sound boolean?]
           #:scale      [scale number?]
           #:components [first-component component-or-system?])
       #:rest [more-components (listof component-or-system?)]
       [returns entity?])

   @{Returns a custom entity, which will be placed in to the world
         automatically if it is passed into @racket[minecraft-game]
         via the @racket[#:mob-list] parameter.}

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

;========= custom-mob to replace custom-enemy ==========
;add additional mob assets (creeper?) (skeleton with arrows)
;(ghast w/ fireball) (wither w/) (enderdragon w/ fireball)

(define/contract/doc (custom-mob #:amount-in-world (amount-in-world 1)
                                 #:sprite          (s (first (shuffle (list creeper-sprite
                                                                            skeleton-sprite
                                                                            ghast-sprite))))
                                 #:ai              (ai-level 'medium)
                                 #:health          (health 100)
                                 #:weapon          (w  #f)
                                 #:death-particles (particles (custom-particles))
                                 #:night-only?     (night-only? #f)
                                 #:components      (c #f)
                                                   . custom-components)

  (->i () (#:amount-in-world [amount-in-world positive?]
           #:sprite          [sprite (or/c sprite? (listof sprite?) string? (listof string?))]
           #:ai              [ai ai-level?]
           #:health          [health positive?] 
           #:weapon          [weapon entity?]
           #:death-particles [death-particles entity?]
           #:night-only?     [night-only? boolean?]
           #:components      [first-component component-or-system?])
       #:rest [more-components (listof component-or-system?)]
       [returns entity?])
  
  @{Returns a custom mob, which will be placed in to the world
         automatically if it is passed into @racket[minecraft-game]
         via the @racket[#:mob-list] parameter.}

  (define sprite (if (sprite? s)
                     s
                     (new-sprite s)))
  
  (define weapon
    (if (not w)
        (cond [(equal? (render sprite) (render ghast-sprite))
               (custom-weapon #:name "Fireball" #:dart (fireball-dart)
                              #:fire-sound FIRE-MAGIC-SOUND)]
              [(equal? (render sprite) (render skeleton-sprite))
               (custom-weapon #:name "Arrow" #:dart (arrow-dart)
                              #:fire-sound random-woosh-sound)]
              [(string-animated-sprite? sprite)
               (custom-weapon #:name "TOOL" #:dart-sprite "DART")]
              [else (custom-weapon #:name "Spitter" #:dart (acid-dart)
                                   #:fire-sound #f)])
        w))
  
  (custom-enemy #:amount-in-world amount-in-world
                #:sprite          s 
                #:ai              ai-level
                #:health          health
                #:weapon          weapon
                #:death-particles particles
                #:night-only?     night-only?
                #:components      (cons c custom-components)))


;======== custom-ore to replace custom-coin ========
;would be nice to have a bunch of assets for this -- iron, copper, gold, diamond, etc

(define/contract/doc (custom-ore #:entity           [base-entity (ore-entity)]
                                 #:sprite           [s #f]
                                 #:position         [p #f]
                                 #:name             [n #f]
                                 #:tile             [t #f]
                                 #:amount-in-world  [world-amt 10]
                                 #:value            [val 10]
                                 #:respawn?         [respawn? #t]
                                 #:components       [c #f]
                                                    . custom-entities)

   (->i () (#:entity     [entity entity?]
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

  @{Returns a custom ore, which will be placed into the world
          automatically if it is passed into @racket[minecraft-game]
          via the @racket[#:ore-list] parameter.}
  
  (custom-coin #:entity    base-entity
               #:sprite    s 
               #:position  p
               #:name      n
               #:tile      t 
               #:amount-in-world  world-amt
               #:value     val
               #:respawn?  respawn?
               #:components (cons c custom-entities)))


;--------- Custom Tool (defaults to melee weapon)
;for ranged, use arrow and customize everything from there.
(define/contract/doc (custom-tool #:name              [n "Iron Sword"]
                                  #:sprite            [s (make-icon "IS")]
                                  #:dart-sprite       [ds swinging-sword-sprite]
                                  #:speed             [spd 0]
                                  #:damage            [dmg 50]
                                  #:range             [rng 10]
                                  #:dart              [dart (sword #:sprite ds
                                                                #:speed spd
                                                                #:damage dmg
                                                                #:range rng)]
                                  #:fire-mode         [fm 'normal]
                                  #:fire-rate         [fr 3]
                                  #:fire-key          [key 'f]
                                  #:fire-sound        [fire-sound #f]
                                  #:mouse-fire-button [button #f]
                                  #:point-to-mouse?   [ptm? #t]
                                  #:rapid-fire?       [rf? #t]
                                  #:rarity            [rarity 'common])
  (->i ()
       (#:name              [name string?]
        #:sprite            [sprite (or/c sprite? (listof sprite?) string? (listof string?))]
        #:dart-sprite       [dart-sprite (or/c sprite? (listof sprite?) string? (listof string?))]
        #:speed             [speed  number?]
        #:damage            [damage number?]
        #:range             [range  number?]
        #:dart              [b entity?]
        #:fire-mode         [fire-mode fire-mode?]
        #:fire-rate         [fire-rate number?]
        #:fire-key          [fire-key symbol?]
        #:fire-sound        [fire-sound (or/c rsound? #f '())]
        #:mouse-fire-button [button (or/c 'left 'right false?)]
        #:point-to-mouse?   [ptm? boolean?]
        #:rapid-fire?       [rf? boolean?]
        #:rarity            [rarity rarity-level?])
       [result entity?])

  @{Returns a custom tool, which will be placed in to the world
         automatically if it is passed into @racket[minecraft-game]
         via the @racket[#:tool-list] parameter.}
  
  (custom-weapon #:name              n
                 #:sprite            s
                 #:dart-sprite       ds
                 #:speed             spd
                 #:damage            dmg 
                 #:range             rng
                 #:dart              dart
                 #:fire-mode         fm
                 #:fire-rate         fr
                 #:fire-key          key
                 #:fire-sound        fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse?   ptm?
                 #:rapid-fire?       rf?
                 #:rarity            rarity))



;random color background for default
(define (random-forest)
  (change-img-hue (random 360) (draw-plain-forest-bg)))

;minecraft-game to replace survival-game
(define/contract/doc
  (minecraft-game #:headless        [headless #f]
                  #:biome           [biome-ent (plain-forest-bg #:image (random-forest))]
                  #:skin            [skin (custom-skin #:sprite (circle 10 'solid 'red))]
                  #:starvation-rate [sr 50]
                  #:sky             [sky (custom-sky)]
                  #:entity-list     [entity-list  '() ]
                  #:mob-list        [mob-list     '() ] 
                  #:ore-list        [ore-list     '() ]
                  #:food-list       [f-list       '() ]
                  #:crafter-list    [c-list       '() ]
                  #:score-prefix    [prefix "Ore"]
                  #:tool-list       [tool-list '()]
                  #:enable-world-objects? [world-objects? #f]
                  #:instructions     [instructions #f]
                  #:other-entities  [ent #f]
                  . custom-entities)
  (->i ()
       (#:headless        [headless boolean?]
        #:biome           [biome-ent entity?]
        #:skin            [skin (or/c entity? #f)]
        #:starvation-rate [starvation-rate (or/c number? #f)]
        #:sky             [sky sky?]
        #:entity-list     [entity-list    (listof (or/c entity? procedure?))]
        #:mob-list        [mob-list       (listof (or/c entity? procedure?))]
        #:ore-list        [ore-list       (listof (or/c entity? procedure?))]
        #:food-list       [food-list      (listof (or/c entity? procedure?))]
        #:crafter-list    [crafter-list   (listof (or/c entity? procedure?))]
        #:score-prefix    [prefix         string?]
        #:tool-list       [tool-list      (listof (or/c entity? procedure?))]
        #:enable-world-objects? [world-objects? boolean?]
        #:instructions   [instructions (or/c #f entity?)]
        #:other-entities  [other-entities (or/c #f entity? (listof #f) (listof entity?))])
       #:rest  [rest (listof entity?)]
       [res () game?])

  @{The top-level function for the minecraft-game language.
         Can be run with no parameters to get a basic, default game.}
  
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
   #:score-prefix    prefix
   #:weapon-list     tool-list
   #:enable-world-objects? world-objects?
   #:instructions   instructions
   #:other-entities  (filter identity (flatten (cons ent custom-entities)))))


;============== CUSTOM WEAPONS AND DARTS ================
; move these out of main and into assets or the like??
; pre-built darts should have the -dart suffix and only be used internally

(define arrow-sprite (beside
                      (rectangle 25 3 'solid (make-color 70 40 0))
                      (rotate 270 (triangle 10 'solid 'silver))))

(define (bow #:name              [n "Bow"]
             #:icon              [i (list (set-sprite-angle -45 arrow-sprite)
                                          (make-icon ""))]  ;(make-icon "Bow" 'brown)]
             #:sprite            [s arrow-sprite]
             #:damage            [dmg 10]
             #:durability        [dur 5]
             #:speed             [spd 3]
             #:range             [rng 100]
             #:dart              [d (arrow-dart #:sprite s
                                                #:damage dmg
                                                #:durability dur
                                                #:speed spd
                                                #:range rng)]
             #:fire-mode         [fm 'normal]
             #:fire-rate         [fr 3]
             #:fire-key          [key 'f]
             #:fire-sound        [fire-sound random-woosh-sound]
             #:mouse-fire-button [button #f]
             #:point-to-mouse?   [ptm? #f]
             #:rapid-fire?       [rf? #f]
             #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define (arrow-dart #:sprite     [s   arrow-sprite]
                    #:damage     [dmg 10]
                    #:durability [dur 5]
                    #:speed      [spd 3]
                    #:range      [rng 100])
  
  (custom-dart #:position (posn 25 0)
               #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng))

(define fireball-sprite
  (row->sprite fireball-sheet
               #:columns 4
               #:delay 2))

(define (fireball #:name              [n "Fireball"]
                  #:icon              [i (list (set-sprite-scale 0.75 fireball-sprite)
                                               (make-icon ""))]
                  #:sprite            [s fireball-sprite]
                  #:damage            [dmg 20]
                  #:durability        [dur 5]
                  #:speed             [spd 4]
                  #:range             [rng 100]
                  #:dart              [d (fireball-dart #:sprite s
                                                        #:damage dmg
                                                        #:durability dur
                                                        #:speed spd
                                                        #:range rng)]
                  #:fire-mode         [fm 'normal]
                  #:fire-rate         [fr 3]
                  #:fire-key          [key 'f]
                  #:fire-sound        [fire-sound random-woosh-sound]
                  #:mouse-fire-button [button #f]
                  #:point-to-mouse?   [ptm? #f]
                  #:rapid-fire?       [rf? #f]
                  #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define (fireball-dart #:sprite     [s   fireball-sprite]
                       #:damage     [dmg 20]
                       #:durability [dur 5]
                       #:speed      [spd 4]
                       #:range      [rng 100])
  
  (custom-dart #:position (posn 25 0)
               #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng))