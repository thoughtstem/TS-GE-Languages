#lang at-exp racket


(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require (except-in game-engine
                    change-health-by)
         game-engine-demos-common)


(require ts-kata-util
         (only-in racket/draw make-font)
         "../assets.rkt")

;Instead of using provide,
;  use define/contract/doc on your functions.
;This will provide it automatically.
;  And it will also document it automatically for you.
;  If your change the contract, it will automatically change
;  the docs. 
(provide plain-bg-entity
         (rename-out (spear-sprite SPEAR-IMG))
         ice-sprite
         spear
         sword
         fire-magic
         ice-magic
         ring-of-fire
         ring-of-ice
         ring-of-blades
         paint-thrower
         sword-magic
         
         spear-dart
         sword-dart
         paint-dart
         flying-dagger-dart
         ring-of-fire-dart

         move-in-ring

         STUDENT-IMAGE-HERE

         builder-dart
         wall
         lava

         tower

         force-field
         lock-to-grid
         round-nearest-posn
         
         spear-tower-builder
         spike-mine-builder
         lava-builder

         rocket-tower-builder
         repeater-tower-builder
         dagger-tower-builder

         rocket
         rocket-sprite

         spike-mine-sprite

         fire-mode?    
         rarity-level?
         ai-level?

         draw-plain-bg
         plain-bg

         (rename-out (battlearena-game battle-arena-game))
         )

