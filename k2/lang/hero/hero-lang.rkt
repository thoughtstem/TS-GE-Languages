#lang racket

(provide (all-from-out racket))

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

(provide-arena-sprites ironman blackwidow captainamerica thor hulk
                       loki redskull mandarin malekith
                       rocketracoon starlord drax gamora nebula)

(provide hammer
         magic-orb
         star-bit
         energy-blast
         start
         
         randp
         randc

         health
         grow
         shrink
         speed
         forcefield
         )

(define health "Health")
(define grow "Grow")
(define shrink "Shrink")
(define speed "Speed")
(define forcefield "Force Field")

(define (hammer (color "black")) 
  (a:hammer-dart #:color color))

(define (magic-orb (color "yellow"))
  (a:magic-orb-dart #:color color))

(define (star-bit (color "green"))
  (a:star-bit-dart #:color color))

(define (energy-blast (color "green"))
  (a:energy-blast-dart #:color color))

(define (randp (color #f))
    (define w (first (shuffle (list hammer magic-orb star-bit energy-blast))))
  (define real-color (call-if-proc color))
    (if real-color (w real-color) (w)))
      
(define randc
    (lambda () (first (shuffle (list "red" "orange" "yellow" "green" "blue" "purple")))))

#|(define (make-hero sprite (dart-f #f) (color "green"))
  (define real-color (call-if-proc color))
  (define real-dart (if dart-f (dart-f real-color) #f))
  (if real-dart
    (a:custom-hero #:sprite sprite
                   #:components
                   (a:custom-weapon-system #:dart real-dart
                                           #:mouse-fire-button 'left
                                           ))
    (a:custom-hero #:sprite sprite)) )|#

(define (make-hero sprite . options)
  (define (evaluates-to-entity? proc)
    (a:entity? (call-if-proc proc)))
  (define real-color (findf (or/c string? symbol?) (map call-if-proc options)))
  (define dart-f (findf evaluates-to-entity? options))
  (define real-dart (if (and dart-f real-color) (dart-f real-color) #f))
  (if real-dart
      (a:custom-hero #:sprite sprite
                     #:components
                     (a:custom-weapon-system #:dart real-dart
                                             #:mouse-fire-button 'left))
      (a:custom-hero #:sprite sprite)))

#|(define (make-villain sprite (dart-f #f) (color "red") )
  (define real-color (call-if-proc color))
  (define real-dart (if dart-f (dart-f real-color) #f))
  (if real-dart
    (a:custom-villain #:sprite sprite
                      #:power (a:custom-power #:dart real-dart))
    (a:custom-villain #:sprite sprite)))|#

(define (make-villain sprite . options)
  (define (evaluates-to-entity? proc)
    (a:entity? (call-if-proc proc)))
  (define real-color (findf (or/c string? symbol?) (map call-if-proc options)))
  (define dart-f (findf evaluates-to-entity? options))
  (define real-dart (if (and dart-f real-color) (dart-f real-color) #f))
  (if real-dart
      (a:custom-villain #:sprite sprite
                        #:power (a:custom-power #:dart real-dart))
      (a:custom-villain #:sprite sprite)))

(define (make-item name)
  (cond
    [(eq? "Health" name) (a:custom-item #:name "Health Powerup"
                                        #:icon (a:make-icon "HP" 'green 'white)
                                        #:on-use (a:change-health-by 50))]
    [(eq? "Grow" name) (a:custom-item #:name "Grow Powerup"
                                      #:icon (a:make-icon "BIG" 'red 'white)
                                      #:on-use (a:scale-sprite 2 #:for 100))]
    [(eq? "Shrink" name) (a:custom-item #:name "Shrink Powerup"
                                        #:icon (a:make-icon "SML" 'blue 'white)
                                        #:on-use (a:scale-sprite 0.5 #:for 100))]
    [(eq? "Speed" name) (a:custom-item #:name "Speed Boost"
                                       #:icon (a:make-icon "SB" 'yellow)
                                       #:on-use (a:multiply-speed-by 2 #:for 200))]
    [(eq? "Force Field" name) (a:custom-item #:name "Force Field"
                                       #:icon (a:make-icon "FF")
                                       #:on-use (a:spawn (a:force-field #:duration 1000)))]
    ))  

(define (call-if-proc p)
  (if (procedure? p)
    (p)
    p))

(define-syntax (app stx)
  (syntax-case stx ()
    [(_ f (args ...)) #'(f args ...)] 

    [(_ f arg) #'(f arg)] ) )

(define-syntax start
  (syntax-rules ()
    [(start hero-sprite (villain-sprite ...) (power-ups ...))
     (let ()
       (define hero
         (app make-hero hero-sprite))
       (define villains
         (list (app make-villain villain-sprite) ...))
       (define p-ups
         (list (app make-item power-ups) ...))
       
       (a:avengers-game #:planet (a:custom-planet #:rows 2
                                                  #:columns 2)
                        #:hero hero 
                        #:villain-list villains
                        #:item-list p-ups)
       )]
    [(start)                     (start a:mystery-sprite () ())]
    [(start hero)                (start hero () ())]
    [(start hero (villains ...)) (start hero (villains ...) ())]

    ))




