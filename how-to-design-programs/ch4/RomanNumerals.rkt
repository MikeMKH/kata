;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname RomanNumerals) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect (int->roman 1) "I")
(check-expect (int->roman 2) "II")
(check-expect (int->roman 4) "IV")
(check-expect (int->roman 5) "V")
(check-expect (int->roman 6) "VI")
(check-expect (int->roman 9) "IX")
(check-expect (int->roman 10) "X")
(check-expect (int->roman 38) "XXXVIII")
(check-expect (int->roman 49) "XLIX")
(check-expect (int->roman 89) "LXXXIX")
(check-expect (int->roman 90) "XC")
(check-expect (int->roman 100) "C")

(define (int->roman n)
  (cond
    [(>= n 100) (string-append "C" (int->roman (- n 100)))]
    [(>= n 90) (string-append "XC" (int->roman (- n 90)))]
    [(>= n 50) (string-append "L" (int->roman (- n 50)))]
    [(>= n 40) (string-append "XL" (int->roman (- n 40)))]
    [(>= n 10) (string-append "X" (int->roman (- n 10)))]
    [(= n 9) "IX"]
    [(>= n 5) (string-append "V" (int->roman (- n 5)))]
    [(= n 4) "IV"]
    [else (replicate n "I")]))