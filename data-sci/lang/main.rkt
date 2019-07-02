#lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require ts-kata-util
         plot
         racket/runtime-path
         data-science)

(define-runtime-path sets "./datasets")

(define/contract/doc (learning-dataset
                       #:page (p 0))
  (->i () (#:page [p number?]) (result any/c))
  @{Return the full Learning Dataset}
  (read-csv (build-path sets "learning.csv") #:->number? #f))


