#lang racket
(require ts-kata-util battle-arena)


(define-kata-code battle-arena boost-2
  (battle-arena-game
   #:item-list (list (custom-item #:name   "Speed Boost"
                                  #:sprite (make-icon "SB" 'yellow)
                                  #:on-use (multiply-speed-by 2 #:for 200))))
  )
