#lang scribble/manual
@require[@for-label[color-strings]
        scribble/extract]

@title{healer-lib}
@author{thoughtstem}

@defmodule[healer-lib]

A library for making Ratchet-based healing games.

Reprovides common colors from @racket[color-strings] package -- @racket[red], @racket[green], @racket[blue], @racket[yellow], @racket[orange], and @racket[purple].

Also reprovides @racket[play-icon] from @racket[common-icons].

@defmodule[healer-lib/start]

Provides a generic start function for other healer games to build upon. 

@defform[(start avatar (food ...) (friends ...) (enemies ...))]{
  The basic starter for a healing game.  It is a macro because we want people to type:

  @codeblock{
    (start cat (dog apple))
  }

  ... not:

  @codeblock{
    (start cat (list dog apple))
  }

  So we capture the user's code, package the parameters into lists and call whatever function has been "bound" with @racket[bind-start-to].  This allows different variations on the healing game to be congifured by defining a function (e.g. @racket[my-start]) and binding it:

  @codeblock{
    (bind-start-to my-function)
  }

  The function should be one that takes between 0 and 4 parameters.  In most cases, it will directly call @racket[generic-start], which does the heavy lifting for the game. 
}

@defproc[(generic-start [#:bg bg bg? (custom-bg #:rows 2 #:columns 2)]
                         [#:avatar-sprite avatar described-sprite? (list question-mark-icon)]
                         [#:starvation-rate starvation-rate number? 25]
                         [#:food-sprites fs (list-of described-sprite?) '()]
                         [#:npc-sprites ns (list-of described-sprite?) '()]
                         [#:enemy-sprites es (list-of described-sprite?) '()]
                         [#:score-prefix score string? "Friends Healed"]
                         [#:instructions instructions entity? (make-instructions default-text)]
                          
                         )
         void?]{
   
}

@defthing[described-sprite? 
          (or/c sprite? 
                (list sprite? color-string?)
                (list sprite? number?)
                (list sprite? color-string? number?))]{
  Contract for recognizing things that are valid avatar, foods, friends, or enemies in the healer language.
}

@defmodule[healer-lib/examples-lib]

Convenience functions for auto-generating katas from a healing game language.

@defform[(define-food-examples
                      #:lang lang
                      #:start START
                      #:avatars (AVATAR-A AVATAR-B AVATAR-C AVATAR-D) 
                      #:foods   (FOOD-A FOOD-B FOOD-C FOOD-D) 
                      #:rand  RAND)]{
  Produces various food katas from pre-written templates, using the provided identifiers.  The kata stimuli is also generated automatically.
}

@defform[(define-friends-examples
                      #:lang lang
                      #:start START
                      #:avatars (AVATAR-A AVATAR-B AVATAR-C AVATAR-D) 
                      #:foods   (FOOD-A   FOOD-B   FOOD-C   FOOD-D) 
                      #:friends (FRIEND-A   FRIEND-B   FRIEND-C   FRIEND-D) 
                      #:colors  (COLOR-A COLOR-B COLOR-C COLOR-D)
                      #:rand  RAND)]{
  Produces various friend katas from pre-written templates, using the provided identifiers.  The kata stimuli is also generated automatically.
}

@defform[(define-enemies-examples
                      #:lang lang
                      #:start START
                      #:avatars (AVATAR-A AVATAR-B AVATAR-C AVATAR-D) 
                      #:foods   (FOOD-A FOOD-B FOOD-C FOOD-D) 
                      #:friends (FRIEND-A   FRIEND-B   FRIEND-C   FRIEND-D) 
                      #:colors  (COLOR-A COLOR-B COLOR-C COLOR-D)
                      #:enemies (ENEMY-A   ENEMY-B   ENEMY-C   ENEMY-D) 
                      #:rand  RAND)]{
  Produces various enemy katas from pre-written templates, using the provided identifiers.  The kata stimuli is also generated automatically.
}

@defform[(extract-stimuli module-path)]{
  Gets the stimuli from the given path and evaluates to a strucutre suitable for use with @racket[ts-kata-util]'s @racket[fill-in-stimuli].

  NOTE: Maybe this should get moved to @racket[ts-kata-util]
}

@defproc[(add-ratchet-output-to-response [k kata?])
         kata?]{
  Takes a kata for a Ratchet language, parses its code response and converts it into an image, using the appropriate icons, as defined by the Ratchet visual language.  

  NOTE: Maybe this should get moved to @racket[ts-kata-util]
}



