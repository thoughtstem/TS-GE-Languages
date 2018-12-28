#lang racket

(provide score-game)

(require game-engine
         game-engine-demos-common
         2htdp/image)


(define/contract (score-game es)
  (-> (listof entity?) number?)
  (calc-scores es
               (if-exists  (player?) #:give 5)
               (for-each   (food?)   #:give 1 #:max 10)
               (for-each   (item?)   #:give 1 #:max 10)
               (for-each   (npc?)
                           #:give 1
                           #:bonus (lines-of-dialog))))



(define/contract (calc-scores es . rules) ;Rules are functions from entity lists to numbers
  (->* ((listof entity?)) #:rest (listof procedure?) number?)
  (apply + (map (apply-rule-to es) rules)))

(define/contract (apply-rule-to es)
  (-> (listof entity?) (-> procedure? number?))
  (lambda (r)
    (r es)))

(define/contract (for-each pred #:give amount #:max (max 100) #:bonus (bonus (thunk* 0)))
  (->* ((-> entity? (or/c number? boolean?))
        #:give number?)
       (#:max number?
        #:bonus (-> entity? number?))
       (-> (listof entity?) number?))
  
  (lambda (es)
    (define matching
      (filter pred es))

    (define bonus-points
      (apply + (map bonus matching)))

    (min max
         (+ (* amount (length matching))
            bonus-points))))

(define (if-exists pred #:give amount)
  (lambda (es) 
    (define matching
      (filter pred es))

    (if (empty? matching) 0 amount)))

(define (with-name n)
  (lambda (e)
    (entity-has-name? n e)))

(define (entity-has-name? n e)
  (string-contains? (get-name e) n))

(define (lines-of-dialog)
  (lambda (npc)
    (length (flatten (get-storage-data "dialog" npc)))))


(define (player?) (with-name "player"))
(define (food?)   (with-name "food"))
(define (item?)   (with-name "item"))
(define (npc?)    (with-name "npc"))


