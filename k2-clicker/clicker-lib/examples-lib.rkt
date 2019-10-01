#lang racket

(provide define-simple-examples)

(require 
  english
  ts-kata-util
  ts-kata-util/inline-stimuli)

(require ts-kata-util/katas/main
         syntax/parse/define)


(define code-a-game "Code a game")

(define (where-the-pointer-is something)
  (english "where the curser is a" something))

(define (collecting something)
  (english "collecting" something))

(define (avoiding something)
  (english "avoiding" something))

(define (special something)
  (english "special" something))

(define (described thing)
  (define (number->power-level n)
    (~a "power-level-" n))

  (define (move-numbers-to-front l)
    (append (map number->power-level (filter number? l))
            (filter-not number? l)))


  (define (replace-rand s)
    (if (string=? (~a s) "rand")
      "[random]"   
      s))

  (match thing
    [(list noun adj ... ) (apply english (append (move-numbers-to-front adj) (list (replace-rand noun))))]
    [_ (replace-rand thing)]))

(define-syntax-rule (define-example-code-with-stimuli-inferred lang id stuff ...)
  (begin
    (new-stimuli id (infer-stimuli stuff ...))
    (define-example-code 
      lang id stuff ...)))

(define-syntax (infer-stimuli-base stx)
  (syntax-parse stx
    [(_ POINTER)
     #'(english (where-the-pointer-is 
                  (a/an (described 'POINTER))))]
    [(_ POINTER (COLLECTABLE ...))
     #'(english (where-the-pointer-is 
                  (a/an (described 'POINTER)))
                (collecting 
                  (list-of (plural (described 'COLLECTABLE)) ...
                           #:or "nothing")))]
    [(_ POINTER (COLLECTABLE ...) (AVOIDABLE ...))
     #'(english (where-the-pointers-is 
                  (a/an (described 'POINTER)))
                (collecting 
                  (list-of (plural (described 'COLLECTABLE)) ...
                           #:or "nothing"))
               ", and is"
               (avoiding 
                 (list-of (plural (described 'AVOIDABLE)) ...
                          #:or "no one")))]
    [(_ POINTER (COLLECTABLE ...) (AVOIDABLE ...) (SPECIAL ...))
     #'(english (where-the-pointer-is
                  (a/an (described 'POINTER)))
                (collecting 
                  (list-of (plural (described 'COLLECTABLE)) ...
                           #:or "nothing"))
               ", and is"
               (avoiding 
                 (list-of (plural (described 'AVOIDABLE)) ...
                          #:or "nothing "))
               ", and can get"
               (special 
                 (list-of (plural (described 'SPECIAL)) ...
                          #:or "nothing")))]))

(define-syntax (infer-stimuli stx)
  (syntax-parse stx
    [(_ (start STUFF ...))
     #'(english code-a-game
                (infer-stimuli-base STUFF ...))]
    [(_ (start STUFF ...) ...)
     #'(english code-a-game
                "with multiple levels:"
                (itemize
                  (infer-stimuli-base STUFF ...)
                  ...))]))

(define-syntax-rule (define-simple-examples 
                      #:lang lang
                      #:start START
                      #:pointers (POINTER-A POINTER-B POINTER-C POINTER-D)
                      #:collectables (COLLECTABLE-A COLLECTABLE-B COLLECTABLE-C COLLECTIBLE-D)
                      #:avoidables (AVOIDABLE-A AVOIDABLE-B AVOIDABLE-C AVOIDABLE-D)
                      #:specials (SPECIAL-A SPECIAL-B SPECIAL-C)
                      #:colors (COLOR-A COLOR-B COLOR-C COLOR-D)
                      #:rand  RAND)
  (begin

    (define-example-code-with-stimuli
      lang
      clicker-000
      "Code a basic game with no customizations."
      (START))

    (define-example-code-with-stimuli-inferred
      lang
      clicker-001
      (START POINTER-A))

    (define-example-code-with-stimuli-inferred
      lang
      clicker-002
      (START POINTER-A 
             (COLLECTABLE-A) 
             (AVOIDABLE-A)
             (SPECIAL-A)))

    (define-example-code-with-stimuli-inferred
      lang
      clicker-003
      (START POINTER-A 
             ((COLLECTABLE-A COLOR-A 2))
             ((AVOIDABLE-A COLOR-A 2))
             ((SPECIAL-A COLOR-A 2)
              (SPECIAL-B COLOR-B 2))))))


