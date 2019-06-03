#lang racket

(require ts-kata-util
         ;k2/lang/ocean/fish
         ;k2/lang/classroom/basic
         ;k2/lang/hero/basic
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

; ===== HERO - INTRO
(define-example-code k2/lang/hero/basic
  hero-000
  (start))

;===== HERO - BASIC
(define-example-code k2/lang/hero/basic
  hero-001
  (start ironman)
  )

(define-example-code k2/lang/hero/basic
  hero-002
  (start gamora)
  )

(define-example-code k2/lang/hero/basic
  hero-003
  (start gamora
         (nebula))
  )

(define-example-code k2/lang/hero/basic
  hero-004
  (start hulk
         (loki redskull mandarin))
  )

(define-example-code k2/lang/hero/basic
  hero-005
  (start ironman
         (captainamerica hulk))
  )

(define-example-code k2/lang/hero/basic
  hero-006
  (start captainamerica
         (captainamerica captainamerica))
  )

; ===== HERO - POWERS

(define-example-code k2/lang/hero/powers
  hero-007
  (start (thor hammer)
         (loki))
  )

(define-example-code k2/lang/hero/powers
  hero-008
  (start (starlord star-bit)
         (mandarin))
  )

(define-example-code k2/lang/hero/powers
  hero-009
  (start (gamora magic-orb)
         ((nebula energy-blast)))
  )

(define-example-code k2/lang/hero/powers
  hero-010
  (start (loki energy-blast)
         ((thor hammer)
          (starlord star-bit)))
  )

(define-example-code k2/lang/hero/powers
  hero-011
  (start (nebula energy-blast)
         ((rocketracoon star-bit)
         (gamora star-bit)
         (drax magic-orb)
         (starlord magic-orb)))
  )

(define-example-code k2/lang/hero/powers
  hero-012
  (start (thor randp)
         ((loki randp)
          (malekith randp)
          (mandarin randp)
          (nebula randp)))
  )

; ===== HERO - POWERS + COLORS

(define-example-code k2/lang/hero/powers
  hero-013
  (start (gamora magic-orb green )
         ((nebula energy-blast blue)))
  )

(define-example-code k2/lang/hero/powers
  hero-014
  (start (loki energy-blast yellow)
         ((thor hammer orange)
          (starlord star-bit purple)))
  )

(define-example-code k2/lang/hero/powers
  hero-015
  (start (nebula energy-blast green)
         ((rocketracoon star-bit red)
          (gamora star-bit red)
          (drax magic-orb red)
          (starlord magic-orb red)))
  )

(define-example-code k2/lang/hero/powers
  hero-016
  (start (loki star-bit)
         ((thor hammer red)
          (thor hammer orange)
          (thor hammer yellow)
          (thor hammer green)
          (thor hammer blue)
          (thor hammer purple)))
  )

(define-example-code k2/lang/hero/powers
  hero-017
  (start (gamora randp red)
         ((nebula randp orange)
          (mandarin randp yellow)))
  )

(define-example-code k2/lang/hero/powers
  hero-018
  (start (starlord randp randc)
         ((rocketracoon randp randc)
          (drax randp randc)
          (gamora randp randc)))
  )

; ===== HERO - ITEMS

(define-example-code k2/lang/hero/items
  hero-019
  (start (drax energy-blast)
         ((loki magic-orb)
          (thor hammer)))
  )

(define-example-code k2/lang/hero/items
  hero-020
  (start (ironman magic-orb red)
         ((mandarin energy-blast orange)
          (mandarin randp randc)))
  )

(define-example-code k2/lang/hero/items
  hero-021
  (start (ironman star-bit)
         ((nebula magic-orb)
          (loki energy-blast))
         (health forcefield))
  )

(define-example-code k2/lang/hero/items
  hero-022
  (start (thor hammer blue)
         ((loki randp randc)
          (mandarin randp randc))
         (grow shrink speed))
  )

(define-example-code k2/lang/hero/items
  hero-023
  (start (nebula star-bit randc)
         ((blackwidow randp red)
          (ironman energy-blast blue))
         (health speed))
  )

(define-example-code k2/lang/hero/items
  hero-024
  (start (ironman magic-orb red)
         ((ironman randp randc)
          (ironman randp randc)
          (ironman randp randc))
         (forcefield speed))
  )

; ===== HERO - ITEMS - MULTI-GAMES
(define-example-code k2/lang/hero/items
  hero-025
  (start (drax randp randc)
         ((loki randp randc)
          (malekith randp randc)
          (mandarin randp randc)
          (nebula randp randc))
         (health grow shrink speed forcefield))
  )

(define-example-code k2/lang/hero/items
  hero-026
  (start (thor hammer)
         ((loki magic-orb)
          (loki star-bit)))
  (start (thor hammer green)
         ((loki magic-orb red)
          (loki star-bit red)))
  )

(define-example-code k2/lang/hero/items
  hero-027
  (start (ironman magic-orb green)
         ((mandarin magic-orb red)))
  (start (ironman magic-orb green)
         ((mandarin magic-orb red))
          (mandarin magic-orb orange))
  (start (ironman magic-orb green)
         ((mandarin magic-orb red)
          (mandarin magic-orb orange)
          (mandarin magic-orb yellow)))
  )

(define-example-code k2/lang/hero/items
  hero-028
  (start (blackwidow randp randc)
         ((nebula randp randc)))
  (start (blackwidow randp randc)
         ((nebula randp randc)
          (nebula randp randc)))
  (start (blackwidow randp randc)
         ((nebula randp randc)
          (nebula randp randc))
         (health speed))
  )

(define-example-code k2/lang/hero/items
  hero-029
  (start (ironman randp randc)
         ((loki randp randc)))
  (start (drax randp randc)
         ((malekith randp randc)
          (mandarin randp randc)))
  (start (blackwidow randp randc)
         ((nebula randp randc)
          (loki randp randc))
         (health speed))
  )

(define-example-code k2/lang/hero/items
  hero-030
  (start (ironman randp randc)
         ((loki randp randc))
         (health))
  (start (drax randp randc)
         ((loki randp randc)
          (malekith randp randc))
         (health grow shrink))
  (start (blackwidow randp randc)
         ((loki randp randc)
          (malekith randp randc)
          (mandarin randp randc)
          (nebula randp randc))
         (health grow shrink speed forcefield))
  )



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

; ==== FARM/FOODS -- day 1
(define-example-code k2/lang/farm/foods
  farm-000
  (start))

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

; ==== FARM/COINS -- day 2

(define-example-code k2/lang/farm/coins
  farm-007
  (start cow
         ((apple 5) (kiwi 5))))

(define-example-code k2/lang/farm/coins
  farm-008
  (start llama
         ((rand 3) (rand 5))))

(define-example-code k2/lang/farm/coins
  farm-009
  (start cow
         (rand (rand 2) (rand 3))))

(define-example-code k2/lang/farm/coins
  farm-010
  (start rabbit
         (apple)
         (copper)))

(define-example-code k2/lang/farm/coins
  farm-011
  (start cow
         (kiwi)
         (gold)))

(define-example-code k2/lang/farm/coins
  farm-012
  (start rand
         (rand)
         (rand)))

; ==== FARM/COINS -- day 3

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

; ==== FARM/ENEMIES -- day 4

(define-example-code k2/lang/farm/enemies
  farm-019
  (start sheep
         (apple)
         (silver)
         (dog)))

(define-example-code k2/lang/farm/enemies
  farm-020
  (start rand
         (rand rand rand rand rand)
         (rand rand rand rand rand)))


(define-example-code k2/lang/farm/enemies
  farm-021
  (start sheep
         (kiwi grapes)
         (silver)
         (dog)))

(define-example-code k2/lang/farm/enemies
  farm-022
  (start horse
         (pepper kiwi)
         (silver gold)
         (dog wolf)))

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
;day 1 start
(define-example-code k2/lang/sea/foods
  sea-000
  (start))

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


; ==== SEA/COINS
; removed from katas. still can code, just needs to be last list in any lang

; ==== SEA/ENEMIES
;Day 2

(define-example-code k2/lang/sea/enemies
  sea-007
  (start ghost-fish
         (strawberry)
         (shark)))

(define-example-code k2/lang/sea/enemies
  sea-008
  (start jellyfish
         ((potato 5))
         (red-fish)))

(define-example-code k2/lang/sea/enemies
  sea-009
  (start rand
         (cherries)
         ((crab 5))))

(define-example-code k2/lang/sea/enemies
  sea-010
  (start shark
         ((apple 3) (strawberry 2))
         (crab jellyfish)))

(define-example-code k2/lang/sea/enemies
  sea-011
  (start strawberry
         (orange-fish octopus)
         ((banana 8))))

(define-example-code k2/lang/sea/enemies
  sea-012
  (start shark
         ((shark 5))
         ((shark 5))))

;Day 3

(define-example-code k2/lang/sea/enemies
  sea-013
  (start octopus
         (tomato kiwi)
         ((orange-fish 3))))

(define-example-code k2/lang/sea/enemies
  sea-014
  (start rand
         ((apple 10))
         ((rand 10))))

(define-example-code k2/lang/sea/enemies
  sea-015
  (start jellyfish
         (kiwi)
         ((jellyfish red))))

(define-example-code k2/lang/sea/enemies
  sea-016
  (start rand
         ((tomato purple 5))
         ((shark green 5))))

(define-example-code k2/lang/sea/enemies
  sea-017
  (start rand
         ((rand orange 3) (rand yellow 3))
         ((rand blue 2) (rand purple 2))))

(define-example-code k2/lang/sea/enemies
  sea-018
  (start rand
         (strawberry (potato yellow))
         (orange-fish))
  (start rand
         (strawberry (potato yellow))
         ((orange-fish 5))))

;==== SEA/FRIENDS ====
;Day 4

(define-example-code k2/lang/sea/friends
  sea-019
  (start starfish
         (octopus)))

(define-example-code k2/lang/sea/friends
  sea-020
  (start jellyfish
         (green-fish orange-fish red-fish)))

(define-example-code k2/lang/sea/friends
  sea-021
  (start shark
         ((yellow-fish 2) (ghost-fish 2))))

(define-example-code k2/lang/sea/friends
  sea-022
  (start crab
         ((crab red) (crab green) (crab purple))))

(define-example-code k2/lang/sea/friends
  sea-023
  (start rand
         ((rand 5))
         (pineapple broccoli)))

(define-example-code k2/lang/sea/friends
  sea-024
  (start rand
         ((yellow-fish 4))
         ((apple 4)))
  (start rand
         ((yellow-fish 4) (rand 4))
         ((apple blue 4))))

;Day 5

(define-example-code k2/lang/sea/friends
  sea-025
  (start rand
         (yellow-fish (shark blue) rand rand)))

(define-example-code k2/lang/sea/friends
  sea-026
  (start ghost-fish
         ((rand purple 5))
         ((mushroom orange 5))
         (shark)))

(define-example-code k2/lang/sea/friends
  sea-027
  (start rand
         (starfish orange-fish))
  (start rand
         (crab green-fish red-fish jellyfish)))

(define-example-code k2/lang/sea/friends
  sea-028
  (start rand
         ((octopus green 4))
         ((kiwi 4))
         ((crab 4)))
  (start rand
         ((rand green 4))
         ((rand 4))
         ((rand 4))))

(define-example-code k2/lang/sea/friends
  sea-029
  (start rand
         ((rand red) (rand orange) (rand yellow))
         ((rand rand rand))
         ((rand green) (rand blue) (rand purple))))

(define-example-code k2/lang/sea/friends
  sea-030
  (start rand
         ((starfish orange) (crab orange))
         ((broccoli orange) (kiwi orange))
         ((shark orange) (jellyfish orange)))
  (start rand
         ((orange-fish 3) (green-fish 3))
         ((pineapple 3) (mushroom 3))
         ((red-fish 3) (yellow-fish 3))))

; ==== ZOO/FOODS
(define-example-code k2/lang/zoo/foods
  zoo-000
  (start))

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

; ==== ZOO/FOOD+COINS DAY 2

(define-example-code k2/lang/zoo/coins
  zoo-007
  (start hippo
         ((apple 5) (banana 5))))

(define-example-code k2/lang/zoo/coins
  zoo-008
  (start hippo
         ((apple 3) (rand 5))))

(define-example-code k2/lang/zoo/coins
  zoo-009
  (start monkey
         ((banana red) (banana green) (banana blue))))

(define-example-code k2/lang/zoo/coins
  zoo-010
  (start hippo
         (rand purple 5)))

(define-example-code k2/lang/zoo/coins
  zoo-011
  (start penguin
         ((fish green 3)
          (fish red 5))))

(define-example-code k2/lang/zoo/coins
  zoo-012
  (start rand
         (rand)
         (gold green 5)))

; ==== ZOO/FARM+COINS DAY 3

(define-example-code k2/lang/zoo/coins
  zoo-013
  (start zookeeper
         (apple)
         (copper silver gold)))

(define-example-code k2/lang/zoo/coins
  zoo-014
  (start zookeeper
         (apple banana)
         ((gold 2) (silver 4) (copper 6))))

(define-example-code k2/lang/zoo/coins
  zoo-015
  (start rand
         ((rand 10))
         ((gold purple 10))))

(define-example-code k2/lang/zoo/coins
  zoo-016
  (start (penguin green)
         (fish blue 5)
         (gold red 10)))

(define-example-code k2/lang/zoo/coins
  zoo-017
  (start monkey
         (banana 10))
  (start monkey
         (banana 10)
         (silver 10)))

(define-example-code k2/lang/zoo/coins
  zoo-018
  (start rand
         (rand rand)
         ((copper 5)))
  (start rand
         (rand rand)
         ((gold 10))
         ))

;==== ZOO/FRIENDS DAY 4

(define-example-code k2/lang/zoo/friends
  zoo-019
  (start zookeeper
         (monkey)))

(define-example-code k2/lang/zoo/friends
  zoo-020
  (start zookeeper
         (monkey elephant giraffe)))

(define-example-code k2/lang/zoo/friends
  zoo-021
  (start zookeeper
         (hippo kangaroo)))

(define-example-code k2/lang/zoo/friends
  zoo-022
  (start zookeeper
         (penguin penguin penguin)))

(define-example-code k2/lang/zoo/friends
  zoo-023
  (start zookeeper
         (monkey monkey elephant elephant)))

(define-example-code k2/lang/zoo/friends
  zoo-024
  (start zookeeper
         ((monkey 2) (elephant 2))))

(define-example-code k2/lang/zoo/friends
  zoo-025
  (start (zookeeper purple)
         ((monkey 2) (elephant 4) (penguin 6))))

(define-example-code k2/lang/zoo/friends
  zoo-026
  (start (zookeeper red)
         ((giraffe green 4) (giraffe purple 4))))

(define-example-code k2/lang/zoo/friends
  zoo-027
  (start zookeeper
         ((rand red 4) (rand green 4) (rand blue 4))))

(define-example-code k2/lang/zoo/friends
  zoo-028
  (start zookeeper
         ((monkey 5) (hippo 5))
         ((apple 5) (banana 5))))

(define-example-code k2/lang/zoo/friends
  zoo-029
  (start zookeeper
         ((monkey red 4) (monkey blue 4) (monkey green 4)))
  (start zookeeper
         ((giraffe orange 4) (giraffe yellow 4) (giraffe purple 4))))

(define-example-code k2/lang/zoo/friends
  zoo-030
  (start zookeeper
         ((monkey 2))
         ((banana 2)))
  (start zookeeper
         ((penguin 4))
         ((fish 4)))
  (start zookeeper
         ((hippo 6))
         ((apple 6))))
