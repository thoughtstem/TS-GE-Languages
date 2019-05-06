#lang at-exp racket

(require ts-kata-util/assets/main
         adventure)

(define-assets-from "assets")

(provide bigmario01-sprite
         bigmario02-sprite
         bigmario03-sprite
         bigmario04-sprite
         bigmario05-sprite
         bigmario06-sprite
         bigmario07-sprite
         bigmario08-sprite
         bigmario09-sprite
         bigmario10-sprite
         bigmario11-sprite

         smallmario01-sprite
         smallmario02-sprite
         smallmario03-sprite
         smallmario04-sprite
         smallmario05-sprite
         smallmario06-sprite
         smallmario07-sprite
         smallmario08-sprite
         smallmario09-sprite
         smallmario10-sprite
         smallmario11-sprite
         )

(define bigmario01-sprite
  (sheet->sprite bigmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 1
                 #:delay 5))

(define bigmario02-sprite
  (sheet->sprite bigmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 2
                 #:delay 5))

(define bigmario03-sprite
  (sheet->sprite bigmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define bigmario04-sprite
  (sheet->sprite bigmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 4
                 #:delay 5))

(define bigmario05-sprite
  (sheet->sprite bigmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 5
                 #:delay 5))

(define bigmario06-sprite
  (sheet->sprite bigmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 6
                 #:delay 5))

(define bigmario07-sprite
  (sheet->sprite bigmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 7
                 #:delay 5))

(define bigmario08-sprite
  (sheet->sprite bigmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 8
                 #:delay 5))

(define bigmario09-sprite
  (sheet->sprite bigmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 9
                 #:delay 5))

(define bigmario10-sprite
  (sheet->sprite bigmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 10
                 #:delay 5))

(define bigmario11-sprite
  (sheet->sprite bigmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 11
                 #:delay 5))

(define smallmario01-sprite
  (sheet->sprite smallmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 1
                 #:delay 5))

(define smallmario02-sprite
  (sheet->sprite smallmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 2
                 #:delay 5))

(define smallmario03-sprite
  (sheet->sprite smallmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 3
                 #:delay 5))

(define smallmario04-sprite
  (sheet->sprite smallmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 4
                 #:delay 5))

(define smallmario05-sprite
  (sheet->sprite smallmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 5
                 #:delay 5))

(define smallmario06-sprite
  (sheet->sprite smallmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 6
                 #:delay 5))

(define smallmario07-sprite
  (sheet->sprite smallmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 7
                 #:delay 5))

(define smallmario08-sprite
  (sheet->sprite smallmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 8
                 #:delay 5))

(define smallmario09-sprite
  (sheet->sprite smallmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 9
                 #:delay 5))

(define smallmario10-sprite
  (sheet->sprite smallmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 10
                 #:delay 5))

(define smallmario11-sprite
  (sheet->sprite smallmario-sheet
                 #:rows 11
                 #:columns 4
                 #:row-number 11
                 #:delay 5))