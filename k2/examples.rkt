#lang racket

(require ts-kata-util
         k2/lang/ocean/fish
         k2/lang/classroom/basic
         k2/lang/hero/basic)

(define-example-code k2/lang/hero/basic
  hero-0
  blackwidow)

(define-example-code k2/lang/hero/basic
  hero-1
  ironman)

(define-example-code k2/lang/hero/basic
  hero-2
  gamora)

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
  (start ironman ironman))

(define-example-code k2/lang/hero/basic
  hero-9
  (start ironman ironman ironman ironman))

(define-example-code k2/lang/hero/basic
  hero-10
  (start gamora gamora gamora gamora gamora))

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




#;(module+ test
  (require ratchet)
  ;TODO: Make some generalization of test-all-examples-as-games
  ;  so we can automatically test all...

  (run-example two-fish)
  (run-example red-fish)

  
  )


