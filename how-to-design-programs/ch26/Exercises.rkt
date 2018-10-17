;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; skipped 431 - 432

(check-error (bundle-check (explode "abc") 0) "bundle: cannot bundle size 0")
(check-error (bundle-check (explode "abc") -1) "bundle: cannot bundle size -1")

(check-expect (bundle-check (explode "abc") 1) '(("a") ("b") ("c")))
(check-expect (bundle-check (explode "abc") 2) '(("a" "b") ("c")))
(check-expect (bundle-check (explode "abc") 5) '(("a" "b" "c")))

(define (bundle-check l n)
  (if (<= n 0)
      (error (string-append "bundle: cannot bundle size " (number->string n)))
      (bundle l n)))

(define (bundle l n)
  (cond
    [(empty? l) '()]
    [else (cons (take l n)
                (bundle (drop l n) n))]))

(check-expect (take '() 0) '())
(check-expect (take '() 1) '())
(check-expect (take '(1) 1) '(1))
(check-expect (take '(1) 0) '())
(check-expect (take '(1 2 3) 2) '(1 2))

(define (take l n)
  (cond
    [(or (empty? l)
         (zero? n)) '()]
    [else (cons (first l)
                (take (rest l) (sub1 n)))]))

(check-expect (drop '() 0) '())
(check-expect (drop '() 1) '())
(check-expect (drop '(1) 1) '())
(check-expect (drop '(1) 0) '(1))
(check-expect (drop '(1 2 3) 2) '(3))

(define (drop l n)
  (cond
    [(or (empty? l)
         (zero? n)) l]
    [else (drop (rest l) (sub1 n))]))

; skipped 434 - 436