#lang racket 

(provide dates query query*
         process-query
         q q*
         categories
         categorize
         relationships
         relate
         (all-from-out racklog))

(require syntax/parse/define
         (for-syntax racket)
         racket/stxparam
         racklog)

(begin-for-syntax
  (define (blank? sym)
    (= 0 
       (string-length
         (string-replace #:all? #t (~a sym) "_" ""))))

  (define-syntax-class fact
                       (pattern
                         ((~datum in) year subject verb object))))

(define-syntax (dates stx)
  (syntax-parse stx
    [(_ db:id f:fact ...)
     #`(begin 
         (define db 
           (%rel ()
                 [('f.year 'f.subject 'f.verb 'f.object)]
                 ...)))]))

(define (process-query q)
  (cond 
    [(empty? q) #t]
    [(not q)    #f]
    [else (map cdr q)]))


(define-syntax (query stx)
  (syntax-parse stx
    [(_ db:id f:fact)

     (define vars 
       (list 
         (if (blank? (syntax-e #'f.year))    (datum->syntax stx 'when) #f)
         (if (blank? (syntax-e #'f.subject)) (datum->syntax stx 'who) #f)
         (if (blank? (syntax-e #'f.verb))    (datum->syntax stx 'did) #f)
         (if (blank? (syntax-e #'f.object))  (datum->syntax stx 'what) #f)) )

     (define when-who-did-what 
       (map (lambda (a b) (or a b))
            vars
            (list 
              #''f.year 
              #''f.subject 
              #''f.verb 
              #''f.object)))

     #`(process-query
         (%which (#,@(filter identity vars))
                 (db #,@when-who-did-what)))]))


(define (%rest)
  (define next (process-query (%more)))
  (if next 
    (cons next (%rest))
    '()))

(define-syntax (query* stx)
  (syntax-parse stx
    [(_ db:id f:fact)
     #'(let ([q (query db f)])
         (if (boolean? q)
           q
           (cons q
                 (%rest))))]))



(define-syntax (categories stx)
  (syntax-parse stx
    [(_ thing:id ...)
     #'(begin (define thing %empty-rel)
              ...)]))


(define-syntax (categorize stx)
  (syntax-parse stx
    [(_ (type:id thing:id ...))
     #'(%assert! type () [('thing ...)])]))

(define-syntax (relationships stx)
  (syntax-parse stx
    [(_ thing:id ...)
     #'(begin (define thing %empty-rel)
              ...)]))

(define-syntax (relate stx)
  (syntax-parse stx
    [(_ (type:id thing:id ...))
     #'(%assert! type () [('thing ...)])]))


(define-syntax (q stx)
  (syntax-parse stx
    [(_ (rel:id slot:id ...))
     (define vars
       (map (compose gensym
                     syntax->datum)
            (syntax->list #'(slot ...))))
     #`(process-query 
         (%which (#,@vars)
            (rel #,@vars)))]))

(define-syntax (q* stx)
  (syntax-parse stx
    [(_ e:expr)
     #'(let ([q (q e)])
         (if (boolean? q)
           q
           (cons q
                 (%rest))))]))






