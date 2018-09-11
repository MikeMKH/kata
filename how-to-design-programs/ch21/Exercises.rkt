;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct add [left right])
(define-struct mul [left right])

(check-expect (eval-expression 3) 3)
(check-expect (eval-expression (make-add 10 -10)) 0)
(check-expect (eval-expression (make-add (make-mul 20 3) 33)) 93)
(check-expect (eval-expression (make-add (make-mul 3.14 (make-mul 2 3)) (make-mul 3.14 (make-mul -1 -9)))) (* 15 3.14))

(check-error (eval-expression "7") "unsupported expression")

(check-expect (eval-expression (make-add -1 2)) (+ -1 2))
(check-expect (eval-expression (make-add (make-mul -2 -3) 33)) (+ (* -2 -3) 33))
(check-expect (eval-expression (make-mul (make-add 1 (make-mul 2 3)) 3.14)) (* (+ 1 (* 2 3)) 3.14))

(define (eval-expression exp)
  (cond
    [(add? exp)
     (+ (eval-expression (add-left exp)) (eval-expression (add-right exp)))]
    [(mul? exp)
     (* (eval-expression (mul-left exp)) (eval-expression (mul-right exp)))]
    [(number? exp) exp]
    [else (error "unsupported expression")]))

(define-struct and-bool [left right])
(define-struct or-bool [left right])
(define-struct not-bool [exp])

(check-expect (eval-bool-expression #true) #true)

(check-expect (eval-bool-expression (make-and-bool #true #false)) #false)
(check-expect (eval-bool-expression (make-and-bool #true #true)) #true)
(check-expect (eval-bool-expression (make-and-bool #true (make-not-bool #false))) #true)
(check-expect (eval-bool-expression (make-and-bool #false (make-not-bool #true))) #false)

(check-expect (eval-bool-expression (make-or-bool #true #false)) #true)
(check-expect (eval-bool-expression (make-or-bool #true #true)) #true)
(check-expect (eval-bool-expression (make-or-bool #true (make-not-bool #false))) #true)
(check-expect (eval-bool-expression (make-or-bool #false (make-not-bool #true))) #false)

(check-error (eval-bool-expression "true") "unsupported expression")

(define (eval-bool-expression exp)
  (cond
    [(and-bool? exp)
     (and (eval-bool-expression (and-bool-left exp)) (eval-bool-expression (and-bool-right exp)))]
    [(or-bool? exp)
     (or (eval-bool-expression (or-bool-left exp)) (eval-bool-expression (or-bool-right exp)))]
    [(not-bool? exp)
     (not (eval-bool-expression (not-bool-exp exp)))]
    [(boolean? exp) exp]
    [else (error "unsupported expression")]))

; TODO 349

; skipped 350

; TODO 351