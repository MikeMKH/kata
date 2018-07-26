;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect (contains? "atom" '()) #false)
(check-expect (contains? "atom" (list "a" "atom" "z")) #true)
(check-expect (contains? "atom" (list "a" "z")) #false)
(check-expect (contains? "basic" (list "casey" "basic")) #true)
(check-expect (contains? "basic" (list "mike" "complex")) #false)
(check-expect (contains? "zoo" (list "kelsey" "going" "to" "the" "zoo")) #true)
(check-expect (contains? "zoo" (list "jack" "staying" "home")) #false)

(define (contains? str los)
  (cond
    [(empty? los) #false]
    [else (or
           (string=? str (first los))
           (contains? str (rest los)))]))

(check-expect (add* 1 '()) '())
(check-expect (add* -9 (add* 1 '())) '())
(check-expect (add* 1 (list 1 2)) (list 2 3))
(check-expect (add* 5 (list 1 2)) (list 6 7))
(check-expect (add* 10 (add* 5 (list 1 2))) (list 16 17))
(check-expect (add* -5 (add* 5 (list 1 2))) (list 1 2))

(define (add* n lon)
  (cond
    [(empty? lon) '()]
    [else (cons (+ n (first lon))
                (add* n (rest lon)))]))

(check-expect (squared>? 3 10) #false)
(check-expect (squared>? 4 10) #true)
(check-expect (squared>? 5 10) #true)

(define (squared>? n value)
  (> (* n n) value))

(check-expect (inf (list 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))
              1)
(check-expect (inf (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25))
              1)
(check-expect (inf (list 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))
              (inf (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25)))

(check-expect (sup (list 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))
              25)
(check-expect (sup (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25))
              25)
(check-expect (sup (list 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))
              (sup (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25)))

(define (most Ord nelon)
  (cond
    [(empty? (rest nelon)) (first nelon)]
    [else (Ord (first nelon)
               (most Ord (rest nelon)))]))

(define (inf nelon) (most min nelon))
(define (sup nelon) (most max nelon))