#lang racket

(provide scoresheet
         avatar-section
         food-section
         coin-section
         npc-section
         crafting-section)

(require 2htdp/image)

(define (scoresheet)
  (above/align "left"
               (avatar-section)
               (coin-section)
               (food-section)
               (npc-section)
               (crafting-section)
               (aesthetics-section)))


(define (avatar-section #:sprint-bonus       (sprint-bonus #f)
                        #:avatar-points      (avatar-points #f)
                        #:animation-points   (animation-points #f)
                        #:theme-avatar-points (theme-avatar-points #f)
                        #:theme-animation-points (theme-animation-points #f))
  (side-title-section "Avatar"
                      (above/align "left"
                       (top-title-section "Sprint Bonus"
                                          (points-for "Any avatar within 5 minutes" 5
                                                      #:fill sprint-bonus))
                       (columns
                        (top-title-section "Computer-Scored"
                                           (points-for "Having an avatar" 1
                                                       #:fill avatar-points)
                                           (points-for "Each animation frame" 1 #:max 4
                                                       #:fill animation-points))
                        (top-title-section "Human-Scored"
                                           (points-for "Avatar matches theme" 1
                                                       #:fill theme-avatar-points)
                                           (points-for "Each theme-matching animation frame" 1 #:max 4
                                                       #:fill theme-animation-points))))))

(define (food-section #:sprint-bonus      (sprint-bonus #f)
                      #:food-points       (food-points #f)
                      #:theme-food-points (theme-food-points #f))
  (side-title-section "Food"
                      (above/align "left"
                       (top-title-section "Sprint Bonus"
                                          (points-for "Any food item within 15 minutes" 5 #:fill sprint-bonus))
                       (columns
                        (top-title-section "Computer-Scored"
                                           (points-for "Each food item" 1 #:max 10 #:fill food-points))
                        (top-title-section "Human-Scored"
                                           (points-for "Each theme-matching food item" 1 #:max 10 #:fill theme-food-points))))))

(define (coin-section #:sprint-bonus          (sprint-bonus #f)
                          #:coin-points       (coin-points #f)
                          #:theme-coin-points (theme-coin-points #f))
  (side-title-section "Coin"
                      (above/align "left"
                                   (top-title-section "Sprint Bonus"
                                                      (points-for "Any coin item within 10 minutes" 5 #:fill sprint-bonus))
                                   (columns
                                    (top-title-section "Computer-Scored"
                                                       (points-for "Each coin item" 1 #:max 10 #:fill coin-points))
                                    (top-title-section "Human-Scored"
                                                       (points-for "Each theme-matching coin item" 1 #:max 10 #:fill theme-coin-points))))))

(define (npc-section #:sprint-bonus          (sprint-bonus #f)
                     #:npc-points            (npc-points #f)
                     #:dialog-points         (dialog-points #f)
                     #:theme-npc-points      (theme-npc-points #f)
                     #:themedialog-points    (theme-dialog-points #f))
  
  (side-title-section "NPC"
                      (above/align "left"
                       (top-title-section "Sprint Bonus"
                                          (points-for "Any NPC item within 20 minutes" 5 #:fill sprint-bonus))
                       (columns
                        (top-title-section "Computer-Scored"
                                           (points-for "Each NPC" 1 #:max 5 #:fill npc-points)
                                           (points-for "Each line of NPC dialog" 1 #:max 20 #:fill dialog-points))
                        (top-title-section "Human-Scored"
                                           (points-for "Each theme-matching NPC" 1 #:max 5 #:fill theme-npc-points)
                                           (points-for "Each theme-matching line of NPC dialog" 1 #:max 20 #:fill theme-dialog-points))))))

(define (crafting-section #:sprint-bonus      (sprint-bonus #f)
                          #:recipe-points     (recipe-points #f)
                          #:ingredient-points (ingredient-points #f)
                          #:theme-recipe-points (theme-recipe-points #f)
                          #:theme-ingredient-points (theme-ingredient-points #f))
  (side-title-section "Crafting"
                      (above/align "left"
                       (top-title-section "Sprint Bonus"
                                          (points-for "Any craftable item within 25 minutes" 5 #:fill sprint-bonus))
                       (columns
                        (top-title-section "Computer-Scored"
                                           (points-for "Each crafting recipe" 1 #:max 5      #:fill recipe-points)
                                           (points-for "Each crafting ingredient" 1 #:max 20 #:fill ingredient-points))
                        (top-title-section "Human-Scored"
                                           (points-for "Each theme-matching crafting recipe" 1 #:max 5      #:fill theme-recipe-points)
                                           (points-for "Each theme-matching crafting ingredient" 1 #:max 20 #:fill theme-ingredient-points))))))


(define (aesthetics-section #:balance-points  (balance-points #f)
                            #:art-points      (art-points #f)
                            #:other-points    (other-points #f))
  (side-title-section "Aesthetic Points"
                      (top-title-section "Human-Scored"
                                         (points-for "Game Balance Points" "?" #:max 25 #:fill balance-points)
                                         (points-for "Art Style Points" "?" #:max 25 #:fill art-points)
                                         (points-for "Other Points" "?" #:max 25 #:fill other-points)
                                         (rectangle 1090 1 'solid 'transparent))))



(define (columns i1 i2)
  (beside (fix-width i1)
          (fix-width i2)))

(define (fix-width i (W 550))
  (define bg (rectangle W
                        (image-height i)
                        'solid 'transparent))
  (overlay/align
   "left" "middle"
   i
   bg))

(define (points-for s n #:max (m #f) #:fill (f #f))
  (beside (overlay
           (if f (text (~a f) 18 'darkgreen) empty-image)
           (rectangle 50 25 'outline 'black))
          (text (~a "  +" n " ") 18 'darkgreen)
          (if m
              (text (~a "(max +" m ") ") 18 'black)
              empty-image)
          (text s 18 'black)))

(define (side-title-section title . contents )
  (frame
   (fix-width
    (titled-section (pad 10 (above (text title 30 'black)
                                   (square 10 'solid 'transparent)))
                    beside 90 contents)
    1020)))

(define (top-title-section title . contents )
  (titled-section (text title 20 'darkgray) (curry above/align "left") 0 contents))

(define (titled-section title pos-f rotation contents)
  (pad 10
       (pos-f (rotate rotation (if (string? title)
                                   (text title 24 'darkgray)
                                   title))
              (apply (make-safe (curry above/align "left")) contents))))

(define (pad n i)
  (overlay i
           (rectangle (+ n (image-width i))
                      (+ n (image-height i))
                      'solid
                      'transparent)))

(define (safe f . args)
  (cond [(empty? args) empty-image]
        [(= 1 (length args)) (first args)]
        [else (apply f args)]))

(define (make-safe f)
  (curry safe f))

(module+ test
  (scoresheet))