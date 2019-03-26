#lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require ts-kata-util
         "../assets.rkt"
         battlearena
         game-engine-demos-common)


(language-mappings battlearena        battlearena-avengers
                   [custom-avatar     custom-hero]
                   [custom-enemy      custom-villain]
                   [custom-weapon     custom-power]
                   [custom-bg         custom-planet]
                   [#:avatar          #:hero]
                   [#:enemy-list      #:villain-list]
                   [#:bg              #:planet]
                   [#:weapon-list     #:power-list]
                   [#:weapon          #:power]
                   [battlearena-game  avengers-game])

(provide energy
         energy-blast
         energy-blast-dart
         star-bit
         star-bit-dart
         energy-droid
         hammer
         hammer-dart
         hammer-sprite
         star-bit-sprite
         energy-blast-sprite
         magic-orb
         magic-orb-dart
         flame-sprite)

;; ----- HERO

(define/contract/doc (custom-hero #:sprite           (sprite (random-character-sprite))
                                  #:damage-processor [dp (divert-damage #:filter-out '(friendly-team passive)
                                                                        #:hit-sound HIT-SOUND)]
                                  #:position         [p   (posn 100 100)]
                                  #:speed            [spd 10]
                                  #:key-mode         [key-mode 'wasd]
                                  #:mouse-aim?       [mouse-aim? #t]
                                  #:item-slots       [w-slots 2]
                                  #:components       [c #f]
                                  . custom-components)
  (->i ()
       (#:sprite [sprite (or/c sprite? (listof sprite?))]
        #:damage-processor [damage-processor damage-processor?]
        #:position [position posn?]
        #:speed [speed number?]
        #:key-mode [key-mode (or/c 'wasd 'arrow-keys)]
        #:mouse-aim? [mouse-aim boolean?]
        #:item-slots [item-slots number?]
        #:components [first-component component-or-system?])
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

;; ----- VILLAIN

(define/contract/doc (custom-villain #:amount-in-world (amount-in-world 1)
                                     #:sprite (sprite wintersoldier-sprite)
                                     #:ai (ai-level 'easy)
                                     #:health (health 100)
                                     #:shield (shield 100)
                                     #:power (power (custom-power #:color 'red))
                                     #:death-particles (death-particles (custom-particles))
                                     #:components (c #f)
                                     . custom-components
                                     )

  (->i () (#:amount-in-world [amount-in-world positive?]
           #:sprite [sprite (or/c sprite? (listof sprite?))]
           #:ai [ai-level ai-level?]
           #:health [health positive?]
           #:shield [shield positive?]
           #:power [power entity?]
           #:death-particles [death-particles entity?]
           #:components [first-component component-or-system?])
       #:rest [more-components (listof component-or-system?)]
       [returns entity?])

    @{Returns a custom enemy, which will be placed in to the world
         automatically if it is passed into @racket[avengers-game]
         via the @racket[#:villain-list] parameter.}

  (custom-enemy #:amount-in-world amount-in-world
                #:sprite sprite
                #:ai ai-level
                #:health health
                #:shield shield
                #:weapon power
                #:death-particles death-particles
                #:components      (cons c custom-components)))

;; ----- POWER

(define/contract/doc (custom-power #:name              [n "Energy Blast"]
                                   #:sprite            [sprite  #f];HACK - REMOVE LINE AFTER BATTLEARENA CHANGES
                                   #:icon              [icon (make-icon "EB" "green")]
                                   #:color             [c "blue"]
                                   #:damage            [dmg 10]
                                   #:dart              [b (energy #:color c
                                                                  #:damage dmg)]
                                   #:fire-mode         [fm 'normal]
                                   #:fire-rate         [fr 3]
                                   #:fire-key          [key 'f]
                                   #:fire-sound        [fire-sound LASER-SOUND]
                                   #:mouse-fire-button [button 'left]
                                   #:point-to-mouse?   [ptm? #t]
                                   #:rapid-fire?       [rf? #t]
                                   #:rarity            [rarity 'common])
  (->i ()
       (#:name        [name string?]
        #:sprite      [sprite (or/c sprite? (listof sprite?) false?)]
        #:icon        [icon (or/c sprite? (listof sprite?))]
        #:color       [color image-color?]
        #:damage      [dmg number?]
        #:dart        [dart entity?]
        #:fire-mode   [fire-mode fire-mode?]
        #:fire-rate   [fire-rate number?]
        #:fire-key    [fire-key symbol?]
        #:fire-sound  [fire-sound (or/c rsound? #f '())]
        #:mouse-fire-button [button (or/c 'left 'right)]
        #:point-to-mouse?   [ptm? boolean?]
        #:rapid-fire?       [rf? boolean?]
        #:rarity      [rarity rarity-level?])
       [result entity?])
  
  @{Returns a custom power, which will be placed in to the world
         automatically if it is passed into @racket[avengers-game]
         via the @racket[#:power-list] parameter.}
  
  (custom-weapon #:name              n
                 #:sprite            (if (equal? sprite #f) ;GET RID OF THIS LATER
                                         icon
                                         sprite)
                 #:dart              b
                 #:fire-mode         fm
                 #:fire-rate         fr
                 #:fire-key          key
                 #:fire-sound        fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse?   ptm?
                 #:rapid-fire?       rf?
                 #:rarity            rarity))

;; ----- PLANET

(define/contract/doc (custom-planet #:img        [bg (change-img-hue (random 360) (draw-plain-bg))]
                                    #:rows       [rows 3]
                                    #:columns    [cols 3]
                                    #:start-tile [t 0]
                                    #:hd?        [hd? #f]  
                                    #:components [c #f]
                                    . custom-components)

  (->i ()
       (#:img [bg-img image?]
        #:rows   [rows number?]
        #:columns [columns number?]
        #:start-tile [start-tile number?]
        #:hd?        [high-def? boolean?]
        #:components [first-component component-or-system?])
       #:rest [more-components (listof component-or-system?)]
       [result entity?])


    @{Returns a custom planet, which will be used
         automatically if it is passed into @racket[avengers-game]
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

(define (star-bit-sprite [c 'white])
  (sheet->sprite (tint-img c (scale 0.5 energyball-sheet))
                 #:rows 1
                 #:columns 8
                 #:row-number 1
                 #:delay 5))

(define (energy-blast-sprite c)
  (define cc (name->color c))
  (define outer-layer (make-color (color-red cc) (color-green cc) (color-blue cc) 64))
  (define middle-layer (make-color (color-red cc) (color-green cc) (color-blue cc) 128))
  (define sheet (beside (overlay (circle 2 "solid" c)
                                 (circle 4 "solid" middle-layer)
                                 (circle 6 "solid" outer-layer))
                        (overlay (circle 2 "solid" outer-layer)
                                 (circle 4 "solid" c)
                                 (circle 6 "solid" middle-layer))
                        (overlay (circle 2 "solid" c)
                                 (circle 4 "solid" middle-layer)
                                 (circle 6 "solid" outer-layer))))
  (sheet->sprite sheet
                 #:rows 1
                 #:columns 3
                 #:row-number 1))

(define (hammer-sprite c)
  (beside
   (rectangle 8 4 "solid" c)
   (rectangle 8 12 "solid" "gray")))

(define (my-flame-sprite c)
  (overlay (circle 5 "solid" c)
           (circle 6 "solid" "orange")
           (circle 7 "solid" "red")))

(define (magic-orb-dart #:color             [c "yellow"]
                        #:sprite            [s   (my-flame-sprite c)]
                        #:damage            [dmg 5]
                        #:durability        [dur 20]
                        #:speed             [spd 10]
                        #:range             [rng 36])
  
  (custom-dart #:position   (posn 25 0)
               #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng
               #:components (on-start (set-size 0.5))
               (every-tick (do-many (scale-sprite 1.05)
                                    (change-direction-by 10)))))

(define (magic-orb #:color             [c "yellow"]
                   #:sprite            [s   (my-flame-sprite c)]
                   #:damage            [dmg 5]
                   #:durability        [dur 20]
                   #:speed             [spd 10]
                   #:range             [rng 36]
                   #:fire-mode         [fm 'normal]
                   #:fire-rate         [fr 3]
                   #:fire-key          [key 'f]
                   #:mouse-fire-button [button 'left]
                   #:point-to-mouse?   [ptm? #t]
                   #:rapid-fire?       [rf? #t]
                   #:rarity            [rarity 'common]
                   #:icon              [icon (make-icon "MO" "orange")]
                   #:dart              [dart (magic-orb-dart #:sprite     s
                                                             #:damage     dmg
                                                             #:durability dur
                                                             #:speed      spd
                                                             #:range      rng)])

  (custom-power #:name              "Magic Orb"
                #:icon              icon
                #:dart              dart
                #:fire-mode         fm
                #:fire-rate         fr
                #:fire-key          key
                #:mouse-fire-button button
                #:point-to-mouse?   ptm?
                #:rapid-fire?       rf?
                #:rarity            'common
                ))

(define (hammer-dart #:color             [c   'black]
                     #:sprite            [s   (hammer-sprite c)]
                     #:damage            [dmg 10]
                     #:durability        [dur 20]
                     #:speed             [spd 5]
                     #:range             [rng 40])
  (custom-dart #:position   (posn 20 0)
               #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng
               #:components (do-every 10 (random-direction 0 360))))

(define (hammer #:color             [c   'black]
                #:sprite            [s   (hammer-sprite c)]
                #:damage            [dmg 10]
                #:durability        [dur 20]
                #:speed             [spd 5]
                #:range             [rng 40]
                #:fire-mode         [fm 'normal]
                #:fire-rate         [fr 3]
                #:fire-key          [key 'f]
                #:mouse-fire-button [button 'left]
                #:point-to-mouse?   [ptm? #t]
                #:rapid-fire?       [rf? #t]
                #:rarity            [rarity 'common]
                #:icon              [icon (make-icon "H" "gray")]
                #:dart              [dart (hammer-dart #:sprite     s
                                                       #:damage     dmg
                                                       #:durability dur
                                                       #:speed      spd
                                                       #:range      rng)])

  (custom-power #:name              "Hammer"
                #:icon              icon
                #:dart              dart
                #:fire-mode         fm
                #:fire-rate         fr
                #:fire-key          key
                #:mouse-fire-button button
                #:point-to-mouse?   ptm?
                #:rapid-fire?       rf?
                #:rarity            'common
                ))

(define (star-bit-dart #:color             [c "green"]
                       #:sprite            [s (star-bit-sprite c)]
                       #:damage            [dmg 5]
                       #:durability        [dur 10]
                       #:speed             [spd 15]
                       #:range             [rng 50])
  (custom-dart #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng))

(define (star-bit
         #:color             [c "green"]
         #:sprite            [s (star-bit-sprite c)]
         #:damage            [dmg 5]
         #:durability        [dur 10]
         #:speed             [spd 15]
         #:range             [rng 50]
         #:fire-mode         [fm 'normal]
         #:fire-rate         [fr 3]
         #:fire-key          [key 'f]
         #:mouse-fire-button [button 'left]
         #:point-to-mouse?   [ptm? #t]
         #:rapid-fire?       [rf? #t]
         #:rarity            [rarity 'common]
         #:icon              [icon (make-icon "SB" "blue")]
         #:dart              [dart (star-bit-dart #:sprite     s
                                                  #:damage     dmg
                                                  #:durability dur
                                                  #:speed      spd
                                                  #:range      rng)])

  (custom-power #:name              "Star Bit"
                #:icon              icon
                #:dart              dart
                #:fire-mode         fm
                #:fire-rate         fr
                #:fire-key          key
                #:mouse-fire-button button
                #:point-to-mouse?   ptm?
                #:rapid-fire?       rf?
                #:rarity            'common
                ))

(define (energy-blast-dart  #:color             [c "green"]
                            #:sprite            [s (energy-blast-sprite c)]
                            #:damage            [dmg 10]
                            #:durability        [dur 10]
                            #:speed             [spd 5]
                            #:range             [rng 30])
  (custom-dart #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng
               #:components (on-start (set-size 0.5))
               (every-tick (scale-sprite 1.1))))

(define (energy-blast
         #:color             [c "green"]
         #:sprite            [s (energy-blast-sprite c)]
         #:damage            [dmg 10]
         #:durability        [dur 10]
         #:speed             [spd 5]
         #:range             [rng 30]
         #:fire-mode         [fm 'normal]
         #:fire-rate         [fr 3]
         #:fire-key          [key 'f]
         #:mouse-fire-button [button 'left]
         #:point-to-mouse?   [ptm? #t]
         #:rapid-fire?       [rf? #t]
         #:rarity            [rarity 'common]
         #:icon              [icon (make-icon "EB" "green")]
         #:dart              [dart (energy-blast-dart #:sprite     s
                                                      #:damage     dmg
                                                      #:durability dur
                                                      #:speed      spd
                                                      #:range      rng)])

  (custom-power #:name              "Energy Blast"
                #:icon              icon
                #:dart              dart
                #:fire-mode         fm
                #:fire-rate         fr
                #:fire-key          key
                #:mouse-fire-button button
                #:point-to-mouse?   ptm?
                #:rapid-fire?       rf?
                #:rarity            'common
                ))

(define (energy
         #:color      [c "green"]
         #:sprite     [s (energy-blast-sprite c)]
         #:damage     [dmg 10]
         #:durability [dur 10]
         #:speed      [spd 5]
         #:range      [rng 30])

  (custom-dart #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng
               #:components (on-start (set-size 0.5))
               (every-tick (scale-sprite 1.1))))

(define (energy-droid #:color      [c "green"]
                      #:sprite     [s (energy-blast-sprite c)]
                      #:damage     [dmg 10]
                      #:durability [dur 10]
                      #:speed      [spd 10]
                      #:range      [rng 30]
                      #:fire-rate  [fire-rate 1]
                      #:fire-mode  [fire-mode 'normal])
  
  (builder-dart #:entity (droid #:weapon (custom-power #:fire-rate fire-rate
                                                       #:fire-mode fire-mode
                                                       #:dart (energy #:color      c
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
  
  (define droid-top (crop-sprite ironpatriot-sheet 4 4 2 2))

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

(define/contract/doc (avengers-game
                      #:hero             [avatar (custom-hero #:sprite (circle 10 'solid 'red))]
                      #:headless         [headless #f]
                      #:planet           [planet-ent (plain-bg)]
                      #:villain-list     [e-list '()]
                      #:power-list       [power-list '()]
                      #:item-list        [item-list '()]
                      #:score-prefix     [prefix "Villains"]
                      #:enable-world-objects? [world-objects? #f]
                      #:other-entities   [ent #f]
                      . custom-entities)

  (->i ()
       (#:headless       [headless boolean?]
        #:planet         [planet entity?]
        #:hero           [avatar (or/c entity? false?)]
        #:villain-list   [enemy-list   (listof (or/c entity? procedure?))]
        #:power-list     [power-list (listof (or/c entity? procedure?))]
        #:item-list      [item-list   (listof (or/c entity? procedure?))]
        #:score-prefix   [prefix string?]
        #:enable-world-objects? [world-objects? boolean?]
        #:other-entities [other-entities (or/c #f entity? (listof false?) (listof entity?))])
       #:rest           [rest (listof entity?)]
       [res () game?])

  @{The top-level function for the battlearena-avengers language.
         Can be run with no parameters to get a basic, default game.}

  (battlearena-game #:headless       headless
                    #:bg             planet-ent
                    #:avatar         avatar
                    #:weapon-list    power-list
                    #:enemy-list     e-list
                    #:item-list      item-list
                    #:score-prefix   prefix
                    #:enable-world-objects? world-objects?
                    #:other-entities (filter identity (flatten (cons ent custom-entities)))))


