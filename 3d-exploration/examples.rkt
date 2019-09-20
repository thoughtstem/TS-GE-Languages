#lang racket

(require ts-kata-util)

; === TODO: Make vr-test work, file in ts-kata-util/main.rkt
(define-example-code
  ;#:with-test (test vr-test)
  3d-exploration hello-world-1
  (exploration-scene))


; ===== ENVIRONMENT KATAS
(define-example-code
  ;#:with-test (test vr-test)
  3d-exploration environment-1
  (exploration-scene
   #:environment (basic-volcano))
  )

(define-example-code
  ;#:with-test (test vr-test)
  3d-exploration environment-2
  (exploration-scene
   #:environment (basic-volcano #:preset 'egypt
                                #:dressing 'mushrooms
                                #:dressing-amount 20
                                #:dressing-scale 0.5
                                ))
  )

(define-example-code
  ;#:with-test (test vr-test)
  3d-exploration environment-3
  (exploration-scene
   #:environment (basic-forest #:preset 'poison
                               #:dressing 'cubes
                               #:dressing-amount 10
                               #:ground 'spikes
                               #:fog 0.6
                               #:horizon-color "#00B0B0"
                               ))
  )

(define-example-code
   ;#:with-test (test vr-test)
  3d-exploration environment-4
  (exploration-scene
   #:environment (basic-environment #:preset 'tron
                                    #:dressing 'hexagons
                                    #:dressing-amount 40
                                    #:dressing-scale 0.5
                                    #:dressing-variance (variance 0.1 2.0 0.1)
                                    #:ground 'canyon
                                    #:ground-texture 'squares
                                    #:fog 0.6
                                    #:horizon-color "#00B0B0"
                                    ))
  )

(define-example-code
  ;#:with-test (test vr-test)
  3d-exploration environment-5
  (exploration-scene
   #:environment (basic-environment #:preset 'tron
                                    #:dressing 'hexagons
                                    #:dressing-amount 40
                                    #:dressing-scale 0.5
                                    #:dressing-variance (variance 0.1 2.0 0.1)
                                    #:ground 'canyon
                                    #:ground-texture 'squares
                                    #:fog 0.6
                                    #:horizon-color "#00B0B0"
                                    ))
  )

; ===== SKY OBJECTS KATAS
; ===== GROUND OBJECTS KATAS
; ===== PARTICLES KATAS
; ===== OCEAN KATAS
