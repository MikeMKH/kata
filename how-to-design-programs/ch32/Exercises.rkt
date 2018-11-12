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