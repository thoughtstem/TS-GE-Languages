2817
((3) 0 () 1 ((q lib "battle-arena-starwars/main.rkt")) () (h ! (equal) ((c def c (c (? . 0) q lando-sprite)) q (6366 . 2)) ((c def c (c (? . 0) q FOREST-BG)) q (5860 . 2)) ((c def c (c (? . 0) q darthmaul-2)) q (6824 . 2)) ((c def c (c (? . 0) q custom-villain)) q (1039 . 19)) ((c def c (c (? . 0) q custom-blaster)) q (3119 . 23)) ((c def c (c (? . 0) q lando)) q (6990 . 2)) ((c def c (c (? . 0) q bobafett-2)) q (6702 . 2)) ((c def c (c (? . 0) q hansolo-sprite)) q (6191 . 2)) ((c def c (c (? . 0) q obiwan)) q (7035 . 2)) ((c def c (c (? . 0) q custom-hero)) q (0 . 20)) ((c def c (c (? . 0) q PINK-BG)) q (5964 . 2)) ((c def c (c (? . 0) q darthmaul)) q (6853 . 2)) ((c def c (c (? . 0) q random-character-sprite)) q (5772 . 2)) ((c def c (c (? . 0) q darthmaul-sprite)) q (6568 . 2)) ((c def c (c (? . 0) q c2po-sprite)) q (6484 . 2)) ((c def c (c (? . 0) q starwars-game)) q (4814 . 18)) ((c def c (c (? . 0) q twilek)) q (7276 . 2)) ((c def c (c (? . 0) q yoda-sprite)) q (6069 . 2)) ((c def c (c (? . 0) q chewie)) q (6800 . 2)) ((c def c (c (? . 0) q DESERT-BG)) q (5912 . 2)) ((c def c (c (? . 0) q c3po-sprite)) q (6445 . 2)) ((c def c (c (? . 0) q c3po)) q (6778 . 2)) ((c def c (c (? . 0) q r2d2-sprite)) q (6406 . 2)) ((c def c (c (? . 0) q princessleia-2)) q (7084 . 2)) ((c def c (c (? . 0) q princessleia-sprite)) q (6274 . 2)) ((c def c (c (? . 0) q rebelpilot)) q (7192 . 2)) ((c def c (c (? . 0) q bobafett-sprite)) q (6612 . 2)) ((c def c (c (? . 0) q luke)) q (7013 . 2)) ((c def c (c (? . 0) q yoda)) q (7300 . 2)) ((c def c (c (? . 0) q bobafett)) q (6730 . 2)) ((c def c (c (? . 0) q padawan-sprite)) q (6149 . 2)) ((c def c (c (? . 0) q custom-planet)) q (4170 . 14)) ((c def c (c (? . 0) q LAVA-BG)) q (5939 . 2)) ((c def c (c (? . 0) q princessleia)) q (7116 . 2)) ((c def c (c (? . 0) q wizard-sheet)) q (5830 . 2)) ((c def c (c (? . 0) q stormtrooper-sprite)) q (6655 . 2)) ((c def c (c (? . 0) q obiwan-sprite)) q (6028 . 2)) ((c def c (c (? . 0) q SNOW-BG)) q (5887 . 2)) ((c def c (c (? . 0) q chewie-sprite)) q (6233 . 2)) ((c def c (c (? . 0) q hansolo)) q (6965 . 2)) ((c def c (c (? . 0) q custom-lightsaber)) q (2031 . 23)) ((c def c (c (? . 0) q luke-sprite)) q (5989 . 2)) ((c def c (c (? . 0) q darthvader)) q (6910 . 2)) ((c def c (c (? . 0) q twilek-sprite)) q (6108 . 2)) ((c def c (c (? . 0) q darthvader-sprite)) q (6523 . 2)) ((c def c (c (? . 0) q padawan)) q (7059 . 2)) ((c def c (c (? . 0) q darthvader-2)) q (6880 . 2)) ((c def c (c (? . 0) q c2po)) q (6756 . 2)) ((c def c (c (? . 0) q rebelpilot-sprite)) q (6321 . 2)) ((c def c (c (? . 0) q r2d2)) q (7170 . 2)) ((c def c (c (? . 0) q hansolo-2)) q (6938 . 2)) ((c def c (c (? . 0) q stormtrooper)) q (7220 . 2)) ((c def c (c (? . 0) q twilek-2)) q (7250 . 2)) ((c def c (c (? . 0) q r2d2-2)) q (7146 . 2))))
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
  weapon : entity? = (custom-blaster #:color "red")
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
  color : string? = "green"
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
  color : string? = "green"
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
  headless : boolean?
           = (custom-hero #:sprite (circle 10 'solid 'red))
  planet : entity? = #f
  avatar : (or/c entity? false?) = (plain-bg)
  enemy-list : (listof (or/c #f entity? procedure?)) = '()
  weapon-list : (listof (or/c entity? procedure?)) = '()
  item-list : (listof (or/c entity? procedure?)) = '()
  other-entities : (or/c #f entity?) = #f
  rest : (listof entity?)
procedure
(random-character-sprite) -> animated-sprite?
value
wizard-sheet : image?
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
luke-sprite : animated-sprite?
value
obiwan-sprite : animated-sprite?
value
yoda-sprite : animated-sprite?
value
twilek-sprite : animated-sprite?
value
padawan-sprite : animated-sprite?
value
hansolo-sprite : animated-sprite?
value
chewie-sprite : animated-sprite?
value
princessleia-sprite : animated-sprite?
value
rebelpilot-sprite : animated-sprite?
value
lando-sprite : animated-sprite?
value
r2d2-sprite : animated-sprite?
value
c3po-sprite : animated-sprite?
value
c2po-sprite : animated-sprite?
value
darthvader-sprite : animated-sprite?
value
darthmaul-sprite : animated-sprite?
value
bobafett-sprite : animated-sprite?
value
stormtrooper-sprite : animated-sprite?
value
bobafett-2 : image?
value
bobafett : image?
value
c2po : image?
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
