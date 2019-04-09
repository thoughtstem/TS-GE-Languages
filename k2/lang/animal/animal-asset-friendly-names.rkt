#lang racket

(provide (rename-out 
          (blackcat-sprite cat)
          (fish-sprite fish)
          (browndog-sprite dog)
          (chicken-sprite chicken)
          (cow-sprite cow)
          (goat-sprite goat)
          (llama-sprite llama)
          (pig-sprite pig)
          (rabbit-sprite rabbit)
          (sheep-sprite sheep)
          (turkey-sprite turkey)
          (goldenhorse-sprite horse)
          (wolf-sprite wolf)
          (apple-sprite apple)
          (banana-sprite banana)
          (brocolli-sprite brocolli)
          (cherries-sprite cherries)
          (eggplant-sprite eggplant)
          (greengrapes-sprite grapes)
          (kiwi-sprite kiwi)
          (mushroom-sprite mushroom)
          (onion-sprite onion)
          (pepper-sprite pepper)
          (pineapple-sprite pineapple)
          (potato-sprite potato)
          (strawberry-sprite strawberry)
          (tomato-sprite tomato)
          (coppercoin-sprite copper)
          (silvercoin-sprite silver)
          (goldcoin-sprite gold)

          (zookeeper-sprite zookeeper)
          (lion-sprite lion)
          (monkey-sprite monkey)
          (tiger-sprite tiger)
          (elephant-sprite elephant)
          (giraffe-sprite giraffe)
          (hippo-sprite hippo)
          (kangaroo-sprite kangaroo)
          (penguin-sprite penguin)
          (zebra-sprite zebra)
          
          ))


(module animal-sprites racket

  (require ts-kata-util/assets/main
           survival)

  (define-assets-from "../../assets/animal")
  (define-assets-from "../../assets/zoo")

  (provide blackcat-sprite
           blackdog-sprite
           blackhorse-sprite
           browncat-sprite
           browndog-sprite
           brownhorse-sprite
           chicken-sprite
           cow-sprite
           fish-sprite
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
           
           zookeeper-sprite
           lion-sprite
           monkey-sprite
           tiger-sprite
           elephant-sprite
           giraffe-sprite
           hippo-sprite
           kangaroo-sprite
           penguin-sprite
           zebra-sprite
           

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
           tomato-sprite

           coppercoin-sprite
           silvercoin-sprite
           goldcoin-sprite)

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
                   #:rows 1
                   #:columns 4
                   #:row-number 1
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
                   #:rows 1
                   #:columns 4
                   #:row-number 1
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

  (define fish-sprite
    (sheet->sprite (beside (square 32 'solid 'blue) 
                           (square 32 'solid 'red))
                   #:rows 1
                   #:columns 2
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
                   #:rows 1
                   #:columns 4
                   #:row-number 1
                   #:delay 5))

  (define grayhorse-sprite
    (sheet->sprite grayhorse-sheet
                   #:rows 1
                   #:columns 4
                   #:row-number 1
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
                   #:rows 1
                   #:columns 4
                   #:row-number 1
                   #:delay 5))

  (define wolf-sprite
    (sheet->sprite wolf-sheet
                   #:rows 1
                   #:columns 5
                   #:row-number 1
                   #:delay 5))

  ; === ZOO ANIMALS ===
  (define lion-sprite
    (sheet->sprite lion-sheet
                   #:rows 4
                   #:columns 3
                   #:row-number 2
                   #:delay 5))

  (define monkey-sprite
    (sheet->sprite monkey-sheet
                   #:rows 4
                   #:columns 3
                   #:row-number 2
                   #:delay 5))

  (define tiger-sprite
    (sheet->sprite tiger-sheet
                   #:rows 4
                   #:columns 3
                   #:row-number 2
                   #:delay 5))

  (define zookeeper-sprite
    (sheet->sprite mystery-sheet
                   #:columns 4
                   #:delay 5))

  (define (make-wiggle-animation img)
    (list img
          (rotate -10 img)
          img
          (rotate 10 img)))
          

  (define elephant-sprite
    (new-sprite (make-wiggle-animation (scale 0.25 round-elephant)) 5))

  (define giraffe-sprite
    (new-sprite (make-wiggle-animation (scale 0.25 round-giraffe)) 5))

  (define hippo-sprite
    (new-sprite (make-wiggle-animation (scale 0.25 round-hippo)) 5))

  (define kangaroo-sprite
    (new-sprite (make-wiggle-animation (scale 0.25 round-kangaroo)) 5))

  (define penguin-sprite
    (new-sprite (make-wiggle-animation (scale 0.25 round-penguin)) 5))

  (define zebra-sprite
    (new-sprite (make-wiggle-animation (scale 0.25 round-zebra)) 5))
  


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

  (define coppercoin-sprite
    (sheet->sprite coppercoin-sheet
                   #:rows 1
                   #:columns 8
                   #:row-number 1
                   #:delay 2))

  (define silvercoin-sprite
    (sheet->sprite silvercoin-sheet
                   #:rows 1
                   #:columns 8
                   #:row-number 1
                   #:delay 2))

  (define goldcoin-sprite
    (sheet->sprite goldcoin-sheet
                   #:rows 1
                   #:columns 8
                   #:row-number 1
                   #:delay 2)))

(require 'animal-sprites)
