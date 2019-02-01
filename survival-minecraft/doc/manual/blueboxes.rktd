678
((3) 0 () 1 ((q lib "survival-minecraft/main.rkt")) () (h ! (equal) ((c def c (c (? . 0) q wizard-sheet)) q (6584 . 2)) ((c def c (c (? . 0) q custom-entity)) q (1634 . 29)) ((c def c (c (? . 0) q alex)) q (6450 . 2)) ((c def c (c (? . 0) q custom-biome)) q (0 . 13)) ((c def c (c (? . 0) q custom-ore)) q (4046 . 21)) ((c def c (c (? . 0) q steve)) q (6561 . 2)) ((c def c (c (? . 0) q custom-mob)) q (3034 . 21)) ((c def c (c (? . 0) q iron-ore)) q (6503 . 2)) ((c def c (c (? . 0) q minecraft-game)) q (5012 . 27)) ((c def c (c (? . 0) q custom-skin)) q (603 . 19)) ((c def c (c (? . 0) q chicken-sheet)) q (6472 . 2)) ((c def c (c (? . 0) q steve-animated)) q (6529 . 2))))
procedure
(custom-biome [#:biome-img img                   
               #:rows rows                       
               #:columns columns                 
               #:start-tile start-tile           
               #:components first-component]     
               more-components ...)          -> entity?
  img : image? = (first (shuffle bg-list))
  rows : number? = 3
  columns : number? = 3
  start-tile : number? = 0
  first-component : component-or-system? = #f
  more-components : (listof component-or-system?)
procedure
(custom-skin [#:sprite sprite                         
              #:damage-processor damage-processor     
              #:position position                     
              #:speed speed                           
              #:key-mode key-mode                     
              #:mouse-aim? mouse-aim                  
              #:components first-component]           
              rest ...)                           -> entity?
  sprite : sprite?
         = (sheet->sprite steve-animated #:rows 1 #:columns 2 #:delay 3)
  damage-processor : damage-processor?
                   = (filter-damage-by-tag #:filter-out '(friendly-team passive) #:show-damage? #t)
  position : posn? = (posn 100 100)
  speed : number? = 10
  key-mode : (or/c 'wasd 'arrow-keys) = 'arrow-keys
  mouse-aim : boolean? = #f
  first-component : component-or-system? = #f
  rest : (listof component-or-system?)
procedure
(custom-entity [#:sprite sprite                   
                #:position position               
                #:name name                       
                #:tile tile                       
                #:dialog dialog                   
                #:mode mode                       
                #:game-width game-width           
                #:speed speed                     
                #:target target                   
                #:sound sound                     
                #:scale scale                     
                #:components first-component]     
                more-components ...)          -> entity?
  sprite : sprite?
         = (row->sprite chicken-sheet #:columns 4 #:delay 4)
  position : posn? = (posn 0 0)
  name : string?
       = (first (shuffle (list "Adrian" "Alex" "Riley" "Sydney" "Charlie" "Andy")))
  tile : number? = 0
  dialog : dialog? = #f
  mode : (or/c 'still 'wander 'pace 'follow) = 'wander
  game-width : number? = 480
  speed : number? = 2
  target : string? = "player"
  sound : any/c = #t
  scale : number? = 1
  first-component : component-or-system? = #f
  more-components : (listof component-or-system?)
procedure
(custom-mob [#:amount-in-world amount-in-world     
             #:sprite sprite                       
             #:ai ai                               
             #:health health                       
             #:weapon weapon                       
             #:death-particles death-particles     
             #:night-only? night-only?             
             #:components first-component]         
             more-components ...)              -> entity?
  amount-in-world : positive? = 1
  sprite : sprite?
         = (first (shuffle (list slime-sprite bat-sprite snake-sprite)))
  ai : ai-level? = 'medium
  health : positive? = 100
  weapon : entity?
         = (custom-weapon #:name "Spitter" #:dart (acid))
  death-particles : entity? = (custom-particles)
  night-only? : boolean? = #t
  first-component : any/c = #f
  more-components : (listof any/c)
procedure
(custom-ore [#:entity entity                       
             #:sprite sprite                       
             #:position position                   
             #:name name                           
             #:tile tile                           
             #:amount-in-world amount-in-world     
             #:value value                         
             #:respawn? respawn                    
             #:components first-component]         
             more-components ...)              -> entity?
  entity : entity? = (ore-entity)
  sprite : sprite? = #f
  position : posn? = #f
  name : string? = #f
  tile : number? = #f
  amount-in-world : number? = 10
  value : number? = 10
  respawn : boolean? = #t
  first-component : component-or-system? = #f
  more-components : (listof component-or-system?)
procedure
(minecraft-game [#:headless headless                   
                 #:biome biome-ent                     
                 #:skin skin                           
                 #:starvation-rate starvation-rate     
                 #:sky sky                             
                 #:entity-list entity-list             
                 #:mob-list mob-list                   
                 #:ore-list ore-list                   
                 #:food-list food-list                 
                 #:crafter-list crafter-list           
                 #:other-entities other-entities]      
                 rest ...)                         -> game?
  headless : boolean? = #f
  biome-ent : entity?
            = (plain-forest-bg #:bg-img (random-forest))
  skin : (or/c entity? #f) = #f
  starvation-rate : number? = 50
  sky : sky? = (custom-sky)
  entity-list : (listof (or/c entity? procedure?)) = '()
  mob-list : (listof (or/c entity? procedure?))
           = (list (custom-enemy))
  ore-list : (listof (or/c entity? procedure?)) = '()
  food-list : (listof (or/c entity? procedure?)) = '()
  crafter-list : (listof (or/c entity? procedure?)) = '()
  other-entities : (or/c #f entity?) = #f
  rest : (listof entity?)
value
alex : image?
value
chicken-sheet : image?
value
iron-ore : image?
value
steve-animated : image?
value
steve : image?
value
wizard-sheet : image?
