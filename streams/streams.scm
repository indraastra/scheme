(define (double x)
  (* 2 x))

(define (square x)
  (* x x))

;; defining and working with streams
(define (s-car s)
  (car s))

(define (s-cdr s)
  (cons ((cdr s) (car s)) (cdr s)))

(define (stream n f)
  (cons n f))

(define (map-stream f s)
  (let ((first (s-car s))
        (rest (s-cdr s)))
    (stream first
            (lambda (n) ; ignores n
              (set! first (s-car rest))
              (set! rest (s-cdr rest))
              (f first)))))

(define (generate-n s n)
  (if (= n 0) '()
      (cons (s-car s)
            (generate-n (s-cdr s) (- n 1)))))

;; some useful streams
(define ints
  (stream 0
          (lambda (n) (+ n 1))))

(define evens
  (map-stream double ints))

(define squares
  (map-stream square ints))
