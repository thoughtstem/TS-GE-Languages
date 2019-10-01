#lang racket

(provide start)

(require healer-lib/start
         (only-in animal-assets question-icon))

(define (my-start
          (avatar-sprite (list question-icon)) 
          (food-sprites '()) 
          (npc-sprites '()) 
          (enemy-sprites '()))

  (displayln "Farm game starting!")

  (generic-start
    #:bg               (custom-bg #:rows 2 #:columns 2)
    #:avatar-sprite    avatar-sprite
    #:food-sprites     food-sprites
    #:npc-sprites      npc-sprites
    #:enemy-sprites    enemy-sprites
    #:score-prefix     "Animals Healed"
    #:instructions 
    (make-instructions "ARROW KEYS to move"
                       "SPACE to eat food and collect coins"
                       "ENTER to close dialogs"
                       "I to open these instructions"
                       "M to open and close the map")))

(bind-start-to my-start)
