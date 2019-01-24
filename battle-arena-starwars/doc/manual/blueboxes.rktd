377
((3) 0 () 1 ((q lib "battle-arena-starwars/main.rkt")) () (h ! (equal) ((c def c (c (? . 0) q starwars-game)) q (1043 . 18)) ((c def c (c (? . 0) q twileck-jedi)) q (2129 . 2)) ((c def c (c (? . 0) q custom-jedi)) q (0 . 20)) ((c def c (c (? . 0) q darth-vader)) q (2046 . 2)) ((c def c (c (? . 0) q r2-d2)) q (2075 . 2)) ((c def c (c (? . 0) q storm-trooper)) q (2098 . 2))))
procedure
(custom-jedi [#:sprite sprite                         
              #:damage-processor damage-processor     
              #:position position                     
              #:speed speed                           
              #:key-mode key-mode                     
              #:mouse-aim? mouse-aim                  
              #:item-slots item-slots                 
              #:components first-component]           
              rest ...)                           -> entity?
  sprite : sprite? = (sheet->sprite twileck-jedi)
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
(starwars-game [#:headless headless                  
                #:bg bg                              
                #:avatar avatar                      
                #:enemy-list enemy-list              
                #:weapon-list weapon-list            
                #:item-list item-list                
                #:other-entities other-entities]     
                rest ...)                        -> game?
  headless : boolean? = (custom-jedi)
  bg : entity? = #f
  avatar : entity? = (custom-background)
  enemy-list : (listof (or/c entity? procedure?))
             = (list (custom-enemy) (custom-enemy #:weapon (custom-weapon #:name "Sword" #:dart (sword))))
  weapon-list : (listof (or/c entity? procedure?)) = '()
  item-list : (listof (or/c entity? procedure?)) = '()
  other-entities : (or/c #f entity?) = #f
  rest : (listof entity?)
value
darth-vader : image?
value
r2-d2 : image?
value
storm-trooper : image?
value
twileck-jedi : image?
