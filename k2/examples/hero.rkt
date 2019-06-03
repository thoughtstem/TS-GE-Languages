#lang racket

(require ts-kata-util
         game-engine)

(module basic racket

  (require ts-kata-util
           k2/lang/hero/basic)

  ; ===== HERO - INTRO
  (define-example-code k2/lang/hero/basic
                       hero-000
                       (start))

  ;===== HERO - BASIC
  (define-example-code k2/lang/hero/basic
                       hero-001
                       (start ironman))

  (define-example-code k2/lang/hero/basic
                       hero-002
                       (start gamora)
                       )

  (define-example-code k2/lang/hero/basic
                       hero-003
                       (start gamora
                              (nebula))
                       )

  (define-example-code k2/lang/hero/basic
                       hero-004
                       (start hulk
                              (loki redskull mandarin))
                       )

  (define-example-code k2/lang/hero/basic
                       hero-005
                       (start ironman
                              (captainamerica hulk))
                       )

  (define-example-code k2/lang/hero/basic
                       hero-006
                       (start captainamerica
                              (captainamerica captainamerica))
                       )
  
  )


(module powers racket

  (require ts-kata-util
           k2/lang/hero/powers)
  ; ===== HERO - POWERS

  (define-example-code k2/lang/hero/powers
                       hero-007
                       (start (thor hammer)
                              (loki))
                       )

  (define-example-code k2/lang/hero/powers
                       hero-008
                       (start (starlord star-bit)
                              (mandarin))
                       )

  (define-example-code k2/lang/hero/powers
                       hero-009
                       (start (gamora magic-orb)
                              ((nebula energy-blast)))
                       )

  (define-example-code k2/lang/hero/powers
                       hero-010
                       (start (loki energy-blast)
                              ((thor hammer)
                               (starlord star-bit)))
                       )

  (define-example-code k2/lang/hero/powers
                       hero-011
                       (start (nebula energy-blast)
                              ((rocketracoon star-bit)
                               (gamora star-bit)
                               (drax magic-orb)
                               (starlord magic-orb)))
                       )

  (define-example-code k2/lang/hero/powers
                       hero-012
                       (start (thor randp)
                              ((loki randp)
                               (malekith randp)
                               (mandarin randp)
                               (nebula randp)))
                       )

  ; ===== HERO - POWERS + COLORS

  (define-example-code k2/lang/hero/powers
                       hero-013
                       (start (gamora magic-orb green )
                              ((nebula energy-blast blue)))
                       )

  (define-example-code k2/lang/hero/powers
                       hero-014
                       (start (loki energy-blast yellow)
                              ((thor hammer orange)
                               (starlord star-bit purple)))
                       )

  (define-example-code k2/lang/hero/powers
                       hero-015
                       (start (nebula energy-blast green)
                              ((rocketracoon star-bit red)
                               (gamora star-bit red)
                               (drax magic-orb red)
                               (starlord magic-orb red)))
                       )

  (define-example-code k2/lang/hero/powers
                       hero-016
                       (start (loki star-bit)
                              ((thor hammer red)
                               (thor hammer orange)
                               (thor hammer yellow)
                               (thor hammer green)
                               (thor hammer blue)
                               (thor hammer purple)))
                       )

  (define-example-code k2/lang/hero/powers
                       hero-017
                       (start (gamora randp red)
                              ((nebula randp orange)
                               (mandarin randp yellow)))
                       )

  (define-example-code k2/lang/hero/powers
                       hero-018
                       (start (starlord randp randc)
                              ((rocketracoon randp randc)
                               (drax randp randc)
                               (gamora randp randc)))
                       ))


(module items racket
  
  (require ts-kata-util
           k2/lang/hero/items)

  ; ===== HERO - ITEMS

  (define-example-code k2/lang/hero/items
                       hero-019
                       (start (drax energy-blast)
                              ((loki magic-orb)
                               (thor hammer)))
                       )

  (define-example-code k2/lang/hero/items
                       hero-020
                       (start (ironman magic-orb red)
                              ((mandarin energy-blast orange)
                               (mandarin randp randc)))
                       )

  (define-example-code k2/lang/hero/items
                       hero-021
                       (start (ironman star-bit)
                              ((nebula magic-orb)
                               (loki energy-blast))
                              (health forcefield))
                       )

  (define-example-code k2/lang/hero/items
                       hero-022
                       (start (thor hammer blue)
                              ((loki randp randc)
                               (mandarin randp randc))
                              (grow shrink speed))
                       )

  (define-example-code k2/lang/hero/items
                       hero-023
                       (start (nebula star-bit randc)
                              ((blackwidow randp red)
                               (ironman energy-blast blue))
                              (health speed))
                       )

  (define-example-code k2/lang/hero/items
                       hero-024
                       (start (ironman magic-orb red)
                              ((ironman randp randc)
                               (ironman randp randc)
                               (ironman randp randc))
                              (forcefield speed))
                       )

  ; ===== HERO - ITEMS - MULTI-GAMES
  (define-example-code k2/lang/hero/items
                       hero-025
                       (start (drax randp randc)
                              ((loki randp randc)
                               (malekith randp randc)
                               (mandarin randp randc)
                               (nebula randp randc))
                              (health grow shrink speed forcefield))
                       )

  (define-example-code k2/lang/hero/items
                       hero-026
                       (start (thor hammer)
                              ((loki magic-orb)
                               (loki star-bit)))
                       (start (thor hammer green)
                              ((loki magic-orb red)
                               (loki star-bit red)))
                       )

  (define-example-code k2/lang/hero/items
                       hero-027
                       (start (ironman magic-orb green)
                              ((mandarin magic-orb red)))
                       (start (ironman magic-orb green)
                              ((mandarin magic-orb red)
                               (mandarin magic-orb orange)))
                       (start (ironman magic-orb green)
                              ((mandarin magic-orb red)
                               (mandarin magic-orb orange)
                               (mandarin magic-orb yellow)))
                       )

  (define-example-code k2/lang/hero/items
                       hero-028
                       (start (blackwidow randp randc)
                              ((nebula randp randc)))
                       (start (blackwidow randp randc)
                              ((nebula randp randc)
                               (nebula randp randc)))
                       (start (blackwidow randp randc)
                              ((nebula randp randc)
                               (nebula randp randc))
                              (health speed))
                       )

  (define-example-code k2/lang/hero/items
                       hero-029
                       (start (ironman randp randc)
                              ((loki randp randc)))
                       (start (drax randp randc)
                              ((malekith randp randc)
                               (mandarin randp randc)))
                       (start (blackwidow randp randc)
                              ((nebula randp randc)
                               (loki randp randc))
                              (health speed))
                       )

  (define-example-code k2/lang/hero/items
                       hero-030
                       (start (ironman randp randc)
                              ((loki randp randc))
                              (health))
                       (start (drax randp randc)
                              ((loki randp randc)
                               (malekith randp randc))
                              (health grow shrink))
                       (start (blackwidow randp randc)
                              ((loki randp randc)
                               (malekith randp randc)
                               (mandarin randp randc)
                               (nebula randp randc))
                              (health grow shrink speed forcefield))
                       )

  )


(provide (all-from-out 'basic 'powers 'items))
(require 'basic 'powers 'items)
