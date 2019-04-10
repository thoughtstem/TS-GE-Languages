#lang racket

(provide post-it)

(require pict pict/shadow racket/runtime-path)

(define-runtime-path images "images")

(define-syntax-rule (define/provide id expr ...)
  (begin
    (provide id)
    (define id expr ...)))

(define/provide dictionary-icon
  (bitmap (build-path images "define.png")))

(define/provide eye-icon
  (inset/clip (bitmap (build-path images "eye.png")) -20))

(define/provide brain-icon
  (inset/clip (bitmap (build-path images "brain.png")) -20))

(define/provide ear-icon
  (inset/clip (bitmap (build-path images "ear.png")) -20))

(define/provide mouth-icon
  (inset/clip (bitmap (build-path images "mouth.png")) -20))

(define/provide hand-icon
  (inset/clip (bitmap (build-path images "hand.png")) -20))

(define/provide who-icon
  (inset/clip (bitmap (build-path images "who.png")) -20))

(define/provide group-icon
  (inset/clip (bitmap (build-path images "group.png")) -20))

(define/provide lightbulb-icon
  (inset/clip (bitmap (build-path images "lightbulb.png")) -20))

(define/provide sit-icon
  (inset/clip
   (bitmap (build-path images "sit.png"))
   -20))

(define/provide stand-icon
  (inset/clip (bitmap (build-path images "stand.png")) -20))

(define/provide step-icon
  (inset/clip (bitmap (build-path images "step.png")) -20))

(define/provide turn-icon
  (inset/clip (bitmap (build-path images "turn.png")) -20))

(define/provide lungs-icon
  (inset/clip (bitmap (build-path images "lungs.png")) -20))

(define/provide play-icon
  (inset/clip (bitmap (build-path images "play.png")) -20))

(define/provide square-icon
  (filled-rectangle 10 10))

(define/provide bigger-icon
  (bitmap (build-path images "bigger.png")))

(define/provide rotate-icon
  (bitmap (build-path images "rotate.png")))

(define/provide red-fish-icon
  (standard-fish 15 10
                 #:direction 'right
                 #:color "red"))

(define/provide green-fish-icon
  (standard-fish 15 10
                 #:direction 'right
                 #:color "green"))

(define/provide blue-fish-icon
  (standard-fish 15 10
                 #:direction 'right
                 #:color "blue"))

(define/provide circle-icon
  (filled-ellipse 10 10))

(define/provide smaller-icon
  (hc-append (arrow 5 pi) (arrow 5 pi)))


(define/provide above-icon
  (bitmap (build-path images "above.png")))



(define/provide beside-icon
  (baseless ;Fixes the problem where this renders below the baseline in typeset code
    (rotate (bitmap (build-path images "above.png"))
            (/ pi 2))))


(define/provide overlay-icon
  (bitmap (build-path images "overlay.png")))

(define/provide jack-o-lantern-icon
  (jack-o-lantern 10))

(define/provide question-mark-icon
  (colorize (text "?") "red"))



(define (post-it i)

  (define bg
    (filled-rectangle 80 80))
  
  (define post-it-icon
    (shadow #:color "black"
            #:shadow-color "black"
            (colorize 
             bg
             "black")
            2 0 3))

  
  (define jitter (* (- (random) .5) 0.3))

  (define y-bg
    (colorize bg "yellow"))
  
  (define p
    (inset (cc-superimpose
            (scale post-it-icon .97)
            y-bg

            (scale-to-fit i 70 70))
           3))

  (rotate p jitter)
  
  )

