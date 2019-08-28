#lang racket

(require ts-kata-util)

;Annoying: Have to comment out the tests because just 
;  requiring anything that requires plot causes a "no :0 display gtk" error of some sort on Travis.
;  TODO: We'll need to mess with define-example-code in ts-kata-util and and see if we can get some alternate testing strategy working, or figure out how to mock up a gui environment on travis.
;For now... just sacrificing automated tests (though it still does checkt for identifiers being bound)

;Procedural Pictures

;TODO: This is copy/pasted from fundamentals/examples.rkt.  Abstract into macro
(module+ stimuli
  (require ts-kata-util/katas/main)
  (provide stimuli)
  (define stimuli (list)))

(define-syntax-rule (new-stimuli id text)
  (module+ stimuli
    (set! stimuli (append stimuli
                          (list 'id
                                (read text))))))





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
    (/ pi 2)))

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
    (rectangle 300 150 
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



(new-stimuli data-sci-plots-000 "Generate a chart showing that there are 100 apples in stock and 200 bananas.")
(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-plots-000
  
  (plot-pict 
    #:title "Fruits in stock"
    (discrete-histogram
               '((apples 100) 
                 (bananas 200)))))

(new-stimuli data-sci-plots-001 "Generate a chart showing that there are 100 apples in stock and 200 bananas.  Draw a red circle on the chart.")
(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-plots-001
  
  (define apples-bananas
    (plot-pict (discrete-histogram
                 '((apples 100) 
                   (bananas 200)))))
  

  (cc-superimpose
    apples-bananas
    (circle 200 #:border-color "red" #:border-width 10)))


(new-stimuli data-sci-plots-002 "Generate a chart showing that there are 100 apples in stock and 200 bananas.  Render that chart beside itself at three different sizes.")
(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-plots-002
  
  (define apples-bananas
    (plot-pict (discrete-histogram
                 '((apples 100) 
                   (bananas 200)))))
  

  
  (hc-append
    (scale apples-bananas 2)
    apples-bananas 
    (scale apples-bananas 0.5)))


(new-stimuli data-sci-plots-003 "Render two charts beside each other, at a slight rotation.  One should show that there are 100 apples and 200 bananas.  The other should show that there are 1000 Macs and 1000 PCs.")
(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-plots-003
  
  (define apples-bananas
    (plot-pict (discrete-histogram
                 '((apples 100) 
                   (bananas 200)))))
  

  (define macs-pcs
    (plot-pict (discrete-histogram
                 #:color "green"
                 '((macs 1000) 
                   (pcs 2000)))))

    (hc-append 
      (rotate apples-bananas (/ pi 5))
      (rotate macs-pcs (- (/ pi 5)))))


