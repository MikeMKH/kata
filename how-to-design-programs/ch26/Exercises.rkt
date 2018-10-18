;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; skipped 431 - 432

(check-error (bundle-check (explode "abc") 0) "bundle: cannot bundle size 0")
(check-error (bundle-check (explode "abc") -1) "bundle: cannot bundle size -1")

(check-expect (bundle-check (explode "abc") 1) '(("a") ("b") ("c")))
(check-expect (bundle-check (explode "abc") 2) '(("a" "b") ("c")))
(check-expect (bundle-check (explode "abc") 5) '(("a" "b" "c")))

(define (bundle-check l n)
  (if (<= n 0)
      (error (string-append "bundle: cannot bundle size " (number->string n)))
      (bundle l n)))

(define (bundle l n)
  (cond
    [(empty? l) '()]
    [else (cons (take l n)
                (bundle (drop l n) n))]))

(check-expect (take '() 0) '())
(check-expect (take '() 1) '())
(check-expect (take '(1) 1) '(1))
(check-expect (take '(1) 0) '())
(check-expect (take '(1 2 3) 2) '(1 2))

(define (take l n)
  (cond
    [(or (empty? l)
         (zero? n)) '()]
    [else (cons (first l)
                (take (rest l) (sub1 n)))]))

(check-expect (drop '() 0) '())
(check-expect (drop '() 1) '())
(check-expect (drop '(1) 1) '())
(check-expect (drop '(1) 0) '(1))
(check-expect (drop '(1 2 3) 2) '(3))

(define (drop l n)
  (cond
    [(or (empty? l)
         (zero? n)) l]
    [else (drop (rest l) (sub1 n))]))

; skipped 434 - 436

; Figure 153: From generative to structural recursion

; (define (general P)
;   (cond
;     [(trivial? P) (solve P)]
;     [else
;      (combine-solutions
;        P
;        (general
;          (generate P)))]))

; (define (special P)
;   (cond
;     [(empty? P) (solve P)]
;     [else
;      (combine-solutions
;        P
;        (special (rest P)))]))

(check-expect (count '()) 0)
(check-expect (count '(1)) 1)
(check-expect (count '(1 2 3)) 3)
(check-expect (count '(a b c)) 3)

(define (count l)
  (cond
    [(empty? l) 0]
    [else
     (add1 (count (rest l)))]))

(check-expect (negate '()) '())
(check-expect (negate '(1)) '(-1))
(check-expect (negate '(-1)) '(1))
(check-expect (negate '(-1 2 -3 4 -5)) '(1 -2 3 -4 5))

(define (negate lon)
  (cond
    [(empty? lon) '()]
    [else
     (cons (- (first lon))
           (negate (rest lon)))]))

(check-expect (upper '()) '())
(check-expect (upper '("A")) '("A"))
(check-expect (upper '("a")) '("A"))
(check-expect (upper '("aT")) '("AT"))
(check-expect (upper '("aT" "CaT" "mac" "FACT")) '("AT" "CAT" "MAC" "FACT"))

(define (upper los)
  (cond
    [(empty? los) '()]
    [else
     (cons (string-upcase (first los))
           (upper (rest los)))]))

(check-expect (add 0 1) 1)
(check-expect (add 1 1) 2)
(check-expect (add 2 1) 3)
(check-expect (add 5 3) 8)
(check-expect (add 41 42) (add 42 41))

(define (add n m)
  (cond
    [(zero? n) m]
    [else
     (add1 (add (sub1 n) m))]))