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
(define (reverse-append l)
  (cond
    [(empty? l) '()]
    [else
     (append (reverse-append (rest l)) (list (first l)))]))

; not really 492 but this seem more fun

; Figure 179: A simple graph

; A SimpleGraph is a [List-of Connection]
; A Connection is a list of two items:
;   (list Node Node)
; A Node is a Symbol.

(define a-sg
  '((A B)
    (B C)
    (C E)
    (D E)
    (E B)
    (F F)))

(check-expect (path-exists? 'A 'A '((A A))) #true)
(check-expect (path-exists? 'A 'E a-sg) #true)
(check-expect (path-exists? 'A 'F a-sg) #false)

(define (path-exists? origin destination sg)
  (local ((define (path-exists?/a origin seen)
            (cond
              [(symbol=? origin destination) #true]
              [(member? origin seen) #false]
              [else
               (path-exists?/a (neighbor origin sg)
                               (cons origin seen))])))
    (path-exists?/a origin '())))

(check-expect (neighbor 'A '((A B))) 'B)
(check-expect (neighbor 'C '((A B) (C D))) 'D)
(check-expect (neighbor 'C '((A B) (C D) (E F))) 'D)
(check-error (neighbor 'A '()) "neighbor: not a node")

(define (neighbor node sg)
  (cond
    [(empty? sg) (error "neighbor: not a node")]
    [(symbol=? node (first (first sg))) (second (first sg))]
    [else (neighbor node (rest sg))]))