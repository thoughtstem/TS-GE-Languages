 #lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require ts-kata-util
         "../assets.rkt"
         survival)

(language-mappings survival          survival-pokemon
                   ;[custom-bg        custom-]
                   ;[custom-avatar    custom-pokemon]
                   ;[custom-npc       custom-trainer]
                   ;[custom-enemy     custom-grunt]
                   ;[custom-coin      custom-]
                   [survival-game    pokemon-game]
                   [#:bg             #:town-bg]
                   [#:avatar         #:pokemon]
                   [#:npc-list       #:trainer-list]
                   [#:enemy-list     #:grunt-list]
                   [#:coin-list      #:stone-list]
                   )

; ---------   Minecraft Main Game

(define (random-forest)
  (change-img-hue (random 360) (draw-plain-forest-bg)))


(define/contract/doc
  (pokemon-game #:headless        [headless #f]
                #:town-bg         [town-ent (plain-forest-bg #:image (random-forest))]
                #:pokemon         [pokemon #f]
                #:starvation-rate [sr 50]
                #:sky             [sky (custom-sky)]
                #:trainer-list    [trainer-list  '()]
                #:grunt-list      [grunt-list '()] 
                #:stone-list      [stone-list  '() ]
                #:food-list       [f-list    '() ]
                #:crafter-list    [c-list    '() ]
                #:other-entities  [ent #f]
                . custom-entities)
  (->i ()
       (#:headless        [headless boolean?]
        #:town-bg         [town-ent entity?]
        #:pokemon         [pokemon (or/c entity? #f)]
        #:starvation-rate [starvation-rate number?]
        #:sky             [sky sky?]
        #:trainer-list    [trainer-list    (listof (or/c entity? procedure?))]
        #:grunt-list      [grunt-list       (listof (or/c entity? procedure?))]
        #:stone-list      [stone-list       (listof (or/c entity? procedure?))]
        #:food-list       [food-list      (listof (or/c entity? procedure?))]
        #:crafter-list    [crafter-list   (listof (or/c entity? procedure?))]
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
   #:npc-list        trainer-list
   #:enemy-list      grunt-list
   #:coin-list       stone-list
   #:food-list       f-list
   #:crafter-list    c-list
   #:other-entities  (cons ent custom-entities)))