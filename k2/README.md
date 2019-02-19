# New k2

This is a collection of languages defined with `ratchet`.  In `lang` you'll find the various language definitions.  In `examples`, you'll find  examples that can be used in kata collections. 

To play with the examples as a student would, use ratchet:

```
(launch ocean)
```

This, for example, would launch a visual editor for the `ocean` language.  

<<TODOs:  MVP
            Make basic kata collection (5 - 10 katas).
	      * Get typeset-code working
            Make (fundamentals?), games for learning parens.
            Ready for day 1!
 
          For classes: Make editor improvements
            Enable #lang k2/lang/ocean, makes launcher button for special editor
            Paren pairs on open-paren
            Delete S-expression on backspace [auto copy]
	    Paste shortcut

            More than day1.  Next languages.
               Fish in simulations!!!  Moddable games...

            
          For paper:
            Compile to Blockly?  [Mostly for Figures]
            "Adjective project" - Lifts noun project to a more complex lanugage...
              What is a visual language?  What should it be?
          >>

## Usual Lang stuff


This is a ThoughtSTEM language.  It can be installed as a Racket package with: 

```
raco pkg install
```

The cannonical structure of this ThoughtSTEM Language is as follows:

```
k2/
  - README.md
  - info.rkt
  - examples.rkt 
  - assets.rkt 
  - assets/
  - main.rkt
  - lang.rkt
  - lang/
    - main.rkt
  - scribblings/
    - manual.scrbl
  - doc/
```

Use the following to generate the examples from their definitions in `examples.rkt`.  This will ensure that all examples are actually valid by runing automatically generated unit tests.

```
raco build-lang-examples
```

API documentation for this language should be written in:

```
scribblings/
```

Or better yet, automatically document your langauge's api by using `define/contract/doc` in `lang/main.rkt`.
As the language grows, additional `.rkt` files for the language's definitions should go in:

```
lang/
```

Use `lang.rkt` to pull everything from `lang/` together with whatever else you want your language to provide
