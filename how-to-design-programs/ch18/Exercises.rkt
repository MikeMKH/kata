;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (p1 x y)
  (+ (* x y)
     (+ (* 2 x)
        (+ (* 2 y) 22))))
 
(define (p2 x)
  (+ (* 55 x) (+ x 11)))
 
(define (p3 x)
  (+ (p1 x 0)
     (+ (p1 x 1) (p2 x))))

; skipped 301 - 303

(require 2htdp/abstraction)

(check-expect
 (for/list ([i 2] [j '(a b)]) (list i j))
 (list (list 0 'a) (list 1 'b)))

(check-expect
 (for*/list ([i 2] [j '(a b)]) (list i j))
 (list (list 0 'a) (list 0 'b) (list 1 'a) (list 1 'b)))

(check-expect (convert-euro '()) '())
(check-expect (convert-euro '(1 10 100 22)) (list 1.06 10.6 106 23.32))

(define (convert-euro usds)
  (for/list ([usd usds]) (* 1.06 usd)))

(check-expect
 (for/list ([i 10]) i)
 '(0 1 2 3 4 5 6 7 8 9))
(check-expect
 (for/list ([i 10] [ith (in-naturals 1)]) ith)
 '(1 2 3 4 5 6 7 8 9 10))
(check-expect
 (for/list ([i 10] [ith (in-naturals 1)]) (/ 1 ith))
 '(1 1/2 1/3 1/4 1/5 1/6 1/7 1/8 1/9 1/10))
(check-expect
 (for/list ([i (in-range 0 10 2)]) i)
 '(0 2 4 6 8))

(check-expect (tabulate add1 0) '())
(check-expect (tabulate add1 3) '(1 2 3))
(check-expect (tabulate sub1 3) '(-1 0 1))

(define (tabulate f n)
  (for/list ([i n]) (f i)))

; skipped 307

(define-struct phone [area switch four])

(check-expect (replace '()) '())
(check-expect
 (replace (list (make-phone 713 664 9993) (make-phone 555 555 5555)))
 (list (make-phone 281 664 9993) (make-phone 555 555 5555)))
(check-expect
 (replace (list (make-phone 111 111 1111) (make-phone 222 222 2222)))
 (list (make-phone 111 111 1111) (make-phone 222 222 2222)))

(define (replace lop)
  (for/list ([ph lop])
    (match ph
      [(phone 713 area four) (make-phone 281 area four)]
      [p p])))

