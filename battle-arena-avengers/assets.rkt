#lang at-exp racket

(require ts-kata-util/assets/main
         battle-arena)

(define-assets-from "assets")

(provide  blackwidow-sprite
          gamora-sprite
          ironman-sprite
          mandarin-sprite
          redskull-sprite
          starlord-sprite
          wintersoldier-sprite
          captainamerica-sprite
          hawkeye-sprite
          loki-sprite
          nebula-sprite
          rocketracoon-sprite
          thor-sprite
          drax-sprite
          hulk-sprite
          malekith-sprite
          nickfury-sprite
          ronan-sprite
          tonystark-sprite
          ironpatriot-sprite

          green-effect-sprite)

; ==== POWERS ====

(define green-effect-sprite
  (sheet->sprite (rotate 90 green-effect)
                 #:rows 1
                 #:columns 10
                 #:row-number 1
                 #:delay 1))

; ==== CUSTOM ASSETS ====

(define blackwidow-sprite
  (sheet->sprite blackwidow-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define gamora-sprite
  (sheet->sprite gamora-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define ironman-sprite
  (sheet->sprite ironman-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define mandarin-sprite
  (sheet->sprite mandarin-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define redskull-sprite
  (sheet->sprite redskull-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define starlord-sprite
  (sheet->sprite starlord-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define wintersoldier-sprite
  (sheet->sprite wintersoldier-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define captainamerica-sprite
  (sheet->sprite captainamerica-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define hawkeye-sprite
  (sheet->sprite hawkeye-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define loki-sprite
  (sheet->sprite loki-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define nebula-sprite
  (sheet->sprite nebula-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define rocketracoon-sprite
  (sheet->sprite rocketracoon-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define thor-sprite
  (sheet->sprite thor-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define drax-sprite
  (sheet->sprite drax-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define hulk-sprite
  (sheet->sprite hulk-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define malekith-sprite
  (sheet->sprite malekith-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define nickfury-sprite
  (sheet->sprite nickfury-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define ronan-sprite
  (sheet->sprite ronan-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define tonystark-sprite
  (sheet->sprite tonystark-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define ironpatriot-sprite
  (sheet->sprite ironpatriot-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))
