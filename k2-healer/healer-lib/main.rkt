#lang racket

(provide 
  (all-from-out color-strings)
  (rename-out [play play-icon]))

(require 
  (only-in common-icons play)
  (only-in color-strings
           red
           green
           blue
           yellow
           orange
           purple))

