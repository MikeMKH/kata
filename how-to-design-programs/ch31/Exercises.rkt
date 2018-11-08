;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect (cons 50 (add-to-each 50 '(40 110 140 170)))
              '(50 90 160 190 220))
 
;(define (add-to-each n l)
;  (cond
;    [(empty? l) '()]
;    [else (cons (+ (first l) n) (add-to-each n (rest l)))]))

(define (add-to-each n l)
  (map (lambda (x) (+ x n)) l))

; skipped 490

(check-expect (reverse-append '()) '())
(check-expect (reverse-append '(1 2 3)) '(3 2 1))
(check-expect (reverse-append (reverse-append (build-list 10 add1))) (build-list 10 add1))
(check-expect (reverse-append (build-list 99 add1)) (reverse (build-list 99 add1)))

; slow
(define (_reverse l)
  (cond
    [(empty? l) '()]
    [else
     (append (_reverse (rest l)) (list (first l)))]))