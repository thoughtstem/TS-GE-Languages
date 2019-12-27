#lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require ts-kata-util
         fandom-sprites-ge
         battlearena
         game-engine-demos-common
         )

(language-mappings battlearena       battlearena-fortnite
                   [battlearena-game fortnite-game])
               
;------------------- MAIN GAME

(define/contract/doc (fortnite-game
                      #:avatar           [avatar (custom-avatar #:sprite (circle 10 'solid 'red))]
                      #:headless         [headless #f]
                      #:bg               [planet-ent (plain-bg)]
                      #:enemy-list       [e-list '()]
                      #:weapon-list      [weapon-list '()]
                      #:item-list        [item-list '()]
                      #:score-prefix     [prefix "Enemies"]
                      #:enable-world-objects? [world-objects? #f]
                      #:instructions     [instructions #f]
                      #:other-entities   [ent #f]
                      . custom-entities)

  (->i ()
       (#:headless       [headless boolean?]
        #:bg             [planet entity?]
        #:avatar           [avatar (or/c entity? false?)]
        #:enemy-list     [enemy-list   (listof (or/c entity? procedure?))]
        #:weapon-list    [weapon-list (listof (or/c entity? procedure?))]
        #:item-list      [item-list   (listof (or/c entity? procedure?))]
        #:score-prefix   [prefix string?]
        #:enable-world-objects? [world-objects? boolean?]
        #:instructions   [instructions (or/c #f entity?)]
        #:other-entities [other-entities (or/c #f entity? (listof false?) (listof entity?))])
       #:rest            [rest (listof entity?)]
       [res () game?])

  @{The top-level function for the battlearena-avengers language.
         Can be run with no parameters to get a basic, default game.}

  (battlearena-game #:headless       headless
                    #:bg             planet-ent
                    #:avatar         avatar
                    #:weapon-list    weapon-list
                    #:enemy-list     e-list
                    #:item-list      item-list
                    #:score-prefix   prefix
                    #:enable-world-objects? world-objects?
                    #:instructions   instructions
                    #:other-entities (filter identity (flatten (cons ent custom-entities)))))