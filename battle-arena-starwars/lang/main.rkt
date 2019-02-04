#lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require ts-kata-util
         ;2htdp/image 
         "../assets.rkt"
         battle-arena)


(language-mappings battle-arena       battle-arena-starwars
                   [custom-avatar     custom-hero]
                   [custom-enemy      custom-villain]
                   ;[custom-weapon     custom-lightsaber]
                   ;[custom-weapon     custom-blaster]
                   [custom-background custom-planet] ;needed?
                   [sword             lightsaber]
                   ;[#:avatar          #:jedi]
                   [battle-arena-game starwars-game])

(provide lightsaber
         blaster-dart
         ;swinging-lightsaber-sprite
         ;blaster-dart-sprite
         double-lightsaber
         
         boba-fett-sprite
         darth-maul-sprite
         darth-vader-sprite
         han-solo-sprite
         luke-sprite
         obi-wan-sprite
         padawan-sprite
         princess-leia-sprite
         r2-d2-sprite
         stormtrooper-sprite
         twileck-jedi-sprite
         yoda-sprite        
         )

;; ---- copied from battle-arena
(define (draw-plain-bg)
  (foldl (λ (image base)
           (place-image image
                        (random 24) (random 18)
                        base))
         (rectangle 24 18 'solid (color 190 143 82))
         (list (ellipse (random 20 30) (random 20 30) 'solid (color 53 137 55 120))
               (ellipse (random 20 30) (random 20 30) 'solid (color 53 137 55 120))
               (ellipse (random 10 30) (random 10 30) 'solid (color 53 137 55 120))
               (ellipse (random 10 20) (random 10 20) 'solid (color 2 89 61 120))
               (ellipse (random 10 20) (random 10 20) 'solid (color 2 89 61 120))
               (ellipse (random 10 15) (random 10 15) 'solid (color 2 89 61 120))
               (ellipse (random 10 15) (random 10 15) 'solid (color 100 164 44 120))
               (ellipse (random 10 15) (random 10 15) 'solid (color 100 164 44 120))
               (ellipse (random 5 10) (random 5 10) 'solid (color 190 143 82 120))
               (ellipse (random 5 10) (random 5 10) 'solid (color 190 143 82 120))
               )))

(define (plain-bg #:bg-img     [bg (draw-plain-bg)]
                  #:scale      [scale 60] ; should scale to 3x 480 by 360 or 1440 by 1080
                  #:rows       [rows 3]
                  #:columns    [cols 3]
                  #:start-tile [t 0]
                  #:components [c #f]
                  . custom-components)
  (add-components (bg->backdrop-entity bg
                                       #:rows       rows
                                       #:columns    cols
                                       #:start-tile t
                                       #:scale scale)
                  (cons c custom-components)))
;; -----------------------------


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

(define/contract/doc (custom-villain #:amount-in-world (amount-in-world 1)
                                     #:sprite (sprite stormtrooper-sprite)
                                     #:ai (ai-level 'easy)
                                     #:health (health 100)
                                     #:shield (shield 100)
                                     #:weapon (weapon (custom-blaster #:color "red"))
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
         of @racket[starwars-game].}

  (custom-enemy #:amount-in-world amount-in-world
                #:sprite sprite
                #:ai ai-level
                #:health health
                #:shield shield
                #:weapon weapon
                #:death-particles death-particles
                #:components      (cons c custom-components)))


(define/contract/doc (custom-lightsaber #:name              [n "Lightsaber"]
                                        #:icon              [s (make-icon "LS" "green")]
                                        #:color             [c "green"]
                                        #:dart              [b (lightsaber #:color c)]
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

(define/contract/doc (custom-blaster #:name              [n "Blaster"]
                                     #:icon              [s (make-icon "B" "red")]
                                     #:color             [c "green"]
                                     #:dart              [b (blaster-dart #:color c)]
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
(define twileck-jedi-sprite
  (sheet->sprite twileck-jedi
                 #:rows 4
                 #:columns 3
                 #:row-number 3))

(define darth-maul-sprite
  (sheet->sprite darth-maul
                 #:rows 4
                 #:columns 3
                 #:row-number 3))

(define darth-vader-sprite
  (sheet->sprite darth-vader
                 #:rows 4
                 #:columns 3
                 #:row-number 3))

(define boba-fett-sprite
  (sheet->sprite boba-fett
                 #:rows 4
                 #:columns 3
                 #:row-number 3))

(define han-solo-sprite
  (sheet->sprite han-solo
                 #:rows 4
                 #:columns 3
                 #:row-number 3))

(define luke-sprite
  (sheet->sprite luke
                 #:rows 4
                 #:columns 3
                 #:row-number 3))

(define obi-wan-sprite
  (sheet->sprite obi-wan
                 #:rows 4
                 #:columns 3
                 #:row-number 3))

(define padawan-sprite
  (sheet->sprite padawan
                 #:rows 4
                 #:columns 3
                 #:row-number 3))

(define princess-leia-sprite
  (sheet->sprite princess-leia
                 #:rows 4
                 #:columns 3
                 #:row-number 3))

(define yoda-sprite
  (sheet->sprite yoda
                 #:rows 4
                 #:columns 3
                 #:row-number 3))

(define r2-d2-sprite
  (sheet->sprite r2-d2
                 #:rows 4
                 #:columns 3
                 #:row-number 3))

(define stormtrooper-sprite
  (sheet->sprite stormtrooper
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

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
         #:color     [c "red"]
         #:sprite    [s (double-lightsaber-sprite c)])
  
  ;@{This returns a sword skinned as a double lightsaber.}
  (sword #:sprite     s
         #:damage     50
         #:durability 20
         #:speed      0
         #:range      10))

(define (lightsaber
         #:color      [c "lightgreen"]
         #:sprite     [s (swinging-lightsaber-sprite c)]
         #:damage     [dmg 50]
         #:durability [dur 20]
         #:speed      [spd  0]
         #:range      [rng 10])
  
  ;@{This returns a sword skinned as a lightsaber.}
  (sword #:sprite     s
         #:damage     dmg
         #:durability dur
         #:speed      spd
         #:range      rng))

(define (blaster-dart
         #:color      [c "green"]
         #:damage     [dmg 10]
         #:durability [dur 20]
         #:speed      [spd  5]
         #:range      [rng 50])
  
  ;@{This returns a red dart.}
  (custom-dart #:sprite     (blaster-dart-sprite c)
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng))


;------------------- MAIN GAME

(define/contract/doc (starwars-game
                      #:hero             [avatar #f]
                      #:headless         [headless #f]
                      #:planet           [planet-ent (plain-bg)]
                      #:villain-list     [e-list (list (custom-villain))]
                      #:weapon-list      [weapon-list '()]
                      #:item-list        [item-list '()]
                      #:other-entities   [ent #f]
                      . custom-entities)

  (->i ()
       (#:headless       [headless boolean?]
        #:planet         [planet entity?]
        #:hero           [avatar (or/c entity? false?)]
        #:villain-list   [enemy-list   (listof (or/c entity? procedure?))]
        #:weapon-list    [weapon-list (listof (or/c entity? procedure?))]
        #:item-list      [item-list   (listof (or/c entity? procedure?))]
        #:other-entities [other-entities (or/c #f entity?)])
       #:rest           [rest (listof entity?)]
       [res () game?])

  @{The top-level function for the battle-arena language.
         Can be run with no parameters to get a basic, default game
         with nothing in it!}

  (battle-arena-game #:bg planet-ent
                     #:avatar avatar
                     #:weapon-list weapon-list
                     #:enemy-list e-list))


