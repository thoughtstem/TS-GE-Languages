#lang racket

(provide (contract-out
          [asl-letter (-> symbol? pict?)]))

(require pict racket/runtime-path)

(define-runtime-path here ".")

(define main
  (inset/clip
   (bitmap (build-path here "abcs.png"))
   -9))

(define sq-width
  (/ (pict-width main) 5))

(define sq-height
  (/ (pict-height main) 6))

(define (pick x y)
  (inset main
         (- (* x sq-width))
         (- (* y sq-height))
         (* (+ 1 (- x 5)) sq-width)
         (* (+ 1 (- y 6)) sq-height)))

(define letters
  '(a b c d e f g h i j k l m n o p q r s t u v w x y z))

(define letter-pictures
  ((curryr take 26)
   (for*/list ([y (range 6)]
               [x (range 5)])
     (pick x y))))

(define (asl-letter l)
  (list-ref
   letter-pictures
   (index-of letters l)))

(define-syntax-rule (define-letter l)
  (begin
    (provide l)
    (define l (asl-letter 'l))))

(define-syntax-rule (define-letters ls ...)
  (begin
    (define-letter ls)
    ...))

(define-letters a b c d e f g h i j k l m n o p q r s t u v w x y z)
