#lang survival
(define (night-sky)
 (sprite->entity (new-sprite (rectangle 4.8 3.6 'solid (make-color 0 0 0 100))
                             #:scale 100)
                 #:position (posn 0 0)
                 #:name "night sky"
                 #:components (layer "ui")
                              (hidden)
                              (on-start (do-many (go-to-pos 'center)
                                                 show))
                              (on-rule  (reached-game-count? 1000) die)))

(define (tm-entity)
 (time-manager-entity
  #:components (on-rule (reached-game-count? 500)(spawn (night-sky) #:relative? #f))
               (on-rule (reached-game-count? 1000) (set-counter 0))))

(survival-game
#:bg     (custom-background #:bg-img SNOW-BG)
#:avatar (custom-avatar #:sprite (random-character-sprite))
#:starvation-rate -200


#:enemy-list (list (curry custom-enemy #:amount-in-world 10))
#:food-list (list (custom-food #:name "Carrot"
                               #:sprite carrot-sprite
                               #:amount-in-world 10)
                  (custom-food #:name "Carrot Stew"
                               #:sprite carrot-stew-sprite
                               #:heals-by 40
                               #:respawn? #f))
#:crafter-list (list (custom-crafter))
#:other-entities (tm-entity))
