;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Lam is one of: 
; – a Symbol
; – (list 'λ (list Symbol) Lam)
; – (list Lam Lam)
(define ex1 '(λ (x) x))
(define ex2 '(λ (x) y))
(define ex3 '(λ (y) (λ (x) y)))
(define ex4 '((λ (x) x) (λ (x) x)))
(define ex5 '((λ (x) (x x)) (λ (x) (x x))))
(define ex6 '(((λ (y) (λ (x) y)) (λ (z) z)) (λ (w) w)))

(define var-exp 'x)
(define λ-exp '(λ (x) x))
(define app-exp '((λ (x) x) 5))

(check-expect (is-var? var-exp) #true)
(check-expect (is-var? λ-exp) #false)
(check-expect (is-var? app-exp) #false)

(define (is-var? exp)
  (symbol? exp))

(check-expect (is-λ? var-exp) #false)
(check-expect (is-λ? λ-exp) #true)
(check-expect (is-λ? app-exp) #false)

(define (is-λ? exp)
  (and (cons? exp)
       (equal? (first exp) 'λ)))

(check-expect (is-app? var-exp) #false)
(check-expect (is-app? λ-exp) #false)
(check-expect (is-app? app-exp) #true)

(define (is-app? exp)
  (and (cons? exp)
       (cons? (first exp))))

(check-expect (λ-para '(λ (x) x)) 'x)
(check-expect (λ-para '(λ (y) x)) 'y)

(define (λ-para exp)
  (first (second exp)))

(check-expect (λ-body '(λ (x) x)) 'x)
(check-expect (λ-body '(λ (y) x)) 'x)

(define (λ-body exp)
  (third exp))

(check-expect (app-fun '((λ (x) x) 5)) '(λ (x) x))
(check-expect (app-fun '((λ (x) 7) 5)) '(λ (x) 7))

(define (app-fun exp)
  (first exp))

(check-expect (app-arg '((λ (x) x) 5)) '5)
(check-expect (app-arg '((λ (x) 7) y)) 'y)

(define (app-arg exp)
  (second exp))

(check-expect (declareds '(λ () x)) '())
(check-expect (declareds '(λ (x) x)) '(x))
(check-expect (declareds '(λ (x y z) x)) '(x y z))
(check-expect (declareds '(λ (x x) x)) '(x x))
(check-expect (declareds '(λ (x y x z x) x)) '(x y x z x))

(define (declareds exp)
  (second exp))

; skipped 513 - 524

(define-struct p*ir [count left right])

(check-expect (p*ir-count (c*ns 'a '())) 1)
(check-expect (p*ir-count (c*ns 'a (c*ns 'b '()))) 2)
(check-error
 (p*ir-count (c*ns 'a (c*ns 'b '(c d e))))
 "c*ns: given list that is not p*ir")

(define (c*ns x l)
  (cond
    [(empty? l) (make-p*ir 1 x l)]
    [(p*ir? l) (make-p*ir (add1 (p*ir-count l)) x l)]
    [else (error "c*ns: given list that is not p*ir")]))

(check-expect (l*ngth (c*ns 'a '())) 1)
(check-expect (l*ngth (c*ns 'a (c*ns 'b '()))) 2)

(define (l*ngth l)
  (p*ir-count l))