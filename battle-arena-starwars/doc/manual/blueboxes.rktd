1502
((3) 0 () 1 ((q lib "battle-arena-starwars/main.rkt")) () (h ! (equal) ((c def c (c (? . 0) q bobafett)) q (5758 . 2)) ((c def c (c (? . 0) q r2d2)) q (6176 . 2)) ((c def c (c (? . 0) q custom-lightsaber)) q (2016 . 23)) ((c def c (c (? . 0) q darthmaul-2)) q (5830 . 2)) ((c def c (c (? . 0) q custom-villain)) q (1040 . 19)) ((c def c (c (? . 0) q custom-blaster)) q (3109 . 23)) ((c def c (c (? . 0) q princessleia)) q (6122 . 2)) ((c def c (c (? . 0) q twilek)) q (6282 . 2)) ((c def c (c (? . 0) q lando)) q (5996 . 2)) ((c def c (c (? . 0) q twilek-2)) q (6256 . 2)) ((c def c (c (? . 0) q bobafett-2)) q (5730 . 2)) ((c def c (c (? . 0) q padawan)) q (6065 . 2)) ((c def c (c (? . 0) q hansolo)) q (5971 . 2)) ((c def c (c (? . 0) q obiwan)) q (6041 . 2)) ((c def c (c (? . 0) q custom-hero)) q (0 . 20)) ((c def c (c (? . 0) q princessleia-2)) q (6090 . 2)) ((c def c (c (? . 0) q custom-planet)) q (4158 . 14)) ((c def c (c (? . 0) q starwars-game)) q (4802 . 18)) ((c def c (c (? . 0) q darthvader)) q (5916 . 2)) ((c def c (c (? . 0) q chewie)) q (5806 . 2)) ((c def c (c (? . 0) q darthvader-2)) q (5886 . 2)) ((c def c (c (? . 0) q c3po)) q (5784 . 2)) ((c def c (c (? . 0) q darthmaul)) q (5859 . 2)) ((c def c (c (? . 0) q hansolo-2)) q (5944 . 2)) ((c def c (c (? . 0) q rebelpilot)) q (6198 . 2)) ((c def c (c (? . 0) q stormtrooper)) q (6226 . 2)) ((c def c (c (? . 0) q luke)) q (6019 . 2)) ((c def c (c (? . 0) q yoda)) q (6306 . 2)) ((c def c (c (? . 0) q r2d2-2)) q (6152 . 2))))
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
bobafett-2 : image?
value
bobafett : image?
value
c3po : image?
value
chewie : image?
value
darthmaul-2 : image?
value
darthmaul : image?
value
darthvader-2 : image?
value
darthvader : image?
value
hansolo-2 : image?
value
hansolo : image?
value
lando : image?
value
luke : image?
value
obiwan : image?
value
padawan : image?
value
princessleia-2 : image?
value
princessleia : image?
value
r2d2-2 : image?
value
r2d2 : image?
value
rebelpilot : image?
value
stormtrooper : image?
value
twilek-2 : image?
value
twilek : image?
value
yoda : image?