(define (force-field [width 80]
                     [height 120]
                     #:allow-friendly-dart? [afd? #f]
                     #:duration [delay 500])

  (define L-ELLIPSE (overlay (ellipse width height 'outline (pen (color 255 255 255 100) 2 'solid "round" "bevel"))
                             (ellipse width height 'outline (pen (color 0 255 255 100) 4 'solid "round" "bevel"))
                             (ellipse width height 'outline (pen (color 0 255 255 100) 8 'solid "round" "bevel"))
                             (ellipse (+ width 8) (+ height 8) 'solid  'transparent)))
  (define R-ELLIPSE (overlay (ellipse width height 'outline (pen (color 255 255 255 180) 2 'solid "round" "bevel"))
                             (ellipse width height 'outline (pen (color 0 255 255 100) 6 'solid "round" "bevel"))
                             (ellipse width height 'outline (pen (color 0 255 255 100) 8 'solid "round" "bevel"))
                             (ellipse (+ width 8) (+ height 8) 'solid  'transparent)))
  (define LR-COLLIDER (rectangle 10 height 'solid 'transparent))
  (define TB-COLLIDER (rectangle width 10 'solid 'transparent))
  
  (precompile! L-ELLIPSE
               R-ELLIPSE
               LR-COLLIDER
               TB-COLLIDER)
  
  (define (shield-collider-left)
    (sprite->entity LR-COLLIDER
                    #:name       "Collider Left"
                    #:position   (posn (- (/ width 2)) 0)
                    #:components (physical-collider)
                    (damager 1000 (if afd?
                                      (list 'passive 'friendly-team)
                                      (list 'passive)))
                    (lock-to "player" #:offset (posn (- (/ width 2)) 0))
                    (after-time delay die)))

  (define (shield-collider-right)
    (sprite->entity LR-COLLIDER
                    #:name "Collider Right"
                    #:position (posn (/ width 2) 0)
                    #:components (physical-collider)
                    (damager 1000 (if afd?
                                      (list 'passive 'friendly-team)
                                      (list 'passive)))
                    (lock-to "player" #:offset (posn (/ width 2) 0))
                    (after-time delay die)))

  (define (shield-collider-top)
    (sprite->entity TB-COLLIDER
                    #:name "Collider Top"
                    #:position (posn 0 (- (/ height 2)))
                    #:components (physical-collider)
                    (damager 1000 (if afd?
                                      (list 'passive 'friendly-team)
                                      (list 'passive)))
                    (lock-to "player" #:offset (posn 0 (- (/ height 2))))
                    (after-time delay die)))

  (define (shield-collider-bottom)
    (sprite->entity TB-COLLIDER
                    #:name "Collider Bottom"
                    #:position (posn 0 (/ height 2))
                    #:components (physical-collider)
                    (damager 1000 (if afd?
                                      (list 'passive 'friendly-team)
                                      (list 'passive)))
                    (lock-to "player" #:offset (posn 0 (/ height 2)))
                    (after-time delay die)))
  
  (sprite->entity (sheet->sprite (beside L-ELLIPSE R-ELLIPSE)
                                 #:columns 2
                                 #:delay 5)
                  #:name "Force Field"
                  #:position (posn 0 0)
                  #:components (lock-to "player")
                  (after-time delay die)
                  (spawn-once (shield-collider-left))
                  (spawn-once (shield-collider-right))
                  (spawn-once (shield-collider-top))
                  (spawn-once (shield-collider-bottom))))


(define rarity-level?
  (or/c 'common 'uncommon 'rare 'epic 'legendary))

(define fire-mode?    (or/c 'normal 'random 'spread 'homing))


(define STUDENT-IMAGE-HERE
  (text "Student Image Here" 30 'blue))

(define (plain-bg-entity)
  (bg->backdrop-entity (rectangle 48 36 ;Can even be smaller...
                                  'solid 'darkgreen) 
                       #:scale 30))


(define (wander-but-defend #:weapon (weapon (custom-weapon))
                           #:range (range 150)
                           #:wander-speed (wspeed 1)
                           #:ticks-between-shots (ticks-between-shots 50))
  
  (define wander (apply state 'wander (wander-mode-components wspeed)))
  (define stand  (apply state 'stand (stand-and-shoot "player" weapon
                                                      #:ticks-between-shots ticks-between-shots)))

  (define wander->stand
    (transition #:rule (near? "player" range)
                wander stand))

  (define stand->wander
    (transition #:rule (not/r (near? "player" range))
                stand wander))
  
  (define ai-machine
    (state-machine wander
                   (list wander stand)
                   (list wander->stand stand->wander)))

  ai-machine)

(define (wander-mode-components spd)
  (list 
   (every-tick (move))
   (speed spd)
   (do-every 50 (random-direction 0 360))
   (on-edge 'left   (set-direction 0))
   (on-edge 'right  (set-direction 180))
   (on-edge 'top    (set-direction 90))
   (on-edge 'bottom (set-direction 270))))

(define (stand-and-shoot target w #:ticks-between-shots (ticks-between-shots 50))
  (list (speed 0)
        (use-weapon-against-player w #:ticks-between-shots ticks-between-shots)
        (every-tick (point-to target))))


(define (get-ai-from-level l weapon)
  (match l
    ['easy   (wander-but-defend #:weapon weapon
                                #:range 100
                                #:ticks-between-shots 50
                                #:wander-speed 1)]
    ['medium (wander-but-defend #:weapon weapon
                                #:range 150
                                #:ticks-between-shots 25
                                #:wander-speed 2)]
    ['hard   (wander-but-defend #:weapon weapon
                                #:range 200
                                #:ticks-between-shots 10
                                #:wander-speed 3)]))


(define (ai-level? v)
  (or/c 'easy 'medium 'hard))



(define/contract/doc (custom-enemy #:amount-in-world (amount-in-world 1)
                                   #:sprite (s (row->sprite (random-character-row) #:delay 4))
                                   #:ai (ai-level 'easy)
                                   #:health (health 100)
                                   #:shield (shield 100)
                                   #:weapon (weapon (custom-weapon))
                                   #:death-particles (particles (custom-particles))
                                   #:components (c #f)
                                   . custom-components
                                   )

  (->i () (#:amount-in-world [amount-in-world positive?]
           #:sprite [sprite sprite?]
           #:ai [ai ai-level?]
           #:health [health positive?]
           #:shield [shield positive?]
           #:weapon [weapon entity?]
           #:death-particles [death-particles entity?]
           #:components [first-component (or/c component-or-system? false? (listof false?))])
       #:rest [more-components (listof component-or-system?)]
       [returns entity?])

  @{Returns a custom enemy, which will be placed in to the world
         automatically if it is passed into @racket[battlearena-game]
         via the @racket[#:enemy-list] parameter.}

  
 
  ;Makes sure that we can run (custom-enemy) through (entity-cloner ...)
  ;  Works because combatant ids get assigned at runtime.
  ;(Otherwise, they'd all end up with the same combatant id, and a shared healthbar)
  (define (become-combatant g e)

    (define c (~> e
                  (combatant
                   #:stats (default-health+shields-stats health shield)
                   #:damage-processor (divert-damage #:filter-out '(passive enemy-team))
                             _)
                  ))
 
    c)
  
  (define death-broadcast
    (sprite->entity empty-image
                    #:name "Enemy Death Broadcast"
                    #:position (posn 0 0)
                    #:components (on-start die)
                                 #;(counter 0)
                                 #;(every-tick (do-many (change-counter-by 1)
                                                      (λ(g e)
                                                        (displayln (~a "I'M ALIVE: " (get-counter e)))
                                                        e)))
                    ))
  
  (define (die-if-health-is-0)
    (on-rule (λ(g e)
               (define h (get-storage-data "health-stat" e))
               (and h (<= h 0)))
             (do-many
              (spawn-on-current-tile particles)
              (spawn death-broadcast)
              (λ(g e)
                (add-component e (after-time 2 die)))
              )))

  
  (custom-npc #:name "Enemy"
              #:sprite s
              #:position (posn 0 0)
              #:mode #f
              ;#:components 

              ;What is making these guys slow???
              (die-if-health-is-0)
              (damager 10 (list 'passive 'enemy-team))
              (hidden)
              ;(active-on-bg 0) ;Don't leave this in
              (on-start (do-many (respawn 'anywhere)
                                 (active-on-random)
                                 
                                 show
                                 become-combatant
                                 ))

              ;Need to face player when attacking...

              (storage "amount-in-world" amount-in-world)

              (enemy-ai (get-ai-from-level ai-level (get-storage-data "Weapon" weapon)))
              ;(enemy-ai (get-ai-from-level ai-level weapon))
              (cons c custom-components)
              ))


(define (custom-npc #:sprite     [s (row->sprite (random-character-row) #:delay 4)]
                    #:position   [p (posn 0 0)]
                    #:name       [name (first (shuffle (list "Adrian" "Alex" "Riley"
                                                             "Sydney" "Charlie" "Andy")))]
                    #:tile       [tile 0]
                    #:mode       [mode 'wander]
                    #:game-width [GAME-WIDTH 480]
                    #:speed      [spd 2]
                    #:target     [target "player"]
                    #:sound      [sound #t]
                    #:scale      [scale 1]
                    #:components [c #f] . custom-components )
  

  (define sprite (if (image? s)
                     (new-sprite s)
                     s))

  (sprite->entity sprite
                  #:name name
                  #:position p
                  #:components
                  (active-on-bg tile)
                  (speed spd)
                  (direction 0)
                  (rotation-style 'left-right)
                  (cons c custom-components)
                  ))



; ===== GAME DEFINITIONS ====


(define (instructions-entity #:move-keys  [move-keys "ARROW KEYS"]
                             #:mouse-aim? [mouse-aim? #f]
                             #:shoot-key  [shoot-key "F"])

  (define (instruction->sprite text offset)
    (new-sprite text #:y-offset offset #:color 'yellow))

  (define i-list (filter identity (list (~a move-keys " to move")
                                        (if mouse-aim?
                                            "MOVE MOUSE to aim"
                                            #f)
                                        ;(~a shoot-key " to shoot")
                                        "LEFT-CLICK to shoot"
                                        "NUM KEYS to select weapon"
                                        "SPACE to interact"
                                        "ENTER to close dialogs"
                                        "I to open these instructions"
                                        "Z to pick up items"
                                        "X to drop items")))
  (define i-length (length i-list))
  
  (define bg (new-sprite (rectangle 1 1 'solid (make-color 0 0 0 100))))
  
  (define i
    (sprite->entity (~> bg
                        (set-x-scale 340 _)             ;260
                        (set-y-scale (* 26 i-length) _) ;150
                        (set-y-offset 0 _))             ;60
                    #:position   (posn 0 0) ;(posn (/ (WIDTH) 2) 50)
                    #:name       "instructions"
                    #:components (layer "ui")
                                 (hidden)
                                 (on-start (do-many (go-to-pos 'center)
                                                    show))
                                 (on-key 'enter die)
                                 (on-key 'space die)
                                 (on-key "i" die)))

  (define last-y-pos (* 20 i-length))

  (add-components i (map instruction->sprite i-list (range (- (/ last-y-pos 2)) (add1 (/ last-y-pos 2)) (/ last-y-pos (sub1 i-length))))
                  ))

; === WON AND LOST RULES ===
(define (won? g e)
  #f)

(define (kill-player-v2)
  (lambda (g e1 e2)
    (define dead-player-image (rotate -90 (pick-frame-original (get-component e2 animated-sprite?) 0)))
    (if (lost? g e2)
        ((do-many remove-on-key
                  (stop-animation)
                  (change-sprite (new-sprite dead-player-image))) g e2)
        e2)))

(define (lost? g e)
  (define player (get-entity "player" g))
  (define health (get-stat "health" player))
  (<= health 0))

(define (tops? e)
  (and ((has-component? layer?) e)
       (eq? (get-layer e) "tops")))

(define (bg? e)
  (eq? (get-name e) "bg"))

(define (backpack-has-armor? g e)
  (define items (get-items (get-entity "player" g)))
  (define entity-list (map item-entity items))
  (ormap (λ (e)(get-storage "Armor" e)) entity-list))

(define (nearest-item-is-armor? g e)
  (define all-es (game-entities g))
  
  (define player (entity-with-name "player" g))

  (define (ui? e)
    (and ((has-component? layer?) e)
         (eq? (get-layer e) "ui")))

  (define (not-ui? e)
    (not (ui? e)))
  
  (define all-but-me-and-player
    (~> all-es
        (remove player _ entity-eq?)
        (remove e      _ entity-eq?)
        (filter (and/c (has-component? on-key?)
                       not-ui?
                       (not/c tops?)
                       (not/c bg?)) _ )))

  (define (closer-to-player? e1 e2)
    (< (distance-between (get-posn e1) (get-posn player))
       (distance-between (get-posn e2) (get-posn player))))

  (define sorted-list (sort all-but-me-and-player
                            closer-to-player?))

  (displayln (~a "NEAREST ENTITY TO PLAYER: " (if (empty? sorted-list)
                                                  "NONE"
                                                  (get-name (first sorted-list)))))
  
  (and (not (empty? sorted-list))
       (get-storage "Armor" (first sorted-list))))




(define/contract/doc (custom-armor        #:name          [n "Armor"]
                                          #:sprite        [s chest-sprite]
                                          #:protects-from [pf "Bullet"]
                                          #:change-damage [cd identity]
                                          #:rarity      [rarity 'common])
  (->i ()
       ( #:name          [name string?]
         #:sprite        [sprite sprite?]
         #:protects-from [protects-from string?]
         #:change-damage [change-damage procedure?]
         #:rarity        [rarity rarity-level?])
       [returns entity?])

  @{Returns a custom armor, which will be placed in to the world
         automatically if it is passed into @racket[battlearena-game]
         via the @racket[#:item-list] parameter.}

  
  (define updated-name (cond [(eq? rarity 'rare)      (~a "Rare " n)]
                             [(eq? rarity 'epic)      (~a "Epic " n)]
                             [(eq? rarity 'legendary) (~a "Legendary " n)]
                             [else n]))

  (define damage-processor (conditional-damage-processor #:rule (damager-has-tag? (string->symbol pf))
                                                         #:processor (divert-damage #:first-stat-protection cd
                                                                                    #:filter-out '(friendly-team passive))
                                                         #:default-processor (divert-damage #:filter-out '(friendly-team passive))))
  (sprite->entity s
                  #:name updated-name
                  #:position    (posn 0 0)
                  #:components  (active-on-bg 0)

                                (physical-collider)
                                (storage "Armor" damage-processor)
                                (storage "Rarity" rarity)

                                (static)
                                (hidden)
                                (on-start (do-many (respawn 'anywhere)
                                                   (active-on-random)
                                                   show))
                                (storable)))



(define/contract/doc (custom-weapon #:name              [n "Repeater"]
                                    #:sprite            [s chest-sprite]
                                    #:dart-sprite       [ds (rectangle 10 2 "solid" "green")]
                                    #:speed             [spd 10]
                                    #:damage            [dmg 10]
                                    #:range             [rng 1000]
                                    #:dart              [b (custom-dart #:sprite ds
                                                                        #:speed spd
                                                                        #:damage dmg
                                                                        #:range rng)]
                                    #:fire-mode         [fm 'normal]
                                    #:fire-rate         [fr 3]
                                    #:fire-key          [key 'f]
                                    #:mouse-fire-button [button 'left]
                                    #:point-to-mouse?   [ptm? #t]
                                    #:rapid-fire?       [rf? #t]
                                    #:rarity            [rarity 'common])
  (->i ()
       (#:name        [name string?]
        #:sprite      [sprite sprite?]
        #:dart-sprite [dart-sprite sprite?]
        #:speed       [speed  number?]
        #:damage      [damage number?]
        #:range       [range  number?]
        #:dart        [dart entity?]
        #:fire-mode   [fire-mode fire-mode?]
        #:fire-rate   [fire-rate number?]
        #:fire-key    [fire-key symbol?]
        #:mouse-fire-button [button (or/c 'left 'right)]
        #:point-to-mouse?   [ptm? boolean?]
        #:rapid-fire?       [rf? boolean?]
        #:rarity      [rarity rarity-level?])
       [result entity?])

  @{Returns a custom weapon, which will be placed in to the world
         automatically if it is passed into @racket[battlearena-game]
         via the @racket[#:weapon-list] parameter.}

  (define updated-name (cond [(eq? rarity 'rare)      (~a "Rare " n)]
                             [(eq? rarity 'epic)      (~a "Epic " n)]
                             [(eq? rarity 'legendary) (~a "Legendary " n)]
                             [else n]))

  (define (add-tag-to-entity e tag)
    (define damager (get-component e damager?))
    (update-entity e damager? (add-damager-tag damager tag)))

  (define weapon-component (custom-weapon-system #:dart (add-tag-to-entity b (string->symbol updated-name))
                                                 #:fire-mode fm
                                                 #:fire-rate fr
                                                 #:fire-key  key
                                                 #:mouse-fire-button button
                                                 #:point-to-mouse? ptm?
                                                 #:rapid-fire? rf?
                                                 #:rule (and/r (weapon-is? updated-name)
                                                               (in-backpack? updated-name))))
  (sprite->entity s
                  #:name updated-name
                  #:position    (posn 0 0)
                  #:components  (active-on-bg 0)

                                (physical-collider)
                                (storage "Weapon" weapon-component)
                                (storage "Rarity" rarity)

                                (static)
                                (hidden)
                                (on-start (do-many (respawn 'anywhere)
                                                   (active-on-random)
                                                   show))
                                (storable)))

(define/contract/doc (custom-item #:name         [n "Item"]
                                  #:sprite       [s chest-sprite]
                                  #:on-use       [f #f]
                                  #:rarity       [r 'common]
                                  #:respawn?     [respawn? #t]
                                  #:components   [c #f]
                                  . custom-entities)

  (->i () (#:name [name string?]
           #:sprite [sprite sprite?]
           #:on-use [on-use any/c]
           #:rarity [rarity rarity-level?]
           #:respawn? [respawn boolean?]
           #:components [first-component component-or-system?])
       #:rest [more-components (listof component-or-system?)]
       [returns entity?])

  @{Returns a custom item, which will be placed in to the world
         automatically if it is passed into @racket[battlearena-game]
         via the @racket[#:item-list] parameter.}
  
  (define new-entity
    (sprite->entity s
                  #:name n
                  #:position (posn 0 0)
                  #:components (physical-collider)
                               (active-on-bg)
                               (static)
                               (hidden)
                               (on-start (do-many (active-on-random)
                                                  (respawn 'anywhere)
                                                  show))
                               (storage "rarity" r)
                               (storage "on-use" f)
                               (storable)
                               (cons c custom-entities)))
  (if respawn?
      (add-components new-entity (on-key 'space #:rule (and/r near-player?
                                                              (nearest-to-player? #:filter (has-component? on-key?)))
                                         (do-many (respawn 'anywhere)
                                                  (active-on-random))))
      (add-components new-entity (on-key 'space #:rule (and/r near-player?
                                                              (nearest-to-player? #:filter (has-component? on-key?)))
                                         die))))

; ==== BORDERLANDS STYLE POP UPS =====
; todo: add to game-engine?
(define (go-to-entity name #:offset [offset (posn 0 0)])
  (lambda (g e)
    (define target? (get-entity name g))
    (if target?
        (update-entity e posn? (posn-add (get-component target? posn?) offset))
        e)))

(define (text/shadow message size color)
  (overlay/offset (freeze (text/font message size color "Arial" 'default 'normal 'normal #f))
                  -1 1
                  (freeze (text/font message size "black" "Arial" 'default 'normal 'normal #f))))

(define (player-toast-entity message #:color [color "yellow"])
  (sprite->entity (text/shadow message 16 color)
                  #:name       "player toast"
                  #:position   (posn 0 0)
                  #:components (hidden)
                               (layer "ui")
                               (direction 270)
                               ;(physical-collider)
                               (speed 3)
                               (on-start (do-many (go-to-entity "player" #:offset (posn 0 -20))
                                                  (random-direction 240 300)
                                                  (random-speed 2 4)
                                                  show))
                               (every-tick (do-many (move)
                                                    (scale-sprite 1.05)))
                               (after-time 15 die)))

(define (entity-cloner entity amount)
  (map (thunk*
        (if (procedure? entity) (entity)
            (clone-entity entity) ))
       (range amount)))


(define/contract (clone-by-amount-in-world es)
  (-> (listof (or/c procedure? entity?)) (listof entity?))

  (define (f e)
    (define to-clone (if (procedure? e)
                         (e)
                         e) )
    
    (define n (if (get-storage "amount-in-world" to-clone)
                  (get-storage-data "amount-in-world" to-clone)
                  1))
    (entity-cloner e n))

  (flatten (map f es)))

(define/contract (clone-by-rarity es)
  (-> (listof (or/c procedure? entity?)) (listof entity?))

  (define (f e)
    (define to-clone (if (procedure? e)
                         (e)
                         e) )
    
    (define rarity (if (get-storage "Rarity" to-clone)
                       (get-storage-data "Rarity" to-clone)
                       'common))
    
    (define n (cond [(eq? rarity 'common)    5]
                    [(eq? rarity 'uncommon)  4]
                    [(eq? rarity 'rare)      3]
                    [(eq? rarity 'epic)      2]
                    [(eq? rarity 'legendary) 1]))
    (entity-cloner e n))

  (flatten (map f es)))

(define/contract (get-total-by-amount-in-world es)
  (-> (listof (or/c entity? procedure?)) number?)
  (define (entity->amount e)
    (define to-clone (if (procedure? e)
                         (e)
                         e))
    (if (get-storage "amount-in-world" to-clone)
        (get-storage-data "amount-in-world" to-clone)
        1))
  (apply + (map entity->amount es)))
  

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

(define (plain-bg #:img     [bg (draw-plain-bg)]
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


(define/contract/doc (custom-bg #:img        [bg (draw-plain-bg)]
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
        #:components [first-component (or/c component-or-system? (listof false?))])
       #:rest [more-components (listof component-or-system?)]
       [result entity?])

  @{Returns a custom background, which will be used
         automatically if it is passed into @racket[battlearena-game]
         via the @racket[#:bg] parameter.}
  
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




(define/contract/doc (custom-avatar
                      #:sprite       [sprite (random-character-sprite)]
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
        #:components [first-component (or/c component-or-system? false? (listof false?))]
        )
       #:rest (rest (listof component-or-system?))
       [returns entity?])

    @{Returns a custom avatar, which will be placed in to the world
         automatically if it is passed into @racket[battlearena-game]
         via the @racket[#:avatar] parameter.}
  

  
  (define dead-frame (if (image? sprite)
                         (rotate -90 sprite)
                         (rotate -90 (render sprite))))

  (define base-avatar
    (sprite->entity sprite
                  #:name       "player"
                  #:position   p
                  #:components (physical-collider)
                               (sound-stream)
                               ;Handle deaths....
                               (precompiler dead-frame)
                               (damager 10 (list 'passive 'friendly-team))
                               (key-movement spd #:mode key-mode #:rule (and/r all-dialog-closed?
                                                                               (not/r lost?)))
                               (key-animator-system #:mode key-mode #:face-mouse? mouse-aim?)
                               (stop-on-edge)
                               (backpack-system #:max-items w-slots
                                                #:pickup-rule (or/r (not/r backpack-has-armor?)
                                                             (not/r nearest-item-is-armor?))
                                                #:components (observe-change backpack-changed? update-backpack))
                               (observe-change lost? (kill-player-v2))
                               (player-edge-system)
                               (counter 0)
                               (weapon-selector #:slots w-slots)
                               (cons c custom-components)
                               ))

  (define health-bar (stat-progress-bar 'green
                                        #:width 100
                                        #:height 10
                                        #:max 100 
                                        #:after (λ(e) (~> e
                                                          (remove-component _ lock-to?)
                                                          (remove-component _ active-on-bg?)
                                                          (add-component _
                                                                         (on-start
                                                                          (go-to-pos-inside 'top-left
                                                                                            #:posn-offset (posn 10 23))))))))

  (define sheild-bar (stat-progress-bar 'deepskyblue
                                        #:width 100
                                        #:height 10
                                        #:max 100
                                        #:after (λ(e) (~> e
                                                          (remove-component _ lock-to?)
                                                          (remove-component _ active-on-bg?)
                                                          (add-component _
                                                                         (on-start
                                                                          (go-to-pos-inside 'top-left
                                                                                            #:posn-offset (posn 10 10))))))))

  (combatant
   #:stats (list (make-stat-config 'health 100 health-bar)
                 (make-stat-config 'shield 100 sheild-bar))
   #:damage-processor dp         
   base-avatar)
  )



  

(define/contract/doc
  (battlearena-game
   #:headless       [headless #f]
   #:bg             [bg-ent (custom-bg)]
   #:avatar         [p (custom-avatar #:sprite (circle 10 'solid 'red))]
   #:enemy-list     [e-list '()]
   #:weapon-list    [weapon-list '()]
   #:item-list      [item-list '()]
   #:score-prefix   [prefix "Enemies"]
   #:enable-world-objects? [world-objects? #f]
   #:other-entities [ent #f]
   . custom-entities)

  (->i ()
       (#:headless [headless boolean?]
        #:bg [bg entity?]
        #:avatar [avatar (or/c entity? false?)]
        #:enemy-list [enemy-list   (listof (or/c false? entity? procedure?))]
        #:weapon-list [weapon-list (listof (or/c entity? procedure?))]
        #:item-list   [item-list   (listof (or/c entity? procedure?))]
        #:score-prefix [prefix string?]
        #:enable-world-objects? [world-objects? boolean?]
        #:other-entities [other-entities (or/c #f entity? (listof false?) (listof entity?))])
       #:rest [rest (listof entity?)]
       [res () game?])

  @{The top-level function for the battlearena language.
         Can be run with no parameters to get a basic, default game.}

  (define (weapon-entity->player-system e)
    (get-storage-data "Weapon" e))

  (define (armor-entity->player-system e)
    (define armor-name (get-name e))
    (define new-dp (get-storage-data "Armor" e))
    (observe-change (in-backpack? armor-name) (λ (g e1 e2)
                                                (if ((in-backpack? armor-name) g e2)
                                                    (begin (displayln (~a "ADDING ARMOR: " armor-name))
                                                           (update-entity e2 damage-processor? new-dp))
                                                    (begin (displayln "REMOVING ARMOR")
                                                           (update-entity e2 damage-processor?
                                                                          (divert-damage #:filter-out '(friendly-team passive))))))))

  (define (item-entity->player-system e #:use-key [use-key 'space])
    (define item-name (get-name e))
    (precompile! (player-toast-entity item-name))
    (define on-use-func (get-storage-data "on-use" e))
    (if on-use-func
        (on-key use-key #:rule (and/r (player-is-near? item-name)
                                      (nearest-entity-to-player-is? item-name #:filter (and/c (has-component? on-key?)
                                                                                              (not/c tops?)
                                                                                              (not/c ui?)
                                                                                              (not/c bg?))))
                (do-many on-use-func
                         (spawn (player-toast-entity item-name))))
        #f)
    )
  
  (define (is-armor? e)
    (get-storage "Armor" e))
     
  (define armor-list    (filter is-armor? item-list))
  (define powerups-list (filter-not is-armor? item-list))
  
  (define player-with-weapons
    (add-components p ;(weapon-selector #:slots 3)
                      (map weapon-entity->player-system weapon-list)
                      (map armor-entity->player-system armor-list)
                      (map item-entity->player-system powerups-list)))

  (define move-keys (if (and p (eq? (get-key-mode p) 'wasd))
                        "WASD KEYS"
                        "ARROW KEYS"))

  (define shoot-key (if (and player-with-weapons (get-component player-with-weapons on-mouse?))
                        "LEFT-CLICK"
                        "F"))

  (define (mouse-aim-component? c)
    (and (on-rule? c)
         (eq? (on-rule-rule? c) mouse-in-game?)
         (eq? (on-rule-func c) point-to-mouse)))

  (define mouse-aim? (and p
                          (get-component p mouse-aim-component?)))

  (define (add-random-start-pos e)
    (define world-amt (get-storage-data "amount-in-world" e))
    (if (> world-amt 0) 
        (add-components e (hidden)
                          (on-start (do-many (active-on-random)
                                             (respawn 'anywhere)
                                             show)))
        e))
  

  (define (start-dead-component? c)
    (and (on-start? c)
         (eq? (on-start-func c) die)))
  
  ;Add more checks to this.
    (define (enemy-died? g e)
      (define death-broadcast (get-entity "Enemy Death Broadcast" g))
      #|(define (has-name? name)
        (lambda (e)
          (eq? (get-name e) name)))
      (define all-death-broadcasts (filter (has-name? "Enemy Death Broadcast") (game-entities g)))
      (if death-broadcast
          (displayln (~a "ENEMY DEATHS DETECTED: " (length all-death-broadcasts)
                         "\nFOUND DEATH COMPONENT: " (get-component death-broadcast start-dead-component?)))
          #f)|#
      (and death-broadcast
           (get-component death-broadcast start-dead-component?))) ; This is still read twice in the same tick

         
  (define total-enemies (get-total-by-amount-in-world e-list))

  (define score-font (make-font #:size 13 #:face "DejaVu Sans Mono" #:family 'modern))
  (define bold-font (make-font #:size 13 #:face "DejaVu Sans Mono" #:family 'modern #:weight 'bold))
   

  (define (enemy-counter-entity prefix)
    (define outer-border-img (square 1 'solid 'black))
    (define inner-border-img (square 1 'solid 'white))
    (define box-img (square 1 'solid 'dimgray))
    (define counter-sprite
      (list (new-sprite (~a prefix " Left: " total-enemies)
                        #:color 'yellow)
            (new-sprite  box-img
                        #:animate #f
                        #:x-scale 180
                        #:y-scale 24)
            (new-sprite inner-border-img
                        #:animate #f
                        #:x-scale 184
                        #:y-scale 28)
            (new-sprite outer-border-img
                        #:animate #f
                        #:x-scale 186
                        #:y-scale 30)
                   ))
    
    
    (register-fonts! bold-font)

    (define (change-text-sprite s)
      (lambda (g e)
        (define current-sprite (get-component e string-animated-sprite?))
        (update-entity e (is-component? current-sprite)
                       s)))

    (define (do-font-fx)
      (lambda (g e)
        (define current-sprite (get-component e string-animated-sprite?))
        (define current-text-frame (render-text-frame current-sprite))
        (define regular-text-frame (~> current-text-frame
                                       (set-text-frame-font score-font _)
                                       (set-text-frame-color 'yellow _)))
        (define bold-text-frame (~> current-text-frame
                                    (set-text-frame-font bold-font _)
                                    (set-text-frame-color 'orangered _)))
        (~> e
            (update-entity _ (is-component? current-sprite)
                             (new-sprite (list bold-text-frame
                                               regular-text-frame)
                                         10
                                         #:scale 1.1
                                         ))
            (add-components _ (after-time 20 (change-text-sprite (new-sprite regular-text-frame)))))))

    
    (sprite->entity counter-sprite
                    #:name       "score"
                    #:position   (posn 330 24)
                    #:components (static)
                                 (counter total-enemies)
                                 (layer "ui")
                                 (on-rule enemy-died? (do-many (change-counter-by -0.5) ; still getting doubled counted
                                                               (draw-counter-rpg #:prefix (~a prefix " Left: ") #:exact-floor? #t)
                                                               (do-font-fx)
                                                               ))
                                 ))

   (define bg-with-instructions
    (add-components bg-ent (on-key "i" #:rule (λ (g e) (not (get-entity "instructions" g)))
                                   (spawn (instructions-entity #:move-keys move-keys #:shoot-key shoot-key #:mouse-aim? mouse-aim?) #:relative? #f))))
 
  (define es (filter identity
                     (flatten
                      (list
                       (instructions-entity #:move-keys move-keys #:shoot-key shoot-key #:mouse-aim? mouse-aim?)
                       (if p (game-over-screen won? lost?) #f)
                       (if p (enemy-counter-entity prefix) #f)


                       player-with-weapons
              
                       (clone-by-rarity weapon-list)

                       (clone-by-rarity item-list)

                       (clone-by-amount-in-world e-list)

                       

                       (cons ent custom-entities)

                       (if world-objects?
                           (make-world-objects round-tree pine-tree)
                           #f)

                       ;For precompilation...
                       default-combat-particles
              
                       bg-with-instructions))))

  
  (if headless
      (initialize-game es) ;Just return initial game state for whatever processing or unit tests...
      (apply start-game es))
  )





(define (move-in-ring)
  (list
   (on-start (set-size 0.5))
   (every-tick (do-many (scale-sprite 1.05)
                        (change-direction-by 10)))))


(define (round-nearest amount n)
  (* amount (round (/ n amount))))

(define (round-nearest-posn amount p)
  (posn (round-nearest amount (posn-x p))
        (round-nearest amount (posn-y p))))

(define (lock-to-grid (amount 10))
  (on-start
   (λ(g e)
     (update-entity e posn?
                    (round-nearest-posn amount (get-component e posn?))))))









(define (mine #:weapon (weapon (custom-weapon))
              #:sprite (s spike-mine-sprite) ;(square 50 'solid 'green)
              #:die-after (die-after 500))

  (define weapon-system (get-storage-data "Weapon" weapon))

  (define remove-point-to-hack
    (lambda (e)
      (~> e
          (remove-component _ on-start?)
          (add-component _ (on-start (random-direction 0 360))))
      ))

  (define explode
    (do-many
     (do-after-time 100 die)
     (λ(g e)
       (add-component e
                      (use-weapon weapon-system)))))
  
  (sprite->entity s
                  #:name "wall"
                  #:position (posn 0 0)
                  #:components
                  (direction 0)
                  (speed 0)
                  (active-on-bg)
            
                  (static)
                  (lock-to-grid 50)
                  (physical-collider)
                  (on-collide "wall" die)
                  (after-time die-after die)
                  (on-collide "Enemy"
                              explode)
                  (on-collide "player"
                              explode))

  )


(define (tower #:weapon (weapon (custom-weapon))
               #:die-after (die-after 500))
  (define tower-id (random 100000))
  (define tower-name (~a "tower" tower-id))
  (displayln (~a "TOWER NAME: " tower-name))

  (define tower-base (overlay/offset 
                      (rectangle 32 24 "solid" "dimgray")
                      0 8
                      (ellipse 50 24 "solid" (make-color 0 0 0 120))))
  
  (define tower-top (above (beside (square 8 "solid" "darkslategray")
                                   (square 8 "solid" "transparent")
                                   (square 8 "solid" "darkslategray")
                                   (square 8 "solid" "transparent")
                                   (square 8 "solid" "darkslategray"))
                           (rectangle 40 10 "solid" "darkslategray")
                           (rectangle 32 32 "solid" "dimgray")))

  (define tower-top-entity
    (sprite->entity tower-top
                    #:name "Tower Top"
                    #:position (posn 0 -40)
                    #:components
                    (layer "tops")
                    (after-time die-after die)
                    (on-rule (λ (g e) (not (get-entity tower-name g))) die)
                    (active-on-bg)))

  (precompile! tower-top
               tower-base)


  (define weapon-system (get-storage-data "Weapon" weapon))
  
  (sprite->entity tower-base

                  #:name tower-name
                  #:position (posn 0 0)
                  #:components
                  (direction 0)
                  (speed 0)
                  (active-on-bg)
                  (use-weapon-against "Enemy" weapon-system)
                  (static)
                  (lock-to-grid 50)
                  (physical-collider)
                  (on-collide tower-name die)
                  (after-time die-after die)
                  (on-start (spawn-on-current-tile tower-top-entity))))


(define (lava #:size size
              #:die-after (die-after 500)
              #:damage damage
              #:sprite sprite)
  (sprite->entity (set-scale-xy size (new-sprite sprite))
                  #:name "wall"
                  #:position (posn 0 0)
                  #:components
                  (active-on-bg)
                  (static)
                  (lock-to-grid size)
                  (physical-collider)
                  (on-collide "wall" die)
                  (damager damage '(lava))
                  (after-time die-after die)))

(define (wall #:size (size 50) #:die-after (die-after 500))
  (sprite->entity (set-scale-xy size (new-sprite (square 1 'solid 'brown)))
                  #:name "wall"
                  #:position (posn 0 0)
                  #:components
                  (active-on-bg)
                  (static)
                  (lock-to-grid size)
                  (physical-collider)
                  (on-collide "wall" die)
                  (after-time die-after die)))

(define (builder-dart #:entity   (to-build (wall))
                      #:distance (die-after 5))
  (custom-dart #:components
               (every-tick (move))
               ;(after-time 6 die)
               (after-time die-after
                           (spawn-on-current-tile to-build))))

       


#;(module+ test
  (battlearena-game
   #:bg              (custom-bg #:img FOREST-BG
                                #:hd? #t)
   #:avatar          (custom-avatar #:sprite pirateboy-sprite)
   #:enemy-list      (list (curry custom-enemy
                                  #:ai 'hard
                                  #:amount-in-world 10
                                  #:weapon (custom-weapon #:speed 5)))
   #:weapon-list     (list (custom-weapon #:name "Light Repeater"
                                          #:sprite (make-icon "LR" "purple")
                                          #:mouse-fire-button 'left
                                          #:fire-mode 'random
                                          #:fire-rate 10
                                          #:rarity 'legendary)
                           (custom-weapon #:name "Spread Shot"
                                          #:sprite (make-icon "SS" "lightblue" "white")
                                          #:mouse-fire-button 'left
                                          #:fire-mode 'spread
                                          #:rapid-fire? #f
                                          #:rarity 'rare))
   #:item-list        (list (custom-item #:name "Force Field"
                                         #:sprite (make-icon "FF" "cyan")
                                         #:on-use (spawn (force-field #:allow-friendly-dart? #t
                                                                      #:duration 2000))))
   #:other-entities
   (round-tree (posn 35 270)  #:tile 0 #:hue (random 330 420) (damager 5 (list 'passive)))
   (round-tree (posn 181 328) #:tile 0 #:hue (random 330 420) (damager 5 (list 'passive)))
   (round-tree (posn 349 318) #:tile 0 #:hue (random 330 420) (damager 5 (list 'passive)))
   (round-tree (posn 425 261) #:tile 0 #:hue (random 330 420) (damager 5 (list 'passive)))
   (round-tree (posn 235 169) #:tile 1 #:hue (random 330 420) (damager 5 (list 'passive)))
   (round-tree (posn 358 240) #:tile 4 #:hue (random 330 420) (damager 5 (list 'passive)))
   (round-tree (posn 325 121) #:tile 4 #:hue (random 330 420) (damager 5 (list 'passive)))
   (round-tree (posn 419 166) #:tile 7 #:hue (random 330 360) (damager 5 (list 'passive)))
   (round-tree (posn 119 259) #:tile 8 #:hue (random 330 360) (damager 5 (list 'passive)))
   (pine-tree  (posn 217 280) #:tile 2 #:hue (random 220 360) (damager 5 (list 'passive)))
   (pine-tree  (posn 400 140) #:tile 2 #:hue (random 220 360) (damager 5 (list 'passive)))
   (pine-tree  (posn 341 297) #:tile 3 #:hue (random 220 360) (damager 5 (list 'passive)))
   (pine-tree  (posn 87 164)  #:tile 3 #:hue (random 220 360) (damager 5 (list 'passive))) 
   (pine-tree  (posn 155 150) #:tile 4 #:hue (random 220 360) (damager 5 (list 'passive)))
   (pine-tree  (posn 293 228) #:tile 5 #:hue (random 220 360) (damager 5 (list 'passive)))
   (pine-tree  (posn 92 276)  #:tile 5 #:hue (random 220 360) (damager 5 (list 'passive)))
   (pine-tree  (posn 114 274) #:tile 6 #:hue (random 220 360) (damager 5 (list 'passive)))
   (pine-tree  (posn 256 252) #:tile 7 #:hue (random 220 360) (damager 5 (list 'passive))))
   )
















; ==== PREBUILT WEAPONS & DARTS ====
(define (spear #:name              [n "Spear"]
               #:icon              [i [make-icon "SP" 'brown]]
               #:sprite            [s spear-sprite]
               #:damage            [dmg 25]
               #:durability        [dur 20]
               #:speed             [spd 5]
               #:range             [rng 20]
               #:dart              [d (spear-dart #:sprite s
                                                  #:damage dmg
                                                  #:durability dur
                                                  #:speed spd
                                                  #:range rng)]
               #:fire-mode         [fm 'normal]
               #:fire-rate         [fr 3]
               #:fire-key          [key 'f]
               #:mouse-fire-button [button 'left]
               #:point-to-mouse?   [ptm? #t]
               #:rapid-fire?       [rf? #f]
               #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define (spear-dart #:sprite     [s spear-sprite]
                    #:damage     [dmg 25]
                    #:durability [dur 20]
                    #:speed      [spd 5]
                    #:range      [rng 20])
  (custom-dart #:position (posn 20 0)
               #:sprite s
               #:damage dmg
               #:durability dur
               #:speed spd
               #:range rng
               #:components (after-time (/ rng 2) (do-many (bounce)
                                                           (horizontal-flip-sprite)))))

(define (sword #:name              [n "Sword"]
               #:icon              [i [make-icon "SW" 'silver]]
               #:sprite            [s swinging-sword-sprite]
               #:damage            [dmg 25]
               #:durability        [dur 20]
               #:speed             [spd 0]
               #:duration          [rng 10]
               #:dart              [d (sword-dart #:sprite s
                                                  #:damage dmg
                                                  #:durability dur
                                                  #:speed spd
                                                  #:duration rng)]
               #:fire-mode         [fm 'normal]
               #:fire-rate         [fr 3]
               #:fire-key          [key 'f]
               #:mouse-fire-button [button 'left]
               #:point-to-mouse?   [ptm? #t]
               #:rapid-fire?       [rf? #f]
               #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define (sword-dart #:sprite     [s swinging-sword-sprite]
                    #:damage     [dmg 50]
                    #:durability [dur 20]
                    #:speed      [spd 0]
                    #:duration   [rng 10])
  (custom-dart #:position (posn 10 0)
               #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng
               #:components (every-tick (change-direction-by 15))))

(define (paint-thrower #:name              [n "Paint Thrower"]
                       #:icon              [i [make-icon "PT"]]
                       #:sprite            [s paint-sprite]
                       #:damage            [dmg 5]
                       #:durability        [dur 5]
                       #:speed             [spd 3]
                       #:range             [rng 20]
                       #:dart              [d (paint-dart #:sprite s
                                                         #:damage dmg
                                                         #:durability dur
                                                         #:speed spd
                                                         #:range rng)]
                       #:fire-mode         [fm 'random]
                       #:fire-rate         [fr 10]
                       #:fire-key          [key 'f]
                       #:mouse-fire-button [button 'left]
                       #:point-to-mouse?   [ptm? #t]
                       #:rapid-fire?       [rf? #t]
                       #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define (paint-dart #:sprite     [s   paint-sprite]
                    #:damage     [dmg 5]
                    #:durability [dur 5]
                    #:speed      [spd 3]
                    #:range      [rng 20])
  (custom-dart #:position (posn 25 0)
               #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng
               #:components (on-start (set-size 0.5))
               (every-tick (scale-sprite 1.1))))

(define (fire-magic #:name              [n "Fire Magic"]
                    #:icon              [i [make-icon "FM" 'red]]
                    #:sprite            [s flame-sprite]
                    #:damage            [dmg 5]
                    #:durability        [dur 5]
                    #:speed             [spd 3]
                    #:range             [rng 20]
                    #:dart              [d (fire-dart #:sprite s
                                                       #:damage dmg
                                                       #:durability dur
                                                       #:speed spd
                                                       #:range rng)]
                    #:fire-mode         [fm 'random]
                    #:fire-rate         [fr 10]
                    #:fire-key          [key 'f]
                    #:mouse-fire-button [button 'left]
                    #:point-to-mouse?   [ptm? #t]
                    #:rapid-fire?       [rf? #t]
                    #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define (fire-dart #:sprite     [s   flame-sprite]
                   #:damage     [dmg 5]
                   #:durability [dur 5]
                   #:speed      [spd 3]
                   #:range      [rng 20])
  (custom-dart #:position (posn 25 0)
               #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng
               #:components (on-start (set-size 0.5))
               (every-tick (scale-sprite 1.1))))

(define (ice-magic #:name              [n "Ice Magic"]
                   #:icon              [i [make-icon "IM" 'lightcyan]]
                   #:sprite            [s ice-sprite]
                   #:damage            [dmg 5]
                   #:durability        [dur 5]
                   #:speed             [spd 3]
                   #:range             [rng 20]
                   #:dart              [d (ice-dart #:sprite s
                                                    #:damage dmg
                                                    #:durability dur
                                                    #:speed spd
                                                    #:range rng)]
                   #:fire-mode         [fm 'random]
                   #:fire-rate         [fr 10]
                   #:fire-key          [key 'f]
                   #:mouse-fire-button [button 'left]
                   #:point-to-mouse?   [ptm? #t]
                   #:rapid-fire?       [rf? #t]
                   #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define ice-sprite
  (overlay (circle 5 "solid" "white")
           (circle 6 "solid" "cyan")
           (circle 7 "solid" "blue")))

(define (ice-dart #:sprite     [s   ice-sprite]
                  #:damage     [dmg 5]
                  #:durability [dur 5]
                  #:speed      [spd 3]
                  #:range      [rng 20])
  (custom-dart #:position (posn 25 0)
               #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng
               #:components (on-start (set-size 0.5))
               (every-tick (scale-sprite 1.1))))

(define (sword-magic #:name              [n "Sword Magic"]
                     #:icon              [i [make-icon "SM" 'silver]]
                     #:sprite            [s flying-sword-sprite]
                     #:damage            [dmg 10]
                     #:durability        [dur 20]
                     #:speed             [spd 4]
                     #:range             [rng 40]
                     #:dart              [d (flying-dagger-dart #:sprite s
                                                                #:damage dmg
                                                                #:durability dur
                                                                #:speed spd
                                                                #:range rng)]
                     #:fire-mode         [fm 'spread]
                     #:fire-rate         [fr 1]
                     #:fire-key          [key 'f]
                     #:mouse-fire-button [button 'left]
                     #:point-to-mouse?   [ptm? #t]
                     #:rapid-fire?       [rf? #t]
                     #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define (flying-dagger-dart #:position   [p   (posn 20 0)]
                            #:sprite     [s   flying-sword-sprite]
                            #:damage     [dmg 10]
                            #:durability [dur 20]
                            #:speed      [spd 4]
                            #:range      [rng 40])
  (custom-dart #:position p
               #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng
               #:components (on-start (do-many (set-size 0.5)))
               (do-every 10 (change-direction-by-random -25 25))))

(define (ring-of-blades #:name              [n "Ring of Blades"]
                        #:icon              [i (make-icon "RoB" 'silver)]
                        #:sprite            [s flying-sword-sprite]
                        #:damage            [dmg 10]
                        #:durability        [dur 20]
                        #:speed             [spd 10]
                        #:duration          [rng 36]
                        #:dart              [d (ring-of-blades-dart #:sprite s
                                                                    #:damage dmg
                                                                    #:durability dur
                                                                    #:speed spd
                                                                    #:duration rng)]
                        #:fire-mode         [fm 'normal]
                        #:fire-rate         [fr 6]
                        #:fire-key          [key 'f]
                        #:mouse-fire-button [button 'left]
                        #:point-to-mouse?   [ptm? #t]
                        #:rapid-fire?       [rf? #t]
                        #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define (ring-of-blades-dart #:sprite     [s   flying-sword-sprite]
                             #:damage     [dmg 10]
                             #:durability [dur 20]
                             #:speed      [spd 10]
                             #:duration   [rng 36])
  (custom-dart #:position   (posn 25 0)
               #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng
               #:components (on-start (set-size 0.5))
               (every-tick (do-many ;(scale-sprite 1.05)
                                    (change-direction-by 10)))))


(define (ring-of-fire #:name              [n "Ring of Fire"]
                      #:icon              [i (make-icon "RoF" 'red)]
                      #:sprite            [s flame-sprite]
                      #:damage            [dmg 5]
                      #:durability        [dur 20]
                      #:speed             [spd 10]
                      #:duration          [rng 36]
                      #:dart              [d (ring-of-fire-dart #:sprite s
                                                                #:damage dmg
                                                                #:durability dur
                                                                #:speed spd
                                                                #:duration rng)]
                      #:fire-mode         [fm 'normal]
                      #:fire-rate         [fr 10]
                      #:fire-key          [key 'f]
                      #:mouse-fire-button [button 'left]
                      #:point-to-mouse?   [ptm? #t]
                      #:rapid-fire?       [rf? #t]
                      #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define (ring-of-ice #:name              [n "Ring of Ice"]
                     #:icon              [i (make-icon "RoI" 'lightcyan)]
                     #:sprite            [s ice-sprite]
                     #:damage            [dmg 5]
                     #:durability        [dur 20]
                     #:speed             [spd 10]
                     #:duration          [rng 36]
                     #:dart              [d (ring-of-fire-dart #:sprite s
                                                               #:damage dmg
                                                               #:durability dur
                                                               #:speed spd
                                                               #:duration rng)]
                     #:fire-mode         [fm 'normal]
                     #:fire-rate         [fr 10]
                     #:fire-key          [key 'f]
                     #:mouse-fire-button [button 'left]
                     #:point-to-mouse?   [ptm? #t]
                     #:rapid-fire?       [rf? #t]
                     #:rarity            [rarity 'common])
  (custom-weapon #:name n
                 #:sprite i
                 #:dart d
                 #:fire-mode fm
                 #:fire-rate fr
                 #:mouse-fire-button button
                 #:point-to-mouse? ptm?
                 #:rapid-fire? rf?
                 #:rarity rarity))

(define (ring-of-fire-dart #:sprite     [s   flame-sprite]
                           #:damage     [dmg 5]
                           #:durability [dur 20]
                           #:speed      [spd 10]
                           #:duration   [rng 36])
  (custom-dart #:position   (posn 25 0)
               #:sprite     s
               #:damage     dmg
               #:durability dur
               #:speed      spd
               #:range      rng
               #:components (on-start (set-size 0.5))
               (every-tick (do-many (scale-sprite 1.05)
                                    (change-direction-by 10)))))

(define (spear-tower-builder #:sprite     [s spear-sprite]
                             #:damage     [dmg 50]
                             #:durability [dur 20]
                             #:speed      [spd 5]
                             #:range      [rng 20]
                             #:fire-rate  [fire-rate 0.5])
  (builder-dart #:entity
                (tower #:weapon (custom-weapon #:fire-rate fire-rate
                                               #:dart (spear-dart
                                                       #:sprite     s
                                                       #:damage     dmg
                                                       #:durability dur
                                                       #:speed      spd
                                                       #:range      rng)))))


(define spike-mine-sprite
  (overlay (ellipse 6 6 'solid 'red)
           (ellipse 16 14 'solid 'gray)
           (ellipse 18 16 'solid 'black)))

(define spike-sprite
  (rotate 30 (triangle 10 'solid 'gray)))

(define (spike-mine-builder #:sprite     [s spike-mine-sprite]
                            #:damage     [dmg 2]
                            #:durability [dur 10]
                            #:speed      [spd 5]
                            #:range      [rng 20]
                            #:fire-rate  [fire-rate 20])
  (builder-dart #:entity
                (mine #:sprite s
                      #:weapon (custom-weapon ;#:fire-mode 'spread
                                              #:fire-rate fire-rate
                                              #:point-to-mouse? #f
                                              #:dart (custom-dart #:sprite spike-sprite
                                                                  #:damage dmg
                                                                  #:durability dur
                                                                  #:speed spd
                                                                  #:range rng
                                                                  #:components (on-start (random-direction 0 360)))
                                              ))))


(define (lava-builder #:damage (damage 10)
                      #:size   (size 1)
                      #:sprite (sprite LAVA-SPRITE)
                      #:range (range 5))
  
  (builder-dart #:entity (lava #:damage damage
                               #:size size
                               #:sprite sprite)
                #:distance range))

(define rocket-sprite
  (scale 0.75 (beside (rotate 90 (triangle 6 "solid" "orange"))
                      (rectangle 5 10 "solid" "gray")
                      (rectangle 16 6 "solid" "gray")
                      (rotate -90 (triangle 12 "solid" "red")))))

(define (rocket #:sprite     [s   rocket-sprite]
                #:damage     [dmg 200]
                #:durability [dur 10]
                #:speed      [spd 5]
                #:range      [rng 100])
  (custom-dart #:position (posn 0 -70)
               #:sprite   s
               #:damage dmg
               #:durability dur
               #:speed spd
               #:range rng
               ))

(define (rocket-tower-builder #:sprite     [s rocket-sprite]
                              #:damage     [dmg 200]
                              #:durability [dur 10]
                              #:speed      [spd 5]
                              #:range      [rng 100]
                              #:fire-mode  [fm 'normal]
                              #:fire-rate  [fire-rate 0.5])
  (builder-dart #:entity
                (tower #:weapon (custom-weapon #:fire-rate fire-rate
                                               #:fire-mode fm
                                               ;#:point-to-mouse? #f
                                               #:dart (rocket
                                                       #:sprite     s
                                                       #:damage     dmg
                                                       #:durability dur
                                                       #:speed      spd
                                                       #:range      rng)))))

(define (repeater-tower-builder #:sprite     [s (rectangle 10 2 "solid" "green")]
                                #:damage     [dmg 10]
                                #:durability [dur 10]
                                #:speed      [spd 10]
                                #:range      [rng 100]
                                #:fire-mode  [fm 'normal]
                                #:fire-rate  [fire-rate 3])
  (builder-dart #:entity
                (tower #:weapon (custom-weapon #:fire-rate fire-rate
                                               #:fire-mode fm
                                               ;#:point-to-mouse? #f
                                               #:dart (custom-dart
                                                       #:position  (posn 0 -70)
                                                       #:sprite     s
                                                       #:damage     dmg
                                                       #:durability dur
                                                       #:speed      spd
                                                       #:range      rng)))))

(define (dagger-tower-builder #:sprite     [s (scale 0.5 flying-sword-sprite)]
                              #:damage     [dmg 200]
                              #:durability [dur 20]
                              #:speed      [spd 5]
                              #:range      [rng 200]
                              #:fire-mode  [fm 'normal]
                              #:fire-rate  [fire-rate 0.5])
  (builder-dart #:entity
                (tower #:weapon (custom-weapon #:fire-rate fire-rate
                                               #:fire-mode fm
                                               ;#:point-to-mouse? #f
                                               #:dart (custom-dart
                                                       #:position  (posn 0 -70) 
                                                       #:sprite     s
                                                       #:damage     dmg
                                                       #:durability dur
                                                       #:speed      spd
                                                       #:range      rng)))))


(define (is-weapon-component? c)
    (and (on-start? c)
         (eq? (on-start-rule c) mouse-in-game?)
         (eq? (on-start-func c) point-to-mouse)))

; POWER UP HANDLERS

(provide set-health-to
         change-health-by
         set-shield-to
         change-shield-by
         change-damage-by
         multiply-damage-by
         set-damage-to)

;change-damage-by
;multiply-damage-by

;Holy crap, why is this so hard.  WE need better tools for
;  applying a function to all things spawned from some entity
(define (change-damage-by n #:for [d #f])
  (λ(g e)
    (define (upgrade-bullet e)
      (define a-damager (get-component e damager?))
      (define old-amount (damager-amount a-damager))
      (update-entity e damager? (set-damager-amount a-damager (+ old-amount n))))
    
    (define (upgrade-weapon w)
      (add-weapon-filter w
                         upgrade-bullet))

    (define old-weapons (get-components e weapon?))

    (define new-weapons (map upgrade-weapon old-weapons))

    (define (revert g e)
      (~> e
          (remove-components _ weapon?)
          (add-components _ old-weapons)))

    (~> e
        (remove-components _ weapon?)
        (add-components new-weapons)
        (add-component _ (after-time d revert)))

    
    ))

(define (multiply-damage-by n #:for [d #f])
  (λ(g e)
    (define (upgrade-bullet e)
      (define a-damager (get-component e damager?))
      (define old-amount (damager-amount a-damager))
      (update-entity e damager? (set-damager-amount a-damager (* old-amount n))))
    
    (define (upgrade-weapon w)
      (add-weapon-filter w
                         upgrade-bullet))

    (define old-weapons (get-components e weapon?))

    (define new-weapons (map upgrade-weapon old-weapons))

    (define (revert g e)
      (~> e
          (remove-components _ weapon?)
          (add-components _ old-weapons)))

    (~> e
        (remove-components _ weapon?)
        (add-components new-weapons)
        (add-component _ (after-time d revert)))

    
    ))

(define (set-damage-to n #:for [d #f])
  (λ(g e)
    (define (upgrade-bullet e)
      (define a-damager (get-component e damager?))
      (update-entity e damager? (set-damager-amount a-damager n)))
    
    (define (upgrade-weapon w)
      (add-weapon-filter w
                         upgrade-bullet))

    (define old-weapons (get-components e weapon?))

    (define new-weapons (map upgrade-weapon old-weapons))

    (define (revert g e)
      (~> e
          (remove-components _ weapon?)
          (add-components _ old-weapons)))

    (~> e
        (remove-components _ weapon?)
        (add-components new-weapons)
        (add-component _ (after-time d revert)))

    
    ))

;change-fire-rate-by
;multiply-fire-rate-by

(define (set-health-to amt)
  (lambda (g e)
    (set-stat "health" e (max 0 (min 100 amt)))))

(define (change-health-by amt)
  (lambda (g e)
    (define current-stat (get-stat "health" e))
    (if (<= current-stat (- 100 amt))
        (change-stat "health" e amt)
        (set-stat "health" e 100))))

(define (set-shield-to amt)
  (lambda (g e)
    (set-stat "shield" e (max 0 (min 100 amt)))))

(define (change-shield-by amt)
  (lambda (g e)
    (define current-stat (get-stat "shield" e))
    (if (<= current-stat (- 100 amt))
        (change-stat "shield" e amt)
        (set-stat "shield" e 100))))


#;(module test racket
  (displayln "TEST!!!")
  )



