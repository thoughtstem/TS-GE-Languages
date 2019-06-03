#lang racket

(require ts-kata-util
         "./lang/main.rkt"
         survival-pokemon)

(define-example-code/from* survival/examples)


;=================================

(define-example-code survival-pokemon alt/avatar-2
  (pokemon-game
   #:pokemon (custom-pokemon #:sprite bulbasaur-sprite))
  )

(define-example-code survival-pokemon alt/avatar-3
  (define (my-pokemon)
     (custom-pokemon #:sprite charmander-sprite
                     #:speed 20))
  
  (pokemon-game
   #:pokemon (my-pokemon))
  )

(define-example-code survival-pokemon alt/avatar-4
  (define (my-pokemon)
     (custom-pokemon #:sprite   armoredmewtwo-sprite
                     #:speed    25
                     #:key-mode 'wasd))
  
  (pokemon-game
   #:pokemon (my-pokemon))
  )

(define-example-code survival-pokemon alt/avatar-5
  (define (my-pokemon)
     (custom-pokemon #:sprite     armoredmewtwo-sprite
                     #:speed      20
                     #:key-mode   'wasd
                     #:health     200
                     #:max-health 200))
  
  (pokemon-game
   #:pokemon (my-pokemon))
  )

;=================================

(define-example-code survival-pokemon alt/coin-2
  (define (my-stone)
    (custom-stone #:value 500))
 
  (pokemon-game
   #:stone-list (list (my-stone)))
  )

(define-example-code survival-pokemon alt/coin-3
  (define (my-stone)
    (custom-stone #:sprite leafstone-sprite
                  #:name   "Leaf Stone"
                  #:value  100
                  #:amount-in-world 20))
 
  (pokemon-game
   #:stone-list (list (my-stone)))

  )

(define-example-code survival-pokemon alt/coin-4
  (define (my-stone)
    (custom-stone #:sprite moonstone-sprite
                  #:name   "Moon Stone"))
 
  (define (my-special-stone)
    (custom-stone #:sprite shinystone-sprite
                  #:name   "Shiny Stone"
                  #:value  1000
                  #:amount-in-world 1
                  #:respawn? #f))
 
  (pokemon-game
   #:stone-list (list (my-stone)
                      (my-special-stone)))

  )

(define-example-code survival-pokemon alt/coin-5
  (define (thunder-stone)
    (custom-coin #:sprite thunderstone-sprite
                 #:name   "Thunder Stone"
                 #:value  500
                 #:amount-in-world 5))
  
  (define (sun-stone)
    (custom-coin #:sprite          sunstone-sprite
                 #:name            "Sun Stone"
                 #:value           1000
                 #:amount-in-world 1
                 #:respawn?        #f))

  (survival-game
   #:coin-list  (list (custom-stone)
                      (thunder-stone)
                      (sun-stone)))
  )


;=================================

(define-example-code survival-pokemon alt/enemy-3
  (define (my-trainer)
    (custom-trainer #:ai 'medium
                    #:sprite james-sprite
                    #:amount-in-world 5))
 
  (pokemon-game
   #:trainer-list (list (my-trainer)))
  )

(define-example-code survival-pokemon alt/enemy-4
  (define (hard-trainer)
    (custom-trainer #:ai 'hard
                    #:sprite redgirl-sprite
                    #:amount-in-world 5
                    #:weapon (pokeball #:damage 50)))
  
  (pokemon-game
   #:trainer-list (list (hard-trainer)))
  )

(define-example-code survival-pokemon alt/enemy-5
  (define (easy-trainer)
    (custom-trainer #:ai 'medium
                    #:sprite greenboy-sprite
                    #:amount-in-world 5))
 
  (define (hard-trainer)
    (custom-trainer #:ai 'hard
                    #:sprite jessie-sprite
                    #:amount-in-world 5
                    #:night-only? #t))
 
  (pokemon-game
   #:trainer-list (list (easy-trainer)
                        (hard-trainer)))
  )

(define-example-code survival-pokemon alt/enemy-6
  (define (easy-trainer)
    (custom-trainer #:ai 'easy
                    #:sprite greenboy-sprite
                    #:amount-in-world 5))
 
  (define (medium-trainer)
    (custom-trainer #:ai 'medium
                    #:sprite redgirl-sprite
                    #:amount-in-world 3))

  (define (hard-trainer)
    (custom-trainer #:ai              'hard
                    #:sprite          james-sprite
                    #:amount-in-world 1
                    #:night-only?     #t
                    #:weapon          (pokeball #:damage 50)))
  
  (pokemon-game
   #:trainer-list (list (easy-trainer)
                        (medium-trainer)
                        (hard-trainer)))
  )

;=================================

(define-example-code survival-pokemon alt/npc-2
  (define (my-friend)
    (custom-friend #:sprite squirtle-sprite
                   #:name "Torty"))
  
  (pokemon-game
   #:friend-list (list (my-friend)))
  )

(define-example-code survival-pokemon alt/npc-3
  (define (my-friend)
    (custom-friend  #:dialog (list
                              "Woah, who are you??"
                              "Nevermind -- I'm too busy."
                              "Move along, now!")))
  
(pokemon-game
  #:friend-list (list (my-friend)))
  )

(define-example-code survival-pokemon alt/npc-4
  (define (my-friend)
    (custom-friend #:sprite wartortle-sprite
                   #:name "Torts"
                   #:tile 3
                   #:mode 'follow))
 
  (pokemon-game
   #:friend-list (list (my-friend)))
  )

(define-example-code survival-pokemon alt/npc-5
  (define (my-friend)
    (custom-friend #:name "Francis"
                   #:tile 4
                   #:dialog (list
                             "Greetings!"
                             "You better find some food soon...")))
 
  (define (another-friend)
    (custom-friend #:sprite ivysaur-sprite
                   #:mode 'pace
                   #:dialog (list
                             "Now where did I put it..."
                             "Have you seen a leaf stone?")))
 
  (pokemon-game
   #:friend-list (list (my-friend)
                       (another-friend)))
  )


  ;=================================


(define-example-code survival-pokemon alt/weapon-crafter-1
  (define my-attack-recipe
    (recipe #:product (fire-blast)
            #:build-time 20))
  
  (pokemon-game
   #:crafter-list (list (custom-crafter
                         #:recipe-list (list my-attack-recipe))))
  )

;======================================

(define-example-code survival-pokemon alt/bg-3
  (define (my-town)
    (custom-town
     #:image LAVA-BG
     #:rows 2
     #:columns 2))

  (pokemon-game
   #:town (my-town))
  )

;====================================================



(test-all-examples-as-games 'survival-pokemon)
