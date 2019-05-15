#lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require ts-kata-util
         "../assets.rkt"
         adventure
         game-engine-demos-common)


(language-mappings adventure       adventure-mario
                   [adventure-game mario-game]
                   [#:avatar       #:character]
                   [#:bg           #:level]
                   [custom-avatar  custom-character])

(define/contract/doc (custom-character #:sprite           [sprite (random-character-sprite)]
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

;------------------- MAIN GAME

(define/contract/doc (mario-game
                      #:headless              [headless #f]
                      #:level                 [level (plain-forest-bg)]
                      #:character             [character (custom-avatar #:sprite (circle 10 'solid 'red))]
                      #:sky                   [sky (custom-sky)]
                      #:intro-cutscene        [intro-cutscene #f]
                      #:npc-list              [npc-list  '()]
                      #:enemy-list            [e-list    '()]
                      #:coin-list             [coin-list '()]
                      #:food-list             [f-list    '()]
                      #:crafter-list          [c-list    '()]
                      #:score-prefix          [prefix "???"]
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
