#lang survival

(require ts-kata-util survival threading)

(define-kata-code survival day-night-cycle
  ; CHANGEABLE BY STUDENTS:
  (define LENGTH-OF-DAY 2400)
  (define START-OF-DAYTIME (exact-round (* 0.1 LENGTH-OF-DAY)))
  (define END-OF-DAYTIME   (exact-round (* 0.9 LENGTH-OF-DAY)))
  (define MAX-ALPHA 150) ; max-darkness? min: 1 max: 255
  ; 'darkred 'midnightblue 'darkslategray 'darkmagenta 'indigo 'dimgray 'black
  (define SKY-COLOR 'darkmagenta)
  
  (define (night-sky #:color         [color 'black]
                     #:max-alpha     [max-alpha 180]
                     #:length-of-day [length-of-day 2400])
    (define update-interval (* 2 (/ length-of-day 2 max-alpha)))
    (define c (name->color color))
    (define r-val (color-red c))
    (define g-val (color-green c))
    (define b-val (color-blue c))
    (define (update-night-sky g e)
      (define game-count (get-counter (get-entity "time manager" g)))
      (define time-of-day (modulo game-count length-of-day))
      (define alpha-val (exact-round (abs (* (- (/ time-of-day length-of-day) .5) 2 max-alpha))))
      (define new-night-sky (~> (new-sprite (square 1 'solid (make-color r-val g-val b-val alpha-val)))
                                (set-x-scale 480 _)
                                (set-y-scale 360 _)))
      (update-entity e animated-sprite? new-night-sky))
    (sprite->entity (~> (new-sprite (square 1 'solid (make-color r-val g-val b-val max-alpha)))
                        (set-x-scale 480 _)
                        (set-y-scale 360 _))
                    #:position (posn 0 0)
                    #:name "night sky"
                    #:components (layer "tops")
                                 (hidden)
                                 (apply precompiler
                                        (map (λ (a)(square 1 'solid (make-color r-val g-val b-val a)))
                                             (range 255)))
                                 (on-start (do-many (go-to-pos 'center)
                                                    show))
                                 (do-every update-interval update-night-sky)
                                 ;(on-rule  (reached-multiple-of? LENGTH-OF-DAY) die)
                                 ))

  (define (tm-entity)
    (time-manager-entity
     #:components (on-rule (reached-multiple-of? LENGTH-OF-DAY #:offset END-OF-DAYTIME)
                           (do-many (spawn (player-toast-entity "NIGHTTIME HAS BEGUN"))
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
                                    ))
                   (on-rule (reached-multiple-of? LENGTH-OF-DAY #:offset START-OF-DAYTIME)
                            (spawn (player-toast-entity "DAYTIME HAS BEGUN")))
                   (on-key 't (start-stop-game-counter))
     ))


  ; === DAY/NIGHT FUNCTIONS FOR ENEMY ===
  (define (store-birth-time g e)
    (define game-count (get-counter (get-entity "time manager" g)))
    (add-components e (storage "birth-time" game-count)))

  ; typically between 6am (600) and 6pm (1800)
  (define (daytime? g e)
    (define game-count (get-counter (get-entity "time manager" g)))
    (define time-of-day (modulo game-count LENGTH-OF-DAY))
    (and (> time-of-day START-OF-DAYTIME)
         (< time-of-day END-OF-DAYTIME)))

  (define (should-be-dead? g e)
    (define game-count (get-counter (get-entity "time manager" g)))
    (define birth-time (get-storage-data "birth-time" e))
    (and birth-time
         (>= (- game-count birth-time) (- END-OF-DAYTIME START-OF-DAYTIME))))
  
  (define (random-enemy)
    (custom-enemy #:amount-in-world 10
                  #:components (on-start store-birth-time)
                               (on-rule daytime? die)
                               (on-rule should-be-dead? die)))
  
  (define (my-stew)
    (custom-food #:name "Carrot Stew"
                 #:sprite carrot-stew-sprite
                 #:heals-by 40
                 #:respawn? #f))
  
  (survival-game
   #:bg     (custom-background #:bg-img FOREST-BG)
   #:avatar (custom-avatar #:sprite (random-character-sprite)
                           #:key-mode 'wasd
                           #:mouse-aim? #t)
   #:starvation-rate 20
   
   ; === MOCKUP CUSTOM-SKY KATA ===
   #;#:sky #;(custom-sky #:night-sky-color  'darkmagenta
                         #:length-of-day    4000
                         #:start-of-daytime 1000
                         #:end-of-daytime   3000 
                         #:max-darkness     150
                         )
   
   #:coin-list  (list (custom-coin))
   #:npc-list   (list (custom-npc))
   #:enemy-list (list (custom-enemy #:sprite slime-sprite
                                    #:amount-in-world 10
                                    #:ai 'easy
                                    #:weapon (custom-weapon #:dart (acid #:damage 0))
                                    ;#:night-only? #t
                                    ))
   #:food-list  (list (custom-food #:name "Carrot"
                                   #:sprite carrot-sprite
                                   #:amount-in-world 10)
                      (my-stew)
                      )
   #:crafter-list (list (custom-crafter
                         #:menu (crafting-menu-set!
                                 #:recipes (recipe #:product (my-stew)
                                                   #:build-time 20
                                                   #:ingredients (list "Carrot")))))
   #:other-entities (tm-entity)
                    (night-sky #:color         SKY-COLOR
                               #:max-alpha     MAX-ALPHA
                               #:length-of-day LENGTH-OF-DAY))
  )

