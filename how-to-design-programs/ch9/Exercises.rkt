;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 137
; contains-flatt? follows the template

(check-expect (sum '()) 0)
(check-expect (sum (cons 1 '())) 1)
(check-expect (sum (cons 1.04 (cons 9.06 '()))) 10.10)

(define (sum monies)
  (cond
    [(empty? monies) 0]
    [else (+
           (first monies)
           (sum (rest monies)))]))

(check-expect (pos? '()) #true)
(check-expect (pos? (cons 1 '())) #true)
(check-expect (pos? (cons -1 '())) #false)
(check-expect (pos? (cons 1 (cons -1 (cons 1 '())))) #false)
(check-expect (pos? (cons 1 (cons 1 (cons 1 '())))) #true)

(define (pos? nums)
  (cond
    [(empty? nums) #true]
    [else (and
           (>= (first nums) 0)
           (pos? (rest nums)))]))

(check-expect (checked-sum '()) 0)
(check-expect (checked-sum  (cons 1 '())) 1)
(check-error (checked-sum  (cons -1 '())) "checked-sum: expects positive numbers")
(check-expect (checked-sum  (cons 2 (cons 1 '()))) 3)
(check-error (checked-sum  (cons 2 (cons -1 '()))) "checked-sum: expects positive numbers")

(define (checked-sum nums)
  (if (pos? nums) (sum nums) (error "checked-sum: expects positive numbers")))

(check-expect (all-true '()) #true)
(check-expect (all-true (cons #true '())) #true)
(check-expect (all-true (cons #false '())) #false)
(check-expect (all-true (cons #true (cons #true '()))) #true)
(check-expect (all-true (cons #true (cons #false '()))) #false)

(define (all-true bools)
  (cond
    [(empty? bools) #true]
    [else (and
           (first bools)
           (all-true (rest bools)))]))

; skipped 141 - 142