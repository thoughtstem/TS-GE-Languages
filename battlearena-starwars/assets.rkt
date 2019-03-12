#lang at-exp racket

(require ts-kata-util/assets/main
         battlearena)

(define-assets-from "assets")

(provide bobafett-sprite
         darthmaul-sprite
         darthvader-sprite
         hansolo-sprite
         luke-sprite
         obiwan-sprite
         padawan-sprite
         princessleia-sprite
         r2d2-sprite
         stormtrooper-sprite
         twilek-sprite
         yoda-sprite
         c3po-sprite
         c2po-sprite
         chewie-sprite
         rebelpilot-sprite
         lando-sprite)       

; ==== CUSTOM ASSETS ====
(define twilek-sprite
  (sheet->sprite twilek-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define darthmaul-sprite
  (sheet->sprite darthmaul-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define darthvader-sprite
  (sheet->sprite darthvader-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define bobafett-sprite
  (sheet->sprite bobafett-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define hansolo-sprite
  (sheet->sprite hansolo-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define luke-sprite
  (sheet->sprite luke-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define obiwan-sprite
  (sheet->sprite obiwan-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define padawan-sprite
  (sheet->sprite padawan-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define princessleia-sprite
  (sheet->sprite princessleia-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define yoda-sprite
  (sheet->sprite yoda-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define r2d2-sprite
  (sheet->sprite r2d2-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define stormtrooper-sprite
  (sheet->sprite stormtrooper-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define c2po-sprite
  (sheet->sprite c2po-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define c3po-sprite
  (sheet->sprite c3po-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define chewie-sprite
  (sheet->sprite chewie-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define lando-sprite
  (sheet->sprite lando-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define rebelpilot-sprite
  (sheet->sprite rebelpilot-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))