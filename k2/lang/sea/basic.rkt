#lang racket


(provide (all-from-out "../animal/animal-lang.rkt"))

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

  (define (crop i)
    (h:crop 0 0 32 32 i))

  (define-visual-language sea-lang
    "../animal/animal-lang.rkt" 

    [start       s play-icon]    
    [fish       f (crop (s:render fish))]))




