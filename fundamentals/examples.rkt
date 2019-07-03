#lang racket

(require ts-kata-util
         ts-kata-util/main
         )

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
  fundamentals hello-world 

  (circle 40 'solid 'red))


(new-stimuli target "Make the target logo")
(define-example-code #:with-test (test begin)
  fundamentals target 

  (overlay
   (circle 10 'solid 'red)
   (circle 15 'solid 'white)
   (circle 20 'solid 'red)
   (circle 25 'solid 'white)
   (circle 30 'solid 'red)))


;Function defs

(new-stimuli func-def-000 "Define a function named foo that returns the number 42.  Call it after you define it.")
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






