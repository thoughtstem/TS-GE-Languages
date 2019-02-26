2658
((3) 0 () 1 ((q lib "battle-arena-fortnite/main.rkt")) () (h ! (equal) ((c def c (c (? . 0) q soldier-sheet)) q (3639 . 2)) ((c def c (c (? . 0) q witch-sprite)) q (2263 . 2)) ((c def c (c (? . 0) q darkknight-sprite)) q (2515 . 2)) ((c def c (c (? . 0) q constructor-sprite)) q (2033 . 2)) ((c def c (c (? . 0) q kavi-sprite)) q (2560 . 2)) ((c def c (c (? . 0) q custom-hero)) q (0 . 20)) ((c def c (c (? . 0) q moderngirl-sheet)) q (3191 . 2)) ((c def c (c (? . 0) q wizard-sheet)) q (3483 . 2)) ((c def c (c (? . 0) q moderngirl-sprite)) q (2599 . 2)) ((c def c (c (? . 0) q madscientist-sprite)) q (2425 . 2)) ((c def c (c (? . 0) q steampunkboy-sprite)) q (2774 . 2)) ((c def c (c (? . 0) q kavi-sheet)) q (3095 . 2)) ((c def c (c (? . 0) q lightelf-sprite)) q (2472 . 2)) ((c def c (c (? . 0) q pirateboy-sprite)) q (2685 . 2)) ((c def c (c (? . 0) q fortnite-game)) q (1039 . 18)) ((c def c (c (? . 0) q moogle-sheet)) q (3253 . 2)) ((c def c (c (? . 0) q moogle-sprite)) q (2644 . 2)) ((c def c (c (? . 0) q madscientist-sheet)) q (3155 . 2)) ((c def c (c (? . 0) q cecil-sheet)) q (3513 . 2)) ((c def c (c (? . 0) q lightelf-sheet)) q (3123 . 2)) ((c def c (c (? . 0) q FOREST-BG)) q (2869 . 2)) ((c def c (c (? . 0) q LAVA-BG)) q (2948 . 2)) ((c def c (c (? . 0) q SNOW-BG)) q (2896 . 2)) ((c def c (c (? . 0) q steampunkgirl-sprite)) q (2821 . 2)) ((c def c (c (? . 0) q wizard-sprite)) q (2345 . 2)) ((c def c (c (? . 0) q caitsith-sheet)) q (2998 . 2)) ((c def c (c (? . 0) q darkknight-sheet)) q (3061 . 2)) ((c def c (c (? . 0) q cecil-sprite)) q (1993 . 2)) ((c def c (c (? . 0) q ninja-sheet)) q (3577 . 2)) ((c def c (c (? . 0) q pirateboy-sheet)) q (3314 . 2)) ((c def c (c (? . 0) q pirategirl-sprite)) q (2729 . 2)) ((c def c (c (? . 0) q steampunkboy-sheet)) q (3381 . 2)) ((c def c (c (? . 0) q outlander-sheet)) q (3606 . 2)) ((c def c (c (? . 0) q ninja-sprite)) q (2079 . 2)) ((c def c (c (? . 0) q witch-sheet)) q (3454 . 2)) ((c def c (c (? . 0) q PINK-BG)) q (2973 . 2)) ((c def c (c (? . 0) q constructor-sheet)) q (3542 . 2)) ((c def c (c (? . 0) q random-character-sprite)) q (2205 . 2)) ((c def c (c (? . 0) q pirategirl-sheet)) q (3347 . 2)) ((c def c (c (? . 0) q monk-sprite)) q (2386 . 2)) ((c def c (c (? . 0) q outlander-sprite)) q (2119 . 2)) ((c def c (c (? . 0) q darkelf-sheet)) q (3030 . 2)) ((c def c (c (? . 0) q steampunkgirl-sheet)) q (3417 . 2)) ((c def c (c (? . 0) q darkelf-sprite)) q (2303 . 2)) ((c def c (c (? . 0) q monk-sheet)) q (3225 . 2)) ((c def c (c (? . 0) q DESERT-BG)) q (2921 . 2)) ((c def c (c (? . 0) q mystery-sheet)) q (3283 . 2)) ((c def c (c (? . 0) q soldier-sprite)) q (2163 . 2))))
procedure
(custom-hero [#:sprite sprite                         
              #:damage-processor damage-processor     
              #:position position                     
              #:speed speed                           
              #:key-mode key-mode                     
              #:mouse-aim? mouse-aim                  
              #:item-slots item-slots                 
              #:components first-component]           
              rest ...)                           -> entity?
  sprite : sprite? = (random-character-sprite)
  damage-processor : damage-processor?
                   = (divert-damage #:filter-out '(friendly-team passive))
  position : posn? = (posn 100 100)
  speed : number? = 10
  key-mode : (or/c 'wasd 'arrow-keys) = 'wasd
  mouse-aim : boolean? = #t
  item-slots : number? = 2
  first-component : component-or-system? = #f
  rest : (listof component-or-system?)
procedure
(fortnite-game [#:headless headless                  
                #:bg planet                          
                #:hero avatar                        
                #:enemy-list enemy-list              
                #:weapon-list weapon-list            
                #:item-list item-list                
                #:other-entities other-entities]     
                rest ...)                        -> game?
  headless : boolean?
           = (custom-hero #:sprite (circle 10 'solid 'red))
  planet : entity? = #f
  avatar : (or/c entity? false?) = (plain-bg)
  enemy-list : (listof (or/c entity? procedure?)) = '()
  weapon-list : (listof (or/c entity? procedure?)) = '()
  item-list : (listof (or/c entity? procedure?)) = '()
  other-entities : (or/c #f entity?) = #f
  rest : (listof entity?)
value
cecil-sprite : animated-sprite?
value
constructor-sprite : animated-sprite?
value
ninja-sprite : animated-sprite?
value
outlander-sprite : animated-sprite?
value
soldier-sprite : animated-sprite?
procedure
(random-character-sprite) -> animated-sprite?
value
witch-sprite : animated-sprite?
value
darkelf-sprite : animated-sprite?
value
wizard-sprite : animated-sprite?
value
monk-sprite : animated-sprite?
value
madscientist-sprite : animated-sprite?
value
lightelf-sprite : animated-sprite?
value
darkknight-sprite : animated-sprite?
value
kavi-sprite : animated-sprite?
value
moderngirl-sprite : animated-sprite?
value
moogle-sprite : animated-sprite?
value
pirateboy-sprite : animated-sprite?
value
pirategirl-sprite : animated-sprite?
value
steampunkboy-sprite : animated-sprite?
value
steampunkgirl-sprite : animated-sprite?
value
FOREST-BG : image?
value
SNOW-BG : image?
value
DESERT-BG : image?
value
LAVA-BG : image?
value
PINK-BG : image?
value
caitsith-sheet : image?
value
darkelf-sheet : image?
value
darkknight-sheet : image?
value
kavi-sheet : image?
value
lightelf-sheet : image?
value
madscientist-sheet : image?
value
moderngirl-sheet : image?
value
monk-sheet : image?
value
moogle-sheet : image?
value
mystery-sheet : image?
value
pirateboy-sheet : image?
value
pirategirl-sheet : image?
value
steampunkboy-sheet : image?
value
steampunkgirl-sheet : image?
value
witch-sheet : image?
value
wizard-sheet : image?
value
cecil-sheet : image?
value
constructor-sheet : image?
value
ninja-sheet : image?
value
outlander-sheet : image?
value
soldier-sheet : image?
