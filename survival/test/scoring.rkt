#lang ts-game-jam-1

(define npc1-response
  (list (list "Oh, hello! My name is Jordan!"
              "It's dangerous out here."
              "You should be careful.")
        (list "Sorry, I don't have any food to spare."
              "If you look around though,\nyou might find carrots."
              "Hello.")))

(define npc1-response-sprites
  (dialog->response-sprites npc1-response
                            #:game-width 600
                            #:animated #t
                            #:speed 4))

(score-game
 (list
 (sprite->entity (circle 40 'solid 'red)
                 #:name       "player"
                 #:position   (posn 0 0))

 (sprite->entity (circle 10 'solid 'red)
                 #:name       "food"
                 #:position   (posn 0 0))

 (sprite->entity (circle 10 'solid 'red)
                 #:name       "food"
                 #:position   (posn 0 0))

 (create-npc #:sprite (circle 20 'solid 'green)
             #:name        "npc"
             #:position    (posn 202 249)
             #:active-tile 0
             #:dialog      npc1-response-sprites
             #:mode        'pace)))
