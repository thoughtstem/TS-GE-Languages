#lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require ts-kata-util
         "../assets.rkt"
         adventure
         game-engine-demos-common)

(provide block
         brick
         fence
         pipe
         question-block
         )


(language-mappings adventure       adventure-mario
                   [adventure-game mario-game]
                   [#:avatar       #:character]
                   [#:bg           #:level]
                   [#:weapon-list  #:power-list]
                   [#:death-cutscene  #:game-over-cutscene]
                   [custom-avatar  custom-character]
                   [custom-bg      custom-level]
                   [custom-weapon  custom-power])

(define/contract/doc (custom-character #:sprite           [sprite (first (shuffle (list mario-sprite
                                                                                        luigi-sprite
                                                                                        princesspeach-sprite
                                                                                        toad-sprite
                                                                                        yoshi1-sprite)))]
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
        #:components [first-component (or/c component-or-system? #f (listof #f) observe-change?)])
       #:rest       [more-components (listof (or/c component-or-system? #f (listof #f) observe-change?))]
       [returns entity?])

  @{Returns a custom character, which will be placed in to the world
         automatically if it is passed into @racket[mario-game]
         via the @racket[#:character] parameter.}

  (custom-avatar #:sprite           sprite
                 #:damage-processor dp
                 #:position         p
                 #:speed            spd
                 #:key-mode         key-mode
                 #:mouse-aim?       mouse-aim?
                 #:health           health
                 #:max-health       max-health
                 #:components       (cons c custom-components)))

; ------------

(define/contract/doc (custom-level #:image      [bg FOREST-BG]
                                   #:rows       [rows 3]
                                   #:columns    [cols 3]
                                   #:start-tile [t 0]
                                   #:hd?        [hd? #f]
                                   #:components [c #f]
                                   . custom-components)

  (->i ()
       (#:image [bg-img image?]
        #:rows   [rows number?]
        #:columns [columns number?]
        #:start-tile [start-tile number?]
        #:hd?        [high-def? boolean?]
        #:components [first-component component-or-system?])
       #:rest [more-components (listof component-or-system?)]
       [result entity?])

  @{Returns a custom level, which will be used
         automatically if it is passed into @racket[mario-game]
         via the @racket[#:level] parameter.}

  (custom-bg #:image      bg
             #:rows       rows
             #:columns    cols
             #:start-tile t
             #:hd?        hd?
             #:components (cons c custom-components)))

; -------------------

(define/contract/doc (custom-power #:name              [n "Repeater"]
                                   #:sprite            [s chest-sprite]
                                   #:dart-sprite       [ds (rectangle 10 2 "solid" "green")]
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

  @{Returns a custom power, which will be placed in to the world
         automatically if it is passed into @racket[mario-game]
         via the @racket[#:power-list] parameter.}

  (custom-power #:name              n
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

;------------------- MAIN GAME

(define/contract/doc (mario-game
                      #:headless              [headless #f]
                      #:level                 [level (plain-forest-bg)]
                      #:character             [character (custom-avatar #:sprite (circle 10 'solid 'red))]
                      #:sky                   [sky (custom-sky)]
                      #:intro-cutscene        [intro-cutscene #f]
                      #:game-over-cutscene    [game-over-cutscene #f]
                      #:npc-list              [npc-list  '()]
                      #:enemy-list            [e-list    '()]
                      #:coin-list             [coin-list '()]
                      #:food-list             [f-list    '()]
                      #:crafter-list          [c-list    '()]
                      #:score-prefix          [prefix "Coins"]
                      #:instructions          [instructions #f]
                      #:enable-world-objects? [world-objects? #f]
                      #:power-list            [power-list '()]
                      #:other-entities        [ent #f]
                      . custom-entities)

  (->i ()
       (#:headless              [headless boolean?]
        #:level                 [level entity?]
        #:character             [character (or/c entity? false?)]
        #:sky                   [sky (or/c sky? #f)]
        #:intro-cutscene        [intro-cutscene (or/c entity? false?)]
        #:game-over-cutscene    [game-over-cutscene (or/c entity? #f)]
        #:npc-list              [npc-list     (listof (or/c entity? procedure?))]
        #:enemy-list            [enemy-list   (listof (or/c entity? procedure?))]
        #:coin-list             [coin-list    (listof (or/c entity? procedure?))]
        #:food-list             [food-list    (listof (or/c entity? procedure?))]
        #:crafter-list          [crafter-list (listof (or/c entity? procedure?))]
        #:score-prefix          [prefix string?]
        #:enable-world-objects? [world-objects? boolean?]
        #:power-list            [power-list (listof (or/c entity? procedure?))]
        #:instructions          [instructions (or/c #f entity?)]
        #:other-entities        [other-entities (or/c #f entity? (listof false?) (listof entity?))])
       #:rest           [rest (listof entity?)]
       [res () game?])

  @{The top-level function for the adventure-mario language.
         Can be run with no parameters to get a basic, default game.}

  (adventure-game #:headless              headless
                  #:bg                    level
                  #:avatar                character
                  #:sky                   sky
                  #:intro-cutscene        intro-cutscene
                  #:death-cutscene    game-over-cutscene
                  #:npc-list              npc-list
                  #:enemy-list            e-list   
                  #:coin-list             coin-list
                  #:food-list             f-list    
                  #:crafter-list          c-list   
                  #:score-prefix          prefix
                  #:enable-world-objects? world-objects?
                  #:weapon-list           power-list 
                  #:instructions          instructions
                  #:other-entities        (filter identity (flatten (cons ent custom-entities)))))

; ==== WORLD OBJECTS
(define (block [p (posn 0 0)] #:tile [tile 0] #:hue [hue 0] #:size [size 1] #:components (c #f) . custom-components )
  (generic-entity block1-sprite
                  p
                  #:name "Block"
                  #:tile tile
                  #:hue hue
                  #:size size
                  #:components (cons c custom-components)))

(define (brick [p (posn 0 0)] #:tile [tile 0] #:hue [hue 0] #:size [size 1] #:components (c #f) . custom-components )
  (generic-entity brick1-sprite
                  p
                  #:name "Brick"
                  #:tile tile
                  #:hue hue
                  #:size size
                  #:components (cons c custom-components)))

(define (fence [p (posn 0 0)] #:tile [tile 0] #:hue [hue 0] #:size [size 1] #:components (c #f) . custom-components )
  (generic-entity fence1-sprite
                  p
                  #:name "Fence"
                  #:tile tile
                  #:hue hue
                  #:size size
                  #:components (cons c custom-components)))

(define (pipe [p (posn 0 0)] #:tile [tile 0] #:hue [hue 0] #:size [size 1] #:components (c #f) . custom-components )
  (generic-entity pipe1-sprite
                  p
                  #:name "Pipe"
                  #:tile tile
                  #:hue hue
                  #:size size
                  #:components (cons c custom-components)))

(define (question-block [p (posn 0 0)] #:tile [tile 0] #:hue [hue 0] #:size [size 1] #:components (c #f) . custom-components )
  (generic-entity question1-sprite
                  p
                  #:name "Question Block"
                  #:tile tile
                  #:hue hue
                  #:size size
                  #:components (cons c custom-components)))