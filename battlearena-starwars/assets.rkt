#lang at-exp racket

(require fandom-sprites/assets-starwars
         battlearena)

(provide c2po-sheet ;need for drone trick
         )

(define (easy-sprite sheet r c n)
  (sheet->sprite sheet
                 #:rows r
                 #:columns c
                 #:row-number n
                 #:delay 5))

(define-syntax-rule (define-sprite sheet r c n sprite-name)
  (begin
    (provide sprite-name)
    (define sprite-name (easy-sprite sheet r c n))))

(define-sprite twilek-sheet 4 4 3 twilek-sprite)
(define-sprite darthmaul-sheet 4 4 3 darthmaul-sprite)
(define-sprite darthvader-sheet 4 4 3 darthvader-sprite)
(define-sprite bobafett-sheet 4 4 3 bobafett-sprite)
(define-sprite hansolo-sheet 4 4 3 hansolo-sprite)
(define-sprite luke-sheet 4 4 3 luke-sprite)
(define-sprite obiwan-sheet 4 4 3 obiwan-sprite)
(define-sprite padawan-sheet 4 4 3 padawan-sprite)
(define-sprite princessleia-sheet 4 4 3 princessleia-sprite)
(define-sprite yoda-sheet 4 4 3 yoda-sprite)
(define-sprite r2d2-sheet 4 4 3 r2d2-sprite)
(define-sprite stormtrooper-sheet 4 4 3 stormtrooper-sprite)
(define-sprite c2po-sheet 4 4 3 c2po-sprite)
(define-sprite c3po-sheet 4 4 3 c3po-sprite)
(define-sprite chewie-sheet 4 4 3 chewie-sprite)
(define-sprite lando-sheet 4 4 3 lando-sprite)
(define-sprite rebelpilot-sheet 4 4 3 rebelpilot-sprite)
