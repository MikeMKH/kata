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

(check-expect (constant 0) 20)
(check-expect (constant 100) 20)

(define (constant x) 20)

(check-expect (linear 0) 0)
(check-expect (linear 100) 200)

(define (linear x) (* 2 x))

(check-expect (square 0) 0)
(check-expect (square 10) 300)

(define (square x) (* 3 (sqr x)))

(check-within (integrate-kepler constant 12 22) 200 ε)
(check-within (integrate-kepler linear 0 10) 100 ε)
;(check-within (integrate-kepler square 0 10) 1000 ε) ; gives 1500 not 1000

(define (integrate-kepler f l r)
  (* (/ 1 2)
     (- r l)
     (+ (f l)
        (f r))))

(check-within (integrate-rectangle constant 12 22) 200 ε)
(check-within (integrate-rectangle linear 0 10) 100 ε)
(check-within (integrate-rectangle square 0 10) 1000 ε)

(define (integrate-rectangle f a b)
  (local ((define r 100)
          (define w (/ (- b a) r))
          (define s (/ w 2))
          (define (helper i)
            (cond
              [(= i r) 0]
              [else
               (+ (* w (f (+ a (* i w) s)))
                  (helper (add1 i)))])))
    (helper 0)))

; skipped 460 - 461