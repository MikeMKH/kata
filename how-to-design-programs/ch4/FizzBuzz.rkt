;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname FizzBuzz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect (fizzbuzz 1) "1")
(check-expect (fizzbuzz 2) "2")
(check-expect (fizzbuzz 3) "fizz")
(check-expect (fizzbuzz 33) "fizz")
(check-expect (fizzbuzz 5) "buzz")
(check-expect (fizzbuzz 55) "buzz")
(check-expect (fizzbuzz 15) "fizzbuzz")
(check-expect (fizzbuzz 150) "fizzbuzz")

(define (fizzbuzz n)
  (cond
    [(and (fizz? n) (buzz? n)) "fizzbuzz"]
    [(fizz? n) "fizz"]
    [(buzz? n) "buzz"]
    [else (number->string n)]))

(check-expect (fizz? 3) #true)
(check-expect (fizz? 2) #false)
(check-expect (fizz? 33) #true)
(check-expect (fizz? 15) #true)
(check-expect (fizz? (* 2 3 5)) #true)

(define (fizz? n)
  (divisible? n 3))


(check-expect (buzz? 5) #true)
(check-expect (buzz? 2) #false)
(check-expect (buzz? 55) #true)
(check-expect (buzz? 15) #true)
(check-expect (buzz? (* 2 3 5)) #true)

(define (buzz? n)
  (divisible? n 5))


(check-expect (divisible? 2 3) #false)
(check-expect (divisible? 6 3) #true)
(check-expect (divisible? 3 3) #true)
(check-expect (divisible? (* 2 3 5) 3) #true)

(define (divisible? n x)
  (= (modulo n x) 0))