#lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require ts-kata-util
         ;2htdp/image ;not needed
         "../assets.rkt"
         battle-arena
         )

(language-mappings battle-arena       battle-arena-avengers
                   [custom-avatar     custom-hero]
                   [custom-enemy      custom-villain]
                   [custom-weapon     custom-power]
                   [custom-background custom-planet]
                   [battle-arena-game avengers-game])

(provide  energy-dart

          blackwidow-sprite
          gamora-sprite
          ironman-sprite
          mandarin-sprite
          redskull-sprite
          starlord-sprite
          wintersoldier-sprite
          captainamerica-sprite
          hawkeye-sprite
          loki-sprite
          nebula-sprite
          rocket-sprite
          thor-sprite
          drax-sprite
          hulk-sprite
          malekith-sprite
          nickfury-sprite
          ronan-sprite
          tonystark-sprite
          ironpatriot-sprite
          )

;; ----- HERO

(define/contract/doc (custom-hero #:sprite           (sprite (circle 10 'solid 'red))
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
  
  @{This returns an avatar.}
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
                                     #:weapon (weapon (custom-power #:color "red"))
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

  @{Creates a custom enemy that can be used in the enemy list
         of @racket[avengers-game].}

  (custom-enemy #:amount-in-world amount-in-world
                #:sprite sprite
                #:ai ai-level
                #:health health
                #:shield shield
                #:weapon weapon
                #:death-particles death-particles
                #:components      (cons c custom-components)))

;; ----- POWER

(define/contract/doc (custom-power #:name              [n "Energy Blast"]
                                   #:icon              [s (make-icon "EB" "green")]
                                   #:color             [c "blue"]
                                   #:dart              [b (energy-dart #:color c)]
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
        #:color       [color string?]
        #:dart        [dart entity?]
        #:fire-mode   [fire-mode fire-mode?]
        #:fire-rate   [fire-rate number?]
        #:fire-key    [fire-key symbol?]
        #:mouse-fire-button [button (or/c 'left 'right)]
        #:point-to-mouse?   [ptm? boolean?]
        #:rapid-fire?       [rf? boolean?]
        #:rarity      [rarity rarity-level?])
       [result entity?])
  
  @{This returns a custom weapon.}
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

  @{Returns a custom background}
  
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


; ==== CUSTOM ASSETS ====

(define blackwidow-sprite
  (sheet->sprite blackwidow
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define gamora-sprite
  (sheet->sprite gamora
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define ironman-sprite
  (sheet->sprite ironman
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define mandarin-sprite
  (sheet->sprite mandarin
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define redskull-sprite
  (sheet->sprite redskull
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define starlord-sprite
  (sheet->sprite starlord
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define wintersoldier-sprite
  (sheet->sprite wintersoldier
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define captainamerica-sprite
  (sheet->sprite captainamerica
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define hawkeye-sprite
  (sheet->sprite hawkeye
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define loki-sprite
  (sheet->sprite loki
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define nebula-sprite
  (sheet->sprite nebula
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define rocket-sprite
  (sheet->sprite rocketracoon
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define thor-sprite
  (sheet->sprite thor
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define drax-sprite
  (sheet->sprite drax
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define hulk-sprite
  (sheet->sprite hulk
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define malekith-sprite
  (sheet->sprite malekith
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define nickfury-sprite
  (sheet->sprite nickfury
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define ronan-sprite
  (sheet->sprite ronan
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define tonystark-sprite
  (sheet->sprite tonystark
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define ironpatriot-sprite
  (sheet->sprite ironpatriot
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

;; ----- WEAPONS & DARTS

(define (energy-dart-sprite c)
  (define cc (name->color c))
  (define outer-layer (make-color (color-red cc) (color-green cc) (color-blue cc) 64))
  (define middle-layer (make-color (color-red cc) (color-green cc) (color-blue cc) 128))
  (beside (overlay (circle 2 "solid" c)
                   (circle 4 "solid" middle-layer)
                   (circle 6 "solid" outer-layer))
          (overlay (circle 2 "solid" outer-layer)
                   (circle 4 "solid" c)
                   (circle 6 "solid" middle-layer))
          (overlay (circle 2 "solid" c)
                   (circle 4 "solid" middle-layer)
                   (circle 6 "solid" outer-layer))
          ))

(define (energy-dart
         #:color      [c "green"]
         #:sprite     [s (sheet->sprite (energy-dart-sprite c)
                                        #:rows 1
                                        #:columns 3
                                        #:row-number 1)]
         #:damage     [dmg 10]
         #:durability [dur 20]
         #:speed      [spd  5]
         #:range      [rng 50])

  (custom-dart #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng))

(define (blaster-droid #:color      [c "green"]
                       #:sprite     [s (energy-dart-sprite c)]
                       #:damage     [dmg 10]
                       #:durability [dur 20]
                       #:speed      [spd 5]
                       #:range      [rng 50]
                       #:fire-rate  [fire-rate 2]
                       #:fire-mode  [fire-mode 'normal])
  
  (builder-dart #:entity (droid #:weapon (custom-power #:fire-rate fire-rate
                                                         #:fire-mode fire-mode
                                                         #:dart (energy-dart #:color      c
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
  
  (define droid-top (crop-sprite ironpatriot 4 4 2 2))

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
                      #:hero             [avatar (custom-hero)]
                      #:headless         [headless #f]
                      #:planet           [planet-ent (plain-bg)]
                      #:villain-list     [e-list (list (custom-villain))]
                      #:power-list       [power-list '()]
                      #:item-list        [item-list '()]
                      #:other-entities   [ent #f]
                      . custom-entities)

  (->i ()
       (#:headless       [headless boolean?]
        #:planet         [planet entity?]
        #:hero           [avatar (or/c entity? false?)]
        #:villain-list   [enemy-list   (listof (or/c entity? procedure?))]
        #:power-list    [power-list (listof (or/c entity? procedure?))]
        #:item-list      [item-list   (listof (or/c entity? procedure?))]
        #:other-entities [other-entities (or/c #f entity?)])
       #:rest           [rest (listof entity?)]
       [res () game?])

  @{The top-level function for the battle-arena language.
         Can be run with no parameters to get a basic, default game
         with nothing in it!}

  (battle-arena-game #:headless headless
                     #:bg planet-ent
                     #:avatar avatar
                     #:weapon-list power-list
                     #:enemy-list e-list
                     #:item-list item-list
                     #:other-entities  (cons ent custom-entities)))


