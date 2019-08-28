#lang racket

(require ts-kata-util
         ts-kata-util/main)

(module+ stimuli
  (require ts-kata-util/katas/main)
  (provide stimuli)
  (define stimuli (list)))

(define-syntax-rule (new-stimuli id text)
  (module+ stimuli
    (set! stimuli (append stimuli
                          (list 'id
                                (read text))))))

(new-stimuli hello-world "Make a red circle")
(define-example-code #:with-test (test begin)
  fundamentals images-hello-world 

  (circle 40 'solid 'red))


(new-stimuli target "Make the target logo")
(define-example-code #:with-test (test begin)
  fundamentals images-target 

  (overlay
   (circle 10 'solid 'red)
   (circle 15 'solid 'white)
   (circle 20 'solid 'red)
   (circle 25 'solid 'white)
   (circle 30 'solid 'red)))




;Function defs

(new-stimuli func-defs-000 "Define a function named foo that returns the number 42.  Call it after you define it.")
(define-example-code #:with-test (test begin)
  fundamentals func-defs-000 

  (define (foo)
    42) 
  
  (foo))


(new-stimuli func-defs-001 "Define a function named double that takes a number and multiplies it by 2.  Call double on the number 756.  Call double twice on the number 422.")
(define-example-code #:with-test (test begin)
  fundamentals func-defs-001 

  (define (double x)
    (* 2 x)) 
  
  (double 756)
  
  (double (double 422)))



(new-stimuli func-defs-002 "Define a function named end-of-string that takes a string and returns everything except the first character.  Call the function on your full name.")
(define-example-code #:with-test (test begin)
  fundamentals func-defs-002

  (define (end-of-string x)
    (substring x 1))
  
  (end-of-string "Albert Einstein"))


