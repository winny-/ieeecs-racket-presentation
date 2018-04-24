#lang racket

(define (length ls)
  (match ls
    [(list) 0]
    [(list _ rest ...) (add1 (length rest))]))