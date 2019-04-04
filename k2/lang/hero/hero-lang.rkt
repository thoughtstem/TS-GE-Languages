#lang racket

(module hero-stuff racket
  
  (require (prefix-in a: battlearena-avengers)
           battlearena-avengers/assets
           ratchet/util
           (for-syntax racket))

  (define-syntax (provide-string stx)
    (define id (second (syntax->datum stx)))
    (datum->syntax stx
      `(begin
         (provide ,id)
         (define ,id ,(~a id)))))

  (define-syntax-rule (provide-strings s ...)
    (begin (provide-string s) ...))


  (define-syntax (provide-arena-sprite stx)
    (define id (second (syntax->datum stx)))
    (datum->syntax stx
      `(begin
         (provide ,id)
         (define ,id ,(string->symbol (~a "a:" id "-sprite"))))))

  (define-syntax-rule (provide-arena-sprites s ...)
    (begin (provide-arena-sprite s) ...))


  (provide-strings red orange yellow green blue purple)

  (provide-arena-sprites blackwidow gamora captainamerica drax hawkeye hulk ironman loki)

  (provide hammer
           magic-orb
           star-bit
           energy-blast
           start)

  (define (hammer (color #f)) 
    (a:hammer-dart))

  (define (magic-orb (color "yellow"))
    (a:magic-orb-dart #:color color))

  (define (star-bit (color "green"))
    (a:star-bit-dart #:color color))

  (define (energy-blast (color "green"))
    (a:energy-blast-dart #:color color))

  (define (make-hero sprite (dart #f))
    (define real-dart (call-if-proc dart))
    (if real-dart
         (a:custom-hero #:sprite sprite
                        #:components
                        (a:custom-weapon-system #:dart real-dart
                                                #:mouse-fire-button 'left
                                                ))
         (a:custom-hero #:sprite sprite)) )

  (define (make-villain sprite (dart #f) )
    (define real-dart (call-if-proc dart))
    (if real-dart
      (a:custom-villain #:sprite sprite
                        #:power (a:custom-power #:dart real-dart))
      (a:custom-villain #:sprite sprite)))  

  (define (call-if-proc p)
    (if (procedure? p)
      (p)
      p))

  (define-syntax (app stx)
    (syntax-case stx ()
      [(_ f (args ...)) #'(f args ...)] 

      [(_ f arg) #'(f arg)] ) )

  (define-syntax-rule (start hero villains ...)
    (let ()
      (define vs
        (list 
          (app make-villain villains ) ...))

      (launch-for-ratchet
        (a:avengers-game #:planet (a:custom-planet #:rows 2
                                                   #:columns 2)
                         #:hero (app make-hero hero)
                         #:villain-list vs))))
  
  )

  
(require 'hero-stuff)
(provide (all-from-out racket 'hero-stuff))
