#lang racket

(require ts-kata-util)

;Annoying: Have to comment out the tests because just 
;  requiring anything that requires plot causes a "no :0 display gtk" error of some sort on Travis.
;  TODO: We'll need to mess with define-example-code in ts-kata-util and and see if we can get some alternate testing strategy working, or figure out how to mock up a gui environment on travis.
;For now... just sacrificing automated tests (though it still does checkt for identifiers being bound)

;Procedural Pictures


(define-example-code 
;  #:with-test (test no-test)
  data-sci
  data-sci-pict-000

  (hc-append (circle 10) 
             (circle 10)))


(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-pict-001
  
  (define (two-circles)
    (hc-append (circle 10) 
               (circle 10))) 

  (vc-append (two-circles) 
             (two-circles)))



(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-pict-002
  
  (define (two-circles)
    (hc-append (circle 10) 
               (circle 10))) 

  (define (four-circles)
    (vc-append (two-circles) 
               (two-circles)))
  

  (hc-append (four-circles)
             (scale (four-circles) 2)
             (four-circles)))

(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-pict-003
  
  (rotate
    (text "This is upside down")
    pi))


(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-pict-004
  
  (rotate
    (text "This is sideways")
    (/ pi 2)))

(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-pict-005
  
  (scale
    (text "This is big")
    2))

(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-pict-006
  
  (scale
    (rotate
      (text "This is sideways")
      (/ pi 2))
    2))

(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-pict-007
  
  (colorize
    (text "This is red")
    "red"))

(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-pict-008
  
  (rotate
    (colorize
      (text "This is green and sideways")
      "green")
    pi))

(define-example-code 
  ;  #:with-test (test no-test)

  data-sci
  data-sci-pict-009

  (rectangle 200 200 
             #:border-width 10
             #:border-color "green"))

(define-example-code 
  ;  #:with-test (test no-test)

  data-sci
  data-sci-pict-010

  (cc-superimpose
    (text "I am in a green box")
    (rectangle 200 200 
               #:border-width 10
               #:border-color "green")))

(define-example-code 
  ;  #:with-test (test no-test)

  data-sci
  data-sci-pict-011

  (define green-box
    (cc-superimpose
      (text "This is green")
      (rectangle 200 200 
                 #:border-width 10
                 #:border-color "green"))) 

  (define red-box
    (cc-superimpose
      (text "This is red")
      (rectangle 200 200 
                 #:border-width 10
                 #:border-color "red"))) 

  (vc-append green-box 
             red-box 
             green-box 
             red-box))


#|
(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-000
  
  (plot-pict (discrete-histogram
               (list '(apples 100) '(bananas 200)))))

(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-001
  
  (define apples-bananas
    (plot-pict (discrete-histogram
                 (list '(apples 100) '(bananas 200)))))
  

  (cc-superimpose
    apples-bananas
    (circle 200 #:border-color "red" #:border-width 10)))

(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-002
  
  (define apples-bananas
    (plot-pict (discrete-histogram
                 (list '(apples 100) '(bananas 200)))))
  

  (define small-apples-bananas 
    (scale apples-bananas 0.5))

  
  (hc-append
    small-apples-bananas 
    apples-bananas 
    small-apples-bananas))


(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-003
  
  (define apples-bananas
    (plot-pict (discrete-histogram
                 (list '(apples 100) '(bananas 200)))))
  

  (define macs-pcs
    (plot-pict (discrete-histogram
                 #:color "green"
                 (list '(macs 1000) '(pcs 1000)))))
  

  
  (scale 
    (hc-append 
      (rotate apples-bananas (/ pi 5))
      (rotate macs-pcs (- (/ pi 5))))
    0.5))


;More random image assembly here...
;  Maybe 20 total?



;Data manipulation

(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-100

  (map add1 (list 1 2 3 4 5)))




;Histograms

(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-200

  (define the-data
    (list '(a 1) '(b 2) '(c 3) '(d 5)))
  
  (plot (discrete-histogram the-data)))



(define-example-code 
;  #:with-test (test no-test)
  
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
;  #:with-test (test no-test)
  
  data-sci
  data-sci-300 

  (plot3d (discrete-histogram3d '(#(a a 1) #(a b 2) #(b b 3))
                                #:label "Missing (b,a)"
                                #:color 4 #:line-color 4)))

;Storytelling


(define-example-code 
;  #:with-test (test no-test)
  
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
;  #:with-test (test no-test)
  
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



#;
(define-example-code 
  #:with-test (test no-test)
  
  data-sci
  data-sci-500

  (define data-science-sentiment
    (words->sentiment
     (corpus->words
      (data-science-wiki))))

  (plot-sentiment-polarity data-science-sentiment))






|#
