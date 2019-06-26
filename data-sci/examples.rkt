#lang racket

(require ts-kata-util
  data-sci)


;Procedural Pictures


(define-example-code 
  #:with-test (test identity)
  
  data-sci
  data-sci-000
  (hc-append (circle 10) 
             (circle 10)))



(define-example-code 
  #:with-test (test identity)
  
  data-sci
  data-sci-001
  
  (define (two-circles)
    (hc-append (circle 10) 
               (circle 10))) 

  (vc-append (two-circles) 
             (two-circles)))



(define-example-code 
  #:with-test (test identity)
  
  data-sci
  data-sci-002
  
  (define (two-circles)
    (hc-append (circle 10) 
               (circle 10))) 

  (define (four-circles)
    (vc-append (two-circles) 
               (two-circles)))
  

  (hc-append (four-circles)
             (scale (four-circles) 2)
             (four-circles)))


;Data manipulation

(define-example-code 
  #:with-test (test identity)
  
  data-sci
  data-sci-100

  (map add1 (list 1 2 3 4 5)))




;Histograms

(define-example-code 
  #:with-test (test identity)
  
  data-sci
  data-sci-200

  (define the-data
    (list '(a 1) '(b 2) '(c 3) '(d 5)))
  
  (plot (discrete-histogram the-data)))



(define-example-code 
  #:with-test (test identity)
  
  data-sci
  data-sci-201

  (define the-data
    (list '(a 1) '(b 2) '(c 3) '(d 4)))
  
  (define the-data2
    (list '(a 2) '(b 3) '(c 4) '(d 5)))
  
  (plot (list
         (discrete-histogram the-data)
         (discrete-histogram the-data2 #:x-min 6 #:color 2))))


;3D Histograms


(define-example-code
  #:with-test (test identity)
  
  data-sci
  data-sci-300 

  (plot3d (discrete-histogram3d '(#(a a 1) #(a b 2) #(b b 3))
                                #:label "Missing (b,a)"
                                #:color 4 #:line-color 4)))

;Storytelling


(define-example-code 
  #:with-test (test identity)
  
  data-sci
  data-sci-400

  (define the-data
    (list '(a 1) '(b 2) '(c 3) '(d 4)))
  
  (define the-data2
    (list '(a 2) '(b 3) '(c 4) '(d 5)))

  (cc-superimpose
   (text "As you can see below, the greens are bigger than the blues...")
   (plot-pict (list
               (discrete-histogram the-data)
               (discrete-histogram the-data2 #:x-min 6 #:color 2)))))


(define-example-code 
  #:with-test (test identity)
  
  data-sci
  data-sci-401

  (define the-data
    (list '(a 1) '(b 2) '(c 3) '(d 4)))
  
  (define the-data2
    (list '(a 2) '(b 3) '(c 4) '(d 5)))

  (define plot1
    (plot-pict (list
                (discrete-histogram the-data)
                (discrete-histogram the-data2 #:x-min 6 #:color 2))))

  (define plot2
    (plot-pict (list
                (discrete-histogram the-data)
                (discrete-histogram the-data2 #:x-min 6 #:color 3))))

  (hc-append
   plot1
   plot2))


;Real datasets



(define-example-code 
  #:with-test (test identity)
  
  data-sci
  data-sci-500

  (define data-science-sentiment
    (words->sentiment
     (corpus->words
      (data-science-wiki))))

  (plot-sentiment-polarity data-science-sentiment)
  )

