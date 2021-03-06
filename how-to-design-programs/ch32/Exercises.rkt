;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; skipped 493 - 494

(check-expect (sum '()) 0)
(check-expect (sum '(1)) 1)
(check-expect (sum '(1 2)) 3)
(check-expect (sum '(1 2 5)) 8)
; (sum/a '(10 4) 0) == (sum/a '(4) 10))

(define (sum l0)
  (local ((define (sum/a l a)
            (cond
              [(empty? l) a]
              [else
               (sum/a (rest l)
                      (+ (first l) a))])))
    (sum/a l0 0)))

(check-expect (! 0) 1)
(check-expect (! 1) 1)
(check-expect (! 2) 2)
(check-expect (! 3) 6)
; (!/a 1 6) == 6

(define (! n0)
  (local ((define (!/a n a)
            (cond
              [(<= n 1) a]
              [else
               (!/a (sub1 n) (* n a))])))
    (!/a n0 1)))

; from 32.2

; N -> N 
; computes (* n (- n 1) (- n 2) ... 1)
(check-expect (!.v1 3) 6) 

(define (!.v1 n)
  (cond
    [(zero? n) 1]
    [else (* n (!.v1 (sub1 n)))]))

; (time (!.v1 20)) ;cpu time: 0 real time: 0 gc time: 0
; (time (! 20))    ;cpu time: 0 real time: 0 gc time: 0

; (time (!.v1 1000)) ;cpu time: 0 real time: 0 gc time: 0
; (time (! 1000))    ;cpu time: 0 real time: 0 gc time: 0

; skipped 498

(check-expect (product '()) 1)
(check-expect (product '(8)) 8)
(check-expect (product '(1 2 3)) 6)
(check-expect (product '(11 3 2 -1)) -66)

(define (product l0)
  (local ((define (product/a l a)
            (cond
              [(empty? l) a]
              [else
               (product/a (rest l)
                          (* (first l) a))])))
    (product/a l0 1)))

(check-expect (how-many '()) 0)
(check-expect (how-many '(a)) 1)
(check-expect (how-many '(a b c)) 3)
(check-expect (how-many '(a b c (1 2 3))) 4)

(define (how-many l0)
  (local ((define (how-many/a l a)
            (cond
              [(empty? l) a]
              [else
               (how-many/a (rest l) (add1 a))])))
    (how-many/a l0 0)))

(check-within (add-to-pi 0) pi 0.001)
(check-within (add-to-pi 1) (+ pi 1) 0.001)
(check-within (add-to-pi 10) (+ pi 10) 0.001)

(define (add-to-pi n0)
  (local ((define (add-to-pi/a n a)
            (cond
              [(zero? n) a]
              [else
               (add-to-pi/a (sub1 n) (add1 a))])))
    (add-to-pi/a n0 pi)))

(check-expect (palindrome '()) '())
(check-expect (palindrome (explode "abc")) (explode "abcba"))
(check-expect (palindrome (explode "a")) (explode "a"))
(check-expect (palindrome (explode "ab")) (explode "aba"))

(define (palindrome l)
  (local ((define (mirror lne a)
            (cond
              [(empty? (rest lne)) a]
              [else
               (mirror (rest lne)
                             (cons (first lne) a))])))
    (if (empty? l)
        '()
        (append l (mirror l '())))))

; skipped 503

(check-expect (to10 '()) 0)
(check-expect (to10 '(1)) 1)
(check-expect (to10 '(1 2)) 12)
(check-expect (to10 '(1 2 5)) 125)

(define (to10 l0)
  (local ((define (to10/a l a)
            (cond
              [(empty? l) a]
              [else
               (to10/a (rest l)
                       (+ (* a 10) (first l)))])))
    (to10/a l0 0)))

(check-expect (is-prime 2) #true)
(check-expect (is-prime 3) #true)
(check-expect (is-prime 4) #false)
(check-expect (is-prime 5) #true)
(check-expect (is-prime 55) #false)

(define (is-prime n0)
  (local ((define (is-prime/a n a)
            (cond
              [(= a 1) #true]
              [else
               [if (zero? (remainder n a))
                   #false
                   (is-prime/a n (sub1 a))]])))
    (is-prime/a n0 (integer-sqrt n0))))

(check-expect (m*p identity '()) '())
(check-expect (m*p identity '(1 2 3)) '(1 2 3))
(check-expect (m*p sub1 '(1 2 3)) '(0 1 2))
(check-expect (m*p int->string '(97 98 99)) '("a" "b" "c"))

(define (m*p f0 l0)
  (local ((define (map/a f l a)
            (cond
              [(empty? l) (reverse a)]
              [else
               (map/a f (rest l) (cons (f (first l)) a))])))
    (map/a f0 l0 '())))

(check-expect (build-l*st 0 identity) (build-list 0 identity))
(check-expect (build-l*st 100 identity) (build-list 100 identity))
(check-expect (build-l*st 1 add1) (build-list 1 add1))

(define (build-l*st n0 f0)
  (local ((define (build-list/a n f a)
            (cond
              [(zero? n) a]
              [else
               (build-list/a (sub1 n) f (cons (f (sub1 n)) a))])))
    (build-list/a n0 f0 '())))

; skipped 508 - 510