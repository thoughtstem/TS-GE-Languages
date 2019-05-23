#lang at-exp racket

(require ts-kata-util/assets/main
         adventure)

(define-assets-from "assets")

(provide harrypotter-sprite
         potion-sprite)

(define harrypotter-sprite
  (sheet->sprite harrypotter-sheet
                 #:rows 1
                 #:columns 9
                 #:row-number 1
                 #:delay 5))

(define potion-sprite
  (sheet->sprite potion-sheet
                 #:rows 1
                 #:columns 1
                 #:row-number 1
                 #:delay 5))