 #lang scheme/base

(provide (all-defined-out))

;;;; EVERYTHING HERE (unless otherwise stated) IS IN TERMS OF COMBINATORS
;;;; RECURSION IS IMPLEMENTED WITH THE Y-COMBINATOR


;;;; HELPER COMBINATORS
;; returns the church numeral for integer
(define (int->cnum n)
  (lambda (f x)
    (if (zero? n) x
        (f ((int->cnum (- n 1)) f x)))))

;; returns the integer for the church numeral
;; NOT a combinator...doesn't really need to be one since it's just for
;; verification
(define (cnum->int n-c)
  ((if-c (is-zero? n-c) (lambda () 0)
        (lambda () (+ 1 (cnum->int (pred n-c)))))))


;;;; ARITHMETIC
;; zero
(define (zero x y) y)

;; returns the church numeral successor of this integer
(define (succ n)
  (lambda (f z)
    (f (n f z))))

;; returns the church numeral predecessor of this integer
(define (pred n)
  (lambda (f x)
    (second (n (predfn f) (pair x x)))))
(define (predfn f)
  (lambda (p)
    (pair (f (first p))
          (first p))))

;; returns the church numeral representing m+n
(define (add m n)
  (m succ n))

;; returns the church numeral representing m-n
(define (sub m n)
  (n pred m))

;; returns the church numeral representing n/d
(define (div n d)
  (((Y div-nr) n) d))
(define (div-nr f)
  (lambda (n)
    (lambda (d)
      ((if-c (is-zero? n)
            (lambda () (int->cnum 0))
            (lambda () (succ ((f (sub n d)) d))))))))

;; returns the church numeral representing m*n
(define (mult m n)
  (lambda (f x)
    (m (lambda (x) (n f x)) x)))


;;;; LOGIC
(define (true x y) x)
(define false zero)

(define (if-c c x y)
  (c x y))

(define (and-c c1 c2)
  (c1 c2 false))

(define (or-c c1 c2)
  (c1 true c2))

(define (not-c c)
  (c false true))

(define (is-zero? n)
  (n (lambda (x) false) true))


;;;; RECURSION
;; the godly Y combinator
(define (Y nr)
  ((lambda (f) (f f))
   (lambda (f) (nr (lambda (x) ((f f) x))))))


;;;; PAIRS
(define (pair x y)
  (lambda (f)
    (f x y)))

(define left true)
(define (first p) (p left))

(define right false)
(define (second p) (p right))


;;;; LISTS
;; list 1 :: 2 :: 3 :: nil looks like
;; (true, (3, (true, (1, (true, (2, (true, (3, (false, false)))))))))
(define (cons x y)
  (pair true (pair x y)))

(define (car l)
  (first (second l)))

(define (cdr l)
  (second (second l)))

(define nil (pair false false))

;; conses the length of the sequence of cons cells onto the list as its first
;; element, allowing for scott's request that (l (cnum 0)) => len(l)
(define (list p)
  (lambda (n)
    (car (n cdr (cons (len p) p)))))

;; length is defined for CONS cells, not LISTS, strange as this may sound.
;; to get the length of a list, use (l (num 0)) where l is a list combinator
;; object
(define (len p)
  ((Y len-nr) p))
;; alternative definition
;; (define len (Y len-nr))

(define (len-nr f)
  (lambda (l)
    ((if-c (first l) 
          (lambda () (succ (f (cdr l))))
          (lambda () (int->cnum 0))))))


;;;; ACKERMANN COMBINATOR
(define (ack m)
  (m
   (lambda (f)
     (lambda (n)
       (n f (f (int->cnum 1)))))
   succ))

;;;; CANTOR PAIR COMBINATOR
(define (cantor c1 c2)
  (add (div (mult (add c1 c2) (add c1 (add c2 (int->cnum 1))))
            (int->cnum 2))
       c2))
