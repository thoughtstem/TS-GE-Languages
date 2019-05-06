#lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require ts-kata-util
         "../assets.rkt"
         adventure
         game-engine-demos-common)


(language-mappings adventure       adventure-mario
                   [adventure-game mario-game])

;------------------- MAIN GAME

(define/contract/doc (mario-game
                      #:headless              [headless #f]
                      #:planet                [level (plain-forest-bg)]
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
        #:planet                [level entity?]
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
