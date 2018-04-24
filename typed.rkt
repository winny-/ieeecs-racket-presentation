#lang typed/racket

; Defines a container for x and y coords.
(struct pt ([x : Real] [y : Real]))
 
(: distance (-> pt pt Real))
(define (distance p1 p2)
  (sqrt (+ (sqr (- (pt-x p2) (pt-x p1)))
           (sqr (- (pt-y p2) (pt-y p1))))))

(distance (pt 1 1) (pt 2.3 -1)) ; 2.3853720883753127