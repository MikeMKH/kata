;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Peano) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect (add 1 0) 1)
(check-expect (add 0 1) 1)
(check-expect (add 1 1) 2)
(check-expect (add 12 100) 112)

(define (add a b)
  (cond
    [(zero? a) b]
    [(zero? b) a]
    [else
     (add (add1 a) (sub1 b))]))

(check-expect (multiply 1 0) 0)
(check-expect (multiply 0 1) 0)
(check-expect (multiply 3 1) 3)
(check-expect (multiply 1 3) 3)
(check-expect (multiply 12 100) 1200)

(define (multiply a b)
  (cond
    [(or (zero? a) (zero? b)) 0]
    [(one? b) a]
    [else
     (add a (multiply a (sub1 b)))]))

(check-expect (one? 1) #true)
(check-expect (one? 0) #false)
(check-expect (one? 100) #false)

(define (one? x)
  (if (= x 1) #true #false))