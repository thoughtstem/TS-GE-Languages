#lang racket

(require ts-kata-util)

#;
(module fish racket
  (require ts-kata-util)

  (define-example-code k2/lang/ocean/fish
                       fish-1
                       (red fish))

  (define-example-code k2/lang/ocean/fish
                       fish-2
                       (blue fish))

  (define-example-code k2/lang/ocean/fish
                       fish-3
                       (beside
                         (red fish)
                         (blue fish)))

  (define-example-code k2/lang/ocean/fish
                       fish-4
                       (above
                         (red fish)
                         (blue fish)))

  (define-example-code k2/lang/ocean/fish
                       fish-5
                       (beside
                         (above
                           (red fish)
                           (blue fish))
                         (green fish))))


#;
(require 'fish)
#;
(provide 
  (all-from-out 'fish))
