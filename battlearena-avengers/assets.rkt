#lang at-exp racket

(require fandom-sprites/assets-avengers
         battlearena)

(provide energyball-sheet ;need sheet for tint trick
         ironpatriot-sheet ;need sheet for drone trick
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



(define-sprite (rotate 90 green-effect) 1 10 1 green-effect-sprite)
(define-sprite blackwidow-sheet 4 4 3 blackwidow-sprite)
(define-sprite gamora-sheet 4 4 3 gamora-sprite)
(define-sprite ironman-sheet 4 4 3 ironman-sprite)
(define-sprite mandarin-sheet 4 4 3 mandarin-sprite)
(define-sprite redskull-sheet 4 4 3 redskull-sprite)
(define-sprite starlord-sheet 4 4 3 starlord-sprite)
(define-sprite wintersoldier-sheet 4 4 3 wintersoldier-sprite)
(define-sprite captainamerica-sheet 4 4 3 captainamerica-sprite)
(define-sprite hawkeye-sheet 4 4 3 hawkeye-sprite)
(define-sprite loki-sheet 4 4 3 loki-sprite)
(define-sprite nebula-sheet 4 4 3 nebula-sprite)
(define-sprite rocketracoon-sheet 4 4 3 rocketracoon-sprite)
(define-sprite thor-sheet 4 4 3 thor-sprite)
(define-sprite drax-sheet 4 4 3 drax-sprite)
(define-sprite hulk-sheet 4 4 3 hulk-sprite)
(define-sprite malekith-sheet 4 4 3 malekith-sprite)
(define-sprite nickfury-sheet 4 4 3 nickfury-sprite)
(define-sprite ronan-sheet 4 4 3 ronan-sprite)
(define-sprite tonystark-sheet 4 4 3 tonystark-sprite)
(define-sprite ironpatriot-sheet 4 4 3 ironpatriot-sprite)
