#lang at-exp racket

(require ts-kata-util/assets/main
         battle-arena)

(define-assets-from "assets")

(provide  cecil-sprite
          constructor-sprite
          ninja-sprite
          outlander-sprite
          soldier-sprite
          )

; ==== CUSTOM ASSETS ====
(define cecil-sprite
  (sheet->sprite cecil-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define constructor-sprite
  (sheet->sprite constructor-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define ninja-sprite
  (sheet->sprite ninja-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define outlander-sprite
  (sheet->sprite outlander-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define soldier-sprite
  (sheet->sprite soldier-sheet
                 #:rows 4
                 #:columns 4
                 #:row-number 3
                 #:delay 5))