3544
((3) 0 () 1 ((q lib "survival-pokemon/main.rkt")) () (h ! (equal) ((c def c (c (? . 0) q charizard-sheet)) q (3226 . 2)) ((c def c (c (? . 0) q LAVA-BG)) q (2558 . 2)) ((c def c (c (? . 0) q greengirl-sheet)) q (3359 . 2)) ((c def c (c (? . 0) q moderngirl-sprite)) q (2209 . 2)) ((c def c (c (? . 0) q charmeleon-sheet)) q (3293 . 2)) ((c def c (c (? . 0) q random-character-sprite)) q (1815 . 2)) ((c def c (c (? . 0) q moogle-sheet)) q (2863 . 2)) ((c def c (c (? . 0) q witch-sheet)) q (3064 . 2)) ((c def c (c (? . 0) q madscientist-sheet)) q (2765 . 2)) ((c def c (c (? . 0) q charmander-sheet)) q (3259 . 2)) ((c def c (c (? . 0) q greenboy-sprite)) q (1607 . 2)) ((c def c (c (? . 0) q pikachurun-sheet)) q (3513 . 2)) ((c def c (c (? . 0) q armoredmewtwo-sprite)) q (1389 . 2)) ((c def c (c (? . 0) q redgirl-sprite)) q (1565 . 2)) ((c def c (c (? . 0) q ivysaur-sheet)) q (3392 . 2)) ((c def c (c (? . 0) q FOREST-BG)) q (2479 . 2)) ((c def c (c (? . 0) q greengirl-sprite)) q (1650 . 2)) ((c def c (c (? . 0) q steampunkgirl-sheet)) q (3027 . 2)) ((c def c (c (? . 0) q pikachu-sheet)) q (3482 . 2)) ((c def c (c (? . 0) q moogle-sprite)) q (2254 . 2)) ((c def c (c (? . 0) q james-sprite)) q (1775 . 2) (1694 . 2)) ((c def c (c (? . 0) q armoredmewtwo-sheet)) q (3123 . 2)) ((c def c (c (? . 0) q kavi-sheet)) q (2705 . 2)) ((c def c (c (? . 0) q madscientist-sprite)) q (2035 . 2)) ((c def c (c (? . 0) q redboy-sheet)) q (3547 . 2)) ((c def c (c (? . 0) q moderngirl-sheet)) q (2801 . 2)) ((c def c (c (? . 0) q SNOW-BG)) q (2506 . 2)) ((c def c (c (? . 0) q PINK-BG)) q (2583 . 2)) ((c def c (c (? . 0) q jessie-sprite)) q (1734 . 2)) ((c def c (c (? . 0) q monk-sprite)) q (1996 . 2)) ((c def c (c (? . 0) q DESERT-BG)) q (2531 . 2)) ((c def c (c (? . 0) q wizard-sprite)) q (1955 . 2)) ((c def c (c (? . 0) q darkknight-sheet)) q (2671 . 2)) ((c def c (c (? . 0) q caitsith-sheet)) q (2608 . 2)) ((c def c (c (? . 0) q redboy-sprite)) q (1524 . 2)) ((c def c (c (? . 0) q pikachurun-sprite)) q (1479 . 2)) ((c def c (c (? . 0) q wartortle-sheet)) q (3672 . 2)) ((c def c (c (? . 0) q steampunkboy-sheet)) q (2991 . 2)) ((c def c (c (? . 0) q wizard-sheet)) q (3093 . 2)) ((c def c (c (? . 0) q lightelf-sprite)) q (2082 . 2)) ((c def c (c (? . 0) q mystery-sheet)) q (2893 . 2)) ((c def c (c (? . 0) q pirategirl-sheet)) q (2957 . 2)) ((c def c (c (? . 0) q pikachu-sprite)) q (1437 . 2)) ((c def c (c (? . 0) q jessie-sheet)) q (3452 . 2)) ((c def c (c (? . 0) q steampunkgirl-sprite)) q (2431 . 2)) ((c def c (c (? . 0) q james-sheet)) q (3423 . 2)) ((c def c (c (? . 0) q darkelf-sheet)) q (2640 . 2)) ((c def c (c (? . 0) q pirategirl-sprite)) q (2339 . 2)) ((c def c (c (? . 0) q pirateboy-sheet)) q (2924 . 2)) ((c def c (c (? . 0) q bulbasaur-sheet)) q (3193 . 2)) ((c def c (c (? . 0) q witch-sprite)) q (1873 . 2)) ((c def c (c (? . 0) q pokemon-game)) q (0 . 26)) ((c def c (c (? . 0) q squirtle-sheet)) q (3608 . 2)) ((c def c (c (? . 0) q kavi-sprite)) q (2170 . 2)) ((c def c (c (? . 0) q blastoise-sheet)) q (3160 . 2)) ((c def c (c (? . 0) q darkelf-sprite)) q (1913 . 2)) ((c def c (c (? . 0) q venusaur-sheet)) q (3640 . 2)) ((c def c (c (? . 0) q greenboy-sheet)) q (3327 . 2)) ((c def c (c (? . 0) q pirateboy-sprite)) q (2295 . 2)) ((c def c (c (? . 0) q redgirl-sheet)) q (3577 . 2)) ((c def c (c (? . 0) q steampunkboy-sprite)) q (2384 . 2)) ((c def c (c (? . 0) q lightelf-sheet)) q (2733 . 2)) ((c def c (c (? . 0) q darkknight-sprite)) q (2125 . 2)) ((c def c (c (? . 0) q monk-sheet)) q (2835 . 2))))
procedure
(pokemon-game [#:headless headless                   
               #:world world-ent                     
               #:pokemon pokemon                     
               #:starvation-rate starvation-rate     
               #:sky sky                             
               #:trainer-list trainer-list           
               #:grunt-list grunt-list               
               #:stone-list stone-list               
               #:food-list food-list                 
               #:crafter-list crafter-list           
               #:other-entities other-entities]      
               rest ...)                         -> game?
  headless : boolean? = #f
  world-ent : entity?
            = (plain-forest-bg #:image (random-forest))
  pokemon : (or/c entity? #f) = #f
  starvation-rate : number? = 50
  sky : sky? = (custom-sky)
  trainer-list : (listof (or/c entity? procedure?)) = '()
  grunt-list : (listof (or/c entity? procedure?)) = '()
  stone-list : (listof (or/c entity? procedure?)) = '()
  food-list : (listof (or/c entity? procedure?)) = '()
  crafter-list : (listof (or/c entity? procedure?)) = '()
  other-entities : (or/c #f entity?) = #f
  rest : (listof entity?)
value
armoredmewtwo-sprite : animated-sprite?
value
pikachu-sprite : animated-sprite?
value
pikachurun-sprite : animated-sprite?
value
redboy-sprite : animated-sprite?
value
redgirl-sprite : animated-sprite?
value
greenboy-sprite : animated-sprite?
value
greengirl-sprite : animated-sprite?
value
james-sprite : animated-sprite?
value
jessie-sprite : animated-sprite?
value
james-sprite : animated-sprite?
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
armoredmewtwo-sheet : image?
value
blastoise-sheet : image?
value
bulbasaur-sheet : image?
value
charizard-sheet : image?
value
charmander-sheet : image?
value
charmeleon-sheet : image?
value
greenboy-sheet : image?
value
greengirl-sheet : image?
value
ivysaur-sheet : image?
value
james-sheet : image?
value
jessie-sheet : image?
value
pikachu-sheet : image?
value
pikachurun-sheet : image?
value
redboy-sheet : image?
value
redgirl-sheet : image?
value
squirtle-sheet : image?
value
venusaur-sheet : image?
value
wartortle-sheet : image?
