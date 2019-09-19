#lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require vr-engine
         "../assets.rkt"
         ;ts-kata-util
         )

(provide exploration-scene
         random-scale
         random-color
         random-rotation)

; ==== GENENRIC FUNCTIONS ====
(define (random-float min max #:factor [factor 10])
  (real->double-flonum (/ (random  (exact-round (* min factor)) (exact-round (* max factor))) factor)))

; ==== EXPLORATION SCENE =====
(define (exploration-scene #:environment    [environment (basic-forest)]
                           #:ocean          [ocean #f]
                           #:sky-objects    [sky-objects '()]
                           #:ground-objects [ground-objects '()]
                           . other-entities)
  (define (randomize-sky-position e)
    (define old-attrs (entity-attrs e))
    (define (position-attribute? attr)
      (is-a? attr position%))
    (define new-attrs (append (list (position (random-float -80 80)
                                              (random-float  20 60)
                                              (random-float -80 80)))
                              (filter-not position-attribute? old-attrs)))
    (update-attributes e new-attrs))

  (define (randomize-ground-position e)
    (define old-attrs (entity-attrs e))
    (define (position-attribute? attr)
      (is-a? attr position%))
    (define new-attrs (append (list (position (random-float -40 40)
                                              1
                                              (random-float -40 40)))
                              (filter-not position-attribute? old-attrs)))
    (update-attributes e new-attrs))

  (define (randomize-scale e)
    (define old-attrs (entity-attrs e))
    (define (scale-attribute? attr)
      (is-a? attr scale%))
    (define scale-val (random-float 5.0 10.0))
    (define new-attrs (append (list (scale scale-val
                                           scale-val
                                           scale-val))
                              (filter-not scale-attribute? old-attrs)))
    (update-attributes e new-attrs))

  (define (randomize-color e)
    (define old-attrs (entity-attrs e))
    (define (color-attribute? attr)
      (is-a? attr color%))
    (define new-attrs (append (list (color (random 256)
                                           (random 256)
                                           (random 256)))
                              (filter-not color-attribute? old-attrs)))
    (update-attributes e new-attrs))

  (define (randomize-rotation e)
    (define old-attrs (entity-attrs e))
    (define (rotation-attribute? attr)
      (is-a? attr rotation%))
    (define new-attrs (append (list (rotation (random 360)
                                              (random 360)
                                              (random 360)))
                              (filter-not rotation-attribute? old-attrs)))
    (update-attributes e new-attrs))
  
  (define (asset-eq? a1 a2)
    (equal? (send (findf (curryr is-a? id%) (entity-attrs a1)) render)
            (send (findf (curryr is-a? id%) (entity-attrs a2)) render)))

  (define (obj-model? e)
    (equal? (entity-name e) "obj-model"))

  (define (gltf-model? e)
    (equal? (entity-name e) "gltf-model"))
  
  (define (model->assets-items model)
    ;Note, calling render will save it twice
    (cond [(obj-model? model) (let ([src-str (send (findf (curryr is-a? src%) (entity-attrs model)) render)]
                                    [mtl-str (send (findf (curryr is-a? mtl%) (entity-attrs model)) render)])
                                (list (assets-item #:components-list
                                                   (list (id (string-replace src-str "." "-"))
                                                         (src src-str)))
                                      (assets-item #:components-list
                                                   (list (id (string-replace mtl-str "." "-"))
                                                         (src mtl-str)))))]
          [(gltf-model? model) (let ([src-str (send (findf (curryr is-a? src%) (entity-attrs model)) render)])
                                 (list (assets-item #:components-list
                                                    (list (id (string-replace src-str "." "-"))
                                                          (src src-str)))))]
          [else (error "That wasn't a valid model file")]
          ))

  (define (assetize-model e)
    (define old-attrs (entity-attrs e))
    (define (src-or-mtl? attr)
      (or (is-a? attr src%)
          (is-a? attr mtl%)))
    (define new-src (src (~a "#" (string-replace (send (findf (curryr is-a? src%) old-attrs) render)
                                                 "." "-"))))
    (define new-mtl (if (findf (curryr is-a? mtl%) old-attrs)
                        (mtl (~a "#" (string-replace (send (findf (curryr is-a? mtl%) old-attrs) render)
                                                     "." "-")))
                        #f))
    (define new-attrs (append (filter identity (list new-src
                                                     new-mtl))
                              (filter-not src-or-mtl? old-attrs)))
    (update-attributes e new-attrs))

  (define sky-object-model-list (filter (or/c obj-model?
                                              gltf-model?) sky-objects))

  (define ground-object-model-list (filter (or/c obj-model?
                                                 gltf-model?) ground-objects))
  
  (define assets-manager
    (assets #:components-list
            (remove-duplicates (flatten (append (map model->assets-items sky-object-model-list)
                                                (map model->assets-items ground-object-model-list)))
                               asset-eq?)))

  (define assetized-sky-object-models (map assetize-model sky-object-model-list))
  (define assetized-ground-object-models (map assetize-model ground-object-model-list))

  (define modified-sky-objects (map randomize-sky-position
                                    (append (filter-not (or/c obj-model?
                                                              gltf-model?) sky-objects)
                                            assetized-sky-object-models)))
  (define modified-ground-objects (map randomize-ground-position
                                       (append (filter-not (or/c obj-model?
                                                                 gltf-model?) ground-objects)
                                               assetized-ground-object-models)))
  
  (vr-scene environment
            (basic-sky #:color (color 255 165 0)
                       #:opacity 0.5)
            (basic-camera #:fly? #t
                          #:acceleration 300
                          #:cursor (basic-cursor #:color (color 0 255 255)
                                                 #:opacity 0.5))
            (filter identity (append (list assets-manager)
                                     modified-sky-objects
                                     modified-ground-objects
                                     (list ocean)
                                     other-entities) )))

(define (random-scale [min 0.25] [max 4.0])
  (define scale-val (random-float min max))
  (scale scale-val scale-val scale-val))

(define (random-color)
  (color (random 256) (random 256) (random 256)))

(define (random-rotation)
  (rotation (random 360) (random 360) (random 360)))

; ==== EXAMPLE EXPLORATION SCENE ====
;PRESETS:        none, default, contact, egypt, checkerboard, forest, goaland, yavapai, goldmine,
;                threetowers, poison, arches, tron, japan, dream, volcano, starry, osiris
;DRESSINGS:      none, cubes, pyramids, cylinders, hexagons, stones,
;                towers, mushrooms, trees, apparatus, torii, arches
;GROUND:         none, flat, hills, canyon
;GROUND-TEXTURE: none, checkerboard, squares, walkernoise

#;(module+ test
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
                                    )
   #:sky-objects (list (basic-dodecahedron #:scale (random-scale 10.0 20.0)
                                           #:rotation (random-rotation)
                                           #:color (random-color))
                       (basic-dodecahedron #:scale (random-scale 10.0 20.0)
                                           #:rotation (random-rotation)
                                           #:color (random-color))
                       (basic-dodecahedron #:scale (random-scale 10.0 20.0)
                                           #:rotation (random-rotation)
                                           #:color (random-color))
                       (basic-dodecahedron #:scale (random-scale 10.0 20.0)
                                           #:rotation (random-rotation)
                                           #:color (random-color))
                       (basic-dodecahedron #:scale (random-scale 10.0 20.0)
                                           #:rotation (random-rotation)
                                           #:color (random-color))
                       (basic-dodecahedron #:scale (random-scale 10.0 20.0)
                                           #:rotation (random-rotation)
                                           #:color (random-color))
                       (basic-dodecahedron #:scale (random-scale 10.0 20.0)
                                           #:rotation (random-rotation)
                                           #:color (random-color))
                       (add-particles #:color "#FF00FF" #:speed 2)
                       (add-particles #:color "#FFFF00" #:speed 2)
                       (add-particles #:color "#00FFFF" #:speed 4)
                       bird
                       ;bird
                       ;bird
                       )
   #:ground-objects (list (basic-sphere #:scale (random-scale 1.0 5.0)
                                        #:color (random-color))
                          (basic-sphere #:scale (random-scale 1.0 5.0)
                                        #:color (random-color))
                          (basic-sphere #:scale (random-scale 1.0 5.0)
                                        #:color (random-color))
                          (basic-sphere #:scale (random-scale 1.0 5.0)
                                        #:color (random-color))
                          (basic-sphere #:scale (random-scale 1.0 5.0)
                                        #:color (random-color))
                          carlos-model
                          ;alien-plant-1
                          ;alien-plant-2
                          ;baby-cactus
                          ;bunny-rabbit
                          ;magic-stone
                          ;willow-tree
                          ;sword
                          )
   thoughtstem-logo
   ))

