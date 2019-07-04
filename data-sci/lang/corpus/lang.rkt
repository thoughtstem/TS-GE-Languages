#lang racket

#;
(provide fetch-corpus
         plot-sentiment-polarity
         plot-sentiment-curve
         plot-corpus-size
         corpus->words
         words->sentiment
         paginate
         chapterize
         (all-from-out
           data-science
           plot
           math)) 

#;
(require net/url data-science plot math)

#;
(define (safe-take l n)
  (if (< n (length l))
    l
    (take l n)))

#;
(define (safe-drop l n)
  (if (< n (length l))
    l
    (drop l n)))


#;
(define (chapterize c #:break (break "chapter"))
  (string-split c break))



;Too slow for large texts...
#;
(define (paginate c #:words-per-page (wpp 500))
  (define giant-list (string-split c " "))  

  (define num-pages (/ (length giant-list) wpp))

  (map 
    (lambda (page-number)
      (displayln (~a "Paginating page " page-number " of " num-pages))
      (string-join
        (safe-take (safe-drop giant-list
                             (* page-number wpp)) 
              wpp)
        " "))
    (range num-pages)))

#;
(define (fetch-corpus url-string)
  (define url 
    (if (string? url-string) 
      (string->url url-string)
      url-string ))

  (define in 
    (if (path? url)
      (open-input-file url)
      (get-pure-port url #:redirections 5)))

#;
(define text (string-normalize-spaces
                 (remove-punctuation
                   (string-downcase (port->string in)) #:websafe? #t)))
  (close-input-port in)
  text)

#;
(define (corpus->words corpus)
  (define words 
    (document->tokens corpus #:sort? #t))

  words)

#;
(define (words->sentiment words)
  (define sentiment (list->sentiment words #:lexicon 'bing))
  sentiment)

#;
(define (plot-corpus-size . corpuses)
  (parameterize ([plot-height 200])
    (define i 0)
    (plot (discrete-histogram
            (map
              (lambda (c) 
                (set! i (add1 i))
                (list i (length (string-split c " ")))) 
              corpuses)
            #:color "MediumOrchid"
            #:line-color "MediumOrchid")
          #:x-label "Corpuses"
          #:y-label "Number of Words")))

#;
(define (plot-sentiment-polarity sentiment)
  (parameterize ([plot-height 200])
    (plot (discrete-histogram
            (aggregate sum ($ sentiment 'sentiment) ($ sentiment 'freq))
            #:y-min 0
            ;#:y-max 8000
            ;#:invert? #t
            #:color "MediumOrchid"
            #:line-color "MediumOrchid")
          #:x-label "Frequency"
          #:y-label "Sentiment Polarity")))

#;
(define (plot-sentiment-curve sentiment)

  (define negative-tokens
    (take (cdr (subset sentiment 'sentiment "negative")) 15))
  (define positive-tokens
    (take (cdr (subset sentiment 'sentiment "positive")) 15))

  ;;; Some clever reshaping for plotting purposes
  (define n (map (λ (x) (list (first x) (- 0 (third x))))
                 negative-tokens))
  (define p (sort (map (λ (x) (list (first x) (third x)))
                       positive-tokens)
                  (λ (x y) (< (second x) (second y)))))

  (define min-neg (apply min (map second n)))
  (define max-pos (apply max (map second p)))

  ;;; Plot the results
  (parameterize ((plot-width 800)
                 (discrete-histogram-invert? #t)
                 (plot-x-tick-label-anchor 'top-right)
                 (plot-x-tick-label-angle 0))
    (plot (list
            (tick-grid)
            (discrete-histogram n 
                                #:y-min min-neg
                                #:y-max max-pos
                                #:color "OrangeRed"
                                #:line-color "OrangeRed"
                                #:label "Negative Sentiment") 
            (discrete-histogram p 
                                #:y-min min-neg
                                #:y-max max-pos
                                #:x-min 15
                                #:color "LightSeaGreen"
                                #:line-color "LightSeaGreen"
                                #:label "Positive Sentiment"))
          #:y-label "Word"
          #:x-label "Contribution to sentiment")))



