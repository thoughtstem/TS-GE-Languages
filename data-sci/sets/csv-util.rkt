#lang racket

(provide csv->list-of-lists)

(require csv-reading)

(define (csv->list-of-lists file)
  (define reader (make-csv-reader 
                   (open-input-file file)))
  (csv->list reader)) 
