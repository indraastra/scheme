;;; Time-stamp: <2008-05-09 02:26:28 vishal final-review-sols.scm>
;;;
;;; CS3S (Unofficial) Final Review Problems
;;; Spring 2008
;;; UC Berkeley
;;;
;;; Please keep a Scheme interpreter handy when trying the following
;;; exercises. You should be able to edit this document in a text
;;; editor and copy/paste pieces of code into the interpreter as you
;;; go along.

;;; Round 1: Simple Functions

;; 1. Evaluate the following expressions. If an expression results in an
;; error, specify the reason.
(- 100 10)
(- 3 1 2)
(- 8)
(-8)
(- -8)
(1 - 8)
(1 -8)
(+ 5)
(quotient  5 2)
(remainder 5 2)
(quotient  2 5)
(remainder 2 5)
(sqrt 4)
(sqrt 2 + 2)

;; 2. Suggest better names for the following functions:
(define (fn1 a b)
  (+ a b a b))

(define (fn2 a b c)
  (= a b c))

(define (fn3 a b)
  (sqrt (+ (* a a) (* b b))))

;; 3. Which of the following functions differ in output from fn1 given
;; the same input?
(define (fn1-wannabe1 a b)
  (+ a a b b))

(define (fn1-wannabe2 a b)
  (+ (* 2 a) (* b 2)))

(define (fn1-wannabe3 a b)
  (+ (- b a) a (+ b a) a))

;;; Round 2: Lists

