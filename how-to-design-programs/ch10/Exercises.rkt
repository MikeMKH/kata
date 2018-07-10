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

(check-expect (convert 0.85 0) 0)
(check-expect (convert 1 0) 0)
(check-expect (convert 0.85 10) 8.5)
(check-expect (convert 1 10) 10)

(define (convert conversion amount)
  (* conversion amount))

(check-expect (convert* 0.85 '()) '())
(check-expect (convert* 0.85 (cons 10 (cons 0 '()))) (cons 8.5 (cons 0 '())))
(check-expect (convert* 1 '()) '())
(check-expect (convert* 1 (cons 10 (cons 2 '()))) (cons 10 (cons 2 '())))

(define (convert* conversion amounts)
  (cond
    [(empty? amounts) '()]
    [else (cons
           (convert conversion (first amounts))
           (convert* conversion (rest amounts)))]))

(check-expect (subst-robot '()) '())
(check-expect (subst-robot (cons "something" '())) (cons "something" '()))
(check-expect (subst-robot (cons "robot" '())) (cons "r2d2" '()))
(check-expect (subst-robot (cons "something" (cons "robot" '()))) (cons "something" (cons "r2d2" '())))
(check-expect (subst-robot (cons "robot" (cons "robot" '()))) (cons "r2d2" (cons "r2d2" '())))

(define (subst-robot strs)
  (cond
    [(empty? strs) '()]
    [else (cons
           (if (string=? (first strs) "robot") "r2d2" (first strs))
           (subst-robot (rest strs)))]))

(define-struct workrec [empid employee rate hours])
(define-struct paycheck [empid employee amount])

(check-expect (workrec-wage (make-workrec 123 "Mike" 89.00 40)) (make-paycheck 123 "Mike" (* 89.00 40)))
(check-expect (workrec-wage (make-workrec 456 "Jack" 0.10 2)) (make-paycheck 456 "Jack" 0.20))

(define (workrec-wage rec)
  (make-paycheck
   (workrec-empid rec)
   (workrec-employee rec)
   (* (workrec-rate rec) (workrec-hours rec))))

(check-expect (workrec-wage* '()) '())
(check-expect (workrec-wage*
               (cons (make-workrec 1 "Kelsey" 1000000 1) '()))
               (cons (make-paycheck 1 "Kelsey" 1000000) '()))
(check-expect (workrec-wage*
               (cons (make-workrec 999 "B" 11.99 40) (cons (make-workrec 789 "A" 12.0 40) '())))
               (cons (make-paycheck 999 "B" (* 11.99 40)) (cons (make-paycheck 789 "A" (* 12.0 40)) '())))

(define (workrec-wage* recs)
  (cond
    [(empty? recs) '()]
    [else (cons (workrec-wage (first recs)) (workrec-wage* (rest recs)))]))

; TODO 167 - 170