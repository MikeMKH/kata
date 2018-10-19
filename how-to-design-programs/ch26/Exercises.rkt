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

; skipped 438

; Figure 154: Finding the greatest common divisor via structural recursion

(define (gcd-structural n m)
  (local (; N -> N
          ; determines the gcd of n and m less than i
          (define (greatest-divisor-<= i)
            (cond
              [(= i 1) 1]
              [else
               (if (= (remainder n i) (remainder m i) 0)
                   i
                   (greatest-divisor-<= (- i 1)))])))
    (greatest-divisor-<= (min n m))))

(check-expect (gcd-structural 12 9) 3)
(check-expect (gcd-structural 13 9) 1)

; (time (gcd-structural 101135853 45014640))
; cpu time: 6197 real time: 6193 gc time: 17

; Figure 155: Finding the greatest common divisor via generative recursion

(define (gcd-generative n m)
  (local (; N[>= 1] N[>=1] -> N
          ; generative recursion
          ; (gcd L S) == (gcd S (remainder L S)) 
          (define (clever-gcd L S)
            (cond
              [(= S 0) L]
              [else (clever-gcd S (remainder L S))])))
    (clever-gcd (max m n) (min m n))))

(check-expect (gcd-generative 101135853 45014640) 177)

; (time (gcd-generative 101135853 45014640))
; cpu time: 0 real time: 0 gc time: 0

; skipped 441 - 443

(check-expect (divisors 0 1) '())
(check-expect (divisors 1 1) '(1))
(check-expect (divisors 1 2) '(1))
(check-expect (divisors 2 2) '(2 1))
(check-expect (divisors 2 3) '(1))
(check-expect (divisors 6 6) '(6 3 2 1))

(define (divisors k l)
  (cond
    [(zero? k) '()]
    [else
     (if (zero? (remainder l k))
         (cons k (divisors (sub1 k) l))
         (divisors (sub1 k) l))]))

(check-expect (largest-common '() '()) #false)
(check-expect (largest-common '(1) '()) #false)
(check-expect (largest-common '() '(1)) #false)
(check-expect (largest-common '(1) '(1)) 1)
(check-expect (largest-common '(1) '(2 1)) 1)
(check-expect (largest-common '(2 1) '(1)) 1)
(check-expect (largest-common '(2 1) '(2 1)) 2)
(check-expect (largest-common '(2 1) '(6 3 2 1)) 2)
(check-expect (largest-common '(6 3 2 1) '(2 1)) 2)

; assumes that k and l are sorted in descending order
(define (largest-common k l)
  (cond
    [(or (empty? k)
         (empty? l)) #false]
    [(= (first k) (first l)) (first k)]
    [else
     (if (> (first k) (first l))
         (largest-common (rest k) l)
         (largest-common k (rest l)))]))