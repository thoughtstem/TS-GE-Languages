#lang at-exp racket

(require ts-kata-util/assets/main
         adventure)

(define-assets-from "assets")

(provide harrypotter-sprite
         potion-sprite
         flyingbook-sprite
         pumpkin-sprite
         magiccauldron-sprite
         snape-sprite
         tentacula-sprite
         hagrid-sprite
         oldwizard-sprite

         )

(define harrypotter-sprite
  (sheet->sprite harrypotter-sheet
                 #:rows 1
                 #:columns 18
                 #:row-number 1
                 #:delay 5))

(define potion-sprite
  (sheet->sprite potion-sheet
                 #:rows 1
                 #:columns 1
                 #:row-number 1
                 #:delay 5))

(define flyingbook-sprite
  (sheet->sprite flyingbook-sheet
                 #:rows 1
                 #:columns 6
                 #:row-number 1
                 #:delay 5))

(define pumpkin-sprite
  (sheet->sprite pumpkin-sheet
                 #:rows 1
                 #:columns 8
                 #:row-number 1
                 #:delay 5))

(define magiccauldron-sprite
  (sheet->sprite cauldron-sheet
                 #:rows 1
                 #:columns 6
                 #:row-number 1
                 #:delay 5))

(define snape-sprite
  (sheet->sprite snape-sheet
                 #:rows 1
                 #:columns 21
                 #:row-number 1
                 #:delay 5))

(define tentacula-sprite
  (sheet->sprite tentacula-sheet
                 #:rows 1
                 #:columns 14
                 #:row-number 1
                 #:delay 5))

(define hagrid-sprite
  (sheet->sprite hagrid-sheet
                 #:rows 1
                 #:columns 11
                 #:row-number 1
                 #:delay 5))

(define oldwizard-sprite
  (sheet->sprite oldwizard-sheet
                 #:rows 1
                 #:columns 6
                 #:row-number 1
                 #:delay 5))