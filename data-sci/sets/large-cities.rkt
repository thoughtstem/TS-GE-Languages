#lang racket 

(provide large-cities-raw-string
         large-cities-raw-data
         large-cities)

(require xml
         racket/runtime-path
         "./html-util.rkt")

(define-runtime-path here ".")

(define (large-cities-raw-string)
  (file->string (build-path here "./dumps/cities.html")))

(define (large-cities-raw-data)
  (string->xexpr 
    (large-cities-raw-string)))

(define (large-cities)
  (map tr->city 
       (drop
	 (filter (collect-tag tr?)
		 (fourth (large-cities-raw-data)))
	 1)))

;A gross munging function for some gross data.
(define (tr->city tr)
  (define tds (filter (collect-tag td?) tr))

  (define city-name (string-replace
		      (string-replace
			(second (second (second (third (second tds)))))
			"/wiki/" "")
		      "_" " "))
  (define population (string-replace 
                       (third (fifth tds))
                       "," ""))

  (define country-name (last (last (filter (collect-tag a?) (fourth tds)))))

  (list city-name country-name (string->number population)))





#;
(tr
   (td () "1\n")
   (td
    ()
    (a ((href "/wiki/S%C3%A3o_Paulo") (title "São Paulo")) "São Paulo")
    "\n")
   (td
    ()
    (a
     ((class "image") (href "/wiki/File:S%C3%A3o_Paulo,_Brazil_(3).jpg"))
     (img
      ((alt "São Paulo, Brazil (3).jpg")
       (data-file-height "378")
       (data-file-width "585")
       (decoding "async")
       (height "78")
       (src
        "//upload.wikimedia.org/wikipedia/commons/thumb/b/be/S%C3%A3o_Paulo%2C_Brazil_%283%29.jpg/120px-S%C3%A3o_Paulo%2C_Brazil_%283%29.jpg")
       (srcset
        "//upload.wikimedia.org/wikipedia/commons/thumb/b/be/S%C3%A3o_Paulo%2C_Brazil_%283%29.jpg/180px-S%C3%A3o_Paulo%2C_Brazil_%283%29.jpg 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/b/be/S%C3%A3o_Paulo%2C_Brazil_%283%29.jpg/240px-S%C3%A3o_Paulo%2C_Brazil_%283%29.jpg 2x")
       (width "120"))))
    "\n")
   (td
    ()
    (span
     ((class "flagicon"))
     (img
      ((alt "")
       (class "thumbborder")
       (data-file-height "504")
       (data-file-width "720")
       (decoding "async")
       (height "15")
       (src
        "//upload.wikimedia.org/wikipedia/en/thumb/0/05/Flag_of_Brazil.svg/22px-Flag_of_Brazil.svg.png")
       (srcset
        "//upload.wikimedia.org/wikipedia/en/thumb/0/05/Flag_of_Brazil.svg/33px-Flag_of_Brazil.svg.png 1.5x, //upload.wikimedia.org/wikipedia/en/thumb/0/05/Flag_of_Brazil.svg/43px-Flag_of_Brazil.svg.png 2x")
       (width "22")))
     160)
    (a ((href "/wiki/Brazil") (title "Brazil")) "Brazil")
    "\n")
   (td
    ()
    "11,967,825"
    (sup
     ((class "reference") (id "cite_ref-Brazil_3-0"))
     (a ((href "#cite_note-Brazil-3")) 91 "3" 93))
    "\n")
   "\n"
   (td () "2015\n"))
