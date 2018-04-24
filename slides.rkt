#lang at-exp slideshow

(require slideshow/code
         pict/convert)

;(set-margin! 10)
;(define padding (make-parameter 10))

(define-syntax-rule (with-background proc slide)
  (let ([csa (current-slide-assembler)])
    (parameterize ([current-slide-assembler
                    (lambda (title title-gap pict)
                      (ct-superimpose (proc title title-gap pict)
                                      (csa title title-gap pict)))])
      slide)))
                                                           
  

(define-syntax-rule (my-slide a ...)
  (slide
   ;#:inset (make-slide-inset (padding) (padding) (padding) (padding))
   #:layout 'auto
   ;#:title title
   a ...))

(define (format-example p c #:scale [s 1.0] #:image? [image? #t])
  (define output (if image?
                     (pict-convert (eval c))
                     (typeset-code (datum->syntax #f (eval c)))))
  (scale (hc-append p (inset (text "⇒" null 72) 10) output) s))
  

(define-exec-code (sierpinski-pict sierpinski-code sierpinski-string)
  (require 2htdp/image) (code:comment "draw a picture")
  (let sierpinski ([n 8])
    (cond
      [(zero? n) (triangle 2 'solid 'red)]
      [else
       (define t (sierpinski (- n 1)))
       (freeze (above t (beside t t)))])))

(my-slide
 #:title "The Racket Programming Language"
 @t{Presenter: Winston Weinert}
 #;@item{A programming-language programming language}
 (format-example sierpinski-pict sierpinski-code #:scale .75))

(my-slide
 #:title "Timeline of Racket"
 'next
 @item{1958 - LISP 1.5 is created}
 (bitmap "lisp15.png")
 'next
 @item{1975 - Scheme is created}
 (bitmap "scheme.png")
 'next
 @item{1990 - Racket is created (a better Scheme)}
 (bitmap "racket.png"))

(my-slide
 #:title "Who uses Racket?"
 @para{Racket was born of academic curiousity: use-case specific programming language & to teach programming concepts}
 (scale (bitmap "htdp.png") .75))

(define-exec-code (define-variable-pict define-variable-code define-variable-string)
  (define greeting "Hello World!")
  greeting (code:comment "Automatically printed"))

(define-exec-code (define-function-pict define-function-code define-function-string)
  (define (factorial n)
    (if (<= n 1)
        1
        (* n (factorial (- n 1)))))
  (factorial 5))


(my-slide
 #:title "All you need to know about syntax"
 @item{Define a variable}
 (format-example define-variable-pict define-variable-code #:scale .75 #:image? #f)
 'next
 @item{Define a function}
 (format-example define-function-pict define-function-code #:scale .75 #:image? #f)
 'next
 @item{(Everything else is simply extension of the above)})

(my-slide
 #:title "But I hate all these parentheses!"
 @para{You're in luck!}
 (bitmap "sweet.png"))

(my-slide
 #:title "Racket \"Sublanguages\""
 'next
 @item{Scribble - write documentation or papers}
 (bitmap "scribble.png")
 'next
 @item{Typed Racket - Racket but with static typing (faster & crashes less)}
 (bitmap "typed.png"))
(my-slide
 #:title "Racket \"Sublanguages\" Continued"
 @item{racket/gui - a GUI programming language}
 (bitmap "gui.png")
 'next
 @item{Lazy Racket - Only run code that the program needs to finish}
 'next
 @item{datalog - a logic programming language}
 'next
 @item{slideshow - what this presentation is written in})

(define-exec-code (recur-example-pict recur-example-code recur-example-string)
  (define (sum n)
    (if (zero? n)
        n
        (+ n (sum (sub1 n)))))
  (sum 1024))

(define-exec-code (iter-example-pict iter-example-code iter-example-string)
  (define (sum n)
    (for/sum ([i (add1 n)])
      i))
  (sum 1024))

(my-slide
 #:title "Recursion??"
 @item{For-loop:}
 (format-example iter-example-pict iter-example-code #:image? #f)
 'next
 @item{Recursion:}
 (format-example recur-example-pict recur-example-code #:image? #f))
 

(my-slide
 #:title "Why another programming language?"
 @item{Most languages are rigid - do not allow for extension of the core syntax}
 @item{Predictability and simplicity}
 'next
 @item{Not a catch-all}
 @subitem{Use the best tool for the job}
 @subitem{Small community = less libraries}
 @subitem{It is not fast. But usually doesn't matter.})

#;(my-slide
 #:title "Bibliography")