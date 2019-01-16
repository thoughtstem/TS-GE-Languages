#lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require ts-kata-util 2htdp/image 
         battle-arena)


(define/contract/doc (custom-jedi #:sprite (sprite (circle 10 'solid 'blue)))
  (->i () (#:sprite [sprite any/c]) (result entity?))
  @{This returns an avatar.}
  (custom-avatar #:sprite sprite))

(define/contract/doc (starwars-game #:avatar (avatar (custom-jedi)))
  (->i () (#:avatar [avatar entity?]) (result game?))
  @{This returns an avatar.}
  (battle-arena-game #:avatar avatar))

