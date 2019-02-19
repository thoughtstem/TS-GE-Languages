2390
((3) 0 () 1 ((q lib "battle-arena-avengers/main.rkt")) () (h ! (equal) ((c def c (c (? . 0) q hawkeye-sprite)) q (4888 . 2)) ((c def c (c (? . 0) q blackwidow-sprite)) q (4843 . 2)) ((c def c (c (? . 0) q ironpatriot)) q (5696 . 2)) ((c def c (c (? . 0) q starlord)) q (5928 . 2)) ((c def c (c (? . 0) q malekith-sprite)) q (5435 . 2)) ((c def c (c (? . 0) q rocketracoon)) q (5875 . 2)) ((c def c (c (? . 0) q redskull)) q (5849 . 2)) ((c def c (c (? . 0) q hulk)) q (5649 . 2)) ((c def c (c (? . 0) q custom-villain)) q (1039 . 19)) ((c def c (c (? . 0) q thor-sprite)) q (4969 . 2)) ((c def c (c (? . 0) q captainamerica-sprite)) q (4794 . 2)) ((c def c (c (? . 0) q hawkeye)) q (5624 . 2)) ((c def c (c (? . 0) q captainamerica)) q (5546 . 2)) ((c def c (c (? . 0) q nickfury-sprite)) q (5008 . 2)) ((c def c (c (? . 0) q hulk-sprite)) q (4930 . 2)) ((c def c (c (? . 0) q ironpatriot-sprite)) q (4748 . 2)) ((c def c (c (? . 0) q mandarin)) q (5773 . 2)) ((c def c (c (? . 0) q ironman)) q (5671 . 2)) ((c def c (c (? . 0) q starlord-sprite)) q (5051 . 2)) ((c def c (c (? . 0) q tonystark)) q (5976 . 2)) ((c def c (c (? . 0) q avengers-game)) q (3709 . 18)) ((c def c (c (? . 0) q tonystark-sprite)) q (4662 . 2)) ((c def c (c (? . 0) q loki)) q (5725 . 2)) ((c def c (c (? . 0) q drax-sprite)) q (5182 . 2)) ((c def c (c (? . 0) q rocketracoon-sprite)) q (5135 . 2)) ((c def c (c (? . 0) q ronan)) q (5905 . 2)) ((c def c (c (? . 0) q wintersoldier-sprite)) q (5307 . 2)) ((c def c (c (? . 0) q custom-hero)) q (0 . 20)) ((c def c (c (? . 0) q gamora-sprite)) q (5094 . 2)) ((c def c (c (? . 0) q nickfury)) q (5823 . 2)) ((c def c (c (? . 0) q custom-planet)) q (3065 . 14)) ((c def c (c (? . 0) q nebula)) q (5799 . 2)) ((c def c (c (? . 0) q blackwidow)) q (5518 . 2)) ((c def c (c (? . 0) q drax)) q (5578 . 2)) ((c def c (c (? . 0) q custom-power)) q (2030 . 23)) ((c def c (c (? . 0) q malekith)) q (5747 . 2)) ((c def c (c (? . 0) q thor)) q (5954 . 2)) ((c def c (c (? . 0) q gamora)) q (5600 . 2)) ((c def c (c (? . 0) q wintersoldier)) q (6003 . 2)) ((c def c (c (? . 0) q mandarin-sprite)) q (5221 . 2)) ((c def c (c (? . 0) q nebula-sprite)) q (5394 . 2)) ((c def c (c (? . 0) q loki-sprite)) q (5355 . 2)) ((c def c (c (? . 0) q ronan-sprite)) q (5478 . 2)) ((c def c (c (? . 0) q ironman-sprite)) q (4706 . 2)) ((c def c (c (? . 0) q redskull-sprite)) q (5264 . 2))))
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
  sprite : sprite? = wintersoldier-sprite
  ai-level : ai-level? = 'easy
  health : positive? = 100
  shield : positive? = 100
  weapon : entity? = (custom-power #:color "red")
  death-particles : entity? = (custom-particles)
  first-component : component-or-system? = #f
  more-components : (listof component-or-system?)
procedure
(custom-power [#:name name                    
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
  name : string? = "Energy Blast"
  sprite : sprite? = (make-icon "EB" "green")
  color : string? = "blue"
  dart : entity? = (energy-dart #:color c)
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
(avengers-game [#:headless headless                  
                #:planet planet                      
                #:hero avatar                        
                #:villain-list enemy-list            
                #:power-list power-list              
                #:item-list item-list                
                #:other-entities other-entities]     
                rest ...)                        -> game?
  headless : boolean?
           = (custom-hero #:sprite (circle 10 'solid 'red))
  planet : entity? = #f
  avatar : (or/c entity? false?) = (plain-bg)
  enemy-list : (listof (or/c entity? procedure?)) = '()
  power-list : (listof (or/c entity? procedure?)) = '()
  item-list : (listof (or/c entity? procedure?)) = '()
  other-entities : (or/c #f entity?) = #f
  rest : (listof entity?)
value
tonystark-sprite : animated-sprite?
value
ironman-sprite : animated-sprite?
value
ironpatriot-sprite : animated-sprite?
value
captainamerica-sprite : animated-sprite?
value
blackwidow-sprite : animated-sprite?
value
hawkeye-sprite : animated-sprite?
value
hulk-sprite : animated-sprite?
value
thor-sprite : animated-sprite?
value
nickfury-sprite : animated-sprite?
value
starlord-sprite : animated-sprite?
value
gamora-sprite : animated-sprite?
value
rocketracoon-sprite : animated-sprite?
value
drax-sprite : animated-sprite?
value
mandarin-sprite : animated-sprite?
value
redskull-sprite : animated-sprite?
value
wintersoldier-sprite : animated-sprite?
value
loki-sprite : animated-sprite?
value
nebula-sprite : animated-sprite?
value
malekith-sprite : animated-sprite?
value
ronan-sprite : animated-sprite?
value
blackwidow : image?
value
captainamerica : image?
value
drax : image?
value
gamora : image?
value
hawkeye : image?
value
hulk : image?
value
ironman : image?
value
ironpatriot : image?
value
loki : image?
value
malekith : image?
value
mandarin : image?
value
nebula : image?
value
nickfury : image?
value
redskull : image?
value
rocketracoon : image?
value
ronan : image?
value
starlord : image?
value
thor : image?
value
tonystark : image?
value
wintersoldier : image?
