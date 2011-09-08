;;; some useful functions
(define (id n) n)

(define (double n)
  (* 2 n))

(define (square n)
  (* n n))

(define (add-one n)
  (+ n 1))

(define (even? n)
  (= (remainder n 2) 0))

(define (fib n)
  (cond ((= n 1) 0)
        ((= n 2) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(define (fib-list n)
  (cons (fib n)
        (fib-list (+ n 1))))

;;; stream operations
(define (s-car s)
  (car s))

(define (s-cdr s)
  (force (cdr s)))

(define (s-cadr s)
  (s-car (s-cdr s)))

(define-syntax s-cons
  (syntax-rules ()
    ((s-cons e s)
     (cons e (delay s)))))

(define (s-ref s n)
  (if (= n 0) (s-car s)
      (s-ref (s-cdr s) (- n 1))))

(define (s-ref s n)
  (list-ref (s-generate s (+ n 1)) n))

(define (s-make f n)
  (define (s n)
    (s-cons n (s (f n))))
  (s n))

(define (s-map f s)
  (s-cons (f (s-car s))
          (s-map f (s-cdr s))))

(define (s-merge f s1 s2)
  (let ((h1 (s-car s1))
        (h2 (s-car s2)))
    (s-cons (f h1 h2)
            (s-merge f (s-cdr s1) (s-cdr s2)))))

(define (s-filter f s)
  (if (f (s-car s))
      (s-cons (s-car s)
              (s-filter f (s-cdr s)))
      (s-filter f (s-cdr s))))

(define (s-interleave s1 s2)
  (s-cons (s-car s1)
          (s-cons (s-car s2)
                  (s-interleave (s-cdr s1)
                                (s-cdr s2)))))

(define (s-generate s n)
  (if (= n 0) '()
      (cons (s-car s)
            (s-generate (s-cdr s) (- n 1)))))

;;; some useful streams

;; using s-cons
(define ones
  (s-cons 1 ones))

(define twos
  (s-cons 2 twos))

(define (ints-from n)
  (s-cons n (ints-from (+ n 1))))

(define ints
  (ints-from 1))

(define (evens-from n)
  (s-cons n (evens-from (+ n 2))))

(define evens
  (evens-from 0))

;; using s-make
(define ones
  (s-make id 1))

(define twos
  (s-make id 1))

(define ints
  (s-make add-one 1))

;; using s-map
(define twos
  (s-map double ones))

(define evens
  (s-map double ints))

(define squares
  (s-map square ints))

;; using s-merge
(define twos
  (s-merge + ones ones))

(define odds
  (s-merge +
           ones
           evens))

(define ints
  (s-cons 1 (s-merge +
                     ones
                     ints)))

(define fibs
  (s-cons 0 (s-cons 1 (s-merge +
                               fibs
                               (s-cdr fibs)))))

;; using s-filter
(define evens
  (s-filter even? ints))

;; using s-interleave
(define ints
  (s-interleave evens odds))