#lang racket 

(require "history-lang.rkt"
         rackunit)

(facts history-of-writing
       (in 3400:BC mesopotamians developed  writing)
       (in 3100:BC egyptians     developed  writing)
       (in 1440:AD someone       invented   the-printing-press)
       (in 1890:AD babbage       invented   the-difference-engine))

(check-equal?
  #t
  (query history-of-writing 
         (in 3400:BC mesopotamians developed writing)))

(check-equal?
  #f
  (query history-of-writing 
         (in 3000:BC babbage invented writing)))

(check-equal?
  '(mesopotamians)
  (query history-of-writing 
         (in 3400:BC _ developed writing)))




;TODO: Support multiple blanks

(check-equal?
  '(1890:AD babbage)
  (query history-of-writing 
         (in _ _ invented the-difference-engine)))

(check-equal?
  '((1440:AD someone the-printing-press)  
    (1890:AD babbage the-difference-engine))
  (query* history-of-writing 
          (in _ _ invented _))) 


(query* history-of-writing
        (in _ _ developed writing))




