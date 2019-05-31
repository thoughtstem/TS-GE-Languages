#lang at-exp racket

(require ts-kata-util/assets/main
         game-engine)

;(define-assets-from "assets")

#|(provide witch-sprite
         darkelf-sprite
         lightelf-sprite
         madscientist-sprite
         monk-sprite
         pirate-sprite
         wizard-sprite
         mystery-sprite
         )


(define witch-sprite
  (sheet->sprite witch-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define darkelf-sprite
  (sheet->sprite darkelf-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define lightelf-sprite
  (sheet->sprite lightelf-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define madscientist-sprite
  (sheet->sprite madscientist-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define monk-sprite
  (sheet->sprite monk-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define pirate-sprite
  (sheet->sprite pirate-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define wizard-sprite
  (sheet->sprite wizard-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define mystery-sprite
  (row->sprite mystery-sheet
                 #:columns 4
                 #:delay 2))

|#