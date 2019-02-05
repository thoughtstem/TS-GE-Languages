#lang racket

(require ts-kata-util
         "./lang/main.rkt"
         battle-arena-starwars)


;(define-example-code/from* battle-arena/examples) making my own examples here

;If you want to hook into any of the exported
;  syntax:kata-names, this would be the file to do that.
;You can't see them, but they are here, defined by
;  define-example-code/from*

(define-example-code battle-arena-starwars hero-1
 (starwars-game
   #:hero (custom-hero))
  )

(define-example-code battle-arena-starwars hero-2
 (starwars-game
   #:hero (custom-hero #:sprite (star 20 'solid 'yellow)))
  )

(define-example-code battle-arena-starwars hero-3
 (starwars-game
   #:hero (custom-hero #:sprite yoda-sprite))
  )

; ---------------

(define-example-code battle-arena-starwars enemy-1
 (starwars-game
   #:enemy-list (list (custom-villain)))
  )

(define-example-code battle-arena-starwars enemy-2
  (define my-enemy
    (custom-villain #:ai              'easy
                    #:health          200
                    #:shield          100
                    #:amount-in-world 5))

  (starwars-game 
   #:enemy-list (list my-enemy))
  )

(define-example-code battle-arena-starwars enemy-3
  (define my-enemy
    (custom-villain #:sprite darthvader-sprite
                    #:ai     'medium
                    #:health 200))
  
  (starwars-game 
   #:enemy-list (list my-enemy))
  )

; ---------------

(define-example-code battle-arena-starwars enemy-weapon-1
  (starwars-game 
   #:enemy-list (list (custom-villain
                       #:weapon (custom-blaster
                                 #:color "yellow"))))
  )

(define-example-code battle-arena-starwars enemy-weapon-2
  (starwars-game 
   #:enemy-list (list (custom-villain
                       #:sprite darthvader-sprite
                       #:weapon (custom-lightsaber
                                 #:color "red"))))
  )

(define-example-code battle-arena-starwars enemy-weapon-3 
  (define my-weapon
    (custom-lightsaber 
     #:dart (double-lightsaber)))
 
  (starwars-game 
   #:enemy-list (list (custom-villain
                       #:sprite darthmaul-sprite
                       #:weapon my-weapon)))
  )

; ---------------

(define-example-code battle-arena-starwars lightsaber-1
  (starwars-game
   #:weapon-list (list (custom-lightsaber)))
  )

(define-example-code battle-arena-starwars lightsaber-2
  (define my-lightsaber
    (custom-lightsaber #:name   "Flashy"
                       #:icon   (make-icon "F" "blue")
                       #:rarity 'rare))
  
  (starwars-game
   #:weapon-list (list my-lightsaber))
  )


(define-example-code battle-arena-starwars lightsaber-3
  (define my-blade
    (lightsaber #:color      "blue"
                #:damage     25
                #:durability 30))
    
  (define my-lightsaber
    (custom-lightsaber #:name   "Flashy"
                       #:icon   (make-icon "F" "blue")
                       #:rarity 'rare
                       #:dart my-blade))
  
  (starwars-game
   #:weapon-list (list my-lightsaber))
  )

; ---------------

(define-example-code battle-arena-starwars blaster-1
  (starwars-game
   #:weapon-list (list (custom-blaster)))
  )

(define-example-code battle-arena-starwars blaster-2
  (define my-blaster
    (custom-blaster
     #:name   "Blasty"
     #:icon   (make-icon "B" "orange")
     #:rarity 'legendary))
  
  (starwars-game
   #:weapon-list (list my-blaster))
  )


(define-example-code battle-arena-starwars blaster-3
  (define my-dart
    (blaster-dart #:color      "orange"
                  #:damage     20
                  #:durability 25
                  #:speed      10
                  #:range      70))
  
  (define my-blaster
    (custom-blaster  #:dart   my-dart
                     #:name   "Blasty"
                     #:rarity 'legendary
                     #:icon   (make-icon "B" "orange")))

  (starwars-game
   #:weapon-list (list my-blaster))
  )

;We'll test that the examples all run as games for 10 ticks
(test-all-examples-as-games 'battle-arena-starwars)
