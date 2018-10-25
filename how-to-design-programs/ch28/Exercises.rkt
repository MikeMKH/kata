;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect (slope (lambda (x) (+ x 1)) 1) 1)
(check-expect (slope (lambda (x) (* x x 2)) 0) 0)
(check-expect (slope (lambda (x) (* x x 2)) 1) 4)

(define ε 0.1)

(define (slope f r1)
  (* (/ 1 (* 2 ε))
     (- (f (+ r1 ε))
        (f (- r1 ε)))))

(check-expect (root-of-tangent (lambda (x) (+ x 1)) 1) -1)
(check-expect (root-of-tangent (lambda (x) (* x x 2)) 1) 1/2)
(check-expect (root-of-tangent (lambda (x) (+ (* x x 2) 1)) 1) 1/4)

(define (root-of-tangent f r1)
  (- r1 (/ (f r1)
           (slope f r1))))

(define (poly x)
  (* (- x 2) (- x 4)))

(check-within (newton poly 1) 2 ε)
(check-within (newton poly 3.5) 4 ε)

(define (newton f r1)
  (cond
    [(<= (abs (f r1)) ε) r1]
    [else (newton f (root-of-tangent f r1))]))

; skipped 457