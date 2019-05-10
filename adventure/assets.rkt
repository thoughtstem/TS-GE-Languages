#lang at-exp racket

(require ts-kata-util/assets/main
         game-engine)

(define-assets-from "assets")

(provide witch-sprite
         darkelf-sprite
         lightelf-sprite
         madscientist-sprite
         monk-sprite
         pirate-sprite
         wizard-sprite
         mystery-sprite
         dragon-sprite
         
         darkknight-sprite
         firedog-sprite
         phoenix-sprite
         pirateboy-sprite
         pirategirl-sprite
         prince-sprite
         princess-sprite
         seaserpent-sprite
         steampunkboy-sprite
         steampunkgirl-sprite
         
         )


(define witch-sprite
  (sheet->sprite witch-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 5))

(define darkelf-sprite
  (sheet->sprite darkelf-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 5))

(define lightelf-sprite
  (sheet->sprite lightelf-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 5))

(define madscientist-sprite
  (sheet->sprite madscientist-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 5))

(define monk-sprite
  (sheet->sprite monk-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 5))

(define pirate-sprite
  (sheet->sprite pirate-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 5))

(define wizard-sprite
  (sheet->sprite wizard-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 5))

(define mystery-sprite
  (row->sprite mystery-sheet
                 #:columns 4
                 #:delay 5))



(define dragon-sprite
  (sheet->sprite dragon-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 5))

(define darkknight-sprite
  (sheet->sprite darkknight-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 5))

(define firedog-sprite
  (sheet->sprite firedog-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 5))

(define phoenix-sprite
  (sheet->sprite phoenix-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 5))

(define pirateboy-sprite
  (sheet->sprite pirateboy-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 5))

(define pirategirl-sprite
  (sheet->sprite pirategirl-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 5))

(define prince-sprite
  (sheet->sprite prince-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 5))

(define princess-sprite
  (sheet->sprite princess-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 5))

(define seaserpent-sprite
  (sheet->sprite seaserpent-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 5))

(define steampunkboy-sprite
  (sheet->sprite steampunkboy-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 5))

(define steampunkgirl-sprite
  (sheet->sprite steampunkgirl-sheet
                 #:columns 4
                 #:rows 4
                 #:row-number 3
                 #:delay 5))
