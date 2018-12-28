#lang racket

(require game-engine-rpg
         (except-in ts-racket scale-to-fit)
         (only-in game-engine draw-entity
                              render)
         (only-in ts-curric-common text-with-image)
         pict
         pict/code)

(provide show-coin-sprites
         show-food-sprites)


;TODO get rid of purple loading text

;=== coin sprite list ===

(define (show-coin-sprites)

  (define a (inset-frame (draw-entity (copper-coin-entity))))
  (define b (inset-frame (draw-entity (silver-coin-entity))))
  (define c (inset-frame (draw-entity (cat))))
  (define d (inset-frame (draw-entity (bat))))
  (define f (inset-frame (draw-entity (snake)))) 

  (inset-frame
   (vl-append
    (scale (text "Try these sprites as your coin!") 1.5)
    (ghost (rectangle 10 10))
    (code+hints a #:settings hints-on-right
                (list a
                      (hint
                       (code copper-coin-sprite))))
    (code+hints b #:settings hints-on-right
                (list b
                      (hint
                       (code silver-coin-sprite))))
    (code+hints c #:settings hints-on-right
                (list c
                      (hint
                       (vl-append
                        (code cat-sprite)
                        (text "Also try:")
                        (code white-cat-sprite)
                        (code black-cat-sprite)))))
    (code+hints d #:settings hints-on-right
                (list d
                      (hint
                       (code bat-sprite))))
    (code+hints f #:settings hints-on-right
                (list f
                      (hint
                       (code snake-sprite)))))))

;=== food sprite list ====
(define (show-food-sprites)

  (define a (inset-frame (draw-entity (slime)))) 
  (define b (inset-frame (draw-entity (apples))))
  (define c (inset-frame (draw-entity (carrot-entity))))
  (define d (inset-frame (render toasted-marshmallow-sprite)))
  (define e (inset-frame (render fish-sprite)))
  (define f (inset-frame (render cherry-sprite)))
  (define g (inset-frame (render steak-sprite)))

  (inset-frame
   (vl-append
    (scale (text "Try these food sprites!") 1.5)
    (ghost (rectangle 10 10))
    (code+hints b #:settings hints-on-right
                (list b
                      (hint
                       (code apples-sprite))))
    (code+hints c #:settings hints-on-right
                (list c
                      (hint
                       (code carrot-sprite))))
    (code+hints d #:settings hints-on-right
                (list d
                      (hint
                       (code toasted-marshmallow-sprite))))
    (code+hints e #:settings hints-on-right
                (list e
                      (hint
                       (vl-append
                        (code fish-sprite)
                        (text "Also try:")
                        (code cooked-fish-sprite)))))
    (code+hints f #:settings hints-on-right
                (list f
                      (hint
                       (code cherry-sprite))))
    (code+hints g #:settings hints-on-right
                (list g
                      (hint
                       (code steak-sprite))))
    (code+hints a #:settings hints-on-right
                (list a
                      (hint
                       (code slime-sprite)))))))

(module+ test
  ;(show-coin-sprites)
  (show-food-sprites))
