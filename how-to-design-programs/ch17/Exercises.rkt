;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect ((lambda (x y) (x y y)) + 2) 4)
; (lambda () 10) ; lambda: expected (lambda (variable more-variable ...) expression), but found no variables
(check-expect ((lambda (x) x) 2) 2)
(check-expect ((lambda (x y) x) #true #false) #true)
; (lambda x 10) ; lambda: expected (lambda (variable more-variable ...) expression), but found something else

(check-expect
 ((lambda (x y) (+ x (* x y))) 1 2) 3)
(check-expect
 ((lambda (x y) (+ x (local ((define z (* y y))) (+ (* 3 z) (/ 1 x))))) 1 2) 14)
(check-expect
 ((lambda (x y) (+ x ((lambda (z) (+ (* 3 z) (/ 1 z))) (* y y)))) 1 2) 13.25)

(check-expect ((lambda (x) (< x 10)) 5) #true)
(check-expect ((lambda (x y) (number->string (* x y))) 21 2) "42")
(check-expect ((lambda (x) (modulo x 2)) 11) 1)

(define (f-plain x) (* 10 x))
(define f-lambda (lambda (x) (* 10 x)))

(define (compare x) (= (f-plain x) (f-lambda x)))
(check-expect (compare (random 10000)) #true)

(check-expect (foldl cons '() (list 1 2 3)) (list 3 2 1))
(check-expect (foldr cons '() (list 1 2 3)) (list 1 2 3))

(check-expect
 (
  ((lambda (x) x) (lambda (x) x))
  "identity")
 (
  ((lambda (x) (x x)) (lambda (x) x))
  "identity"))