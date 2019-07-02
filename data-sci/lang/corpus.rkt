#lang racket

#;
(require plot data-science math "./corpus/main.rkt")

#;
(plot-new-window? #t)

#;
(define data-science-sentiment
  (words->sentiment
    (corpus->words 
      (data-science-wiki))))

#;
(plot-sentiment-polarity data-science-sentiment)
#;
(plot-sentiment-curve    data-science-sentiment)

#;
(define moby-sentiment
  (words->sentiment
    (corpus->words (moby-dick))))

#;
(plot-sentiment-polarity moby-sentiment)
#;
(plot-sentiment-curve moby-sentiment)
#;
(apply plot-corpus-size (chapterize (moby-dick)))

;Word clouds?

;Other ways of exploring texts? (all string -> string functions)
;  Segementing
;  Slicing
;  Split by page (based on length)
;  Split by paragraph
;  Split by word
;  Find a particular word, grab surrounding context


;Mildly interesting (but it's hard to see the data story...):

#;
 (map 
   (compose plot-sentiment-curve words->sentiment corpus->words)
   (take (chapterize (moby-dick)) 10))

;Just reading and exploring...
;

;Other texts...
;  Wikipedia articles
;  Twitter dumps
;  Muller report?


;  But we'll add some on-board corpuses (Englishy, Spanishy, and Rackety)
;    Ways of making corpuses out of twitter users...
;    (Or provide some)

;  Various easy graph types.  Ways of combining graphs (overlay, beside, above...)
;    Sizes of languages
;    Word occurances
;      Sets of words.  Set operations on words.
;    Sentiments
;    N-grams
;    Word clouds
;    Markov chains
;    Tweets over time?


;Ways of higlighting parts of graphs?  Calling out bars in histograph, e.g.





