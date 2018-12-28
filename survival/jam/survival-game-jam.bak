#lang racket

(provide survival-game
         ;basic-player-entity
         custom-avatar
         random-character-row
         food
         crafting-menu-set!
         custom-crafter)

(require game-engine
         game-engine-demos-common)

(require "../scoring/score.rkt")

(define-syntax-rule (define/log l head body ...)
  (define head
    (let ()
      (displayln l)
      body ...)))


; ==== BACKDROP COMPONENT ====
; Converts a single bg image to a list of bg tiles
(define (forest-backdrop)
  (bg->backdrop (rectangle (* 3 480) (* 3 360) 'solid 'darkgreen) 
                #:rows       3
                #:columns    3
                #:start-tile 0))

(define (WIDTH)       (backdrop-width  (forest-backdrop)))
(define (HEIGHT)      (backdrop-height (forest-backdrop)))
(define (TOTAL-TILES) (backdrop-length (forest-backdrop)))




; === GAME DIALOG ===
(define (player-dialog)
  (list "Hello. What's your name?"
        "I'm lost and hungry, can you help me?"))

; Responses must have the same number of lists as items in the player-dialog
(define (npc1-response)
  (list (list "Oh, hello! My name is Jordan!"
              "It's dangerous out here."
              "You should be careful.")
        (list "Sorry, I don't have any food to spare."
              "If you look around though,\nyou might find carrots.")
        ))

(define (npc1-response-sprites)
  (dialog->response-sprites npc1-response
                            #:game-width (WIDTH)
                            #:animated #t
                            #:speed 4))

; === ENTITY DEFINITIONS ===
(define (bg-entity)
  (sprite->entity (render-tile (forest-backdrop))
                  #:name     "bg"
                  #:position   (posn 0 0)
                  #:components (static)
                               (forest-backdrop)
                               (precompiler
                                (backdrop-tiles (first (forest-backdrop))))))



(define (instructions-entity)
  (sprite->entity (draw-title (~a "Use ARROW KEYS to move.\n"
                                  "Press SPACE BAR to interact.\n"
                                  "Press ENTER to select or close dialog.\n"
                                  "Press I to open these instructions.\n"
                                  "Press Z to pick up items.\n"
                                  "Press X to drop items."))
                  #:position   (posn (/ (WIDTH) 2) (/ (HEIGHT) 2))
                  #:name       "instructions"
                  #:components (layer "ui")
                               (on-key 'enter die)
                               (on-key 'space die)
                               (on-key "i" die)
                               ))

(define (score-entity)
  (sprite->entity (draw-dialog "Gold: 0")
                  #:name       "score"
                  #:position   (posn 380 20)
                  #:components (static)
                               (counter 0)
                               (layer "ui")
                               (precompiler (player-toast-entity "+10 GOLD"))
                               (apply precompiler (map (λ (num) (draw-dialog (~a "Gold: " num))) (range 0 1001 10)))
                               (on-key 'space #:rule (player-is-near? "Coin") (do-many (change-counter-by 10)
                                                                                       (draw-counter-rpg #:prefix "Gold: ")
                                                                                       (spawn (player-toast-entity "+10 GOLD"))))
                               ))


                               


; ==== NEW HELPER SYSTEMS ====
; todo: add to game-engine?
(define (consumable) (on-key 'space #:rule (near? "player") die)) ;health entity also needs a check when consumed.

(define (entity-cloner entity amount)
  (map (thunk* entity) (range amount)))

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


(define (has-gold? amount)
  (lambda (g e)
    (define gold (get-counter (get-entity "score" g)))
    (>= gold amount)))



; === WON AND LOST RULES ===
(define (won? g e)
  #f)

(define (lost? g e)
  (health-is-zero? g e))
                
(define (food->component f #:use-key [use-key 'space] #:max-health [max-health 100])
  (define item-name (get-name (first f)))
  (define heal-amount (second f))
  (on-key use-key #:rule (player-is-near? item-name) (do-many (maybe-change-health-by heal-amount #:max max-health)
                                                            (spawn (player-toast-entity (~a "+" heal-amount) #:color "green")))))

(define/log "custom-avatar"
  (custom-avatar #:sprite     [sprite (circle 10 'solid 'red)]
                 #:position   [p   (posn 100 100)]
                 #:speed      [spd 10]
                 #:components [c #f]
                               . custom-components)
  (sprite->entity sprite
                  #:name       "player"
                  #:position   p
                  #:components (physical-collider)
                               (sound-stream)
                               (precompiler (rotate -90 (render sprite)))
                               (key-movement spd #:rule (and/r all-dialog-closed?
                                                               (not/r lost?)))
                               (key-animator-system)
                               (stop-on-edge)
                               (backpack-system #:components (observe-change backpack-changed? update-backpack))
                               (player-edge-system)
                               ;(on-key "o" #:rule player-info-closed? show-move-info)
                               (observe-change lost? (kill-player))
                               (on-key "i" #:rule (λ (g e) (not (get-entity "instructions" g)))
                                       (spawn instructions-entity #:relative? #f))
                               ;(on-key "m" (open-mini-map #:close-key "m"))
                               (counter 0)
                               (on-key 'enter #:rule player-dialog-open? (get-dialog-selection))
                               (on-rule (not/r all-dialog-closed?) (stop-movement))
                               (cons c custom-components)))


(define/log "surival-game"
  (survival-game #:bg              [bg-ent (custom-background)]
                 #:avatar          [p         #f #;(custom-avatar)]
                 #:starvation-rate [sr 50]
                 #:npc-list        [npc-list '() #;(list (random-npc (posn 200 200)))]
                 #:item-list       [i-list   '() #;(list (item-entity))]
                 #:food-list       [f-list   '() #;(list (food #:entity (carrot-entity) #:amount-in-world 10)
                                                         (food #:entity carrot-stew #:heals-by 20))]
                 #:crafter-list    [c-list   '() #;(list (custom-crafter))]
                 #:other-entities  [ent #f]
                                   . custom-entities)

  (define player-with-recipes
    (if p
        (add-components p (map recipe->system known-recipes-list))
        #f))

  (define (food->toast-entity f)
    (player-toast-entity (~a "+" (second f)) #:color "green"))

  (define starvation-period (max 1 (- 100 (min 100 (max 0 sr)))))

  (define food-img-list (map (λ (f) (render (get-component (first f) animated-sprite?))) f-list))

  (define (stack img amount)
    (draw-backpack (map (thunk* img) (range amount))))

  (define (img->backpack-stack-list img)
    (map (curry stack img) (range 11)))

  (define all-backpack-stacks
    (apply append (map img->backpack-stack-list food-img-list)))
  
  (define (health-entity)
    (define max-health 100)
    (if p
        (sprite->entity (draw-health-bar 100 #:max max-health)
                        #:name "health"
                        #:position (posn 100 20)
                        #:components (precompiler (player-toast-entity "-1" #:color "red"))
                                     (apply precompiler (map food->toast-entity f-list))
                                     (apply precompiler (map first f-list))
                                     (precompiler all-backpack-stacks)
                                     (counter 100)
                                     (layer "ui")
                                     (apply precompiler (map (lambda(i) (draw-health-bar i #:max max-health))
                                                             (range (add1 max-health))))
                                     (do-every starvation-period (do-many (maybe-change-health-by -1 #:max max-health)
                                                                          (spawn (player-toast-entity "-1" #:color "orangered") #:relative? #f)))
                                     (map food->component f-list))
        #f))

  (define es (filter identity
                     (flatten
                      (list
                       (instructions-entity)
                       (if p (game-over-screen won? health-is-zero?) #f)
                       (if p (score-entity) #f)

                       (if p (health-entity) #f)

                       player-with-recipes
              
              
                       ;(pine-tree (posn 400 140) #:tile 2)
                       ;(pine-tree (posn 93 136) #:tile 4)
                       ;(round-tree (posn 322 59) #:tile 4)

                       npc-list
              
                       c-list
              
                       (map (λ (ent) (entity-cloner ent 10)) i-list)
                       (map (λ (f) (entity-cloner (first f) (third f))) f-list)

                       (cons ent custom-entities)
              
                       bg-ent))))


  (displayln (~a "Score estimation for your game: " (score-game es)))
  
  (apply start-game es))

(define/log "food"
  (food #:entity entity #:heals-by [heal-amt 5] #:amount-in-world [world-amt 0])
  (list entity heal-amt world-amt))

(define known-recipes-list '())

(define/log "crafting-menue-set!"
  (crafting-menu-set! #:open-key     [open-key 'space]
                            #:open-sound   [open-sound #f]
                            #:select-sound [select-sound #f]
                            #:recipes r
                            . recipes)
  (set! known-recipes-list (append (cons r recipes) known-recipes-list))
  (crafting-menu #:open-key open-key
                 #:open-sound open-sound
                 #:select-sound select-sound
                 #:recipes r
                           recipes))

(define default-crafting-menu
  (crafting-menu-set! #:recipes (recipe #:product (carrot-stew-entity)
                                        #:build-time 30
                                        #:ingredients (list "Carrot"))))

(define (custom-crafter #:position   [p (posn 100 100)]
                        #:tile       [t 0]
                        #:name       [name "Crafter"]
                        #:sprite     [sprite cauldron-sprite]
                        #:menu       [menu  default-crafting-menu]
                        #:components [c #f] . custom-components)
  (crafting-chest p
                  #:sprite sprite
                  #:name   name
                  #:components (active-on-bg t)
                               (counter 0)
                               menu
                               (cons c custom-components)))

(define/log "random-character-row"
  (random-character-row)
  (apply beside
         (map fast-image-data
              (vector->list
               (animated-sprite-frames
                (get-component
                 (random-npc)
                 animated-sprite?))))))






