
#lang scribble/manual

@require[scribble/extract]
@require[@for-label["../main.rkt"
                    racket/base]]

@title{Battle Arena}
@author{thoughtstem}

@defmodulelang[battle-arena]

@section{Functions}

@defproc[(builder-dart [ingredient sauerkraut?] ...
                       [#:veggie? veggie? any/c #f])
         sandwich?]{
 Produces a reuben given some number of @racket[ingredient]s.
 
 If @racket[veggie?] is @racket[#f], produces a standard
 reuben with corned beef. Otherwise, produces a vegetable
 reuben.
}

@(include-extracted "../lang/main.rkt")

@section{Image Assets}

@(include-extracted "../assets.rkt")
