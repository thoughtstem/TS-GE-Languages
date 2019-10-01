#lang racket

(provide start-forest)

(require
  (except-in clicker-lib FOREST-BG start-forest)
  (only-in cartoon-assets FOREST-BG cactus01 cactus02 bush06 bush04 cloud01)
  (only-in 2htdp/image crop scale scale/xy)
  (except-in game-engine freeze) 
  (only-in game-engine-demos-common candy-cane-tree make-world-objects))

;Implementing cactuses and clouds as trees, but bit simpler

(define dummy-trunk
  (circle 1 'solid 'transparent))

(define tree1
  (sprite->pointer-tree 
    #:y-offset -0
    dummy-trunk
    cactus01))

(define tree2
  (sprite->pointer-tree 
    #:y-offset -0
    dummy-trunk
    cactus01))

(define cloud
  (sprite->pointer-tree 
    #:y-offset -0
    dummy-trunk
    cloud01))

(define-start start-forest
              #:bg-sprite
              (crop 0 0 640 480 
                    (scale/xy 1.5 1
                              (scale 0.5 FOREST-BG)))
              #:world-objects
              (list
                (cloud (posn 150 100))
                (cloud (posn 350 200))
                (tree1 (posn 100 400)) 
                (tree2 (posn 200 350)) 
                (tree1 (posn 250 375)) 
                (tree2 (posn 450 400))))