(new-stimuli data-sci-plots-004 "There are 1000 apples, 1500 bananas, and 3000 oranges.  Render a chart that makes the point that oranges outnumber bananas and apples.")
(define-example-code
  data-sci
  data-sci-plots-004

  (define data
    (zip
      '(apples bananas oranges)
      '(1000   1500    3000)))

  (plot-pict
    #:title "Oranges outnumber bananas and apples"  
    (discrete-histogram data)))


(new-stimuli data-sci-plots-005 "There are 1000 apples, 1500 bananas, and 3000 oranges.  Render a chart with a large y-axis, making the point that all fruits are scarse.")
(define-example-code
  data-sci 
  data-sci-plots-005

  (define data
    (zip
      '(apples bananas oranges)
      '(1000   1500    3000)))

  (plot-pict
    #:title "All fruits scarse"  
    #:y-max 10000
    (discrete-histogram data)))


(new-stimuli data-sci-plots-006 "There are two machines, the \"Magic Cooker\" and the \"Cook 2000\".  Each can cook Eggs, Bacon, and Pancakes in under 4 minutes.  Make up data for each one and plot the data on a bar chart that compares their cooking times.")
(define-example-code
  data-sci 
  data-sci-plots-006

  (define magic-cooker-data '((Eggs 1.5) (Bacon 2.5) (Pancakes 3.5)))
  (define cook-2000-data '((Eggs 1.4) (Bacon 2.3) (Pancakes 3.1)))

  (plot 
    #:x-label "Breakfast Food" #:y-label "Cooking Time (minutes)"
    #:title "Cooking Times For Breakfast Food, Per Processor"  
    (list (discrete-histogram
            magic-cooker-data
            #:skip 2.5 #:x-min 0
            #:label "The Magic Cooker")
          (discrete-histogram
            cook-2000-data
            #:skip 2.5 #:x-min 1
            #:label "The Cook 2000" #:color 2 #:line-color 2))))


#;
(define-example-code
  data-sci 
  data-sci-plots-007

  (plot (list (discrete-histogram '((a 1) (b 2) (c 3) (d 2)
                                    (e 4) (f 2.5) (g 1))
                                  #:label "Numbers per letter")
              (discrete-histogram (list #(1 1) #(4 2) #(3 1.5))
                                  #:x-min 8
                                  #:label "Numbers per number"
                                  #:color 2 #:line-color 2))))


#;
(define-example-code
  data-sci 
  data-sci-plots-008

  (define data1
    (map list
	 '(Eggs Bacon Pancakes)
	 '(1.5 2.5 3.5)))

  (define data2
    (map list
	 '(Eggs Bacon Pancakes)
	 '(1.4 2.3 3.1)))

  (define data3
    (map list
	 '(Eggs Bacon Pancakes)
	 '(1.7 2.7 3.1)))

  (define (compare sets labels)
    (define (hist data label start)
      (discrete-histogram
	data
	#:skip (+ 0.5 (length sets))
	#:x-min start
	#:label label
	#:color (add1 start)
	#:line-color (add1 start)))

    (map hist sets labels (range (length sets))))


  (plot 
    #:x-label "Breakfast Food" #:y-label "Cooking Time (minutes)"
    #:title "Cooking Times For Breakfast Food, Per Processor"   
    (compare (list data1 data2 data3)
             '("AMD" "Intel" "Qualcomm"))))


;More random image assembly here...
;  Maybe 20 total?



;Data manipulation

(new-stimuli data-sci-data-100 "Map add1 over a list of numbers from 1 and 5 to get the numbers 2 through 6.")
(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-data-100

  (map add1 (list 1 2 3 4 5)))


(new-stimuli data-sci-data-101 "Map sub1 over the numbers from 0 to 100 to get the numbers -1 through 98.")
(define-example-code data-sci data-sci-data-101
   (map sub1 
        (range 100)))


(new-stimuli data-sci-data-102 "Map the circle function over the range of numbers from 10 to 100, skipping every 10 numbers.  You should get back a list of circles of increasing size.")
(define-example-code data-sci data-sci-data-102
   (map circle (range 10 100 10)))

(new-stimuli data-sci-data-103 "Map the rectangle function over two lists of numbers between 0 and 10, getting a list of squares.")
(define-example-code data-sci data-sci-data-103
   (map rectangle (range 10) 
                  (range 10)))

(new-stimuli data-sci-data-104 "Map the string-upcase function over a list of six lowercase strings of your choice.")
(define-example-code data-sci data-sci-data-104
   (map string-upcase '("apple" "dog" "banana" "cat" "orange" "fish")))

(new-stimuli data-sci-data-105 "Map the string-downcase function over a list of six uppercase strings of your choice.")
(define-example-code data-sci data-sci-data-105
   (map string-downcase '("APPLE" "DOG" "BANANA" "CAT" "ORANGE" "FISH")))

(new-stimuli data-sci-data-106 "Map the even? function over a list of numbers from 0 to 99.")
(define-example-code data-sci data-sci-data-106
   (map even? (range 100)))

(new-stimuli data-sci-data-107 "Map the not function over three booleans.")
(define-example-code data-sci data-sci-data-107
   (map not '(#f #t #f)))

(new-stimuli data-sci-data-108 "Find the sum of all the numbers from 0 to 99.")
(define-example-code data-sci data-sci-data-108
   (apply + (range 100)))


#;  ;Maybe too tricky...
(define-example-code data-sci data-sci-data-104
   (map (negate =)  
        (list 1 2 1 4)  
        (list 1 2 3 4)))


;Histograms


#;
(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-histograms-200

  (define the-data
    '((a 1) (b 2) (c 3) (d 5)))
  
  (plot (discrete-histogram the-data)))



#;
(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-histograms-201

  (define the-data
    '((a 1) (b 2) (c 3) (d 4)))
  
  (define the-data2
    '((a 2) (b 3) (c 4) (d 5)))
  
  (plot (list
         (discrete-histogram the-data)
         (discrete-histogram the-data2 #:x-min 6 #:color 2))))


#;
(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-histograms-202

  (define the-data
    '((a 1) (b 2) (c 3) (d 4)))
  
  (define the-data2
    '((a 2) (b 3) (c 4) (d 5)))

  (cc-superimpose
   (text "As you can see below, the greens are bigger than the blues...")
   (plot-pict (list
               (discrete-histogram the-data)
               (discrete-histogram the-data2 #:x-min 6 #:color 2)))))


#;
(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-histograms-203

  (define the-data
    '((a 1) (b 2) (c 3) (d 4)))
  
  (define the-data2
    '((a 2) (b 3) (c 4) (d 5)))

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




;3D Histograms


#;
(define-example-code
;  #:with-test (test no-test)
  
  data-sci
  data-sci-3d-histograms-300 

  (plot3d (discrete-histogram3d '((a a 1) (a b 2) (b b 3))
                                #:label "Missing (b,a)"
                                #:color 4 #:line-color 4)))




;Real datasets

(new-stimuli data-sci-real-data-500 "Print all of the data from the large-cities data set.")
(define-example-code 
  
  data-sci
  data-sci-real-data-500

  (define data (data-set large-cities))
  
  data)



(new-stimuli data-sci-real-data-501 "Print the first five rows of the large-cities data set.")
(define-example-code 
  
  data-sci
  data-sci-real-data-501

  (define data (data-set large-cities))
  
  (take data 5))



(new-stimuli data-sci-real-data-502 "Print the all but the first five rows of the large-cities data set.")
(define-example-code 
  
  data-sci
  data-sci-real-data-502

  (define data (data-set large-cities))
  
  (drop data 5))


(new-stimuli data-sci-real-data-503 "Print the second 5 rows of the large-cities data set.")
(define-example-code 
  
  data-sci
  data-sci-real-data-503

  (define data (data-set large-cities))
  (define all-but-first-5 (drop data 5))
  
  (take all-but-first-5 5))


(new-stimuli data-sci-real-data-504 "Print only the city names in the large-cities data set.")
(define-example-code 
  
  data-sci
  data-sci-real-data-504

  (define data (data-set large-cities))
  (define city-names (map first data))

  city-names)


(new-stimuli data-sci-real-data-505 "Print only the first five city names in the large-cities data set.")
(define-example-code 
  
  data-sci
  data-sci-real-data-505

  (define data (data-set large-cities))
  (define city-names (map first data))
  
  (take city-names 5))


(new-stimuli data-sci-real-data-506 "Print the first five city names in the large-cities data set in reverse order.")
(define-example-code 
  
  data-sci
  data-sci-real-data-506

  (define data (data-set large-cities))
  (define city-names (map first data))
  (define first-5-city-names (take city-names 5)) 
  
  (reverse first-5-city-names))


(new-stimuli data-sci-real-data-507 "Sort the data alphabetically by city name and print it.")
(define-example-code 
  
  data-sci
  data-sci-real-data-507

  (define data (data-set large-cities))
  (define sorted-data (sort data string<? #:key first))
  
  sorted-data)

(new-stimuli data-sci-real-data-508 "Print only the populations from the large-cities data set.")
(define-example-code 
  
  data-sci
  data-sci-real-data-508

  (define data (data-set large-cities))
  (define populations (map third data))
  
  populations)


(new-stimuli data-sci-real-data-509 "Display a bar chart that compares the population of all cities in the titanic data set.")
(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-real-data-509

  (define the-data (data-set large-cities))
  (define cities-only (map first the-data))
  (define population-only (map third the-data))

  (define cities-with-population
    (zip cities-only
         population-only))
  
  (plot-pict (discrete-histogram cities-with-population
                                 #:invert? #t)
             #:height 700
             #:width 700))

(new-stimuli data-sci-real-data-600 "Print the first ten rows of the titanic data set.")
(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-real-data-600

  (define the-data (data-set titanic))

  (define first-10-rows (take the-data 10))

  first-10-rows)

(new-stimuli data-sci-real-data-601 "Print only the names of everyone in the titanic data set.")
(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-real-data-601

  (define the-data (data-set titanic))

  (define names (map titanic-row-name the-data))

  names)

(new-stimuli data-sci-real-data-602 "Print the number of the people under the age of 10 in the titanic data set.")
(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-real-data-602

  (define the-data (data-set titanic))

  (define (is-under-10? row)
    (> 10 (titanic-row-age row)))

  (define under-10 (filter is-under-10? the-data))

  (length under-10))

(new-stimuli data-sci-real-data-603 "Print the names of the people under the age of 30 in the titanic data set.")
(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-real-data-603

  (define the-data (data-set titanic))

  (define (is-under-30? row)
    (> 30 (titanic-row-age row)))

  (define under-30 (filter is-under-30? the-data))

  (define names (map titanic-row-name under-30))

  names)

(new-stimuli data-sci-real-data-604 "Print the average age of everyone over thirty in the titanic data set.")
(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-real-data-604

  (define the-data (data-set titanic))

  (define (is-over-30? row)
    (< 30 (titanic-row-age row)))

  (define over-30 (filter is-over-30? the-data))

  (define ages (map titanic-row-age over-30))

  (define average (mean ages))
  
  average)

(new-stimuli data-sci-real-data-605 "Make a histogram of the ages and names of everyone under 10 in the titanic data set.  Sort your data so the histogram looks pretty.")
(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-real-data-605

  (define the-data
    (sort (data-set titanic)
	  <
	  #:key titanic-row-age))

  (define (is-under-10? row)
    (> 10 (titanic-row-age row)))

  (define under-10 (filter is-under-10? the-data))

  (define names (map titanic-row-name under-10))

  (define ages (map titanic-row-age under-10))

  (plot (discrete-histogram
	  #:invert? #t
	  (zip names ages))
	#:height 1000
	#:width 700))


;Add more histogram related things for both datasets

;Add in XYZ datasets...

#;
(new-stimuli data-sci-real-data-610 "Make a histogram showing the titanic deaths sorted by age.")
#;
(define-example-code 
;  #:with-test (test no-test)
  
  data-sci
  data-sci-real-data-610

  (define the-data (data-set titanic))
  (define names (map titanic-row-name the-data))
  (define ages (map titanic-row-age the-data))

  (define names-with-ages (zip names ages)) 
  
  (plot-pict (discrete-histogram names-with-ages
                                 #:invert? #t)
             #:height 700
             #:width 700))


#;
(define-example-code data-sci data-sci-real-data-700

                      ;TODO: Make this or somethin like it a provided dataset
                      ;      Name cluster function k-means-cluster?
		     (define data

		       (rest
			 (csv->list-of-lists
			   "/home/thoughtstem/Desktop/for-k-means.csv")))

		     (define data-with-numbers
		       (map (curry map string->number) data))

		     (define (row->xyz1 row)
		       (list (first row)
			     (third row)
			     (fifth row)))

		     (define xyzs
		       (map row->xyz1 data-with-numbers))

		     (define-values (centers clusters)
		       (cluster xyzs 3))

		     (define red (points3d (first clusters)
					   #:color "red"))

		     (define green (points3d (second clusters)
					     #:color "green"))

		     (define blue (points3d (third clusters)
					    #:color "blue"))


		     (plot3d (list red green blue))
		     )


;TODO: Plots... 



;Averages?


