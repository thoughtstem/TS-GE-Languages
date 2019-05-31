#lang at-exp racket

(require ts-kata-util/assets/main
         game-engine)

(define-assets-from "assets")

(provide ;witch-sprite
         ;darkelf-sprite
         ;lightelf-sprite
         ;madscientist-sprite
         ;monk-sprite
         ;pirate-sprite
         ;wizard-sprite
         ;mystery-sprite
 
         ;dragon-sprite
         
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
