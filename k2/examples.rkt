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




(define-example-code k2/lang/hero/basic
  hero-0
  blackwidow)

(define-example-code k2/lang/hero/basic
  hero-3
  (start gamora))

(define-example-code k2/lang/hero/basic
  hero-4
  (start ironman))

(define-example-code k2/lang/hero/basic
  hero-5
  (start blackwidow))

(define-example-code k2/lang/hero/basic
  hero-6
  (start blackwidow gamora ironman))

(define-example-code k2/lang/hero/basic
  hero-7
  (start ironman gamora blackwidow))

(define-example-code k2/lang/hero/basic
  hero-8
  (start ironman ironman)) (define-example-code k2/lang/hero/basic
  hero-9
  (start ironman ironman ironman ironman))

(define-example-code k2/lang/hero/basic
  hero-10
  (start gamora gamora gamora gamora gamora))


(define-example-code k2/lang/hero/powers
  hero-11
  (start ironman (gamora hammer)))


(define-example-code k2/lang/hero/powers
  hero-12
  (start ironman (gamora hammer) gamora gamora))

(define-example-code k2/lang/hero/powers
  hero-13
  (start ironman
         (gamora hammer)
         (gamora hammer)
         (gamora hammer)))


(define-example-code k2/lang/hero/powers
  hero-14
  (start ironman
         (drax hammer)
         (hawkeye hammer)
         (gamora hammer)))

(define-example-code k2/lang/hero/powers
  hero-15
  (start (ironman hammer)
         ironman
         ironman
         ironman
         ironman))

(define-example-code k2/lang/hero/powers
  hero-16
  (start (ironman hammer)
         (ironman hammer)
         (ironman hammer)
         (ironman hammer)
         (ironman hammer)))

(define-example-code k2/lang/hero/powers
  hero-17
  (start (ironman hammer)
         (ironman magic-orb)
         (ironman magic-orb)
         (ironman magic-orb)
         (ironman magic-orb)))

(define-example-code k2/lang/hero/powers
  hero-18
  (start (ironman hammer)
         (drax magic-orb)
         (drax magic-orb)
         (blackwidow hammer)
         (blackwidow hammer)))

(define-example-code k2/lang/hero/powers
  hero-19
  (start (ironman hammer)
         (drax magic-orb)
         (drax magic-orb)
         (blackwidow hammer)
         (blackwidow hammer)
         gamora
         gamora))

(define-example-code k2/lang/hero/powers
  hero-20
  (start (ironman (magic-orb red))))

(define-example-code k2/lang/hero/powers
  hero-21
  (start (ironman (star-bit red))))

(define-example-code k2/lang/hero/powers
  hero-22
  (start (ironman (energy-blast red))))

(define-example-code k2/lang/hero/powers
  hero-23
  (start (ironman (magic-orb red))
         (ironman (magic-orb orange))
         (ironman (magic-orb yellow))
         (ironman (magic-orb green))))

(define-example-code k2/lang/hero/powers
  hero-24
  (start (ironman (magic-orb red))
         (ironman (magic-orb orange))
         (ironman (magic-orb yellow))
         (ironman (magic-orb green))
         (ironman (magic-orb blue))
         (ironman (magic-orb purple))))

(define-example-code k2/lang/hero/powers
  hero-25
  (start (ironman (magic-orb red))
         (drax (magic-orb orange))
         (drax (magic-orb yellow))
         (drax (magic-orb green))
         (drax (magic-orb blue))
         (drax (magic-orb purple))))

(define-example-code k2/lang/hero/powers
  hero-26
  (start (ironman (magic-orb red))
         (drax hammer)
         (drax (star-bit yellow))
         (drax (star-bit yellow))
         (drax (energy-blast blue))
         (drax (energy-blast blue))
         ironman
         ironman))

(define-example-code k2/lang/hero/powers
  hero-27
  (start ironman gamora)
  (start ironman drax))

(define-example-code k2/lang/hero/powers
  hero-28
  (start ironman gamora)
  (start ironman drax)
  (start ironman hawkeye))

(define-example-code k2/lang/hero/powers
  hero-29
  (start ironman gamora)
  (start ironman gamora gamora)
  (start ironman gamora gamora gamora))

(define-example-code k2/lang/hero/powers
  hero-30
  (start ironman (gamora (magic-orb green)))
  (start ironman (gamora (magic-orb yellow)))
  (start ironman (gamora (magic-orb red))))

(define-example-code k2/lang/hero/powers
  hero-31
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
  hero-32
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
  hero-33
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
  hero-34
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





