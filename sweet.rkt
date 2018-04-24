#lang sweet-exp racket

define fact(n)
  if {n <= 1} ; infix uses braces
    1
    {n * fact{n - 1}}

fact(5)