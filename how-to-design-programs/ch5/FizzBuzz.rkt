;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname FizzBuzz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct fizzbuzz (value fizz? buzz?))

(check-expect (fizzbuzz-fizz? (make-fizzbuzz 3 #true #false)) #true)
(check-expect (fizzbuzz-buzz? (make-fizzbuzz 5 #false #true)) #true)
(check-expect (fizzbuzz-value (make-fizzbuzz 2 #false #false)) 2)

(check-expect (int->fizzbuzz 22) (make-fizzbuzz 22 #false #false))
(check-expect (int->fizzbuzz 33) (make-fizzbuzz 33 #true #false))
(check-expect (int->fizzbuzz 55) (make-fizzbuzz 55 #false #true))
(check-expect (int->fizzbuzz 15) (make-fizzbuzz 15 #true #true))

(define (int->fizzbuzz n)
  (make-fizzbuzz
   n
   (zero? (modulo n 3))
   (zero? (modulo n 5))))

(check-expect (fizzbuzz->string (make-fizzbuzz 1 #false #false)) "1")
(check-expect (fizzbuzz->string (make-fizzbuzz 6 #true #false)) "fizz")
(check-expect (fizzbuzz->string (make-fizzbuzz 10 #false #true)) "buzz")
(check-expect (fizzbuzz->string (make-fizzbuzz 1515 #true #true)) "fizzbuzz")

(define (fizzbuzz->string x)
  (cond
    [(and (fizzbuzz-fizz? x) (fizzbuzz-buzz? x)) "fizzbuzz"]
    [(and (fizzbuzz-fizz? x) (not (fizzbuzz-buzz? x))) "fizz"]
    [(and (not (fizzbuzz-fizz? x)) (fizzbuzz-buzz? x)) "buzz"]
    [else (number->string (fizzbuzz-value x))]))

(check-expect (fizzbuzz* (int->fizzbuzz 2) (int->fizzbuzz 2)) (make-fizzbuzz 4 #false #false))
(check-expect (fizzbuzz* (int->fizzbuzz 3) (int->fizzbuzz 2)) (make-fizzbuzz 6 #true #false))
(check-expect (fizzbuzz* (int->fizzbuzz 5) (int->fizzbuzz 2)) (make-fizzbuzz 10 #false #true))
(check-expect (fizzbuzz* (int->fizzbuzz 3) (int->fizzbuzz 5)) (make-fizzbuzz 15 #true #true))
(check-expect (fizzbuzz* (int->fizzbuzz 15) (int->fizzbuzz 1)) (make-fizzbuzz 15 #true #true))

(define (fizzbuzz* x y)
  (int->fizzbuzz
   (* (fizzbuzz-value x) (fizzbuzz-value y))))

(check-expect
 (fizzbuzz->string (int->fizzbuzz 15))
 (fizzbuzz->string
  (fizzbuzz* (int->fizzbuzz 6)
             (int->fizzbuzz 10))))

; not bad for bsl :)