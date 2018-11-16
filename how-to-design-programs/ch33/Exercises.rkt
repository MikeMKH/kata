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

; TODO declareds