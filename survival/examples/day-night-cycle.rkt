#lang survival

(require ts-kata-util survival threading)

(define-kata-code survival day-night-cycle
  (define (night-sky)
    (sprite->entity (~> (new-sprite (square 1 'solid (make-color 0 0 0 100)))
                        (set-x-scale 480 _)
                        (set-y-scale 360 _))
                    #:position (posn 0 0)
                    #:name "night sky"
                    #:components (layer "tops")
                                 (hidden)
                                 (on-start (do-many (go-to-pos 'center)
                                                    show))
                                 (on-rule  (reached-game-count? 2000) die)))

  (define (tm-entity)
    (time-manager-entity
     #:components (on-rule (reached-game-count? 1000) (do-many (spawn (night-sky) #:relative? #f)
                                                               (spawn random-enemy #:relative? #f)
                                                               (spawn random-enemy #:relative? #f)
                                                               (spawn random-enemy #:relative? #f)
                                                               (spawn random-enemy #:relative? #f)
                                                               (spawn random-enemy #:relative? #f)
                                                               (spawn random-enemy #:relative? #f)
                                                               (spawn random-enemy #:relative? #f)
                                                               (spawn random-enemy #:relative? #f)
                                                               (spawn random-enemy #:relative? #f)
                                                               (spawn random-enemy #:relative? #f)
                                                               (spawn random-enemy #:relative? #f)
                                                               (spawn random-enemy #:relative? #f)
                                                               (spawn random-enemy #:relative? #f)
                                                               (spawn random-enemy #:relative? #f)
                                                               (spawn random-enemy #:relative? #f)
                                                               (spawn random-enemy #:relative? #f)
                                                               (spawn random-enemy #:relative? #f)
                                                               (spawn random-enemy #:relative? #f)
                                                               (spawn random-enemy #:relative? #f)
                                                               (spawn random-enemy #:relative? #f)
                                                              ))
                  (on-rule (reached-game-count? 2000) (set-counter 0))))

  (define (game-count-between min max)
    (lambda (g e)
      (define game-count (get-counter (get-entity "time manager" g)))
      (and (>= game-count min)
           (<= game-count max))))
      

  (define (random-enemy)
    (custom-enemy #:amount-in-world 10
                  #:components (on-rule (game-count-between 0 1000) die)))

  (survival-game
   #:bg     (custom-background #:bg-img SNOW-BG)
   #:avatar (custom-avatar #:sprite (random-character-sprite))
   #:starvation-rate -200
   ;#:coin-list  (list (custom-coin))
   ;#:npc-list   (list (custom-npc))
   ;#:enemy-list (list (curry custom-enemy #:amount-in-world 10
   ;                                       #:components (on-rule (reached-game-count? 0) die))
   #:food-list (list (custom-food #:name "Carrot"
                                  #:sprite carrot-sprite
                                  #:amount-in-world 10)
                     (custom-food #:name "Carrot Stew"
                                  #:sprite carrot-stew-sprite
                                  #:heals-by 40
                                  #:respawn? #f))
   #:crafter-list (list (custom-crafter))
   #:other-entities (tm-entity))

  )

