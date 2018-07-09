;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect (wage 28) 392)
(check-expect (wage 4) 56)
(check-expect (wage 2) 28)

(define (wage hours)
  (* hours 14))

(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '())) (cons 392 '()))
(check-expect (wage* (cons 4 (cons 2 '()))) (cons 56 (cons 28 '())))

(define (wage* hs)
  (cond
    [(empty? hs) '()]
    [else (cons (wage (first hs)) (wage* (rest hs)))]))

(check-expect (checked-wage 100) 1400)
(check-error (checked-wage 101) "checked-wage: hours more than 100")

(define (checked-wage hours)
  (cond
    [(> hours 100) (error "checked-wage: hours more than 100")]
    [else (wage hours)]))

(check-expect (checked-wage* '()) '())
(check-expect (checked-wage* (cons 100 '())) (cons 1400 '()))
(check-error (checked-wage* (cons 101 '())) "checked-wage: hours more than 100")
(check-error (checked-wage* (cons 100 (cons 101 '()))) "checked-wage: hours more than 100")

(define (checked-wage* hs)
  (cond
    [(empty? hs) '()]
    [else (cons (checked-wage (first hs)) (checked-wage* (rest hs)))]))

(check-expect (convertFC '()) '())
(check-expect (convertFC (cons 32 '())) (cons 0 '()))
(check-expect (convertFC (cons 32 (cons 59 '()))) (cons 0 (cons 15 '())))

(define (convertFC Fs)
  (cond
    [(empty? Fs) '()]
    [else (cons (* (- (first Fs) 32) 5/9) (convertFC (rest Fs)))]))

(check-expect (usd->eur 0) 0)
(check-expect (usd->eur 1) 0.85)
(check-expect (usd->eur 100) 85)
(check-expect (usd->eur 50) 42.5)

(define (usd->eur usd)
  (* usd 0.85))

; TODO 164 - 165