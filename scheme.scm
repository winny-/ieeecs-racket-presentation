#lang r5rs

(define (length ls)
  (if (null? ls)
      0
      (+ 1 (length (cdr ls)))))
