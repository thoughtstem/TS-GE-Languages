#lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require ts-kata-util
         "../assets.rkt"
         battle-arena
         game-engine-demos-common)


(language-mappings battle-arena       battle-arena-starwars
                   [custom-avatar     custom-hero]
                   [custom-enemy      custom-villain]
                   [custom-bg         custom-planet]
                   [#:avatar          #:hero]
                   [#:enemy-list      #:villain-list]
                   [#:bg              #:planet]
                   [battle-arena-game starwars-game])

(provide lightsaber-droid
         blaster-droid
         double-lightsaber
         )

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
         automatically if it is passed into @racket[starwars-game]
         via the @racket[#:hero] parameter.}
  
  (custom-avatar #:sprite           sprite
                 #:damage-processor dp
                 #:position         p
                 #:speed            spd
                 #:key-mode         key-mode
                 #:mouse-aim?       mouse-aim?
                 #:item-slots       w-slots
                 #:components       (cons c custom-components)))

;; ----- VILLAIN

(define/contract/doc (custom-villain #:amount-in-world (amount-in-world 1)
                                     #:sprite (sprite stormtrooper-sprite)
                                     #:ai (ai-level 'easy)
                                     #:health (health 100)
                                     #:shield (shield 100)
                                     #:weapon (weapon (blaster #:color "red"))
                                     #:death-particles (death-particles (custom-particles))
                                     #:components (c #f)
                                     . custom-components
                                     )

  (->i () (#:amount-in-world [amount-in-world positive?]
           #:sprite [sprite sprite?]
           #:ai [ai-level ai-level?]
           #:health [health positive?]
           #:shield [shield positive?]
           #:weapon [weapon entity?]
           #:death-particles [death-particles entity?]
           #:components [first-component component-or-system?])
       #:rest [more-components (listof component-or-system?)]
       [returns entity?])

  @{Returns a custom enemy, which will be placed in to the world
         automatically if it is passed into @racket[starwars-game]
         via the @racket[#:villain-list] parameter.}

  (custom-enemy #:amount-in-world amount-in-world
                #:sprite sprite
                #:ai ai-level
                #:health health
                #:shield shield
                #:weapon weapon
                #:death-particles death-particles
                #:components      (cons c custom-components)))

;; ----- LIGHTSABER

(define/contract/doc (lightsaber #:name              [n "Lightsaber"]
                                 #:icon              [s (make-icon "LS" "green")]
                                 #:color             [c "green"]
                                 #:damage            [dmg 25]
                                 #:durability        [dur 20]
                                 #:dart              [b (lightsaber-dart #:color      c
                                                                         #:damage     dmg)]
                                 #:fire-mode         [fm 'normal]
                                 #:fire-rate         [fr 3]
                                 #:fire-key          [key 'f]
                                 #:mouse-fire-button [button 'left]
                                 #:point-to-mouse?   [ptm? #t]
                                 #:rapid-fire?       [rf? #t]
                                 #:rarity            [rarity 'common])
  (->i ()
       (#:name        [name string?]
        #:icon        [sprite sprite?]
        #:color       [color image-color?]
        #:damage      [dmg number?]
        #:durability  [dur number?]
        #:dart        [dart entity?]
        #:fire-mode   [fire-mode fire-mode?]
        #:fire-rate   [fire-rate number?]
        #:fire-key    [fire-key symbol?]
        #:mouse-fire-button [button (or/c 'left 'right)]
        #:point-to-mouse?   [ptm? boolean?]
        #:rapid-fire?       [rf? boolean?]
        #:rarity      [rarity rarity-level?])
       [result entity?])

  @{Returns a custom lightsaber, which will be placed in to the world
         automatically if it is passed into @racket[starwars-game]
         via the @racket[#:weapon-list] parameter.}
  
  (custom-weapon #:name              n
                 #:sprite            s
                 #:dart              b
                 #:fire-mode         fm
                 #:fire-rate         fr
                 #:fire-key          key
                 #:mouse-fire-button button
                 #:point-to-mouse?   ptm?
                 #:rapid-fire?       rf?
                 #:rarity            rarity))

;; ----- BLASTER

(define/contract/doc (blaster #:name              [n "Blaster"]
                              #:icon              [s (make-icon "B" "red")]
                              #:color             [c "green"]
                              #:damage            [dmg 10]
                              #:durability        [dur 20]
                              #:speed             [spd  5]
                              #:range             [rng 50]
                              #:dart              [b (blaster-dart #:color      c
                                                                   #:damage     dmg
                                                                   #:durability dur
                                                                   #:speed      spd
                                                                   #:range      rng)]
                              #:fire-mode         [fm 'normal]
                              #:fire-rate         [fr 3]
                              #:fire-key          [key 'f]
                              #:mouse-fire-button [button 'left]
                              #:point-to-mouse?   [ptm? #t]
                              #:rapid-fire?       [rf? #t]
                              #:rarity            [rarity 'common])
  (->i ()
       (#:name        [name string?]
        #:icon        [sprite sprite?]
        #:color       [color image-color?]
        #:damage      [dmg number?]
        #:durability  [dur number?]
        #:speed       [spd number?]
        #:range       [rng number?]
        #:dart        [dart entity?]
        #:fire-mode   [fire-mode fire-mode?]
        #:fire-rate   [fire-rate number?]
        #:fire-key    [fire-key symbol?]
        #:mouse-fire-button [button (or/c 'left 'right)]
        #:point-to-mouse?   [ptm? boolean?]
        #:rapid-fire?       [rf? boolean?]
        #:rarity      [rarity rarity-level?])
       [result entity?])
  
  @{Returns a custom blaster, which will be placed in to the world
         automatically if it is passed into @racket[starwars-game]
         via the @racket[#:weapon-list] parameter.}
  
  (custom-weapon #:name              n
                 #:sprite            s
                 #:dart              b
                 #:fire-mode         fm
                 #:fire-rate         fr
                 #:fire-key          key
                 #:mouse-fire-button button
                 #:point-to-mouse?   ptm?
                 #:rapid-fire?       rf?
                 #:rarity            rarity))

;; ----- PLANET

(define/contract/doc (custom-planet #:img        [bg (change-img-hue (random 360) (draw-plain-bg))]
                                    #:rows       [rows 3]
                                    #:columns    [cols 3]
                                    #:start-tile [t 0]
                                    #:components [c #f]
                                    . custom-components)

  (->i ()
       (#:img [bg-img image?]
        #:rows   [rows number?]
        #:columns [columns number?]
        #:start-tile [start-tile number?]
        #:components [first-component component-or-system?])
       #:rest [more-components (listof component-or-system?)]
       [result entity?])

  @{Returns a custom planet, which will be used
         automatically if it is passed into @racket[starwars-game]
         via the @racket[#:planet] parameter.}
  
  (if (> (image-width bg) 24)
      (bg->backdrop-entity (scale 0.25 bg)
                           #:rows       rows
                           #:columns    cols
                           #:start-tile t
                           #:scale 4)
      (bg->backdrop-entity bg
                           #:rows       rows
                           #:columns    cols
                           #:start-tile t
                           #:scale 60)))

;; ----- WEAPONS & DARTS

(define (swinging-lightsaber-sprite c)
  (rotate 90 (beside (rectangle 40 40 "solid" "transparent")
                     (rectangle 8 4 "solid" "black")
                     (rectangle 28 4 "solid" c))))

(define (double-lightsaber-sprite c)
  (rotate 90 (beside (rectangle 12 40 "solid" "transparent")
                     (rectangle 28 4 "solid" c)
                     (rectangle 8 4 "solid" "black")
                     (rectangle 28 4 "solid" c))))

(define (blaster-dart-sprite c)
  (rectangle 10 2 "solid" c))

(define (double-lightsaber
         #:color      [c "red"]
         #:sprite     [s (double-lightsaber-sprite c)]
         #:damage     [dmg 50]
         #:durability [dur 20]
         #:speed      [spd  0]
         #:range      [rng 10])

  (sword #:name          "Double Lightsaber"
         #:icon          (make-icon "DL")
         #:sprite        s
         #:damage        dmg
         #:durability    dur
         #:speed         spd
         #:duration      rng))

(define (lightsaber-dart
         #:color      [c "green"]
         #:sprite     [s (swinging-lightsaber-sprite c)]
         #:damage     [dmg 25]
         #:durability [dur 20]
         #:speed      [spd  0]
         #:range      [rng 10])

  (sword-dart #:sprite        s
              #:damage        dmg
              #:durability    dur
              #:speed         spd
              #:duration      rng))

(define (blaster-dart
         #:color      [c "green"]
         #:sprite     [s (blaster-dart-sprite c)]
         #:damage     [dmg 10]
         #:durability [dur 20]
         #:speed      [spd  5]
         #:range      [rng 50])

  (custom-dart #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng))


(define (lightsaber-droid #:color      [c "green"]
                          #:sprite     [s (swinging-lightsaber-sprite c)]
                          #:damage     [dmg 50]
                          #:durability [dur 20]
                          #:speed      [spd 5]
                          #:range      [rng 20]
                          #:fire-rate  [fire-rate 0.5])
  
  (builder-dart #:entity (droid #:weapon (lightsaber #:fire-rate fire-rate
                                                     #:dart (lightsaber-dart #:color      c
                                                                             #:sprite     s
                                                                             #:damage     dmg
                                                                             #:durability dur
                                                                             #:speed      spd
                                                                             #:range      rng)))))

(define (blaster-droid #:color      [c "green"]
                       #:sprite     [s (blaster-dart-sprite c)]
                       #:damage     [dmg 10]
                       #:durability [dur 20]
                       #:speed      [spd 5]
                       #:range      [rng 50]
                       #:fire-rate  [fire-rate 2]
                       #:fire-mode  [fire-mode 'normal])
  
  (builder-dart #:entity (droid #:weapon (blaster #:fire-rate fire-rate
                                                         #:fire-mode fire-mode
                                                         #:dart (blaster-dart #:color      c
                                                                              #:sprite     s
                                                                              #:damage     dmg
                                                                              #:durability dur
                                                                              #:speed      spd
                                                                              #:range      rng)))))

;; ----- DROIDS

(define (crop-sprite img row col x-idx y-idx)
  (define w (image-width  img))
  (define h (image-height img))
  (define crop-w (/ w col))
  (define crop-h (/ h row))
  (crop (* crop-w x-idx) (* crop-h y-idx) crop-w crop-h img))
  
(define (droid #:weapon (weapon (custom-weapon))
               #:die-after (die-after 500))
  (define droid-id (random 100000))
  (define droid-name (~a "droid" droid-id))
  (displayln (~a "DROID NAME: " droid-name))

  (define droid-base (rectangle 20 1 'solid 'transparent))
  
  (define droid-top (crop-sprite c2po 4 4 2 2))

  (define droid-top-entity
    (sprite->entity droid-top
                    #:name "Droid Top"
                    #:position (posn 0 -20)
                    #:components
                    (layer "tops")
                    (after-time die-after die)
                    (on-rule (λ (g e) (not (get-entity droid-name g))) die)
                    (active-on-bg)))

  (precompile! droid-top
               droid-base)


  (define weapon-system (get-storage-data "Weapon" weapon))
  
  (sprite->entity droid-base

                  #:name droid-name
                  #:position (posn 0 0)
                  #:components
                  (direction 0)
                  (speed 0)
                  (active-on-bg)
                  (use-weapon-against "Enemy" weapon-system)
                  (static)
                  (lock-to-grid 50)
                  (physical-collider)
                  (on-collide droid-name die)
                  (after-time die-after die)
                  (on-start (spawn-on-current-tile droid-top-entity))))


;------------------- MAIN GAME

(define/contract/doc (starwars-game
                      #:hero             [avatar (custom-hero #:sprite (circle 10 'solid 'red))]
                      #:headless         [headless #f]
                      #:planet           [planet-ent (plain-bg)]
                      #:villain-list     [e-list '()]
                      #:weapon-list      [weapon-list '()]
                      #:item-list        [item-list '()]
                      #:other-entities   [ent #f]
                      . custom-entities)

  (->i ()
       (#:headless       [headless boolean?]
        #:planet         [planet entity?]
        #:hero           [avatar (or/c entity? false?)]
        #:villain-list   [enemy-list   (listof (or/c #f entity? procedure?))]
        #:weapon-list    [weapon-list (listof (or/c entity? procedure?))]
        #:item-list      [item-list   (listof (or/c entity? procedure?))]
        #:other-entities [other-entities (or/c #f entity?)])
       #:rest           [rest (listof entity?)]
       [res () game?])

  @{The top-level function for the battle-arena-starwars language.
         Can be run with no parameters to get a basic, default game.}

  (battle-arena-game #:headless headless
                     #:bg planet-ent
                     #:avatar avatar
                     #:weapon-list weapon-list
                     #:enemy-list e-list
                     #:item-list item-list
                     #:other-entities  (cons ent custom-entities)))


