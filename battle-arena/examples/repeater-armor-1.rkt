#lang racket
(require ts-kata-util battle-arena)


(define-kata-code battle-arena repeater-armor-1
  
  (battle-arena-game
   #:item-list (list (custom-armor #:name   "Repeater Armor"
                                   #:sprite (make-icon "RA"))))

  
  )
