#lang racket

(provide start)

(require healer-lib/start
         (only-in animal-assets question-icon sea-bg))

(define (my-start
          (avatar-sprite (list question-icon)) 
          (food-sprites '()) 
          (npc-sprites '()) 
          (enemy-sprites '()))

  (displayln "Sea game starting!")

  (generic-start
    #:bg               (custom-bg #:image sea-bg
                                  #:rows 2 #:columns 2)
    #:starvation-rate  -1000
    #:avatar-sprite    avatar-sprite
    #:food-sprites     food-sprites
    #:npc-sprites      npc-sprites
    #:enemy-sprites    enemy-sprites
    #:score-prefix     "Sea Creatures Healed"
    #:instructions 
    (make-instructions "ARROW KEYS to move"
                       "SPACE to eat food and talk"
                       "ENTER to close dialogs"
                       "H to heal"
                       "I to open these instructions"
                       "M to open and close the map")))

(bind-start-to my-start)
