#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena spread-shot-1
  (battle-arena-game
   #:weapon-list    (list (custom-weapon #:name      "Spread Shot"
                                         #:sprite    (make-icon "SPR")
                                         #:fire-mode 'spread))))