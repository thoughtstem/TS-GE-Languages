#lang racket

(require ts-kata-util
         k2/lang/ocean/fish
         k2/lang/classroom/basic
         #;k2/lang/hero/basic
         )

(define-example-code k2/lang/classroom/basic
  demo-0
  (say 'A))

(define-example-code k2/lang/classroom/basic
  demo-2
  (sign 'A))

(define-example-code k2/lang/classroom/basic
  demo-3
  (say 'B))

(define-example-code k2/lang/classroom/basic
  demo-4
  (sign 'B))

(define-example-code k2/lang/classroom/basic
  demo-5
  (say 'C))

(define-example-code k2/lang/classroom/basic
  demo-6
  (sign 'C))

(define-example-code k2/lang/classroom/basic
  demo-7
  (say 'A)
  (say 'B)
  (say 'C))

(define-example-code k2/lang/classroom/basic
  demo-8
  (sign 'A)
  (sign 'B)
  (sign 'C))

(define-example-code k2/lang/classroom/basic
  demo-10
  (say 'A)
  (sign 'B)
  (sign 'C))

(define-example-code k2/lang/classroom/basic
  demo-11
  (whenever (hear 'A)
            (say 'A)) )

(define-example-code k2/lang/classroom/basic
  demo-12
  (whenever (hear 'A)
            (sign 'A)) )

(define-example-code k2/lang/classroom/basic
  demo-13
  (whenever (hear 'B)
            (sign 'B)) )

(define-example-code k2/lang/classroom/basic
  demo-14
  (whenever (hear 'C)
            (sign 'C)) )

(define-example-code k2/lang/classroom/basic
  demo-15
  (whenever (hear 'A)
            (sign 'A))
  (whenever (hear 'B)
            (sign 'B))
  (whenever (hear 'C)
            (sign 'C)))

(define-example-code k2/lang/classroom/basic
  demo-16
  (whenever (see 'A)
            (say 'A))
  (whenever (see 'B)
            (say 'B))
  (whenever (see 'C)
            (say 'C)))

(define-example-code k2/lang/classroom/basic
  demo-17
  (whenever (see 'A)
            (sign 'A))
  (whenever (see 'B)
            (sign 'B))
  (whenever (see 'C)
            (sign 'C)))

(define-example-code k2/lang/classroom/basic
  demo-18
  (assign 'Left-Side
          (whenever (see 'A)
                    (say 'A)))

  (assign 'Right-Side
          (whenever (hear 'A)
                    (say 'A))))

(define-example-code k2/lang/classroom/basic
  demo-19
  (assign 'Right-Side
          (whenever (see 'A)
                    (say 'A)))

  (assign 'Left-Side
          (whenever (hear 'A)
                    (say 'A))))

(define-example-code k2/lang/classroom/basic
  demo-20
  (assign 'Left-Side
          (whenever (see 'A)
                    (say 'A))
          (whenever (see 'B)
                    (say 'B))
          (whenever (see 'C)
                    (say 'C)))

  (assign 'Right-Side
          (whenever (hear 'A)
                    (say  'A))
          (whenever (hear 'B)
                    (say  'B))
          (whenever (hear 'C)
                    (say  'C))))


(define-example-code k2/lang/classroom/basic
  demo-bots-1
  (assign 'Controller
          (whenever (want)
                    (sign 'A)))

  (assign 'Bot
          (whenever (see 'A)
                    (step 'Forward))))

(define-example-code k2/lang/classroom/basic
  demo-bots-2
  (assign 'Controller
          (whenever (want)
                    (sign 'A))
          (whenever (want)
                    (sign 'B))
          (whenever (want)
                    (sign 'C)))

  (assign 'Bot
          (whenever (see 'A)
                    (step 'Forward))
          (whenever (see 'B)
                    (turn 'Right))
          (whenever (see 'C)
                    (turn 'Left))))

(define-example-code k2/lang/classroom/basic
  demo-bots-3
  (assign 'Controller
          (whenever (want)
                    (sign 'A))
          (whenever (want)
                    (sign 'B))
          (whenever (want)
                    (sign 'C)))

  (assign 'Red-Bot 'Blue-Bot
          (whenever (see 'A)
                    (step 'Forward))
          (whenever (see 'B)
                    (turn 'Right))
          (whenever (see 'C)
                    (turn 'Left))) )


(define-example-code k2/lang/classroom/basic
  intro-0a
  
  (say 'A)

  (sit)

  (breathe 1)

  (stand)

  (step 1))

(define-example-code k2/lang/classroom/basic
  intro-0b
  
  (say 'A)

  (sit)

  (breathe 1)

  (stand)

  (step 1)

  (say 'B)

  (sign 'A)

  (turn 1)

  (step 2)

  (sign 'B)

  (breathe 2)

  (turn 2))

(define-example-code k2/lang/classroom/basic
  intro-1

  (whenever (hear 'A)
            (say 'W))

  (whenever (hear 'B)
            (sit))

  (whenever (hear 'C)
            (stand))

  (whenever (hear 'D)
            (step 1))

  (whenever (hear 'E)
            (breathe 1)))

(define-example-code k2/lang/classroom/basic
  intro-2

  (whenever (hear 'A)
            (say 'Z))

  (whenever (hear 'B)
            (sit))

  (whenever (hear 'C)
            (stand))

  (whenever (hear 'D)
            (step 1))

  (whenever (hear 'E)
            (breathe 1))

  (whenever (hear 'F)
            (sign 'A))

  (whenever (hear 'G)
            (turn 1))

  (whenever (hear 'H)
            (step 2))

  (whenever (hear 'I)
            (sign 'B))

  (whenever (hear 'J)
            (turn 2)))

(define-example-code k2/lang/classroom/basic
  intro-3

  (assign 'Red
          (whenever (hear 'A)
                    (say 'A))

          (whenever (hear 'B)
                    (sit))

          (whenever (hear 'C)
                    (stand)))

  (assign 'Blue
          (whenever (hear 'D)
                    (step 1))

          (whenever (hear 'E)
                    (say 'B))

          (whenever (hear 'F)
                    (sign 'A))))

(define-example-code k2/lang/classroom/basic
  intro-4

  (assign 'Red
          (whenever (hear 'A)
                    (say 'B))

          (whenever (hear 'C)
                    (say 'D))

          (whenever (hear 'E)
                    (say 'F))

          (whenever (hear 'E)
                    (sit)))

  (assign 'Blue
          (whenever (hear 'B)
                    (say 'C))

          (whenever (hear 'D)
                    (say 'E))

          (whenever (hear 'F)
                    (say 'G))

          (whenever (hear 'F)
                    (sit))))



(define-example-code k2/lang/classroom/basic
  warm-ups-asl-0
  
  (whenever (hear  'A)
            asl:a)

  (whenever (hear 'B)
            asl:b)

  (whenever (hear 'C)
            asl:c)

  (whenever (hear 'D)
            asl:d))

(define-example-code k2/lang/classroom/basic
  warm-ups-asl-1
  
  (whenever (hear  'A)
            (sign 'A))

  (whenever (hear 'B)
            (sign 'B))

  (whenever (hear 'C)
            (sign 'C))

  (whenever (hear 'D)
            (sign 'D)))

(define-example-code k2/lang/classroom/basic
  warm-ups-asl-2
  
  (whenever (see  'A)
            (say 'A))

  (whenever (see 'B)
            (say 'B))

  (whenever (see 'C)
            (say 'C))

  (whenever (see 'D)
            (say 'D)))

(define-example-code k2/lang/classroom/basic
  bots-0
  
  (whenever (see  'A)
            (step 1))

  (whenever (see 'B)
            (turn 1))

  (whenever (see 'C)
            (breathe 1))

  (whenever (see 'D)
            (step 2)))

(define-example-code k2/lang/classroom/basic
  bots-1
  
  (whenever (see  'A)
            (turn 2))

  (whenever (see 'B)
            (turn 3))

  (whenever (see 'C)
            (step 1))

  (whenever (see 'D)
            (step 2)))


(define-example-code k2/lang/classroom/basic
  bots-2

  (assign 'Bots
          (whenever (hear 'A)
                    (step 1))

          (whenever (hear 'B)
                    (turn 2)))

  (assign 'Control
          (whenever (see 'A)
                    (say 'A))
          
          (whenever (see 'B)
                    (say 'B))))

(define-example-code k2/lang/classroom/basic
  bots-3

  (assign 'Bots
          (whenever (hear 'A)
                    (step 1))

          (whenever (hear 'B)
                    (turn 2)))

  (assign 'Control
          (whenever (see 'C)
                    (say 'A))
          
          (whenever (see 'D)
                    (say 'B))))



(define-example-code k2/lang/hero/basic
  hero-000
  blackwidow)

(define-example-code k2/lang/hero/basic
  hero-003
  (start gamora))

(define-example-code k2/lang/hero/basic
  hero-004
  (start ironman))

(define-example-code k2/lang/hero/basic
  hero-005
  (start blackwidow))

(define-example-code k2/lang/hero/basic
  hero-006
  (start blackwidow gamora ironman))

(define-example-code k2/lang/hero/basic
  hero-007
  (start ironman gamora blackwidow))

(define-example-code k2/lang/hero/basic
  hero-008
  (start ironman ironman))

(define-example-code k2/lang/hero/basic
  hero-009
  (start ironman ironman ironman ironman))

(define-example-code k2/lang/hero/basic
  hero-010
  (start gamora gamora gamora gamora gamora))

(define-example-code k2/lang/hero/powers
  hero-011
  (start ironman (gamora hammer)))

(define-example-code k2/lang/hero/powers
  hero-012
  (start ironman (gamora hammer) gamora gamora))

(define-example-code k2/lang/hero/powers
  hero-013
  (start ironman
         (gamora hammer)
         (gamora hammer)
         (gamora hammer)))

(define-example-code k2/lang/hero/powers
  hero-014
  (start ironman
         (drax hammer)
         (hawkeye hammer)
         (gamora hammer)))

(define-example-code k2/lang/hero/powers
  hero-015
  (start (ironman hammer)
         ironman
         ironman
         ironman
         ironman))

(define-example-code k2/lang/hero/powers
  hero-016
  (start (ironman hammer)
         (ironman hammer)
         (ironman hammer)
         (ironman hammer)
         (ironman hammer)))

(define-example-code k2/lang/hero/powers
  hero-017
  (start (ironman hammer)
         (ironman magic-orb)
         (ironman magic-orb)
         (ironman magic-orb)
         (ironman magic-orb)))

(define-example-code k2/lang/hero/powers
  hero-018
  (start (ironman hammer)
         (drax magic-orb)
         (drax magic-orb)
         (blackwidow hammer)
         (blackwidow hammer)))

(define-example-code k2/lang/hero/powers
  hero-019
  (start (ironman hammer)
         (drax magic-orb)
         (drax magic-orb)
         (blackwidow hammer)
         (blackwidow hammer)
         gamora
         gamora))

(define-example-code k2/lang/hero/powers
  hero-020
  (start (ironman (magic-orb red))))

(define-example-code k2/lang/hero/powers
  hero-021
  (start (ironman (star-bit red))))

(define-example-code k2/lang/hero/powers
  hero-022
  (start (ironman (energy-blast red))))

(define-example-code k2/lang/hero/powers
  hero-023
  (start (ironman (magic-orb red))
         (ironman (magic-orb orange))
         (ironman (magic-orb yellow))
         (ironman (magic-orb green))))

(define-example-code k2/lang/hero/powers
  hero-024
  (start (ironman (magic-orb red))
         (ironman (magic-orb orange))
         (ironman (magic-orb yellow))
         (ironman (magic-orb green))
         (ironman (magic-orb blue))
         (ironman (magic-orb purple))))

(define-example-code k2/lang/hero/powers
  hero-025
  (start (ironman (magic-orb red))
         (drax (magic-orb orange))
         (drax (magic-orb yellow))
         (drax (magic-orb green))
         (drax (magic-orb blue))
         (drax (magic-orb purple))))

(define-example-code k2/lang/hero/powers
  hero-026
  (start (ironman (magic-orb red))
         (drax hammer)
         (drax (star-bit yellow))
         (drax (star-bit yellow))
         (drax (energy-blast blue))
         (drax (energy-blast blue))
         ironman
         ironman))

(define-example-code k2/lang/hero/powers
  hero-027
  (start ironman gamora)
  (start ironman drax))

(define-example-code k2/lang/hero/powers
  hero-028
  (start ironman gamora)
  (start ironman drax)
  (start ironman hawkeye))

(define-example-code k2/lang/hero/powers
  hero-029
  (start ironman gamora)
  (start ironman gamora gamora)
  (start ironman gamora gamora gamora))

(define-example-code k2/lang/hero/powers
  hero-030
  (start ironman (gamora (magic-orb green)))
  (start ironman (gamora (magic-orb yellow)))
  (start ironman (gamora (magic-orb red))))

(define-example-code k2/lang/hero/powers
  hero-031
  (start ironman
         (gamora (magic-orb green)))
  (start ironman
         (gamora (magic-orb yellow))
         (gamora (magic-orb yellow)))
  (start ironman
         (gamora (magic-orb red))
         (gamora (magic-orb red))
         (gamora (magic-orb red))))

(define-example-code k2/lang/hero/powers
  hero-032
  (start ironman
         (gamora (magic-orb green)))
  (start ironman
         (drax (magic-orb yellow))
         (drax (magic-orb yellow)))
  (start ironman
         (hawkeye (magic-orb red))
         (hawkeye (magic-orb red))
         (hawkeye (magic-orb red))))

(define-example-code k2/lang/hero/powers
  hero-033
  (start ironman
         ironman
         (gamora (magic-orb green)))
  (start ironman
         ironman
         ironman
         (drax (magic-orb yellow))
         (drax (magic-orb yellow)))
  (start ironman
         ironman
         ironman
         ironman
         (hawkeye (magic-orb red))
         (hawkeye (magic-orb red))
         (hawkeye (magic-orb red))))

(define-example-code k2/lang/hero/powers
  hero-034
  (start (ironman (energy-blast green))
         (gamora (magic-orb green)))
  (start (ironman (energy-blast yellow))
         (drax (magic-orb yellow))
         (drax (magic-orb yellow)))
  (start (ironman (energy-blast red))
         (hawkeye (magic-orb red))
         (hawkeye (magic-orb red))
         (hawkeye (magic-orb red))))



(define-example-code k2/lang/ocean/fish
  fish-1
  (red fish))

(define-example-code k2/lang/ocean/fish
  fish-2
  (blue fish))

(define-example-code k2/lang/ocean/fish
  fish-3
  (beside
   (red fish)
   (blue fish)))

(define-example-code k2/lang/ocean/fish
  fish-4
  (above
   (red fish)
   (blue fish)))

(define-example-code k2/lang/ocean/fish
  fish-5
  (beside
   (above
    (red fish)
    (blue fish))
   (green fish)))

; ==== FARM/FOODS
(define-example-code k2/lang/farm/foods
  farm-001
  (start chicken
         (apple)))

(define-example-code k2/lang/farm/foods
  farm-002
  (start chicken
         (broccoli)))

(define-example-code k2/lang/farm/foods
  farm-003
  (start horse
         (broccoli apple onion)))

(define-example-code k2/lang/farm/foods
  farm-004
  (start horse
         (potato rand rand)))

(define-example-code k2/lang/farm/foods
  farm-005
  (start rand
         (rand rand rand)))

(define-example-code k2/lang/farm/foods
  farm-006
  (start rand
         (apple broccoli grapes onion potato tomato)))

(define-example-code k2/lang/farm/foods
  farm-007
  (start chicken
         ((apple 5) (tomato 5))))

(define-example-code k2/lang/farm/foods
  farm-008
  (start llama
         ((rand 3) (rand 5))))

(define-example-code k2/lang/farm/foods
  farm-009
  (start horse
         (rand (rand 2) (rand 3))))

(define-example-code k2/lang/farm/foods
  farm-010
  (start rabbit
         (rabbit)))

; ==== FARM/COINS

(define-example-code k2/lang/farm/coins
  farm-011
  (start cow
         (kiwi)
         (copper)))

(define-example-code k2/lang/farm/coins
  farm-012
  (start rand
         (rand)
         (rand)))

(define-example-code k2/lang/farm/coins
  farm-013
  (start sheep
         (kiwi rand)
         (silver rand)))

(define-example-code k2/lang/farm/coins
  farm-014
  (start rabbit
         ((banana 5) (apple 5))
         (gold)))

(define-example-code k2/lang/farm/coins
  farm-015
  (start rand
         ((kiwi 10))
         (copper)))

(define-example-code k2/lang/farm/coins
  farm-016
  (start rand
         ((rand 3) (rand 5))
         (rand rand)))

(define-example-code k2/lang/farm/coins
  farm-017
  (start rand
         (potato)
         (rand rand)))

(define-example-code k2/lang/farm/coins
  farm-018
  (start rand
         (rand rand)
         (copper silver gold)))

(define-example-code k2/lang/farm/coins
  farm-019
  (start potato
         ((silver 3))
         (apple)))

(define-example-code k2/lang/farm/coins
  farm-020
  (start rand
         (rand rand rand rand rand)
         (rand rand rand rand rand)))

; ==== FARM/ENEMIES

(define-example-code k2/lang/farm/enemies
  farm-021
  (start sheep
         (grapes)
         (silver)
         (dog)))

(define-example-code k2/lang/farm/enemies
  farm-022
  (start horse
         (pepper kiwi)
         (silver gold)
         (wolf)))

(define-example-code k2/lang/farm/enemies
  farm-023
  (start rand
         ((apple 3) (rand 5))
         (silver rand)
         (rand)))

(define-example-code k2/lang/farm/enemies
  farm-024
  (start wolf
         (apple (grapes 10))
         (kiwi pepper)
         (sheep cow)))

(define-example-code k2/lang/farm/enemies
  farm-025
  (start horse
         ((pepper 3) (grapes 3) (kiwi 3))
         (silver gold)
         ((dog 3) wolf)))

(define-example-code k2/lang/farm/enemies
  farm-026
  (start apple
         ((apple 5))
         (apple)
         ((apple 2))))

(define-example-code k2/lang/farm/enemies
  farm-027
  (start rand
         ((rand 5) (rand 5))
         (rand rand rand)
         (rand rand rand rand)))

(define-example-code k2/lang/farm/enemies
  farm-028
  (start rabbit
         (apple)
         (gold))
  (start rabbit
         (kiwi)
         (silver)
         (dog)))

(define-example-code k2/lang/farm/enemies
  farm-029
  (start rand
         ((apple 3) (grapes 5))
         (silver gold))
  (start rand
         (apple grapes)
         (copper silver)
         (wolf)))

(define-example-code k2/lang/farm/enemies
  farm-030
  (start horse
         ((apple 5) (grapes 5) (kiwi 5))
         (gold)
         (dog))
  (start llama
         ((apple 5) (grapes 5))
         (silver)
         ((dog 2) wolf))
  (start rabbit
         ((apple 5))
         (copper)
         ((wolf 3))))

; ==== SEA/FOODS
(define-example-code k2/lang/sea/foods
  sea-001
  (start yellow-fish
         (pineapple)))

(define-example-code k2/lang/sea/foods
  sea-002
  (start crab
         (kiwi)))

(define-example-code k2/lang/sea/foods
  sea-003
  (start red-fish
         (broccoli tomato apple)))

(define-example-code k2/lang/sea/foods
  sea-004
  (start starfish
         (pineapple rand rand)))

(define-example-code k2/lang/sea/foods
  sea-005
  (start rand
         (rand rand rand)))

(define-example-code k2/lang/sea/foods
  sea-006
  (start rand
         (pineapple broccoli kiwi tomato apple)))

(define-example-code k2/lang/sea/foods
  sea-007
  (start apple
         (broccoli)))

(define-example-code k2/lang/sea/foods
  sea-008
  (start pineapple
         (rand rand)))

(define-example-code k2/lang/sea/foods
  sea-009
  (start kiwi
         (rand rand rand)))

(define-example-code k2/lang/sea/foods
  sea-010
  (start green-fish
         (green-fish)))

; ==== SEA/COINS
; commented out to keep from funneling into summer collection

#;(define-example-code k2/lang/sea/coins
    sea-011
    (start shark
           (kiwi)
           (copper)))

#;(define-example-code k2/lang/sea/coins
    sea-012
    (start rand
           (rand)
           (rand)))

#;(define-example-code k2/lang/sea/coins
    sea-013
    (start octopus
           (pineapple rand)
           (silver rand)))

#;(define-example-code k2/lang/sea/coins
    sea-014
    (start jellyfish
           (broccoli apple)
           (gold)))

#;(define-example-code k2/lang/sea/coins
    sea-015
    (start rand
           (copper)
           (apple)))

#;(define-example-code k2/lang/sea/coins
    sea-016
    (start rand
           (rand rand)
           (rand rand)))

#;(define-example-code k2/lang/sea/coins
    sea-017
    (start rand
           (tomato)
           (rand rand)))

#;(define-example-code k2/lang/sea/coins
    sea-018
    (start rand
           (rand rand)
           (copper silver gold)))

#;(define-example-code k2/lang/sea/coins
    sea-019
    (start broccoli
           (rand)
           (rand)))

#;(define-example-code k2/lang/sea/coins
    sea-020
    (start rand
           (rand rand rand rand rand)
           (rand rand rand rand rand)))

; ==== SEA/ENEMIES

(define-example-code k2/lang/sea/enemies
  sea-021
  (start ghost-fish
         (strawberry)
         (shark)))

(define-example-code k2/lang/sea/enemies
  sea-022
  (start jellyfish
         (potato cherries)
         (red-fish)))

(define-example-code k2/lang/sea/enemies
  sea-023
  (start rand
         (rand mushroom)
         (rand)))

(define-example-code k2/lang/sea/enemies
  sea-024
  (start shark
         (apple strawberry)
         (crab jellyfish)))

(define-example-code k2/lang/sea/enemies
  sea-025
  (start strawberry
         (orange-fish octopus)
         (tomato kiwi banana)))

(define-example-code k2/lang/sea/enemies
  sea-026
  (start shark
         (shark)
         (shark)))

(define-example-code k2/lang/sea/enemies
  sea-027
  (start rand
         (rand rand)
         (rand rand rand rand)))

(define-example-code k2/lang/sea/enemies
  sea-028
  (start octopus
         (apple)
         (crab))
  (start octopus
         (cherries)
         (shark)))

(define-example-code k2/lang/sea/enemies
  sea-029
  (start rand
         (strawberry potato)
         (orange-fish))
  (start rand
         (strawberry potato)
         (jellyfish)))

(define-example-code k2/lang/sea/enemies
  sea-030
  (start rand
         (rand rand)
         (rand))
  (start rand
         (rand rand)
         (rand rand))
  (start rand
         (rand rand)
         (rand rand rand)))

;==== SEA/FRIENDS ====

(define-example-code k2/lang/sea/friends
  sea-031
  (start starfish
         (octopus)))

(define-example-code k2/lang/sea/friends
  sea-032
  (start jellyfish
         (green-fish orange-fish red-fish)))

(define-example-code k2/lang/sea/friends
  sea-033
  (start shark
         (yellow-fish ghost-fish)))

(define-example-code k2/lang/sea/friends
  sea-034
  (start crab
         (crab crab crab)))

(define-example-code k2/lang/sea/friends
  sea-035
  (start rand
         (red-fish starfish broccoli)))

(define-example-code k2/lang/sea/friends
  sea-036
  (start mushroom
         (apple kiwi pineapple broccoli)))

(define-example-code k2/lang/sea/friends
  sea-037
  (start rand
         (yellow-fish shark rand rand)))

(define-example-code k2/lang/sea/friends
  sea-038
  (start ghost-fish
         (starfish orange-fish))
  (start ghost-fish
         (crab rand rand rand)))

(define-example-code k2/lang/sea/friends
  sea-039
  (start rand
         (octopus rand rand))
  (start rand
         (green-fish rand rand)))

(define-example-code k2/lang/sea/friends
  sea-040
  (start rand
         (rand rand rand rand)))

; ==== ZOO/FOODS
(define-example-code k2/lang/zoo/foods
  zoo-001
  (start monkey
         (banana)))

(define-example-code k2/lang/zoo/foods
  zoo-002
  (start elephant
         (grapes)))

(define-example-code k2/lang/zoo/foods
  zoo-003
  (start hippo
         (apple potato onion)))

(define-example-code k2/lang/zoo/foods
  zoo-004
  (start kangaroo
         (apple rand rand)))

(define-example-code k2/lang/zoo/foods
  zoo-005
  (start rand
         (rand rand rand)))

(define-example-code k2/lang/zoo/foods
  zoo-006
  (start rand
         (apple banana grapes onion tomato)))

(define-example-code k2/lang/zoo/foods
  zoo-007
  (start apple
         (banana)))

(define-example-code k2/lang/zoo/foods
  zoo-008
  (start potato
         (rand rand)))

(define-example-code k2/lang/zoo/foods
  zoo-009
  (start grapes
         (rand rand rand)))

(define-example-code k2/lang/zoo/foods
  zoo-010
  (start hippo
         (rand rand rand rand rand rand)))

; ==== ZOO/COINS

(define-example-code k2/lang/zoo/coins
  zoo-011
  (start giraffe
         (apple)
         (copper)))

(define-example-code k2/lang/zoo/coins
  zoo-012
  (start rand
         (rand)
         (rand)))

(define-example-code k2/lang/zoo/coins
  zoo-013
  (start elephant
         (apple rand)
         (silver rand)))

(define-example-code k2/lang/zoo/coins
  zoo-014
  (start jellyfish
         (apple banana)
         (gold)))

(define-example-code k2/lang/zoo/coins
  zoo-015
  (start rand
         (copper)
         (apple)))

(define-example-code k2/lang/zoo/coins
  zoo-016
  (start rand
         (rand rand)
         (rand rand)))

(define-example-code k2/lang/zoo/coins
  zoo-017
  (start rand
         (apple)
         (rand rand)))

(define-example-code k2/lang/zoo/coins
  zoo-018
  (start rand
         (rand rand)
         (copper silver gold)))

(define-example-code k2/lang/zoo/coins
  zoo-019
  (start banana
         (rand)
         (rand)))

(define-example-code k2/lang/zoo/coins
  zoo-020
  (start rand
         (rand rand rand rand rand)
         (rand rand rand rand rand)))

;==== ZOO/FRIENDS ====

(define-example-code k2/lang/zoo/friends
  zoo-021
  (start zookeeper
         (monkey)))

(define-example-code k2/lang/zoo/friends
  zoo-022
  (start zookeeper
         (monkey elephant giraffe)))

(define-example-code k2/lang/zoo/friends
  zoo-023
  (start zookeeper
         (hippo kangaroo)))

(define-example-code k2/lang/zoo/friends
  zoo-024
  (start zookeeper
         (penguin penguin penguin)))

(define-example-code k2/lang/zoo/friends
  zoo-025
  (start rand
         (monkey monkey elephant elephant)))

(define-example-code k2/lang/zoo/friends
  zoo-026
  (start zookeeper
         (apple apple apple apple)))

(define-example-code k2/lang/zoo/friends
  zoo-027
  (start penguin
         (zookeeper zookeeper zookeeper)))

(define-example-code k2/lang/zoo/friends
  zoo-028
  (start zookeeper
         (monkey elephant))
  (start zookeeper
         (giraffe rand rand rand)))

(define-example-code k2/lang/zoo/friends
  zoo-029
  (start zookeeper
         (hippo rand rand))
  (start zookeeper
         (kangaroo rand rand)))

(define-example-code k2/lang/zoo/friends
  zoo-030
  (start zookeeper
         (rand rand rand rand)))