;; Fill in the blanks with car, cdr, cons, or list to get the desired
;; results (denoted by '=>'):
(____ (____ (____ '(1 (2 (3))) )))
; => (3)

(____ (____ '(1 (2 (3))) ))))
; => 2

(____ 1 '())
; => (1)

(____ (____ 1 '(2 3)))
; => 1

(____ 1 (____ (____ 2 (____ (____ 3 '())))))
; => (1 (2 (3)))

(append (____ 1) (____ 2) (____ 3))
; => (1 2 3)

(____ '(1) '(2 3))
; => (1 2 3)

(____ '(1) '(2 3))
; => ((1) 2 3)

;;; Round 3: Evaluation

;; Evaluate the following calls made to the functions defined earlier:
(fn1 3 3)
; =>

(fn1 4 9)
; =>

(fn2 1 2 3)
; =>

(fn2 1 1 1)
; =>

(fn3 3 4)
; =>

(fn3 5 (fn1 3 3))
; => (fn3 5 _________) ; Simplify the above call first
; =>                   ; Then evaluate

;;; Round 4: Predicates

;; 1. Complete the definitions of the following functions. Some may ask
;; you to define them multiple ways.

;; (even? 3) => #f
;; (even? 2) => #t
(define (even? n)

  )

;; (odd? 3) => #t
;; (odd? 2) => #f
(define (odd? n) ; don't use even? to define this version

  )

(define (odd? n) ; use even? to define this version

  )

;; 2. Describe what the following function does and how it works:
(define (all-equal? a b c)
  (and (equal? a b)
       (equal? b c)))

;;; Round 5: Case Analysis

;; 1. Define a function named majority that accepts 3 arguments and
;; returns #t if 2 or more of its arguments are #t, and #f otherwise.
;; (majority #f #f #f) => #f
;; (majority #f #t #f) => #f
;; (majority #t #f #t) => #t
(define (majority a b c)

  )

;; 2. Define a function named same-suit that accepts three cards of the
;; form (symbol suit) and returns #t if the three cards all have the
;; same suit, and #f otherwise.
;; (same-suit? '(K H) '(10 H) '(J H)) => #t
;; (same-suit? '(Q S) '( 8 C) '(5 D)) => #f
(define (same-suit? card1 card2 card3)

  )

;; 3. Define a function named ordinal that works as follows:
;; (ordinal 1) => st
;; (ordinal 2) => nd
;; (ordinal 3) => rd
;; (ordinal 4) => th
;; (ordinal 1329) => th
(define (ordinal n)

  )

;; 4. Using the ordinal function above, define another function called
;; date-format that works as follows:
;; (date-format 21 'september 1987)
;; => (the 21 st of september in the year 1987)
;; (date-format 29 'october 1900)
;; => (the 29 th of october in the year 1900)
(define (date-format date month year)

  )

;;; Round 7: Simple Recursionn

;; 1. Define a function named duplicate-elements that takes a list of
;; elements and returns a list with those elements appearing twice
;; consecutively.
;; (duplicate-elements '(1 2 3)) => '(1 1 2 2 3 3)
(define (duplicate-elements L)

  )

;; 2. Define a function named all-sums that takes a list of numbers and
;; returns a list of sums of all sublists starting from the first
;; element. The resulting list should be the same length as the
;; original list. You may also define a helper function or three.
;; (all-sums '(1 2 3)) => (1 3 6)
;; (all-sums '(0 1 1 2 3)) => (0 1 2 4 7)
(define (all-sums L)

  )

;; 3. (skip if you hate math) The 3n+1 Conjecture
;; See http://en.wikipedia.org/wiki/Collatz_conjecture
;; a. Define a function named collatz that acts as follows:
;;                  ( n/2   if n is even
;;     collatz(n) = {
;;                  ( 3n+1  if n is odd
;;    Feel free to use any functions you defined earlier.
(define (collatz n)
  (if (even? n) (/ n 2)
      (+ (* 3 n) 1)))

;; b. Define a function named collatz-sequence that collects the
;;    decreasing sequence of Collatz numbers (until 1 is reached) as
;;    follows:
;;    (collatz-sequence 3) => (10 5 16 8 4 2 1)
;;    (collatz-sequence 28) => (14 7 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1)
(define (collatz-sequence n)
  (if (= n 1) '()
      (cons (collatz n) (collatz-sequence (collatz n)))))

;;; Round 8: More Recursionn

;; 1. What does the following pair of functions do?:
(define (loves-me? n)
  (if (= n 1) #t
      (loves-me-not? (- n 1))))

(define (loves-me-not? n)
  (if (= n 1) #f
      (loves-me? (- n 1))))

;; 2. Expand the following call into a series of recursive calls along
;; with the result:
(loves-me? 4)
;; Here's something to start you off:
;; => (loves-me-not? 3)
;;
;; ...
;;
;; => ___ (this should probably be #t or #f)

;; That last problem wasn't too realistic. Let's try this again.
;; First, here's a function to make a flower of a given number of
;; petals (the stem comes for free!):
;; (make-flower 3) => (petal petal petal stem)
;; (make-flower 1) => (petal stem)
;; (make-flower 0) => (stem)
(define (make-flower num-petals)
  (if (= num-petals 0) '(stem)
      (cons 'petal (make-flower (- num-petals 1)))))

;; This function determines whether a flower in the above form has any
;; petals left on it or not.
;; (has-petals? '(stem)) => #f
;; (has-petals? '(petal petal stem)) => #t
(define (has-petals? flower)
  (or (null? flower)
      (equal? (car flower) 'petal)))

;; Feel free to play around with these functions before continuing!

;; 3. This next one you can define by yourself:
;; (pluck '(petal petal petal stem)) => (petal petal stem)
;; (pluck '(petal stem)) => (stem)
;; (pluck '(stem)) => (stem)
(define (pluck flower)

  )

;; 4. Now that we've got actual petals to pluck, pluck away by redefining
;; loves-me? and loves-me-not? to accomodate this change. You should
;; use the functions we just defined. I've started you off with some
;; code:
(define (loves-me? flower)
  (if (not (has-petals? flower)) _____
      (loves-me-not? (_____ flower))))

(define (loves-me-not? flower)

  )

;; 5. Expand the following call into a series of recursive calls along
;; with the result:
(loves-me? (make-flower 4))




;;; Round 9: Functionals (FINAL ROUND)

;; From here on out, use higher-order functions as opposed to
;; recursion. Many of the functions you will be defining can be
;; defined multiple ways, so just pick one (or pick all).

;; 1. Define a function named sum that accepts a list of numbers
;; and returns their sum.
;; (sum '(1 2 3)) => 6
;; (sum '()) => 0
(define (sum L)

  )

;; 2. Define a function named product that accepts a list of numbers
;; and returns their product.
;; (product '(1 2 3)) => 6
;; (product '()) => 1
(define (product L)

  )

;; 3. Define a function named sum-squares that accepts a list of numbers
;; and returns the sum of their squares.
;; (sum-squares '(1 2 3)) => 14
;; (sum-squares '()) => 0
(define (sum-squares L)

  )

;; 4. Define a function named all-equal? that accepts a list of atoms and
;; returns #t if they are all equal, and #f otherwise.
;; (all-equal? '(1 2 3)) => #f
;; (all-equal? '(a a a)) => #t
(define (all-equal? L)

  )

;; 5. Define a function named same-suit that accepts a list of cards of
;; the form (symbol suit) and returns #t if they all have the same
;; suit, and #f otherwise.
;; (same-suit? '((K H) (10 H) (J H))) => #t
;; (same-suit? '((Q S) ( 8 C) (5 D))) => #f
;; (same-suit? '((1 C)))              => #t
(define (same-suit? L)

  )

;; By now you should be best pals with (or weary enemy of) map, apply,
;; accumulate find-if, find-if-not, remove-if, keep-if, any, every,
;; lambda, and assoc. If you think they're special, just wait until
;; you write a few of them yourself.

;; 6. Write the following functionals using no other functionals (you can
;; use whatever else you like, especially recursion):
(define (assoc key L)

  )

(define (every predicate L)

  )

(define (any predicate L)

  )

(define (map fn L)

  )

