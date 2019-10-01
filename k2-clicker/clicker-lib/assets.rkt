#lang racket

(provide freeze slow light
         (rename-out
           [pointer-sprite pointer]
           [cage-sprite cage]
           [glovecursor-sprite glove]
           [magicwandcursor-sprite magic-wand]
           [whitehandcursor-sprite white-hand]))

(require clicker-assets game-engine)

(define freeze
  (new-sprite (make-rounded-icon freeze-icon 'cyan)))

(define slow (new-sprite (make-rounded-icon turtle-icon 'cyan)))

(define light (new-sprite (make-rounded-icon sun-icon 'yellow)))

(define pointer-sprite
  (new-sprite POINTER-IMG))

(define cage-sprite
  (new-sprite 
    (change-img-alpha -100 (apply beside (map (λ (x) (rectangle 20 80 'outline (pen 'gray 4 'solid 'butt 'bevel))) (range 5))))))

(define glovecursor-sprite
  (new-sprite (change-img-alpha -100 glove-cursor)))

(define magicwandcursor-sprite (sheet->sprite magic-wand-cursor-sheet
                                              #:columns 6
                                              #:delay 5))

(define whitehandcursor-sprite (new-sprite white-hand-cursor))
