;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; no, it would produce an endless loop

(check-expect (take '() 1) '())
(check-expect (take '(1) 1) '(1))
(check-expect (take '(1 2) 1) '(1))
(check-expect (take '(1 2) 3) '(1 2))

(define (take l n)
  (cond
    [(or (empty? l)
         (zero? n)) '()]
    [else (cons (first l)
                (take (rest l) (sub1 n)))]))

(check-expect (drop '() 1) '())
(check-expect (drop '(1) 1) '())
(check-expect (drop '(1 2) 1) '(2))

(define (drop l n)
  (cond
    [(or (empty? l)
         (zero? n)) l]
    [else (drop (rest l) (sub1 n))]))

(check-expect (list->chunks '() 1) '())
(check-expect (list->chunks '(1) 1) '((1)))
(check-expect (list->chunks '(1 2) 1) '((1) (2)))
(check-expect (list->chunks '(1 2 3 4 5) 3) '((1 2 3) (4 5)))

(define (list->chunks l n)
  (cond
    [(empty? l) '()]
    [else (cons (take l n)
                (list->chunks (drop l n) n))]))

(check-expect (bundle '() 2) '())
(check-expect (bundle (explode "ab") 2) '("ab"))
(check-expect (bundle (explode "abc") 2) '("ab" "c"))

(define (bundle los n)
  (map implode (list->chunks los n)))

(check-satisfied
 (partition "abc" 2)
 (lambda (p) (equal? p (bundle (explode "abc") 2))))

(check-expect (partition "" 1) '())
(check-expect (partition "a" 1) '("a"))
(check-expect (partition "ab" 1) '("a" "b"))
(check-expect (partition "abcdef" 2) '("ab" "cd" "ef"))
(check-expect (partition "abcdef" 3) (bundle (explode "abcdef") 3))

(define (partition s n)
  (bundle (explode s) n))
