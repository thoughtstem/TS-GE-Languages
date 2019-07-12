#lang racket

;TODO: Prove that sets of facts you want learners to learn can be taught as a language...

;Selling points:
;1) Link to existing ecosystem
;2) Get new content for free (e.g. new learning packs)
;3) Get new features for free (e.g. put your images on webpages...)  
;4) Learn history while learning to code   
;     Learning transfers from domain to domain (no need to re-teach query when you start teaching the history of capitalism...)  



;Teacher invents language by defining the facts to be taught...
#;
(facts
  (in 3000:BC (mesopotamians invented writing))
  (in 3000:BC (mesopotamians invented culture)) 
-
  (in 470:BC  (plato critiqued writing))
  (in 470:BC  (plato wrote dialogs))

  (in 1440:AD (someone invented the-printing-press))

  (in 1890:AD (babbage invented the-difference-engine)) )

;(in YEAR:AD/BC (SUBJECT VERB OBJECT))

;TODO: Note that "facts" don't have to be real.  You, the teacher, are asserting that they are facts.



;Possible expressions in this language

;True
#;
(before 
  (plato critiqued writing)
  (mesopotamians invented writing))


;True
#;
(after 
  (mesopotamians invented writing) 
  (plato critiqued writing))

;True
#;
(and 
  (plato wrote dialogs)
  (plato critiqued writing))

;False
#;
(between (100:AD 200:AD)
  (after
    (plato critiqued writing)  
    (someone invented the-printing-press)))


;Ex: Write an expression that shows that the egyptians did not invent writing

#;
(query
  (egyptians invented writing))


;True
#;
(query
  (egyptians invented mummification))



;Ex: Write an expression that determines who invented writing

(query (___ invented writing)) ;mesopotamians



 

;Ex: Write an expression that determines when writing was invented by the mesopotamians

(query (in ____ (mesopotamians invented writing)))

;Ex: Write an expression that determines what else happened in the year that the mesopotamians invented writing

(define year-writing-invented
  (query (in ____ (mesopotamians invented writing)))) 

(query
  (in year-writing-invented 
      _____))

#;
(used-writing-to-criticize-writing plato)

;Ex: How many years were there between the invention of writing and the invention of the printing press.

#;
(- 
  (query (in ____ (someone invented the-printing-press))) 
  (query (in ____ (mesopotamians invented writing))))


;What will the following return? (You may not use a computer)

(query (in ____ (someone invented the-printing-press)))  




;Ex: Give any values of this function that return true.

#;
(define (used-writing-to-criticize-writing x)
  (and 
    (x wrote dialogs)
    (x critiqued writing)))


;Ex: Show that it would be impossible for babbage to have invented the printing press.  Use assertions to show your work.

(define babbage-alive-year
  (query (in ___ (babbage invented the-difference-engine))))

(check-equal? 
  babbage-alive-year 
  1890) ;BONUS

(define printing-press-invention-year
  (query (in ___ (someone invented the-printing-press))))

(check-equal? 
  printing-press-invention-year 
  1440) ;BONUS

(define years-between-printing-press-and-difference-engine
  (- babbage-alive-year
     printing-press-invention-year))

(> years-between-printing-press-and-difference-engine 
   MAXIMUM-HUMAN-LIFESPAN)


;Ex: Write a program that generates flashcards for all events between 3000:BC and 0:AD.  How meta: Using the same thing for a study aid...

#;
(flashcards
  (query*
    (between (3000:BC 0:AD)
             ___)))



;Ex: Write a program that generates a timeline picture of all events pertaining to plato 

#;
(timeline
  (query*
    (plato ___ ___)))



;(NOTE: Can now link to rest of software ecosystem...)
 
;Ex: Write a program that put two timelines above each other

#;
(above
  (timeline
    (query*
      (plato ___ ___)))
  
  (timeline
    (query*
      (leibniz ___ ___))))


;Ex: Write a program that put plato's timeline on the back of a flashcard with the front being "draw the timeline of plato"

#;
(card
  "Draw the timeline of plato"
  (timeline
    (query*
      (plato ___ ___))))


;Ex: Create a personal deck of study cards that would help someone remember the timelines of various philosophers 

#;
(list
  (card
    "Draw the timeline of Plato"
    (timeline
      (query*
        (plato ___ ___))))
  
  (card
    "Draw the timeline of Leibniz"
    (timeline
      (query*
        (leibniz ___ ___)))))




;Ex: (Student -> teacher) project : Create your own database of facts about your own life and write a bunch of questions that would help someone become an expert in the details of your life.  Get with a partner and teach/learn everything about each other using only your code.  You may not talk, you may only trade code snippets...















