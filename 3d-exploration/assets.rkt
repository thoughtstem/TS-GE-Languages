#lang at-exp racket

(require
  (only-in ts-kata-util/assets/main
           define-assets-from
           )
  (rename-in vr-engine
             [scale vr:scale]
             [color vr:color])
  racket/runtime-path
  )

(define-assets-from "assets")

  ; ===== 3D MODEL ASSETS =====
  ; TODO: move this section to a seperatate assets file without cyclic require error!

  ; CARLOS BUST (618 KB)
  ; Credit: figure of Carlos Hererra scanned and edited by aBlender using Microsoft Kinect V2.
  ; Todo: convert to a single glb file
  (provide carlos-model)
  
  (define-runtime-path carlos-obj-path "assets/carlos_head.obj")
  (define-runtime-path carlos-mtl-path "assets/carlos_head.mtl")
  (define carlos-model
    (obj-model #:components-list
               (list (src carlos-obj-path)
                     (mtl carlos-mtl-path)
                     (rotation -90 0 0))))

  ; ALIEN PLANT (19 MB)
  ; Credit: ...
  ; Todo: remove or reduce polygons, it's 19 MiB!
  (provide alien-plant-1)
  (define-runtime-path alien-plant-1-gltf-path "assets/alien-plant-1.glb")
  (define alien-plant-1
    (gltf-model #:components-list
               (list (src alien-plant-1-gltf-path)
                     (vr:scale 0.2 0.2 0.2))))

  ; ALIENT PLANT 2 (7 MB)
  (provide alien-plant-2)
  (define-runtime-path alien-plant-2-gltf-path "assets/alien-plant-2.glb")
  (define alien-plant-2
    (gltf-model #:components-list
               (list (src alien-plant-2-gltf-path))))

  ; BABY CACTUS (7 MB, ANIMATED)
  ; Credit: pixipui - https://sketchfab.com/3d-models/baby-cactus-2a403b03dbf64f1fb34cf35a295ba8b6
  (provide baby-cactus)
  (define-runtime-path baby-cactus-gltf-path "assets/baby-cactus.glb")
  (define baby-cactus
    (gltf-model #:components-list
               (list (src baby-cactus-gltf-path)
                     (animation-mixer))))

  ; BUNNY RABBIT (20.5 MB, ANIMATED)
  ; Credit: DarkLordFlash - https://sketchfab.com/3d-models/animated-bunny-rabbit-critter-free-l-poly-3f8b61e440fe43059226a57f269b9b53
  (provide bunny-rabbit)
  (define-runtime-path bunny-rabbit-gltf-path "assets/bunny-rabbit.glb")
  (define bunny-rabbit
    (gltf-model #:components-list
                (list (src bunny-rabbit-gltf-path)
                      (animation-mixer)
                      (vr:scale 0.05 0.05 0.05))))

  ; BIRD (1.3 MB, ANIMATED)
  ; Credit: Charlie Tinley - https://sketchfab.com/3d-models/low-poly-bird-animated-82ada91f0ac64ab595fbc3dc994a3590
  (provide bird)
  (define-runtime-path bird-gltf-path "assets/bird.glb")
  (define bird
    (gltf-model #:components-list
                (list (src bird-gltf-path)
                      (animation-mixer))))

  ; MAGIC STONE (29 MB, ANIMATED)
  ; Credit: Rafi Azhar - https://sketchfab.com/3d-models/magic-stone-e932cbae15854c1eac01a192313c9942
  (provide magic-stone)
  (define-runtime-path magic-stone-gltf-path "assets/magic-stone.glb")
  (define magic-stone
    (gltf-model #:components-list
                (list (src magic-stone-gltf-path)
                      (animation-mixer))))
  
  ; WILLOW TREE (24 MB, ANIMATED?)
  ; Credit: adam127 - https://sketchfab.com/3d-models/weeping-willow-tree-48c090ce93d543cf8b19d3c6f2b6788a
  (provide willow-tree)
  (define-runtime-path willow-tree-gltf-path "assets/willow-tree.glb")
  (define willow-tree
    (gltf-model #:components-list
                (list (src willow-tree-gltf-path)
                      (animation-mixer)
                      (vr:scale 0.05 0.05 0.05))))

  ; THOUGHTSTEM LOGO (378 KB)
  ; Credit: ThoughSTEM LLC
  (provide thoughtstem-logo)
  (define-runtime-path thoughtstem-logo-gltf-path "assets/thoughtstem-logo.glb")
  (define thoughtstem-logo
    (gltf-model #:components-list
                (list (src thoughtstem-logo-gltf-path))))

  ; SWORD (61 KB)
  ; Credit: aBlender
  (provide sword)
  (define-runtime-path sword-gltf-path "assets/sword.glb")
  (define sword
    (gltf-model #:components-list
                (list (src sword-gltf-path))))
