;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname PrimeFactors) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect (prime-factors 2) (list 2))
(check-expect (prime-factors 6) (list 2 3))
(check-expect (prime-factors 4) (list 2 2))
(check-expect (prime-factors (* 2 2 3 5 5 7 11)) (list 2 2 3 5 5 7 11))

(check-expect (prime-factors 1) '())
(check-expect (prime-factors 0) '())
(check-expect (prime-factors -1) '())

(define (prime-factors n)
  (reverse
   (prime-factors-loop '() 2 n)))

(define (prime-factors-loop factors p n)
  (cond
    [(<= n 1) factors]
    [(= (modulo n p) 0)
     (prime-factors-loop
      (cons p factors)
      p
      (/ n p))]
    [else (prime-factors-loop factors (add1 p) n)]))