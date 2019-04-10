#lang racket


(provide (all-from-out "../animal/animal-lang.rkt")
         (all-from-out "../animal/animal-asset-friendly-names.rkt"  ))

(require "../animal/animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt")

(module reader syntax/module-reader
  k2/lang/animal/animal-lang)

(module ratchet racket
  
  (require ratchet
           (rename-in "../animal/animal-lang.rkt" 
	              [start-a start])
           "../icons.rkt"
           "../animal/animal-asset-friendly-names.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))



  (define-visual-language sea-lang
    "../animal/animal-lang.rkt" 

    [start       s play-icon]    
    [ghost-fish  f (s:scale-to-fit (s:render ghost-fish) 32)]
    [crab        c (s:scale-to-fit (s:render crab)       32)]
    [green-fish  g (s:scale-to-fit (s:render green-fish) 32)]))




