#lang racket

(provide survival-game
         
         ;food
         ;coin
         crafting-menu-set!
         custom-avatar
         custom-crafter
         custom-npc
         custom-background
         custom-coin
         custom-food
         entity-cloner)

(require game-engine
         game-engine-demos-common)

(require "../scoring/score.rkt")

(define-syntax-rule (define/log l head body ...)
  (define head
    (let ()
      (displayln l)
      body ...)))


(define (WIDTH)       480)
(define (HEIGHT)      360)
(define (TOTAL-TILES) 9)

; === ENTITY DEFINITIONS ===
(define (plain-bg-entity)
  (bg->backdrop-entity (rectangle 48 36 ;Can even be smaller...
                                  'solid 'darkgreen) 
                       #:scale 30))




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
              "If you look around though,\nyou might find carrots.")  ))

(define (npc1-response-sprites)
  (dialog->response-sprites npc1-response
                            #:game-width (WIDTH)
                            #:animated #t
                            #:speed 4))



(define (instructions-entity)
  (define bg (new-sprite (rectangle 1 1 'solid (make-color 0 0 0 100))))
  
  (define i
    (sprite->entity (~> bg
                        (set-x-scale 260 _)
                        (set-y-scale 150 _)
                        (set-y-offset 60 _))
                    #:position   (posn (/ (WIDTH) 2) 50)
                    #:name       "instructions"
                    #:components (layer "ui")
                    (on-key 'enter die)
                    (on-key 'space die)
                    (on-key "i" die)))

  (add-components i
                  (new-sprite "ARROW KEYS to move"
                              #:y-offset 0 #:color 'yellow)
                  (new-sprite "SPACE BAR to interact"
                              #:y-offset 20 #:color 'yellow)
                  (new-sprite "ENTER to select or close dialog"
                              #:y-offset 40 #:color 'yellow)
                  (new-sprite "I to open these instructions"
                              #:y-offset 60 #:color 'yellow)
                  (new-sprite "Z to pick up items"
                              #:y-offset 80 #:color 'yellow)
                  (new-sprite "X to drop items"
                              #:y-offset 100 #:color 'yellow)))
     
; ==== NEW HELPER SYSTEMS ====
(define (entity-cloner entity amount)
  (map (thunk*
        (if (procedure? entity) (entity) entity ))
       (range amount)))

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
  (and e
       (health-is-zero? g e)))
    
(define (food->component f #:use-key [use-key 'space] #:max-health [max-health 100])
  (define item-name (get-name f))
  (define heal-amount (get-storage-data "heals-by" f))
  (if heal-amount
      (on-key use-key #:rule (and/r (player-is-near? item-name)
                                (nearest-entity-to-player-is? item-name))
          (do-many (maybe-change-health-by heal-amount #:max max-health)
                   (spawn (player-toast-entity (~a "+" heal-amount) #:color "green"))))
      #f))

(define (coin->component c #:use-key [use-key 'space])
  (define coin-name (get-name c))
  (define coin-value (get-storage-data "value" c))
  (define coin-toast-entity
    (player-toast-entity (~a "+" coin-value " GOLD")))

  
  (if coin-value
      (list 
            (precompiler coin-toast-entity)
         ;   (apply precompiler (map (λ (num) (draw-dialog (~a "Gold: " num))) (range 0 (add1 (* 100 coin-value)) coin-value)))
            (on-key use-key #:rule (and/r (player-is-near? coin-name)
                                          (nearest-entity-to-player-is? coin-name #:filter (has-component? on-key?)))
                    (do-many (change-counter-by coin-value)
                             (draw-counter-rpg #:prefix "Gold: ")
                             (spawn coin-toast-entity))))
      #f))

(define/log "custom-avatar"
  (custom-avatar #:sprite     [sprite (circle 10 'solid 'red)]
                 #:position   [p   (posn 100 100)]
                 #:speed      [spd 10]
                 #:key-mode   [key-mode 'arrow-keys]
                 #:mouse-aim? [mouse-aim? #f]
                 #:components [c #f]
                               . custom-components)
  (define dead-frame (if (image? sprite)
                         (rotate -90 sprite)
                         (rotate -90 (render sprite))))
  (sprite->entity sprite
                  #:name       "player"
                  #:position   p
                  #:components (physical-collider)
                               (sound-stream)
                               (precompiler dead-frame)
                               (key-movement spd #:mode key-mode #:rule (and/r all-dialog-closed?
                                                                               (not/r lost?)))
                               (key-animator-system #:mode key-mode #:face-mouse? mouse-aim?)
                               (stop-on-edge)
                               (backpack-system #:components (observe-change backpack-changed? update-backpack))
                               (player-edge-system)
                               ;(on-key "o" #:rule player-info-closed? show-move-info)
                               (observe-change lost? (kill-player))
                               ;(on-key "i" #:rule (λ (g e) (not (get-entity "instructions" g)))
                               ;        (spawn instructions-entity #:relative? #f))
                               ;(on-key "m" (open-mini-map #:close-key "m"))
                               (counter 0)
                               (on-key 'enter #:rule player-dialog-open? (get-dialog-selection))
                               (on-rule (not/r all-dialog-closed?) (stop-movement))
                               (cons c custom-components)))


(define/log "surival-game"
  (survival-game #:bg              [bg-ent (plain-bg-entity)]
                 #:headless        [headless #f]
                 #:avatar          [p         #f #;(custom-avatar)]
                 #:starvation-rate [sr 50]
                 #:npc-list        [npc-list  '() #;(list (random-npc (posn 200 200)))]
                 #:coin-list       [coin-list '() #;(list (coin #:entity (coin-entity) #:amount-in-world 10))]
                 #:food-list       [f-list    '() #;(list (food #:entity (carrot-entity) #:amount-in-world 10)
                                                         (food #:entity carrot-stew #:heals-by 20))]
                 #:crafter-list    [c-list    '() #;(list (custom-crafter))]
                 #:other-entities  [ent #f]
                                   . custom-entities)

  (define bg-with-instructions
    (add-components bg-ent (on-key "i" #:rule (λ (g e) (not (get-entity "instructions" g)))
                                   (spawn instructions-entity #:relative? #f))))
  
  (define player-with-recipes
    (if p
        (add-components p (map recipe->system known-recipes-list))
        #f))

  (define (add-random-start-pos e)
    (define world-amt (get-storage-data "amount-in-world" e))
    (if (> world-amt 0) 
        (add-components e (hidden)
                          (on-start (do-many (active-on-random)
                                             (respawn 'anywhere)
                                             show)))
        e))

  (define (food->toast-entity f)
    (define heal-amt (get-storage-data "heals-by" f))
    (player-toast-entity (~a "+" heal-amt) #:color "green"))

  (define starvation-period (max 1 (- 100 (min 100 sr))))

  (define food-img-list (map (λ (f) (render (get-component f animated-sprite?))) f-list))

  
  (define (health-entity)
    (define max-health 100)

    (define e (health-bar-entity #:max 100
                                 #:starvation-period starvation-period
                                 #:change-by         -1))

    (~> e
        (update-entity _ posn? (posn 100 20))
        (add-components _
                        (precompiler (player-toast-entity "-1" #:color "orangered"))
                        (apply precompiler (map food->toast-entity f-list))
                        (apply precompiler f-list)
                       ; (precompiler all-backpack-stacks)
                        (map food->component f-list)
                        (do-every starvation-period
                                  (spawn (player-toast-entity "-1" #:color "orangered") #:relative? #f)))))

  (define (score-entity)
    (define bg (~> (rectangle 1 1 'solid (make-color 0 0 0 100))
                   (new-sprite _ #:animate #f)
                   (set-x-scale 75 _)
                   (set-y-scale 14 _)
                   ))
    
    (sprite->entity bg
                    #:name       "score"
                    #:position   (posn 380 20)
                    #:components (static)
                                 (new-sprite "Gold: 0" #:y-offset -7 #:scale 0.7 #:color 'yellow)
                                 (counter 0)
                                 (layer "ui")
                                 (map coin->component coin-list)))
  
  (define updated-food-list (map add-random-start-pos f-list))
  (define updated-coin-list (map add-random-start-pos coin-list))
  
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
              
                       (map (λ (c) (entity-cloner c (get-storage-data "amount-in-world" c))) updated-coin-list)
                       (map (λ (f) (entity-cloner f (get-storage-data "amount-in-world" f))) updated-food-list)

                       (cons ent custom-entities)
              
                       bg-with-instructions))))


  (displayln (~a "Score estimation for your game: " (score-game es)))
  
  (if headless
      (initialize-game es)
      (apply start-game es))
  
  )

#|(define/log "food"
  (food #:entity [entity (carrot-entity)] #:heals-by [heal-amt 5] #:amount-in-world [world-amt 0])
  (list entity heal-amt world-amt))

(define/log "coin"
  (coin #:entity entity #:value [val 10] #:amount-in-world [world-amt 10])
  (list entity val world-amt))
|#

(define known-recipes-list '())

(define/log "crafting-menu-set!"
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


(define (custom-npc #:sprite     [s (row->sprite (random-character-row) #:delay 4)]
                    #:position   [p (posn 0 0)]
                    #:name       [name (first (shuffle (list "Adrian" "Alex" "Riley"
                                                             "Sydney" "Charlie" "Andy")))]
                    #:tile       [tile 0]
                    #:dialog     [d  #f]
                    #:mode       [mode 'wander]
                    #:game-width [GAME-WIDTH 480]
                    #:speed      [spd 2]
                    #:target     [target "player"]
                    #:sound      [sound #t]
                    #:scale      [scale 1]
                    #:components [c #f] . custom-components )
  
  (define dialog
    (if (not d)
        (dialog->sprites (first (shuffle (list (list "Hello.")
                                           (list "Hi! Nice to meet you!")
                                           (list "Sorry, I don't have time to talk now.")
                                           (list "The weather is nice today."))))
                     #:game-width GAME-WIDTH
                     #:animated #t
                     #:speed 4)
        (if (string? (first d))
            (dialog->sprites d
                             #:game-width GAME-WIDTH
                             #:animated #t
                             #:speed    4)
            (dialog->response-sprites d
                                      #:game-width GAME-WIDTH
                                      #:animated #t
                                      #:speed 4))))
  
  (define sprite (if (image? s)
                     (new-sprite s)
                     s))
  
  (create-npc #:sprite      sprite
              #:name        name
              #:position    p
              #:active-tile tile
              #:dialog      dialog
              #:mode        mode
              #:speed       spd
              #:target      target
              #:sound       sound
              #:scale       scale
              #:components  (cons c custom-components)))



(define (custom-background #:bg-img     [bg FOREST-BG]
                           #:rows       [rows 3]
                           #:columns    [cols 3]
                           #:start-tile [t 0]
                           #:components [c #f]
                                        . custom-components)
  (define backdrop
    (bg->backdrop bg #:rows rows #:columns cols #:start-tile t))
  (sprite->entity (render-tile backdrop)
                  #:name "bg"
                  #:position (posn 0 0)
                  #:components backdrop
                               (cons c custom-components)))

(define (safe-update-entity e component-pred f)
  (if f
      (update-entity e component-pred f)
      e))

(define (custom-food #:entity           [base-entity (carrot-entity)]
                     #:sprite           [s #f]
                     #:position         [p #f]
                     #:name             [n #f]
                     #:tile             [t #f]
                     #:amount-in-world  [world-amt 0]
                     #:heals-by         [heal-amt 10]
                     #:respawn?         [respawn? #t]
                     #:components       [c #f]
                                        . custom-entities)
  (define sprite (cond [(image? s)           (new-sprite s)]
                       [(animated-sprite? s) s             ]
                       [else              #f]))
  (define name   (if n (entity-name n) #f))
  (define tile   (if t (active-on-bg t) #f))
  (define new-entity (~> base-entity
                         (safe-update-entity _ animated-sprite? sprite)
                         (safe-update-entity _ posn? p)
                         (safe-update-entity _ entity-name? name)
                         (safe-update-entity _ active-on-bg? tile)
                         (add-components _ (storage "amount-in-world" world-amt)
                                           (storage "heals-by"        heal-amt)
                                           (cons c custom-entities))))
  (if respawn?
      (add-components new-entity (on-key 'space #:rule (and/r near-player?
                                                              (nearest-to-player? #:filter (has-component? on-key?)))
                                         (do-many (respawn 'anywhere)
                                                  (active-on-random))))
      (add-components new-entity (on-key 'space #:rule (and/r near-player?
                                                              (nearest-to-player? #:filter (has-component? on-key?)))
                                         die))))

(define (custom-coin #:entity           [base-entity (coin-entity)]
                     #:sprite           [s #f]
                     #:position         [p #f]
                     #:name             [n #f]
                     #:tile             [t #f]
                     #:amount-in-world  [world-amt 10]
                     #:value            [val 10]
                     #:respawn?         [respawn? #t]
                     #:components       [c #f]
                                        . custom-entities)
  (define sprite (cond [(image? s)           (new-sprite s)]
                       [(animated-sprite? s) s             ]
                       [else              #f]))
  (define name   (if n (entity-name n) #f))
  (define tile   (if t (active-on-bg t) #f))
  (define new-entity (~> base-entity
                         (safe-update-entity _ animated-sprite? sprite)
                         (safe-update-entity _ posn? p)
                         (safe-update-entity _ entity-name? name)
                         (safe-update-entity _ active-on-bg? tile)
                         (add-components _ (storage "amount-in-world" world-amt)
                                           (storage "value"           val)
                                           (cons c custom-entities))))
  (if respawn?
      (add-components new-entity (on-key 'space #:rule (and/r near-player?
                                                              (nearest-to-player? #:filter (has-component? on-key?)))
                                         (do-many (respawn 'anywhere)
                                                  (active-on-random))))
      (add-components new-entity (on-key 'space #:rule (and/r near-player?
                                                              (nearest-to-player? #:filter (has-component? on-key?)))
                                         die))))


(module+ test
  (survival-game
   #:avatar (custom-avatar)
   #:coin-list (list (custom-coin))
   #:food-list (list (custom-food #:entity (carrot-entity)
                                  #:amount-in-world 30))))








