#lang survival

(require ts-kata-util survival threading)

(define-kata-code survival day-night-cycle
  (define LENGTH-OF-DAY 2000)
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
                                 (on-rule  (reached-multiple-of? LENGTH-OF-DAY) die)))

  (define (day-time? g e)
    (define game-count (get-counter (get-entity "time manager" g)))
    (< (modulo game-count LENGTH-OF-DAY) (/ LENGTH-OF-DAY 2)))

  (define (reached-multiple-of? num #:offset [offset 0])
    (lambda (g e)
      (define game-count (get-counter (get-entity "time manager" g)))
      (= (modulo (+ game-count offset) num) 0)))

  (define (tm-entity)
    (time-manager-entity
     #:components (on-rule (reached-multiple-of? LENGTH-OF-DAY #:offset (/ LENGTH-OF-DAY 2))
                           (do-many (spawn (night-sky) #:relative? #f)
                                    (spawn-on-current-tile random-enemy)
                                    (spawn-on-current-tile random-enemy)
                                    (spawn-on-current-tile random-enemy)
                                    (spawn-on-current-tile random-enemy)
                                    (spawn-on-current-tile random-enemy)
                                    (spawn-on-current-tile random-enemy)
                                    (spawn-on-current-tile random-enemy)
                                    (spawn-on-current-tile random-enemy)
                                    (spawn-on-current-tile random-enemy)
                                    (spawn-on-current-tile random-enemy)
                                    (spawn-on-current-tile random-enemy)
                                    (spawn-on-current-tile random-enemy)
                                    (spawn-on-current-tile random-enemy)
                                    (spawn-on-current-tile random-enemy)
                                    (spawn-on-current-tile random-enemy)
                                    (spawn-on-current-tile random-enemy)
                                    (spawn-on-current-tile random-enemy)
                                    (spawn-on-current-tile random-enemy)
                                    ))))

  (define (game-count-between min max)
    (lambda (g e)
      (define game-count (get-counter (get-entity "time manager" g)))
      (and (>= game-count min)
           (<= game-count max))))
  
  (define (store-birth-time g e)
    (define game-count (get-counter (get-entity "time manager" g)))
    (add-components e (storage "birth-time" game-count)))

  (define (should-be-dead? g e)
    (define game-count (get-counter (get-entity "time manager" g)))
    (define birth-time (get-storage-data "birth-time" e))
    (and birth-time
         (>= (- game-count birth-time) (/ LENGTH-OF-DAY 2))))
  
  (define (random-enemy)
    (custom-enemy #:amount-in-world 10
                  #:components (on-start store-birth-time)
                               (on-rule day-time? die)
                               (on-rule should-be-dead? die)))

  (survival-game
   #:bg     (custom-background #:bg-img SNOW-BG)
   #:avatar (custom-avatar #:sprite (random-character-sprite)
                           #:key-mode 'wasd
                           #:mouse-aim? #t)
   #:starvation-rate 20
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

