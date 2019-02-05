980
((3) 0 () 1 ((q lib "battle-arena-starwars/main.rkt")) () (h ! (equal) ((c def c (c (? . 0) q obi-wan)) q (5862 . 2)) ((c def c (c (? . 0) q starwars-game)) q (4802 . 18)) ((c def c (c (? . 0) q han-solo)) q (5814 . 2)) ((c def c (c (? . 0) q boba-fett)) q (5730 . 2)) ((c def c (c (? . 0) q princess-leia)) q (5912 . 2)) ((c def c (c (? . 0) q luke)) q (5840 . 2)) ((c def c (c (? . 0) q r2-d2)) q (5943 . 2)) ((c def c (c (? . 0) q custom-lightsaber)) q (2016 . 23)) ((c def c (c (? . 0) q custom-blaster)) q (3109 . 23)) ((c def c (c (? . 0) q custom-villain)) q (1040 . 19)) ((c def c (c (? . 0) q stormtrooper)) q (5966 . 2)) ((c def c (c (? . 0) q padawan)) q (5887 . 2)) ((c def c (c (? . 0) q darth-maul)) q (5757 . 2)) ((c def c (c (? . 0) q darth-vader)) q (5785 . 2)) ((c def c (c (? . 0) q yoda)) q (6026 . 2)) ((c def c (c (? . 0) q custom-hero)) q (0 . 20)) ((c def c (c (? . 0) q custom-planet)) q (4158 . 14)) ((c def c (c (? . 0) q twileck-jedi)) q (5996 . 2))))
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
  sprite : sprite? = (circle 30 'solid 'red)
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
(custom-villain [#:amount-in-world amount-in-world     
                 #:sprite sprite                       
                 #:ai ai-level                         
                 #:health health                       
                 #:shield shield                       
                 #:weapon weapon                       
                 #:death-particles death-particles     
                 #:components first-component]         
                 more-components ...)              -> entity?
  amount-in-world : positive? = 1
  sprite : sprite? = stormtrooper-sprite
  ai-level : ai-level? = 'easy
  health : positive? = 100
  shield : positive? = 100
  weapon : entity? = (custom-blaster)
  death-particles : entity? = (custom-particles)
  first-component : component-or-system? = #f
  more-components : (listof component-or-system?)
procedure
(custom-lightsaber [#:name name                    
                    #:icon sprite                  
                    #:color color                  
                    #:dart dart                    
                    #:fire-mode fire-mode          
                    #:fire-rate fire-rate          
                    #:fire-key fire-key            
                    #:mouse-fire-button button     
                    #:point-to-mouse? ptm?         
                    #:rapid-fire? rf?              
                    #:rarity rarity])          -> entity?
  name : string? = "Lightsaber"
  sprite : sprite? = (make-icon "LS" "green")
  color : string? = "lightgreen"
  dart : entity? = (lightsaber #:color c)
  fire-mode : fire-mode? = 'normal
  fire-rate : number? = 3
  fire-key : symbol? = 'f
  button : (or/c 'left 'right) = 'left
  ptm? : boolean? = #t
  rf? : boolean? = #t
  rarity : rarity-level? = 'common
procedure
(custom-blaster [#:name name                    
                 #:icon sprite                  
                 #:color color                  
                 #:dart dart                    
                 #:fire-mode fire-mode          
                 #:fire-rate fire-rate          
                 #:fire-key fire-key            
                 #:mouse-fire-button button     
                 #:point-to-mouse? ptm?         
                 #:rapid-fire? rf?              
                 #:rarity rarity])          -> entity?
  name : string? = "Blaster"
  sprite : sprite? = (make-icon "B" "red")
  color : string? = "red"
  dart : entity? = (blaster-dart #:color c)
  fire-mode : fire-mode? = 'normal
  fire-rate : number? = 3
  fire-key : symbol? = 'f
  button : (or/c 'left 'right) = 'left
  ptm? : boolean? = #t
  rf? : boolean? = #t
  rarity : rarity-level? = 'common
procedure
(custom-planet [#:img bg-img                      
                #:rows rows                       
                #:columns columns                 
                #:start-tile start-tile           
                #:components first-component]     
                more-components ...)          -> entity?
  bg-img : image?
         = (change-img-hue (random 360) (draw-plain-bg))
  rows : number? = 3
  columns : number? = 3
  start-tile : number? = 0
  first-component : component-or-system? = #f
  more-components : (listof component-or-system?)
procedure
(starwars-game [#:headless headless                  
                #:planet planet                      
                #:hero avatar                        
                #:villain-list enemy-list            
                #:weapon-list weapon-list            
                #:item-list item-list                
                #:other-entities other-entities]     
                rest ...)                        -> game?
  headless : boolean? = #f
  planet : entity? = #f
  avatar : (or/c entity? false?) = (plain-bg)
  enemy-list : (listof (or/c entity? procedure?))
             = (list (custom-villain))
  weapon-list : (listof (or/c entity? procedure?)) = '()
  item-list : (listof (or/c entity? procedure?)) = '()
  other-entities : (or/c #f entity?) = #f
  rest : (listof entity?)
value
boba-fett : image?
value
darth-maul : image?
value
darth-vader : image?
value
han-solo : image?
value
luke : image?
value
obi-wan : image?
value
padawan : image?
value
princess-leia : image?
value
r2-d2 : image?
value
stormtrooper : image?
value
twileck-jedi : image?
value
yoda : image?
