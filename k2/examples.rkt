#lang racket


(provide 
  (all-from-out 
    "./examples/hero.rkt"))

(require 
  ts-kata-util
  (only-in game-engine headless tick game?)
  "./examples/hero.rkt"
  "./examples/zoo.rkt"
  "./examples/sea.rkt"
  "./examples/farm.rkt"
  )

;Which (start ...) is actually getting tested??
;  Need to clarify/fix, it's probably buggy right now.  And I doubt we can trust the test results completely
#;
(require k2/lang/hero/basic
         k2/lang/hero/powers 
         k2/lang/hero/items
         
         k2/lang/farm/foods
         k2/lang/farm/coins
         k2/lang/farm/enemies

         k2/lang/sea/foods
         k2/lang/sea/friends
         k2/lang/sea/enemies
         
         k2/lang/zoo/food
         k2/lang/zoo/coins
         k2/lang/zoo/friends
         )

;Can this get pushed into the required modules instead of being up here where we'll end up with a bunch of name collisions between all the similar languages?
#;
(test-all-examples-as-games 'k2)  

