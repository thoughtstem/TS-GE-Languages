#lang racket

(require ts-kata-util)

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

