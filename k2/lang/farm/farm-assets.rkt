#lang at-exp racket

(require ts-kata-util/assets/main
         survival)

(define-assets-from "../../assets/farm")


(provide blackcat-sprite
         blackdog-sprite
         blackhorse-sprite
         browncat-sprite
         browndog-sprite
         brownhorse-sprite
         chicken-sprite
         cow-sprite
         goat-sprite
         goldencat-sprite
         goldendog-sprite
         goldenhorse-sprite
         grayhorse-sprite
         llama-sprite
         pig-sprite
         rabbit-sprite
         sheep-sprite
         turkey-sprite
         whitecat-sprite
         whitedog-sprite
         whitehorse-sprite
         wolf-sprite

         apple-sprite
         banana-sprite
         brocolli-sprite
         cherries-sprite
         eggplant-sprite
         greengrapes-sprite
         kiwi-sprite
         mushroom-sprite
         onion-sprite
         pepper-sprite
         pineapple-sprite
         potato-sprite
         purplegrapes-sprite
         strawberry-sprite
         tomato-sprite)

; == ANIMALS
(define blackcat-sprite
  (sheet->sprite blackcat-sheet
               #:rows 1
               #:columns 3
               #:row-number 1
               #:delay 5))

(define blackdog-sprite
  (sheet->sprite blackdog-sheet
               #:rows 1
               #:columns 3
               #:row-number 1
               #:delay 5))

(define blackhorse-sprite
  (sheet->sprite blackhorse-sheet
               #:rows 19
               #:columns 4
               #:row-number 8
               #:delay 5))

(define browncat-sprite
  (sheet->sprite browncat-sheet
               #:rows 1
               #:columns 3
               #:row-number 1
               #:delay 5))

(define browndog-sprite
  (sheet->sprite browndog-sheet
               #:rows 1
               #:columns 3
               #:row-number 1
               #:delay 5))

(define brownhorse-sprite
  (sheet->sprite brownhorse-sheet
               #:rows 19
               #:columns 4
               #:row-number 8
               #:delay 5))

(define chicken-sprite
  (sheet->sprite chicken-sheet
               #:rows 4
               #:columns 4
               #:row-number 4
               #:delay 5))

(define cow-sprite
  (sheet->sprite cow-sheet
               #:rows 1
               #:columns 4
               #:row-number 1
               #:delay 5))

(define goat-sprite
  (sheet->sprite goat-sheet
               #:rows 1
               #:columns 4
               #:row-number 1
               #:delay 5))

(define goldencat-sprite
  (sheet->sprite goldencat-sheet
               #:rows 1
               #:columns 3
               #:row-number 1
               #:delay 5))

(define goldendog-sprite
  (sheet->sprite goldendog-sheet
               #:rows 1
               #:columns 3
               #:row-number 1
               #:delay 5))

(define goldenhorse-sprite
  (sheet->sprite goldenhorse-sheet
               #:rows 19
               #:columns 4
               #:row-number 8
               #:delay 5))

(define grayhorse-sprite
  (sheet->sprite grayhorse-sheet
               #:rows 19
               #:columns 4
               #:row-number 8
               #:delay 5))

(define llama-sprite
  (sheet->sprite llama-sheet
               #:rows 1
               #:columns 4
               #:row-number 1
               #:delay 5))

(define pig-sprite
  (sheet->sprite pig-sheet
               #:rows 1
               #:columns 4
               #:row-number 1
               #:delay 5))

(define rabbit-sprite
  (sheet->sprite rabbit-sheet
               #:rows 1
               #:columns 5
               #:row-number 1
               #:delay 5))

(define sheep-sprite
  (sheet->sprite sheep-sheet
               #:rows 1
               #:columns 4
               #:row-number 1
               #:delay 5))

(define turkey-sprite
  (sheet->sprite turkey-sheet
               #:rows 1
               #:columns 4
               #:row-number 1
               #:delay 5))

(define whitecat-sprite
  (sheet->sprite whitecat-sheet
               #:rows 1
               #:columns 3
               #:row-number 1
               #:delay 5))

(define whitedog-sprite
  (sheet->sprite whitedog-sheet
               #:rows 1
               #:columns 3
               #:row-number 1
               #:delay 5))

(define whitehorse-sprite
  (sheet->sprite whitehorse-sheet
               #:rows 19
               #:columns 4
               #:row-number 8
               #:delay 5))

(define wolf-sprite
  (sheet->sprite wolf-sheet
               #:rows 1
               #:columns 5
               #:row-number 1
               #:delay 5))

; == FOOD
(define apple-sprite
  (sheet->sprite apple
               #:rows 1
               #:columns 1
               #:row-number 1
               #:delay 5))

(define banana-sprite
  (sheet->sprite banana
               #:rows 1
               #:columns 1
               #:row-number 1
               #:delay 5))

(define brocolli-sprite
  (sheet->sprite brocolli
               #:rows 1
               #:columns 1
               #:row-number 1
               #:delay 5))

(define cherries-sprite
  (sheet->sprite cherries
               #:rows 1
               #:columns 1
               #:row-number 1
               #:delay 5))

(define eggplant-sprite
  (sheet->sprite eggplant
               #:rows 1
               #:columns 1
               #:row-number 1
               #:delay 5))

(define greengrapes-sprite
  (sheet->sprite greengrapes
               #:rows 1
               #:columns 1
               #:row-number 1
               #:delay 5))

(define kiwi-sprite
  (sheet->sprite kiwi
               #:rows 1
               #:columns 1
               #:row-number 1
               #:delay 5))

(define mushroom-sprite
  (sheet->sprite mushroom
               #:rows 1
               #:columns 1
               #:row-number 1
               #:delay 5))

(define onion-sprite
  (sheet->sprite onion
               #:rows 1
               #:columns 1
               #:row-number 1
               #:delay 5))

(define pepper-sprite
  (sheet->sprite pepper
               #:rows 1
               #:columns 1
               #:row-number 1
               #:delay 5))

(define pineapple-sprite
  (sheet->sprite pineapple
               #:rows 1
               #:columns 1
               #:row-number 1
               #:delay 5))

(define potato-sprite
  (sheet->sprite potato
               #:rows 1
               #:columns 1
               #:row-number 1
               #:delay 5))

(define purplegrapes-sprite
  (sheet->sprite purplegrapes
               #:rows 1
               #:columns 1
               #:row-number 1
               #:delay 5))

(define strawberry-sprite
  (sheet->sprite strawberry
               #:rows 1
               #:columns 1
               #:row-number 1
               #:delay 5))

(define tomato-sprite
  (sheet->sprite tomato
               #:rows 1
               #:columns 1
               #:row-number 1
               #:delay 5))