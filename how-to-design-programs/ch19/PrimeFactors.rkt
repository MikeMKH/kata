;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname PrimeFactors) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect (prime-factors 2) '(2))
(check-expect (prime-factors 3) '(3))
(check-expect (prime-factors 6) '(2 3))
(check-expect (prime-factors (* 11 3 3 2)) '(2 3 3 11))

(define (prime-factors n)
  (local
    ((define (iter i x res)
       (cond
         [(> i x) res]
         [(zero? (modulo x i))
          (iter i (/ x i) (cons i res))]
         [else
          (iter (add1 i) x res)])))
    (reverse (iter 2 n '()))))