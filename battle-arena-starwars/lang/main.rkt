#lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require ts-kata-util 2htdp/image 
         "../assets.rkt"
         battle-arena)


(language-mappings battle-arena       battle-arena-starwars
                   [custom-avatar     custom-jedi]
                   [battle-arena-game starwars-game])


(define sprite? (or/c image? animated-sprite?))


(define/contract/doc (custom-jedi #:sprite       (sprite (sheet->sprite twileck-jedi
                                                                        #:rows 4
                                                                        #:columns 3
                                                                        #:row-number 3))
                                  #:damage-processor [dp (divert-damage #:filter-out '(friendly-team passive))]
                                  #:position     [p   (posn 100 100)]
                                  #:speed        [spd 10]
                                  #:key-mode     [key-mode 'wasd]
                                  #:mouse-aim?   [mouse-aim? #t]
                                  #:item-slots   [w-slots 2]
                                  #:components   [c #f]
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
  
  @{This returns an avatar.}
  (custom-avatar #:sprite sprite))

(define/contract/doc (starwars-game
                      #:avatar         (avatar (custom-jedi))
                      #:headless       [headless #f]
                      #:bg             [bg-ent (custom-background)]
                      #:enemy-list     [e-list (list (custom-enemy)
                                                     (custom-enemy #:weapon (custom-weapon #:name "Sword"
                                                                                           #:dart (sword))))]
                      #:weapon-list    [weapon-list '()]
                      #:item-list      [item-list '()]
                      #:other-entities [ent #f]
                      . custom-entities)

  (->i ()
       (#:headless [headless boolean?]
        #:bg [bg entity?]
        #:avatar [avatar entity?]
        #:enemy-list [enemy-list   (listof (or/c entity? procedure?))]
        #:weapon-list [weapon-list (listof (or/c entity? procedure?))]
        #:item-list   [item-list   (listof (or/c entity? procedure?))]
        #:other-entities [other-entities (or/c #f entity?)])
       #:rest [rest (listof entity?)]
       [res () game?])

  @{The top-level function for the battle-arena language.
         Can be run with no parameters to get a basic, default game
         with nothing in it!}

  (battle-arena-game #:avatar avatar))


