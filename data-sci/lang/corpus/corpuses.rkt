#lang racket

#;
(provide moby-dick 
         data-science-wiki
         tijuana-wiki)

#;
(require "./lang.rkt"
         memoize
         racket/runtime-path)

#;
(define-runtime-path corpus-folder "./texts")

#;
(define/memo (moby-dick) 
  (fetch-corpus 
    (build-path corpus-folder "moby-dick.txt")))


#;
(define/memo (tijuana-wiki) 
  (fetch-corpus 
    (build-path corpus-folder "tijuana-wiki.txt")))

#;
(define/memo (data-science-wiki) 
  (fetch-corpus 
    (build-path corpus-folder "data-science-wiki.txt")))
