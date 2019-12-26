#lang at-exp racket

(require ts-kata-util/assets/main
         fandom-sprites
         game-engine)


(provide potion-sprite
         redmushroom-sprite
         greenmushroom-sprite
         energyball-sheet
         ironpatriot-sheet
         c2po-sheet
         ore-entity
         coalore-sprite
         ironore-sprite
         copperore-sprite
         goldore-sprite
         meseore-sprite
         diamondore-sprite
         coallump-sprite
         ironlump-sprite
         copperlump-sprite
         goldingot-sprite
         mesecrystal-sprite
         diamond-sprite
         fireball-sheet
         pokeball2-sheet
         dawnstone-sprite
         duskstone-sprite
         everstone-sprite
         firestone-sprite
         leafstone-sprite
         moonstone-sprite
         shinystone-sprite
         sunstone-sprite
         thunderstone-sprite
         waterstone-sprite
         dawnstone-sprite
         )

(define (easy-sprite sheet r c n)
  (sheet->sprite sheet
                 #:rows r
                 #:columns c
                 #:row-number n
                 #:delay 5))

(define-syntax-rule (define-sprite sheet r c n sprite-name)
  (begin
    (provide sprite-name)
    (define sprite-name (easy-sprite sheet r c n))))

(define-syntax-rule (define-sprites sheet r c start sprite-name ...)
  (begin
    (define row-num (sub1 start))
    (define (next-row-num)
      (begin
        (set! row-num (add1 row-num))
        row-num))
    (provide sprite-name ...)
    (define sprite-name (easy-sprite sheet r c (next-row-num))) ...))

; Harry Potter
(define-sprite harrypotter-sheet 1 18 1 harrypotter-sprite)
(define-sprite flyingbook-sheet 1 6 1  flyingbook-sprite)
(define-sprite pumpkin-sheet 1 8 1 pumpkin-sprite)
(define-sprite cauldron-sheet 1 6 1 magiccauldron-sprite)
(define-sprite snape-sheet 1 21 1 snape-sprite)
(define-sprite tentacula-sheet 1 14 1 tentacula-sprite)
(define-sprite hagrid-sheet 1 11 1 hagrid-sprite)
(define-sprite oldwizard-sheet 1 6 1 oldwizard-sprite)

; Mario
(define-sprite bigmario-sheet 4 4 1 bigmario-sprite)
(define-sprite block-sheet 4 1 1 pinkblock-sprite)
(define-sprite blooper-sheet 4 2 1 blooper-sprite)
(define-sprite bowser-sheet 4 4 1 bowser-sprite)
(define-sprite brick-sheet 4 1 1 pinkbrick-sprite)
(define-sprite buzzy-sheet 4 2 1 buzzy-sprite)
(define-sprite cheep-sheet 4 2 1 cheep-sprite)
(define-sprite fence-sheet 4 1 1 pinkfence-sprite)
(define-sprite goomba-sheet 4 2 1 goomba-sprite)
(define-sprite lakitu-sheet 4 2 1 lakitu-sprite)
(define-sprite paratroopa-sheet 4 2 1 paratroopa-sprite)
(define-sprite pipe-sheet 4 1 1 pinkpipe-sprite)
(define-sprite piranha-sheet 4 5 1 piranha-sprite)
(define-sprite question-sheet 4 1 1 pinkquestion-sprite)
(define-sprite smallmario-sheet 4 4 1 smallmario-sprite)
(define-sprite spiny-sheet 4 2 1 spiny-sprite)
(define-sprite troopa-sheet 4 2 1 troopa-sprite)


(define-sprite princesspeach-sheet 1 2 1 princesspeach-sprite)
(define-sprite toad-sheet 1 2 1 toad-sprite)
(define-sprite luigi-sheet 1 2 1 luigi-sprite)
(define-sprite mario-sheet 1 2 1 mario-sprite)
(define-sprite yoshi-sheet 2 2 1 yoshi-sprite)
(define-sprite yoshi-sheet 2 2 2 redyoshi-sprite)

(define-sprites bigmario-sheet 4 4 2
  bluebigmario-sprite
  orangebigmario-sprite
  greybigmario-sprite)

(define-sprites block-sheet 4 1 2
  blueblock-sprite
  orangeblock-sprite
  greyblock-sprite)

(define-sprites blooper-sheet 4 2 2
  blueblooper-sprite
  orangeblooper-sprite
  greyblooper-sprite)

(define-sprites bowser-sheet 4 4 2
  bluebowser-sprite
  orangebowser-sprite
  greybowser-sprite)

(define-sprites brick-sheet 4 1 2
  bluebrick-sprite
  orangebrick-sprite
  greybrick-sprite)

(define-sprites buzzy-sheet 4 2 2
  bluebuzzy-sprite
  orangebuzzy-sprite
  greybuzzy-sprite)

(define-sprites cheep-sheet 4 2 2
  bluecheep-sprite
  orangecheep-sprite
  greycheep-sprite)

(define-sprites fence-sheet 4 1 2
  bluefence-sprite
  orangefence-sprite
  greyfence-sprite)

(define-sprites goomba-sheet 4 2 2
  bluegoomba-sprite
  orangegoomba-sprite
  greygoomba-sprite)

(define-sprites lakitu-sheet 4 2 2
  bluelakitu-sprite
  orangelakitu-sprite
  greylakitu-sprite)

(define-sprites paratroopa-sheet 4 2 2
  blueparatroopa-sprite
  orangeparatroopa-sprite
  greyparatroopa-sprite)

(define-sprites pipe-sheet 4 1 2
  bluepipe-sprite
  orangepipe-sprite
  greypipe-sprite)

(define-sprites piranha-sheet 4 5 2
  bluepiranha-sprite
  orangepiranha-sprite
  greypiranha-sprite)

(define-sprites question-sheet 4 1 2
  bluequestion-sprite
  orangequestion-sprite
  greyquestion-sprite)

(define-sprites smallmario-sheet 4 4 2
  bluesmallmario-sprite
  orangesmallmario-sprite
  greysmallmario-sprite)

(define-sprites spiny-sheet 4 2 2
  bluespiny-sprite
  orangespiny-sprite
  greyspiny-sprite)

(define-sprites troopa-sheet 4 2 2
  bluetroopa-sprite
  orangetroopa-sprite
  greytroopa-sprite)

;Avengers
(define-sprite (rotate 90 green-effect) 1 10 1 green-effect-sprite)
(define-sprite blackwidow-sheet 4 4 3 blackwidow-sprite)
(define-sprite gamora-sheet 4 4 3 gamora-sprite)
(define-sprite ironman-sheet 4 4 3 ironman-sprite)
(define-sprite mandarin-sheet 4 4 3 mandarin-sprite)
(define-sprite redskull-sheet 4 4 3 redskull-sprite)
(define-sprite starlord-sheet 4 4 3 starlord-sprite)
(define-sprite wintersoldier-sheet 4 4 3 wintersoldier-sprite)
(define-sprite captainamerica-sheet 4 4 3 captainamerica-sprite)
(define-sprite hawkeye-sheet 4 4 3 hawkeye-sprite)
(define-sprite loki-sheet 4 4 3 loki-sprite)
(define-sprite nebula-sheet 4 4 3 nebula-sprite)
(define-sprite rocketracoon-sheet 4 4 3 rocketracoon-sprite)
(define-sprite thor-sheet 4 4 3 thor-sprite)
(define-sprite drax-sheet 4 4 3 drax-sprite)
(define-sprite hulk-sheet 4 4 3 hulk-sprite)
(define-sprite malekith-sheet 4 4 3 malekith-sprite)
(define-sprite nickfury-sheet 4 4 3 nickfury-sprite)
(define-sprite ronan-sheet 4 4 3 ronan-sprite)
(define-sprite tonystark-sheet 4 4 3 tonystark-sprite)
(define-sprite ironpatriot-sheet 4 4 3 ironpatriot-sprite)

;Star Wars
(define-sprite twilek-sheet 4 4 3 twilek-sprite)
(define-sprite darthmaul-sheet 4 4 3 darthmaul-sprite)
(define-sprite darthvader-sheet 4 4 3 darthvader-sprite)
(define-sprite bobafett-sheet 4 4 3 bobafett-sprite)
(define-sprite hansolo-sheet 4 4 3 hansolo-sprite)
(define-sprite luke-sheet 4 4 3 luke-sprite)
(define-sprite obiwan-sheet 4 4 3 obiwan-sprite)
(define-sprite padawan-sheet 4 4 3 padawan-sprite)
(define-sprite princessleia-sheet 4 4 3 princessleia-sprite)
(define-sprite yoda-sheet 4 4 3 yoda-sprite)
(define-sprite r2d2-sheet 4 4 3 r2d2-sprite)
(define-sprite stormtrooper-sheet 4 4 3 stormtrooper-sprite)
(define-sprite c2po-sheet 4 4 3 c2po-sprite)
(define-sprite c3po-sheet 4 4 3 c3po-sprite)
(define-sprite chewie-sheet 4 4 3 chewie-sprite)
(define-sprite lando-sheet 4 4 3 lando-sprite)
(define-sprite rebelpilot-sheet 4 4 3 rebelpilot-sprite)

;Minecraft
(define-sprite steve-sheet 1 2 1 steve-sprite)
(define-sprite alex-sheet 1 2 1 alex-sprite)
(define-sprite (scale .75 creeper-sheet)1 4 1 creeper-sprite)
(define-sprite chicken-sheet 1 4 1 chicken-sprite)
(define-sprite pig-sheet 1 4 1 pig-sprite)
(define-sprite sheep-sheet 1 4 1 sheep-sprite)
(define-sprite (scale .75 skeleton-sheet) 1 4 1 skeleton-sprite)
(define-sprite ghast-sheet 1 4 1 ghast-sprite)

(define (ore-entity)
  (sprite->entity (sheet->sprite ironore-sprite #:columns 1)
                  #:position   (posn 0 0)
                  #:name       "Iron Ore"
                  #:components (active-on-bg 0)
                               (physical-collider)))

;Pokemon
(define-sprite armoredmewtwo-sheet 4 4 3 armoredmewtwo-sprite)
(define-sprite pikachu-sheet 1 4 1 pikachu-sprite)
(define-sprite pikachurun-sheet 1 4 1 pikachurun-sprite)
(define-sprite jessie-sheet 4 4 3 jessie-sprite)
(define-sprite james-sheet 4 4 3 james-sprite)
(define-sprite redboy-sheet 4 4 3 redboy-sprite)
(define-sprite redgirl-sheet 4 4 3 redgirl-sprite)
(define-sprite greenboy-sheet 4 4 3 greenboy-sprite)
(define-sprite greengirl-sheet 4 4 3 greengirl-sprite)
(define-sprite bulbasaur-sheet 1 5 1 bulbasaur-sprite)
(define-sprite ivysaur-sheet 1 6 1 ivysaur-sprite)
(define-sprite venusaur-sheet 1 5 1 venasaur-sprite)
(define-sprite squirtle-sheet 1 6 1 squirtle-sprite)
(define-sprite wartortle-sheet 1 8 1 wartortle-sprite)
(define-sprite blastoise-sheet 1 8 1 blastoise-sprite)
(define-sprite charmander-sheet 1 5 1 charmander-sprite)
(define-sprite charmeleon-sheet 1 8 1 charmelon-sprite)
(define-sprite charizard-sheet 1 8 1 charizard-sprite)