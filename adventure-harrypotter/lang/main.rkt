#lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require ts-kata-util
         "../assets.rkt"
         adventure
         game-engine-demos-common)


(language-mappings adventure       adventure-harrypotter
                   [#:avatar       #:wizard]
                   [#:weapon-list  #:spell-list]
                   [#:crafter-list #:cauldron-list]
                   [#:enemy-list   #:deatheater-list]
                   [#:food-list    #:ingredient-list]
                   [#:coin-list    #:currency-list]
                   [custom-avatar  custom-wizard]
                   [custom-weapon  custom-spell]
                   [custom-crafter custom-cauldron]
                   [custom-enemy   custom-deatheater]
                   [custom-food    custom-ingredient]
                   [custom-coin    custom-currency]
                   [adventure-game harrypotter-game]
                   )

(provide wand
         swinging-wand-sprite
         colorize-potion
         )

; ----------- WEAPONS
(define swinging-wand-sprite
  (rotate 90 (beside (rectangle 40 40 "solid" "transparent")
                     (rectangle 40 4 "solid" "sienna"))))

(define (wand #:name              [n "Wand"]
              #:sprite            [s swinging-wand-sprite]
              #:icon              [i (list (set-sprite-angle -45 s)
                                           (make-icon "" 'silver))]
              #:damage            [dmg 25]
              #:durability        [dur 20]
              #:speed             [spd 0]
              #:duration          [rng 10]
              #:dart              [d (sword-dart #:sprite s
                                                 #:damage dmg
                                                 #:durability dur
                                                 #:speed spd
                                                 #:duration rng)]
              #:fire-mode         [fm 'normal]
              #:fire-rate         [fr 3]
              #:fire-key          [key 'f]
              #:fire-sound        [fire-sound random-slash-sound]
              #:mouse-fire-button [button #f]
              #:point-to-mouse?   [ptm? #f]
              #:rapid-fire?       [rf? #f]
              #:rarity            [rarity 'common]
              #:on-store          [store-func (λ (g e) e)]
              #:on-drop           [drop-func (λ (g e) e)])

  (sword #:name              n
         #:sprite            s
         #:icon              i
         #:dart              d 
         #:fire-mode         fm
         #:fire-rate         fr
         #:fire-key          key
         #:fire-sound        fire-sound
         #:mouse-fire-button button
         #:point-to-mouse?   ptm?
         #:rapid-fire?       rf?
         #:rarity            rarity
         #:on-store          store-func
         #:on-drop           drop-func))

; ----------------

(define/contract/doc (custom-wizard #:sprite           [sprite (first (shuffle (list harrypotter-sprite
                                                                                     hagrid-sprite
                                                                                     oldwizard-sprite)))]
                                    #:damage-processor [dp (filter-damage-by-tag #:filter-out '(friendly-team passive)
                                                                                 #:show-damage? #t
                                                                                 #:hit-sound HIT-SOUND)]
                                    #:position         [p   (posn 100 100)]
                                    #:speed            [spd 10]
                                    #:key-mode         [key-mode 'arrow-keys]
                                    #:mouse-aim?       [mouse-aim? #f]
                                    #:health           [health     100]
                                    #:max-health       [max-health 100]
                                    #:components       [c #f]
                                    . custom-components)
  (->i ()
       (#:sprite           [sprite sprite?]
        #:damage-processor [damage-processor damage-processor?]
        #:position         [position posn?]
        #:speed            [speed number?]
        #:key-mode         [key-mode (or/c 'wasd 'arrow-keys)]
        #:mouse-aim?       [mouse-aim boolean?]
        #:health           [health     number?]
        #:max-health       [max-health number?]
        #:components [first-component  component-or-system?])
       #:rest       [more-components (listof component-or-system?)]
       [returns entity?])

  @{Returns a custom wizard, which will be placed in to the world
         automatically if it is passed into @racket[harrypotter-game]
         via the @racket[#:wizard] parameter.}

  (apply (curry custom-avatar #:sprite           sprite
                              #:damage-processor dp
                              #:position         p
                              #:speed            spd
                              #:key-mode         key-mode
                              #:mouse-aim?       mouse-aim?
                              #:health           health
                              #:max-health       max-health
                              #:components       c)
                 custom-components))

; -----------

(define/contract/doc (custom-spell #:name              [n "Spell"]
                                   #:sprite            [s chest-sprite]
                                   #:color             [c "green"]
                                   #:dart-sprite       [ds (rectangle 10 2 "solid" c)]
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
                                   #:fire-sound        [fire-sound LASER-SOUND]
                                   #:mouse-fire-button [button #f]
                                   #:point-to-mouse?   [ptm? #f]
                                   #:rapid-fire?       [rf? #t]
                                   #:rarity            [rarity 'common])
  (->i ()
       (#:name              [name string?]
        #:sprite            [sprite (or/c sprite? (listof sprite?))]
        #:color             [c image-color?]
        #:dart-sprite       [dart-sprite (or/c sprite? (listof sprite?))]
        #:speed             [speed  number?]
        #:damage            [damage number?]
        #:range             [range  number?]
        #:dart              [dart entity?]
        #:fire-mode         [fire-mode fire-mode?]
        #:fire-rate         [fire-rate number?]
        #:fire-key          [fire-key symbol?]
        #:fire-sound        [fire-sound (or/c rsound? procedure? '() #f)]
        #:mouse-fire-button [button (or/c 'left 'right false?)]
        #:point-to-mouse?   [ptm? boolean?]
        #:rapid-fire?       [rf? boolean?]
        #:rarity            [rarity rarity-level?])
       [result entity?])

  @{Returns a custom spell, which will be placed in to the world
         automatically if it is passed into @racket[harrypotter-game]
         via the @racket[#:spell-list] parameter.}

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

; -----------------

(define/contract/doc (custom-cauldron #:position   [p (posn 0 0)]
                                      #:tile       [t 0]
                                      #:name       [name "Cauldron"]
                                      #:sprite     [sprite magiccauldron-sprite]
                                      #:open-key     [open-key 'space]
                                      #:open-sound   [open-sound OPEN-DIALOG-SOUND]
                                      #:select-sound [select-sound BLIP-SOUND]
                                      #:recipe-list [r-list (list (recipe #:product (carrot-stew)
                                                                         #:build-time 30
                                                                         ))]
                                     #:components [c #f] . custom-components)
  (->i ()
       (#:position   [position posn?]
        #:tile       [tile number?]
        #:name       [name string?]
        #:sprite     [sprite (or/c sprite? (listof sprite?))]
        #:open-key     [open-key (or/c string? symbol?)]
        #:open-sound   [open-sound (or/c rsound? procedure? '() #f)]
        #:select-sound [select-sound (or/c rsound? procedure? '() #f)]
        #:recipe-list [recipe-list (listof recipe?)]
        #:components [first-component component-or-system?])
       #:rest       [more-components (listof component-or-system?)]
       [result entity?])

  @{Returns a custom cauldron, which will be placed in to the world
         automatically if it is passed into @racket[harrypotter-game]
         via the @racket[#:cauldron-list] parameter.}

  (custom-crafter #:position     p
                  #:tile         t
                  #:name         name
                  #:sprite       sprite
                  #:open-key     open-key
                  #:open-sound   open-sound
                  #:select-sound select-sound
                  #:recipe-list  r-list
                  #:components   (cons c custom-components)))

; ----------

(define/contract/doc (custom-deatheater #:amount-in-world [amount-in-world 1]
                                        #:position        [pos #f]
                                        #:tile            [tile #f]
                                        #:sprite          [s (first (shuffle (list snape-sprite
                                                                                   pumpkin-sprite
                                                                                   tentacula-sprite
                                                                                   bat-sprite
                                                                                   snake-sprite
                                                                                   slime-sprite
                                                                                   )))]
                                        #:ai              [ai-level 'medium]
                                        #:health          [health 100]
                                        #:weapon          [weapon (custom-weapon #:name "Spitter"
                                                                                 #:dart (acid-dart))]
                                        #:death-particles [particles (custom-particles)]
                                        #:night-only?     [night-only? #f]
                                        #:on-death        [death-func (λ (g e) e)]
                                        #:loot-list       [loot-list '()]
                                        #:components      [c #f]
                                        . custom-components
                                        )

  (->i () (#:amount-in-world [amount-in-world positive?]
           #:position        [pos (or/c posn? #f)]
           #:tile            [tile (or/c number? #f)]
           #:sprite          [sprite (or/c sprite? (listof sprite?))]
           #:ai              [ai ai-level?]
           #:health          [health positive?]
           #:weapon          [weapon entity?]
           #:death-particles [death-particles entity?]
           #:night-only?     [night-only? boolean?]
           #:on-death        [death-function procedure?]
           #:loot-list       [loot-list (listof (or/c entity? procedure?))]
           #:components      [first-component component-or-system?])
       #:rest       [more-components (listof component-or-system?)]
       [returns entity?])

  @{Returns a custom deatheater, which will be placed in to the world
         automatically if it is passed into @racket[harrypotter-game]
         via the @racket[#:deatheater-list] parameter.}

  (custom-enemy #:amount-in-world amount-in-world
                #:position        pos
                #:tile            tile
                #:sprite          s
                #:ai              ai-level
                #:health          health
                #:weapon          weapon
                #:death-particles particles
                #:night-only?     night-only?
                #:on-death        death-func
                #:loot-list       loot-list
                #:components      (cons c custom-components)))

; -----------

(define/contract/doc (custom-ingredient  #:name              [n "Carrot"]
                                         #:sprite            [s carrot-sprite]
                                         #:tile              [tile 0]
                                         #:position          [pos (posn 0 0)]
                                         #:amount-in-world   [world-amt 1]
                                         #:storable?         [storable? #t]
                                         #:consumable?       [consumable? #f]
                                         #:heals-by          [heals-by 10]    ;only used if consumable is #t
                                         #:respawn?          [respawn? #t]    ;only used if consumable is #t
                                         #:on-pickup         [pickup-func (λ (g e) e)]
                                         #:on-store          [store-func (λ (g e) e)]
                                         #:on-drop           [drop-func (λ (g e) e)]
                                         #:components        [c #f]
                                         . custom-components)

  (->i () (#:name            [name string?]
           #:sprite          [sprite (or/c sprite? (listof sprite?))]
           #:tile            [tile (or/c number? #f)]
           #:position        [pos (or/c posn? #f)]
           #:amount-in-world [amount-in-world positive?]
           #:storable?       [storable? boolean?]
           #:consumable?     [consumable? boolean?]
           #:heals-by        [heals-by number?]
           #:respawn?        [respawn? boolean?]    
           #:on-pickup       [pickup-func procedure?]
           #:on-store        [store-func procedure?]
           #:on-drop         [drop-func procedure?]
           #:components      [first-component component-or-system?])
       #:rest       [more-components (listof component-or-system?)]
       [returns entity?])

  @{Returns a custom ingredient, which will be placed in to the world
         automatically if it is passed into @racket[harrypotter-game]
         via the @racket[#:ingredient-list] parameter.}

  (custom-item  #:name              n
                #:sprite            s
                #:tile              tile
                #:position          pos
                #:amount-in-world   world-amt
                #:storable?         storable?
                #:consumable?       consumable?
                #:heals-by          heals-by    
                #:respawn?          respawn? 
                #:on-pickup         pickup-func
                #:on-store          store-func 
                #:on-drop           drop-func 
                #:components        (cons c custom-components)))

; -----------
(define/contract (colorize-sprite color-name sprite)
  (-> (or/c string? symbol?) animated-sprite? animated-sprite?)
  (define c-hsb (name->color-hsb color-name))
  (define h (color-hsb-hue c-hsb))
  (apply-image-function (curry set-img-hue h)
                        sprite))

(define (colorize-potion c)
  (colorize-sprite c potion-sprite))

(define/contract/doc (custom-potion  #:name              [n "Potion"]
                                     #:color             [col 'white]
                                     #:sprite            [s (colorize-sprite col potion-sprite)]
                                     #:tile              [tile 0]
                                     #:position          [pos (posn 0 0)]
                                     #:amount-in-world   [world-amt 1]
                                     #:storable?         [storable? #t]
                                     #:consumable?       [consumable? #t]
                                     #:heals-by          [heals-by 10]    ;only used if consumable is #t
                                     #:respawn?          [respawn? #t]    ;only used if consumable is #t
                                     #:on-pickup         [pickup-func (λ (g e) e)]
                                     #:on-store          [store-func (λ (g e) e)]
                                     #:on-drop           [drop-func (λ (g e) e)]
                                     #:components        [c #f]
                                     . custom-components)
  
  (->i () (#:name            [name string?]
           #:color           [color image-color?]
           #:sprite          [sprite (or/c sprite? (listof sprite?))]
           #:tile            [tile (or/c number? #f)]
           #:position        [pos (or/c posn? #f)]
           #:amount-in-world [amount-in-world positive?]
           #:storable?       [storable? boolean?]
           #:consumable?     [consumable? boolean?]
           #:heals-by        [heals-by number?]
           #:respawn?        [respawn? boolean?]    
           #:on-pickup       [pickup-func procedure?]
           #:on-store        [store-func procedure?]
           #:on-drop         [drop-func procedure?]
           #:components      [first-component component-or-system?])
       #:rest       [more-components (listof component-or-system?)]
       [returns entity?])

  @{Returns a custom ingredient, which will be placed in to the world
         automatically if it is passed into @racket[harrypotter-game]
         via the @racket[#:ingredient-list] parameter.}

  (custom-item  #:name              n
                #:sprite            s
                #:tile              tile
                #:position          pos
                #:amount-in-world   world-amt
                #:storable?         storable?
                #:consumable?       consumable?
                #:heals-by          heals-by    
                #:respawn?          respawn? 
                #:on-pickup         pickup-func
                #:on-store          store-func 
                #:on-drop           drop-func 
                #:components        (cons c custom-components)))

;-------------------

(define/contract/doc (custom-currency #:name            [n "Knut"]
                                      #:sprite          [s coppercoin-sprite]
                                      #:position        [p #f]
                                      #:tile            [t #f]
                                      #:amount-in-world [world-amt 10]
                                      #:value           [val 10]
                                      #:respawn?        [respawn? #t]
                                      #:storable?       [storable? #t]
                                      #:consumable?     [consumable? #t]
                                      #:on-pickup       [pickup-func (λ (g e) e)]
                                      #:on-store        [store-func (λ (g e) e)]
                                      #:on-drop         [drop-func (λ (g e) e)]
                                      #:components      [c #f]
                                      . custom-components)

   (->i () (#:name            [name (or/c string? #f)]
            #:sprite          [sprite (or/c sprite? (listof sprite?) #f)]
            #:position        [position (or/c posn? #f)]           
            #:tile            [tile (or/c number? #f)]
            #:amount-in-world [amount-in-world number?]
            #:value           [value number?]
            #:respawn?        [respawn boolean?]
            #:storable?       [storable? boolean?]
            #:consumable?     [consumable? boolean?]
            #:on-pickup       [pickup-function procedure?]
            #:on-store        [store-function procedure?]
            #:on-drop         [drop-function procedure?]
            #:components      [first-component component-or-system?])
       #:rest [more-components (listof component-or-system?)]
        [returns entity?])

  @{Returns a custom currency, which will be placed into the world
              automatically if it is passed into @racket[harrypotter-game]
              via the @racket[#:currency-list] parameter.}

    (apply (curry custom-item  #:name              n
                                #:sprite            s
                                #:tile              t
                                #:position          p
                                #:amount-in-world   world-amt
                                #:value             val
                                #:storable?         storable?
                                #:consumable?       consumable?
                                #:respawn?          respawn? 
                                #:on-pickup         pickup-func
                                #:on-store          store-func 
                                #:on-drop           drop-func 
                                #:components        c)
           custom-components))

;------------------- MAIN GAME

(define/contract/doc (harrypotter-game
                      #:headless              [headless #f]
                      #:bg                    [bg (plain-forest-bg)]
                      #:wizard                [wizard (custom-wizard #:sprite (circle 10 'solid 'red))]
                      #:sky                   [sky (custom-sky)]
                      #:intro-cutscene        [intro-cutscene #f]
                      #:death-cutscene        [death-cutscene #f]
                      #:npc-list              [npc-list  '()]
                      #:deatheater-list       [e-list    '()]
                      #:currency-list         [currency-list '()]
                      #:ingredient-list       [f-list    '()]
                      #:potion-list           [p-list    '()]
                      #:cauldron-list         [c-list    '()]
                      #:score-prefix          [prefix "Knuts"]
                      #:instructions          [instructions #f]
                      #:enable-world-objects? [world-objects? #f]
                      #:spell-list            [spell-list '()]
                      #:other-entities        [ent #f]
                      . custom-entities)

  (->i ()
       (#:headless              [headless boolean?]
        #:bg                    [bg entity?]
        #:wizard                [wizard (or/c entity? false?)]
        #:sky                   [sky (or/c sky? #f)]
        #:intro-cutscene        [intro-cutscene (or/c entity? false?)]
        #:death-cutscene        [death-cutscene (or/c entity? #f)]
        #:npc-list              [npc-list     (listof (or/c entity? procedure?))]
        #:deatheater-list       [deatheater-list   (listof (or/c entity? procedure?))]
        #:currency-list         [currency-list    (listof (or/c entity? procedure?))]
        #:ingredient-list       [ingredient-list    (listof (or/c entity? procedure?))]
        #:potion-list           [potion-list    (listof (or/c entity? procedure?))]
        #:cauldron-list         [cauldron-list (listof (or/c entity? procedure?))]
        #:score-prefix          [prefix string?]
        #:enable-world-objects? [world-objects? boolean?]
        #:spell-list            [spell-list (listof (or/c entity? procedure?))]
        #:instructions          [instructions (or/c #f entity?)]
        #:other-entities        [other-entities (or/c #f entity? (listof false?) (listof entity?))])
       #:rest           [rest (listof entity?)]
       [res () game?])

  @{The top-level function for the adventure-mario language.
         Can be run with no parameters to get a basic, default game.}

  (adventure-game #:headless              headless
                  #:bg                    bg
                  #:avatar                wizard
                  #:sky                   sky
                  #:intro-cutscene        intro-cutscene
                  #:death-cutscene        death-cutscene
                  #:npc-list              npc-list
                  #:enemy-list            e-list   
                  #:coin-list             currency-list
                  #:food-list             (append f-list p-list)
                  #:crafter-list          c-list   
                  #:score-prefix          prefix
                  #:enable-world-objects? world-objects?
                  #:weapon-list           spell-list 
                  #:instructions          instructions
                  #:other-entities        (filter identity (flatten (cons ent custom-entities)))))
