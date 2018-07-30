;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect (tabulate sqrt 0) (list 0))
(check-within (tabulate sqrt 4) (list 2 (sqrt 3) (sqrt 2) 1 0) 0.01)

(check-expect (tabulate tan 0) (list 0))
(check-within (tabulate tan 4) (list (tan 4) (tan 3) (tan 2) (tan 1) 0) 0.01)

(define (tabulate f n)
  (cond
    [(= n 0) (list (f n))]
    [else
     (cons (f n)
           (tabulate f (sub1 n)))]))

(check-expect (fold1 + 0 '()) 0)
(check-expect (fold1 + 100 '()) 100)
(check-expect (fold1 + 0 (range 0 11 1)) (+ 0 1 2 3 4 5 6 7 8 9 10))

(check-expect (fold1 * 1 '()) 1)
(check-expect (fold1 * 1 (range 1 4 1)) (* 2 3))
(check-expect (fold1 * 0 (range 1 10000 1)) 0) ;)

(define (fold1 f seed l)
  (cond
    [(empty? l) seed]
    [else
     (f (first l)
        (fold1 f seed (rest l)))]))

(check-expect (fold2 * 1 '()) 1)
(check-expect (fold2 * 1 (range 1 4 1)) (* 2 3))

(define (fold2 f seed l)
  (cond
    [(empty? l) seed]
    [else
     (f (first l)
        (fold2 f seed (rest l)))]))