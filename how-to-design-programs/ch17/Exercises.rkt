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

(check-expect (convert-euro '()) '())
(check-expect (convert-euro (list 1 10 100 22.22)) (list 1.06 10.6 106.0 23.5532))

(define (convert-euro usds)
  (map (lambda (usd) (* usd 1.06)) usds))

(check-expect (convertFC '()) '())
(check-expect (convertFC (list -459.67 32 212)) (list -273.15 0 100))

(define (convertFC Fs)
  (map (lambda (F) (* (- F 32) 5/9)) Fs))

(check-expect (translate '()) '())
(check-expect (translate (list (make-posn 1 2) (make-posn 4 2))) (list '(1 2) '(4 2)))

(define (translate posns)
  (map (lambda (posn) (list (posn-x posn) (posn-y posn))) posns))

; skipped 286 - 287

(check-expect (build-list 3 (lambda (x) x)) '(0 1 2))
(check-expect (build-list 3 add1) '(1 2 3))
(check-expect (build-list 3 (lambda (x) (/ 1 (add1 x)))) '(1 1/2 1/3))
(check-expect (build-list 3 (lambda (x) (* 2 x))) '(0 2 4))

(check-expect (find-name "jack" '()) #false)
(check-expect (find-name "jack" (list "jack")) #true)
(check-expect (find-name "jack" (list "Jack")) #true)
(check-expect (find-name "jack" (list "Moe" "Jack" "Jill")) #true)
(check-expect (find-name "jack" (list "Moe" "Mo")) #false)
(check-expect (find-name "j" (list "Moe" "Mo")) #false)
(check-expect (find-name "j" (list "Jack" "Jill")) #true)

(define (find-name name names)
  (ormap (lambda (n) (string-contains-ci? name n)) names))

(check-expect (start-name "j" (list "Moe" "Mo")) #false)
(check-expect (start-name "j" (list "Jack" "Jill")) #true)
(check-expect (start-name "J" (list "Jack" "Jill")) #true)

(define (start-name name names)
  (andmap (lambda (n) (string-ci=? name (string-ith n 0))) names))

; todo 290 - 291