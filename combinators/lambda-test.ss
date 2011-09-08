#lang scheme/base

(require (planet schematics/schemeunit:3) 
         "lambda.ss")

(define one (succ zero))
(define two (succ one))
(define three (succ two))

;; helpers
(check-equal? (cnum->int zero) 0)
(check-equal? (cnum->int one) 1)
(check-equal? (cnum->int two) 2)
(check-equal? (cnum->int three) 3)

;; arithmetic
(check-equal? (cnum->int (pred (succ three))) 3)
(check-equal? (cnum->int (pred (succ (succ (pred two))))) 2)

(check-equal? (cnum->int (add (int->cnum 6)
                              (int->cnum 4)))
              10)

(check-equal? (cnum->int (mult (int->cnum 3)
                               (int->cnum 5)))
              15)

(check-equal? (cnum->int (div (int->cnum 18)
                              (int->cnum 2)))
              9)

;; logic
(check-equal? (is-zero? zero) true)
(check-equal? (is-zero? three) false)

(check-equal? (if-c true 1 2) 1)
(check-equal? (if-c false 1 2) 2)

(check-equal? (if-c (or-c true false) 1 2) 1)
(check-equal? (if-c (or-c false false) 1 2) 2)

(check-equal? (if-c (and-c true false) 1 2) 2)
(check-equal? (if-c (and-c true true) 1 2) 1)

(check-equal? (not-c false) true)
(check-equal? (not-c true) false)
(check-equal? (if-c (and-c true (not-c false)) 1 2) 1)
(check-equal? (if-c (or-c false (not-c true)) 1 2) 2)
