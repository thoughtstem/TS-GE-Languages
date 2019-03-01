#lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require ts-kata-util
         "../assets.rkt"
         battle-arena
         game-engine-demos-common
         )

(language-mappings battle-arena       battle-arena-fortnite
                   [custom-avatar     custom-hero]
                   [#:avatar          #:hero]
                   [battle-arena-game fortnite-game])

;; ----- HERO

(define/contract/doc (custom-hero #:sprite           (sprite (random-character-sprite))
                                  #:damage-processor [dp (divert-damage #:filter-out '(friendly-team passive))]
                                  #:position         [p   (posn 100 100)]
                                  #:speed            [spd 10]
                                  #:key-mode         [key-mode 'wasd]
                                  #:mouse-aim?       [mouse-aim? #t]
                                  #:item-slots       [w-slots 2]
                                  #:components       [c #f]
                                  . custom-components)
  (->i ()
       (#:sprite [sprite sprite?]
        #:damage-processor [damage-processor damage-processor?]
        #:position [position posn?]
        #:speed [speed number?]
        #:key-mode [key-mode (or/c 'wasd 'arrow-keys)]
        #:mouse-aim? [mouse-aim boolean?]
        #:item-slots [item-slots number?]
        #:components [first-component component-or-system?]
        )
       #:rest (rest (listof component-or-system?))
       [returns entity?])
  
    @{Returns a custom hero, which will be placed in to the world
         automatically if it is passed into @racket[avengers-game]
         via the @racket[#:hero] parameter.}
  
  (custom-avatar #:sprite           sprite
                 #:damage-processor dp
                 #:position         p
                 #:speed            spd
                 #:key-mode         key-mode
                 #:mouse-aim?       mouse-aim?
                 #:item-slots       w-slots
                 #:components       (cons c custom-components)))
                 
;------------------- MAIN GAME

(define/contract/doc (fortnite-game
                      #:hero             [avatar (custom-hero #:sprite (circle 10 'solid 'red))]
                      #:headless         [headless #f]
                      #:bg               [planet-ent (plain-bg)]
                      #:enemy-list       [e-list '()]
                      #:weapon-list      [weapon-list '()]
                      #:item-list        [item-list '()]
                      #:score-prefix     [prefix "Enemies"]
                      #:other-entities   [ent #f]
                      . custom-entities)

  (->i ()
       (#:headless       [headless boolean?]
        #:bg             [planet entity?]
        #:hero           [avatar (or/c entity? false?)]
        #:enemy-list     [enemy-list   (listof (or/c entity? procedure?))]
        #:weapon-list    [weapon-list (listof (or/c entity? procedure?))]
        #:item-list      [item-list   (listof (or/c entity? procedure?))]
        #:score-prefix   [prefix string?]
        #:other-entities [other-entities (or/c #f entity?)])
       #:rest            [rest (listof entity?)]
       [res () game?])

  @{The top-level function for the battle-arena-avengers language.
         Can be run with no parameters to get a basic, default game.}

  (battle-arena-game #:headless       headless
                     #:bg             planet-ent
                     #:avatar         avatar
                     #:weapon-list    weapon-list
                     #:enemy-list     e-list
                     #:item-list      item-list
                     #:score-prefix   prefix
                     #:other-entities (cons ent custom-entities)))