(new-stimuli func-defs-003 "Define a function named small-circle that takes a symbol and returns a small circle of that color.  Call that function to produce an orange circle.")
(define-example-code #:with-test (test begin)
  fundamentals func-defs-003

  (define (small-circle color)
    (circle 40 'solid color))
  
  (small-circle 'orange))


(new-stimuli func-defs-004 "Define a function named random-circle that takes a symbol and returns a randomly sized circle of that color.  Call that function five times to produce five different colored circle of various sizes.")
(define-example-code #:with-test (test begin)
  fundamentals func-defs-004

  (define (random-circle color)
    (circle (add1 (random 100)) 'solid color))
  
  (random-circle 'red)
  (random-circle 'orange)
  (random-circle 'yellow)
  (random-circle 'green)
  (random-circle 'blue))


(new-stimuli func-defs-005 "Define a function named add-1-and-square that takes a number, adds 1 to it, and squares it.  Call it on two positive numbers and two negative numbers of your choice.")
(define-example-code #:with-test (test begin)
  fundamentals func-defs-005

  (define (add-1-and-square x)
    (sqr (add1 x)))

  (add-1-and-square -1)
  (add-1-and-square -5)

  (add-1-and-square 22)
  (add-1-and-square 41))


(new-stimuli func-defs-006 "Define a function called is-cool that takes two strings and puts them together with a space in between and the string \"is cool\" at the end.  Call it on your own name and the names of two other people's names.")
(define-example-code #:with-test (test begin)
  fundamentals func-defs-006

  (define (is-cool a b)
    (string-append a " " b " is cool"))

  (is-cool "Stephen" "Foster")
  (is-cool "Ada" "Lovelace")
  (is-cool "Alan" "Turing"))

(new-stimuli func-defs-007 "Define a function called repeat-3 that takes one string and returns that string repeated 3 times with spaces in between.  Call it on a string of your choice.  Call it twice on a different string to make it repeat 9 times.")
(define-example-code #:with-test (test begin)
  fundamentals func-defs-007

  (define (repeat-3 s)
    (string-append s " " s " " s))

  (repeat-3 "Stephen")
  (repeat-3 (repeat-3 "¡Hola!")))



(new-stimuli func-defs-008 "Define a function called yes-no that takes a boolean and returns the string \"yes\" when the boolean is true and \"no\" when it is false.  Call it on both true and false.")
(define-example-code #:with-test (test begin)
  fundamentals func-defs-008

  (define (yes-no b)
    (if b "yes" "no"))

  (yes-no #t)
  (yes-no #f))



(new-stimuli func-defs-009 "Define a function called red-green which takes a boolean and returns a green circle or a red circle depending on if the boolean is true or false.  Call it on both true and false.")
(define-example-code #:with-test (test begin)
  fundamentals func-defs-009

  (define (red-green b)
    (if b
      (circle 40 'solid 'green)
      (circle 40 'solid 'red)))

  (red-green #t)
  (red-green #f))



(new-stimuli func-defs-010 "Define a function called circle-star which takes a boolean and returns either a circle or a star depending on the value of the boolean.  Call it on both true and false.")
(define-example-code #:with-test (test begin)
  fundamentals func-defs-010

  (define (circle-star b)
    (if b 
      (circle 40 'solid 'green)
      (star 40 'solid 'green)))

  (circle-star #t)
  (circle-star #f))



(new-stimuli func-defs-011 "Define a function called colored-circle-triangle that takes a boolean and a string.  The boolean should control whether the function returns a circle or a triangle, the color string should determine the color of the shape.  Call several times to produce 3 circles and two triangles, all of different colors.")
(define-example-code #:with-test (test begin)
  fundamentals func-defs-011

  (define (colored-circle-triangle b color)
    (if b 
      (circle 40 'solid color)
      (triangle 40 'solid color)))

  (colored-circle-triangle #t "red")
  (colored-circle-triangle #t "orange")
  (colored-circle-triangle #t "yellow")
  (colored-circle-triangle #f "green")
  (colored-circle-triangle #f "blue")
  (colored-circle-triangle #f "purple"))



(new-stimuli func-defs-012 "Define a function called sum-or-diff that takes two numbers and a boolean.  If the boolean is true, the function should return the sum of the two numbers.  Otherwise, it should return the difference.  Call it 5 times on a variety of inputs.")
(define-example-code #:with-test (test begin)
  fundamentals func-defs-012

  (define (sum-or-diff b x y)
    (if b
      (+ x y)
      (- x y)))

  (sum-or-diff #t 2 2)
  (sum-or-diff #f 2 2)

  (sum-or-diff #t 100 300)
  (sum-or-diff #f 100 300)

  (sum-or-diff #f 71 -11))



(new-stimuli func-defs-013 "Define a function called max-or-min that takes two numbers and a boolean.  If the boolean is true, the function should return the greater of the two numbers.  Otherwise, it should return the lesser.  Call it 5 times on a variety of inputs.")
(define-example-code #:with-test (test begin)
  fundamentals func-defs-013

  (define (max-or-min b x y)
    (if b 
      (max x y)
      (min x y)))

  (max-or-min #t 2 2)
  (max-or-min #f 2 2)

  (max-or-min #t 100 300)
  (max-or-min #f 100 300)

  (max-or-min #f 71 -11))



(new-stimuli func-defs-014 "Define a function called magic-14 that takes a number.  If the number is 14, it should return a blue circle.  For any other number, it should return a red square.  Call it twice to produce both a blue circle and a red square.")
(define-example-code #:with-test (test begin)
  fundamentals func-defs-014

  (define (magic-14 n)
    (if (= 14 n)
      (circle 40 'solid 'blue)
      (square 40 'solid 'red)))

  (magic-14 10)
  (magic-14 14))



(new-stimuli func-defs-015 "Define a function called magic-22/45 that takes a number.  If the number is 22 or 45, it should return a purple star.  For any other number, it should return a red square.  Call it twice to produce both a purple star and a red square.")
(define-example-code #:with-test (test begin)
  fundamentals func-defs-015

  (define (magic-22/45 n)
    (if (or (= 22 n)
            (= 45 n))
      (star 40 'solid 'purple) 
      (square 40 'solid 'red)))

  (magic-22/45 22)
  (magic-22/45 10))





