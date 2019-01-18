#lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require ts-kata-util 2htdp/image 
         "../assets.rkt"
         battle-arena)

(provide (except-out (all-from-out battle-arena)
                     battle-arena-game
                     custom-avatar))

(define sprite? (or/c image? animated-sprite?))


(define/contract/doc (custom-jedi #:sprite (sprite (sheet->sprite twileck-jedi)))
  (->i () (#:sprite [sprite sprite?]) (result entity?))
  @{This returns an avatar.}
  (custom-avatar #:sprite sprite))

(define/contract/doc (starwars-game #:avatar (avatar (custom-jedi)))
  (->i () (#:avatar [avatar entity?]) (result game?))
  @{This starts a game.}
  (battle-arena-game #:avatar avatar))


(module+ mappings
  (provide battle-arena-game
           custom-avatar)

  (require syntax/parse)

  
  (define-syntax (battle-arena-game stx)
    (syntax-case stx ()
      [(_)          #`(starwars-game)]
      [(_ expr ...) #`(starwars-game expr ...)]
      [_ stx]))

  
  (define-syntax (custom-avatar stx)
    (syntax-case stx ()
      [(_)          #`(custom-jedi)]
      [(_ expr ...) #`(custom-jedi expr ...)]
      [_ stx]))

  )

