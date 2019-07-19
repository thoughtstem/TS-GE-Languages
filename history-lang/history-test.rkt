#lang racket 

(require "history-lang.rkt"
         syntax/macro-testing
         rackunit)

(dates history-of-writing
       (in 3400:BC mesopotamians developed  writing)
       (in 3100:BC egyptians     developed  writing)

       (in 1440:AD someone       invented   the-printing-press)

       (in 1739:AD vaucanson     invented   the-digesting-duck)
       (in 1745:AD vaucanson     invented   punchcards)
       (in 1745:AD vaucanson     invented   automated-loom)

       (in 1804:AD jacquard      invented   the-jacquard-loom) 
       (in 1890:AD babbage       invented   the-difference-engine))

(categories person civilization machine automaton)

(categorize (civilization egyptians))
(categorize (civilization mesopotamian))

(categorize (person babbage))
(categorize (person jacquard))
(categorize (person vaucanson))

(categorize (machine the-difference-engine))
(categorize (machine the-printing-press))
(categorize (automaton the-digesting-duck))


(relationships full-name uses)

(relate (full-name charles babbage))
(relate (full-name joseph jacquard))
(relate (uses punchards the-difference-engine))
(relate (uses punchards the-jacquard-loom))


;Queries...


(check-equal?
  #f
  (q  (full-name harles babbage)))

(check-equal?
  #t
  (q  (full-name charles babbage)))

(check-equal?
  '(charles)
  (q  (full-name _ babbage)))


;Civilizations before 3000:BC?
;  Yeah, it's hard to compose these as is... But maybe that's okay for the intended users.

#;
(begin
  
(q* (civilization _))
(q* (full-name __ babbage))
(q  (machine __))
(q* (machine __))
  )



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
  '((3400:BC mesopotamians)
    (3100:BC egyptians))
  (query* history-of-writing 
          (in _ _ developed writing))) 


