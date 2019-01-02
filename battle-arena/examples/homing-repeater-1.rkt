#lang battle-arena

(define-kata-code battle-arena homing-repeater-1
  (battle-arena-game
   #:weapon-list    (list (custom-weapon #:name "Homing Repeater"
                                         #:sprite (make-icon "HR")
                                         #:fire-mode 'homing))))