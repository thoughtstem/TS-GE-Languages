#lang at-exp racket

(require ts-kata-util/assets/main
         game-engine)

(define-assets-from "assets")

(provide witch-sprite
         darkelf-sprite
         lightelf-sprite
         madscientist-sprite
         monk-sprite
         wizard-sprite
         caitsith-sprite
         darkknight-sprite
         kavi-sprite
         moderngirl-sprite
         moogle-sprite
         pirateboy-sprite
         pirategirl-sprite
         steampunkboy-sprite
         steampunkgirl-sprite
         mystery-sprite
         )

;===== ASSETS ========

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

(define wizard-sprite
  (sheet->sprite wizard-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define caitsith-sprite
  (sheet->sprite caitsith-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define darkknight-sprite
  (sheet->sprite darkknight-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define kavi-sprite
  (sheet->sprite kavi-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define moderngirl-sprite
  (sheet->sprite moderngirl-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define moogle-sprite
  (sheet->sprite moogle-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define pirateboy-sprite
  (sheet->sprite pirateboy-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define pirategirl-sprite
  (sheet->sprite pirategirl-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define steampunkboy-sprite
  (sheet->sprite steampunkboy-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define steampunkgirl-sprite
  (sheet->sprite steampunkgirl-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))

(define mystery-sprite
  (row->sprite mystery-sheet
                 #:columns 4
                 #:delay 2))

(define dragon-sprite
  (sheet->sprite dragon-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 2))