#lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require ts-kata-util
         "../assets.rkt"
         battlearena
         game-engine-demos-common)


(language-mappings battlearena       battlearena-starwars
                   [basic-avatar     basic-rebel]
                   [basic-enemy      basic-imperial]
                   [basic-bg         basic-planet]

                   [repeater          blaster]
                   [sword             lightsaber]
                   [#:avatar          #:rebel]
                   [#:enemy-list      #:imperial-list]
                   [#:bg              #:planet]
                   [battlearena-game starwars-game])

(provide lightsaber-droid
         blaster-droid
         lightsaber-sprite
         (rename-out (swinging-lightsaber-sprite swinginglightsaber-sprite))
         (rename-out (double-lightsaber-sprite doublelightsaber-sprite))
         (rename-out (blaster-dart-sprite bolt-sprite))
         (rename-out 
           (custom-rebel basic-rebel)
           (custom-imperial basic-imperial)
           (custom-planet basic-planet)))

;; ----- REBEL

(define/contract/doc (custom-rebel #:sprite          (sprite (first (shuffle (list c3po-sprite
                                                                                   chewie-sprite
                                                                                   hansolo-sprite
                                                                                   lando-sprite
                                                                                   luke-sprite
                                                                                   obiwan-sprite
                                                                                   padawan-sprite
                                                                                   princessleia-sprite
                                                                                   r2d2-sprite
                                                                                   rebelpilot-sprite
                                                                                   twilek-sprite
                                                                                   yoda-sprite))))
                                  #:damage-processor [dp (divert-damage #:filter-out '(friendly-team passive)
                                                                        #:hit-sound HIT-SOUND)]
                                  #:position         [p   (posn 100 100)]
                                  #:speed            [spd 10]
                                  #:key-mode         [key-mode 'wasd]
                                  #:mouse-aim?       [mouse-aim? #t]
                                  #:item-slots       [w-slots 2]
                                  #:health           [health 100]
                                  #:max-health       [max-health 100]
                                  #:shield           [shield 100]
                                  #:max-shield       [max-shield 100]
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
        #:health     [health number?]
        #:max-health [max-health number?]
        #:shield     [shield number?]
        #:max-shield [max-shield number?]
        #:components [first-component component-or-system?]
        )
       #:rest (rest (listof component-or-system?))
       [returns entity?])
  
  @{Returns a custom rebel, which will be placed in to the world
         automatically if it is passed into @racket[starwars-game]
         via the @racket[#:rebel] parameter.}
  
  (custom-avatar #:sprite           sprite
                 #:damage-processor dp
                 #:position         p
                 #:speed            spd
                 #:key-mode         key-mode
                 #:mouse-aim?       mouse-aim?
                 #:item-slots       w-slots
                 #:health           health
                 #:max-health       max-health
                 #:shield           shield
                 #:max-shield       max-shield
                 #:components       (cons c custom-components)))

;; ----- IMPERIAL

(define/contract/doc (custom-imperial #:amount-in-world (amount-in-world 1)
                                     #:sprite (sprite (first (shuffle (list stormtrooper-sprite
                                                                            darthmaul-sprite
                                                                            bobafett-sprite
                                                                            darthvader-sprite))))
                                     #:ai (ai-level 'easy)
                                     #:health (health 100)
                                     #:shield (shield 100)
                                     #:weapon (weapon (blaster #:color "red"
                                                               #:fire-mode 'random))
                                     #:death-particles (death-particles (custom-particles))
                                     #:components (c #f)
                                     . custom-components
                                     )

  (->i () (#:amount-in-world [amount-in-world positive?]
           #:sprite [sprite (or/c sprite? (listof sprite?))]
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
         via the @racket[#:imperial-list] parameter.}

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
                                 #:icon              [i (make-icon "LS" "green")]
                                 #:color             [c "green"]
                                 #:sprite            [s (swinging-lightsaber-sprite c)]
                                 #:speed             [spd 0]
                                 #:damage            [dmg 25]
                                 #:durability        [dur 20]
                                 #:duration          [rng 10]
                                 #:fire-mode         [fm 'normal]
                                 #:fire-rate         [fr 3]
                                 #:fire-key          [key 'f]
                                 #:fire-sound        [fire-sound random-lightsaber-sound]
                                 #:mouse-fire-button [button 'left]
                                 #:point-to-mouse?   [ptm? #t]
                                 #:rapid-fire?       [rf? #t]
                                 #:rarity            [rarity 'common])
  (->i ()
       (#:name        [name string?]
        #:icon        [sprite (or/c sprite? (listof sprite?))]
        #:color       [color image-color?]
        #:sprite      [s (or/c sprite? (listof sprite?))]
        #:speed       [spd number?]
        #:damage      [dmg number?]
        #:durability  [dur number?]
        #:duration    [rng number?]
        #:fire-mode   [fire-mode fire-mode?]
        #:fire-rate   [fire-rate number?]
        #:fire-key    [fire-key symbol?]
        #:fire-sound  [fire-sound (or/c rsound? procedure? #f '())]
        #:mouse-fire-button [button (or/c 'left 'right)]
        #:point-to-mouse?   [ptm? boolean?]
        #:rapid-fire?       [rf? boolean?]
        #:rarity      [rarity rarity-level?])
       [result entity?])

  @{Returns a custom lightsaber, which will be placed in to the world
         automatically if it is passed into @racket[starwars-game]
         via the @racket[#:weapon-list] parameter.}
  
  (sword #:name              n
         #:sprite            s
         #:icon              i
         #:speed             spd
         #:damage            dmg
         #:durability        dur
         #:duration          rng
         #:fire-mode         fm
         #:fire-rate         fr
         #:fire-key          key
         #:fire-sound        fire-sound
         #:mouse-fire-button button
         #:point-to-mouse?   ptm?
         #:rapid-fire?       rf?
         #:rarity            rarity))

;; ----- BLASTER

(define/contract/doc (blaster #:name              [n "Blaster"]
                              #:icon              [i (make-icon "B" "red")]
                              #:color             [c "green"]
                              #:sprite            [s (blaster-dart-sprite c)]
                              #:damage            [dmg 10]
                              #:durability        [dur 20]
                              #:speed             [spd  5]
                              #:range             [rng 1000]
                              #:fire-mode         [fm 'normal]
                              #:fire-rate         [fr 3]
                              #:fire-key          [key 'f]
                              #:fire-sound        [fire-sound random-blaster-sound]
                              #:mouse-fire-button [button 'left]
                              #:point-to-mouse?   [ptm? #t]
                              #:rapid-fire?       [rf? #t]
                              #:rarity            [rarity 'common])
  (->i ()
       (#:name        [name string?]
        #:icon        [i (or/c sprite? (listof sprite?))]
        #:color       [color image-color?]
        #:sprite      [s (or/c sprite? (listof sprite?))]
        #:damage      [dmg number?]
        #:durability  [dur number?]
        #:speed       [spd number?]
        #:range       [rng number?]
        #:fire-mode   [fire-mode fire-mode?]
        #:fire-rate   [fire-rate number?]
        #:fire-key    [fire-key symbol?]
        #:fire-sound  [fire-sound (or/c rsound? procedure? #f '())]
        #:mouse-fire-button [button (or/c 'left 'right)]
        #:point-to-mouse?   [ptm? boolean?]
        #:rapid-fire?       [rf? boolean?]
        #:rarity      [rarity rarity-level?])
       [result entity?])
  
  @{Returns a custom blaster, which will be placed in to the world
         automatically if it is passed into @racket[starwars-game]
         via the @racket[#:weapon-list] parameter.}
  
  (repeater #:name              n
            #:icon              i
            #:sprite            s
            #:damage            dmg
            #:durability        dur
            #:speed             spd
            #:range             rng
            #:fire-mode         fm
            #:fire-rate         fr
            #:fire-key          key
            #:fire-sound        fire-sound
            #:mouse-fire-button button
            #:point-to-mouse?   ptm?
            #:rapid-fire?       rf?
            #:rarity            rarity))

;; ----- PLANET

(define/contract/doc (custom-planet #:image        [bg (change-img-hue (random 360) (draw-plain-bg))]
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

  @{Returns a custom planet, which will be used
         automatically if it is passed into @racket[starwars-game]
         via the @racket[#:planet] parameter.}
  
  (define bg-base-entity
    (if (> (image-width bg) 24)
        (if hd?
            (bg->backdrop-entity bg
                                 #:rows       rows
                                 #:columns    cols
                                 #:start-tile t)
            (bg->backdrop-entity (scale 0.25 bg)
                                 #:rows       rows
                                 #:columns    cols
                                 #:start-tile t
                                 #:scale 4))
        (bg->backdrop-entity bg
                             #:rows       rows
                             #:columns    cols
                             #:start-tile t
                             #:scale 60)))
  (add-components bg-base-entity
                  (cons c custom-components))
  )

;; ----- WEAPONS & DARTS

(define (lightsaber-sprite c)
  (beside (rectangle 8 4 "solid" "black")
          (rectangle 28 4 "solid" c)))

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

; ---- DOUBLE LIGHTSABER
(define/contract/doc (double-lightsaber
                      #:name              [n "Lightsaber"]
                      #:icon              [i (make-icon "DBL" "red")]
                      #:color             [c "red"]
                      #:sprite            [s (double-lightsaber-sprite c)]
                      #:damage            [dmg 50]
                      #:durability        [dur 20]
                      #:duration          [rng 10]
                      #:speed             [spd  0]
                      #:fire-mode         [fm 'normal]
                      #:fire-rate         [fr 3]
                      #:fire-key          [key 'f]
                      #:fire-sound        [fire-sound random-lightsaber-sound]
                      #:mouse-fire-button [button 'left]
                      #:point-to-mouse?   [ptm? #t]
                      #:rapid-fire?       [rf? #t]
                      #:rarity            [rarity 'common])
  (->i ()
       (#:name        [name string?]
        #:icon        [sprite (or/c sprite? (listof sprite?))]
        #:color       [color image-color?]
        #:sprite      [s (or/c sprite? (listof sprite?))]
        #:speed       [spd number?]
        #:damage      [dmg number?]
        #:durability  [dur number?]
        #:duration    [rng number?]
        #:fire-mode   [fire-mode fire-mode?]
        #:fire-rate   [fire-rate number?]
        #:fire-key    [fire-key symbol?]
        #:fire-sound  [fire-sound (or/c rsound? procedure? #f '())]
        #:mouse-fire-button [button (or/c 'left 'right)]
        #:point-to-mouse?   [ptm? boolean?]
        #:rapid-fire?       [rf? boolean?]
        #:rarity      [rarity rarity-level?])
       [result entity?])
  
@{Returns a custom double lightsaber, which will be placed in to the world
         automatically if it is passed into @racket[starwars-game]
         via the @racket[#:weapon-list] parameter.}
  
  (sword #:name              n
         #:sprite            s
         #:icon              i
         #:speed             spd
         #:damage            dmg
         #:durability        dur
         #:duration          rng
         #:fire-mode         fm
         #:fire-rate         fr
         #:fire-key          key
         #:fire-sound        fire-sound
         #:mouse-fire-button button
         #:point-to-mouse?   ptm?
         #:rapid-fire?       rf?
         #:rarity            rarity))

(define (blaster-dart
         #:color      [c "green"]
         #:sprite     [s (blaster-dart-sprite c)]
         #:damage     [dmg 10]
         #:durability [dur 20]
         #:speed      [spd  5]
         #:range      [rng 1000])

  (custom-dart #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng))

(define (lightsaber-droid #:name              [n "Lightsaber Droid"]
                          #:icon              [i (make-icon "LSD" 'aquamarine)]
                          #:color             [c "green"]
                          #:sprite            [s (swinging-lightsaber-sprite c)]
                          #:damage            [dmg 50]
                          #:durability        [dur 20]
                          #:fire-rate         [fr 0.5]
                          #:fire-sound        [fire-sound random-lightsaber-sound]
                          #:dart              [d (lightsaber-droid-dart #:color      c
                                                                        #:sprite     s
                                                                        #:damage     dmg
                                                                        #:durability dur
                                                                        #:fire-rate  fr)]
                          #:fire-mode         [fm 'normal]
                          #:fire-key          [key 'f]
                          #:mouse-fire-button [button 'left]
                          #:point-to-mouse?   [ptm? #t]
                          #:rapid-fire?       [rf? #f]
                          #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode 'normal ;hard coded into all droids
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define (lightsaber-droid-dart #:color      [c "green"]
                               #:sprite     [s (swinging-lightsaber-sprite c)]
                               #:damage     [dmg 50]
                               #:durability [dur 20]
                               #:fire-rate  [fire-rate 0.5])
  
  (builder-dart #:entity (droid #:weapon (lightsaber #:fire-rate fire-rate
                                                     #:color      c                       
                                                     #:damage     dmg
                                                     #:durability dur))))

(define (blaster-droid #:name              [n "Blaster Droid"]
                       #:icon              [i (make-icon "BLD" 'lime)]
                       #:color             [c "green"]
                       #:sprite            [s (blaster-dart-sprite c)]
                       #:damage            [dmg 10]
                       #:durability        [dur 20]
                       #:speed             [spd 5]
                       #:range             [rng 1000]
                       #:fire-rate         [fr 2]
                       #:fire-sound        [fire-sound random-blaster-sound]
                       #:fire-mode         [fm 'normal]
                       #:dart              [d (blaster-droid-dart #:color      c
                                                                  #:sprite     s
                                                                  #:damage     dmg
                                                                  #:durability dur
                                                                  #:speed      spd
                                                                  #:range      rng
                                                                  #:fire-rate  fr
                                                                  #:fire-mode  fm)] 
                       #:fire-key          [key 'f]
                       #:mouse-fire-button [button 'left]
                       #:point-to-mouse?   [ptm? #t]
                       #:rapid-fire?       [rf? #f]
                       #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode 'normal ;hard coded into all droids
                 #:fire-rate fr
                 #:fire-sound fire-sound
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define (blaster-droid-dart #:color      [c "green"]
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
  
  (define droid-top (crop-sprite c2po-sheet 4 4 2 2))

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
                      #:rebel             [avatar (custom-rebel #:sprite (circle 10 'solid 'red))]
                      #:headless         [headless #f]
                      #:planet           [planet-ent (plain-bg)]
                      #:imperial-list     [e-list '()]
                      #:weapon-list      [weapon-list '()]
                      #:item-list        [item-list '()]
                      #:score-prefix     [prefix "Imperials"]
                      #:enable-world-objects? [world-objects? #f]
                      #:instructions     [instructions #f]
                      #:other-entities   [ent #f]
                      . custom-entities)

  (->i ()
       (#:headless       [headless boolean?]
        #:planet         [planet entity?]
        #:rebel           [avatar (or/c entity? false?)]
        #:imperial-list   [enemy-list   (listof (or/c #f entity? procedure?))]
        #:weapon-list    [weapon-list (listof (or/c entity? procedure?))]
        #:item-list      [item-list   (listof (or/c entity? procedure?))]
        #:score-prefix   [prefix string?]
        #:enable-world-objects? [world-objects? boolean?]
        #:instructions   [instructions (or/c #f entity?)]
        #:other-entities [other-entities (or/c #f entity? (listof false?) (listof entity?))])
       #:rest            [rest (listof entity?)]
       [res () game?])

  @{The top-level function for the battlearena-starwars language.
         Can be run with no parameters to get a basic, default game.}

  (battlearena-game #:headless        headless
                    #:bg              planet-ent
                    #:avatar          avatar
                    #:weapon-list     weapon-list
                    #:enemy-list      e-list
                    #:item-list       item-list
                    #:score-prefix    prefix
                    #:enable-world-objects? world-objects?
                    #:instructions   instructions
                    #:other-entities  (filter identity (flatten (cons ent custom-entities)))))


