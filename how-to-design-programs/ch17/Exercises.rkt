;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect ((lambda (x y) (x y y)) + 2) 4)
; (lambda () 10) ; lambda: expected (lambda (variable more-variable ...) expression), but found no variables
(check-expect ((lambda (x) x) 2) 2)
(check-expect ((lambda (x y) x) #true #false) #true)
; (lambda x 10) ; lambda: expected (lambda (variable more-variable ...) expression), but found something else

(check-expect
 ((lambda (x y) (+ x (* x y))) 1 2) 3)
(check-expect
 ((lambda (x y) (+ x (local ((define z (* y y))) (+ (* 3 z) (/ 1 x))))) 1 2) 14)
(check-expect
 ((lambda (x y) (+ x ((lambda (z) (+ (* 3 z) (/ 1 z))) (* y y)))) 1 2) 13.25)

(check-expect ((lambda (x) (< x 10)) 5) #true)
(check-expect ((lambda (x y) (number->string (* x y))) 21 2) "42")
(check-expect ((lambda (x) (modulo x 2)) 11) 1)

(define (f-plain x) (* 10 x))
(define f-lambda (lambda (x) (* 10 x)))

(define (compare x) (= (f-plain x) (f-lambda x)))
(check-expect (compare (random 10000)) #true)

(check-expect (foldl cons '() (list 1 2 3)) (list 3 2 1))
(check-expect (foldr cons '() (list 1 2 3)) (list 1 2 3))

(check-expect
 (
  ((lambda (x) x) (lambda (x) x))
  "identity")
 (
  ((lambda (x) (x x)) (lambda (x) x))
  "identity"))

(check-expect (convert-euro '()) '())
(check-expect (convert-euro (list 1 10 100 22.22)) (list 1.06 10.6 106.0 23.5532))

(define (convert-euro usds)
  (map (lambda (usd) (* usd 1.06)) usds))

(check-expect (convertFC '()) '())
(check-expect (convertFC (list -459.67 32 212)) (list -273.15 0 100))

(define (convertFC Fs)
  (map (lambda (F) (* (- F 32) 5/9)) Fs))

(check-expect (translate '()) '())
(check-expect (translate (list (make-posn 1 2) (make-posn 4 2))) (list '(1 2) '(4 2)))

(define (translate posns)
  (map (lambda (posn) (list (posn-x posn) (posn-y posn))) posns))

; skipped 286 - 287

(check-expect (build-list 3 (lambda (x) x)) '(0 1 2))
(check-expect (build-list 3 add1) '(1 2 3))
(check-expect (build-list 3 (lambda (x) (/ 1 (add1 x)))) '(1 1/2 1/3))
(check-expect (build-list 3 (lambda (x) (* 2 x))) '(0 2 4))

(check-expect (find-name "jack" '()) #false)
(check-expect (find-name "jack" (list "jack")) #true)
(check-expect (find-name "jack" (list "Jack")) #true)
(check-expect (find-name "jack" (list "Moe" "Jack" "Jill")) #true)
(check-expect (find-name "jack" (list "Moe" "Mo")) #false)
(check-expect (find-name "j" (list "Moe" "Mo")) #false)
(check-expect (find-name "j" (list "Jack" "Jill")) #true)

(define (find-name name names)
  (ormap (lambda (n) (string-contains-ci? name n)) names))

(check-expect (start-name "j" (list "Moe" "Mo")) #false)
(check-expect (start-name "j" (list "Jack" "Jill")) #true)
(check-expect (start-name "J" (list "Jack" "Jill")) #true)

(define (start-name name names)
  (andmap (lambda (n) (string-ci=? name (string-ith n 0))) names))

; skipped 290 - 291

(check-expect (sorted? < '()) #true)
(check-expect (sorted? < '(1 2 3)) #true)
(check-expect (sorted? < '(3 2 3)) #false)

(define (sorted? cmp l)
  (cond
    [(or
      (empty? l)
      (empty? (rest l))) #true]
    [else
     (and (if (cmp (first l) (first (rest l)))
              #true
              #false)
          (sorted? cmp (rest l)))]))

(check-expect ((found? 1 '(1)) '(1)) #true)
(check-expect ((found? 1 '(1 2)) '(1 2)) #true)
(check-expect ((found? 2 '(1)) '(1)) #false)

(define (found? x l0)
  (lambda (l)
    (if (list? l)
        (equal? x (first l))
        (andmap (lambda (i) (not (equal? i x))) l0))))

(define (find x l)
  (cond
    [(empty? l) #false]
    [else
     (if (equal? (first l) x) l (find x (rest l)))]))

(check-satisfied (find "needle" '("haystack" "needle")) (found? "needle" '("haystack" "needle")))
(check-satisfied (find "needle" '("haystack")) (found? "needle" '("haystack")))

; skip 294 - 298

(define (mk-set predicate)
  (lambda (x)
    (predicate x)))

(define even (mk-set (lambda (n) (even? n))))
(check-expect (even 2) #true)
(check-expect (even 3) #false)
(check-expect (even 9992) #true)

(define odd (mk-set (lambda (n) (odd? n))))
(check-expect (odd 1) #true)
(check-expect (odd 2) #false)
(check-expect (odd 2221) #true)

(define divisible-by-10 (mk-set (lambda (n) (zero? (modulo n 10)))))
(check-expect (divisible-by-10 10) #true)
(check-expect (divisible-by-10 11) #false)
(check-expect (divisible-by-10 11111110) #true)

(define (add-element set elm)
  (lambda (n)
    (or
     (= elm n)
     (set n))))

(check-expect ((add-element divisible-by-10 11) 11) #true)
(check-expect ((add-element divisible-by-10 11) 12) #false)
(check-expect ((add-element divisible-by-10 11) 20) #true)

(define (union s1 s2)
  (lambda (n)
    (or (s1 n) (s2 n))))

(define even-or-7
  (union even (mk-set (lambda (n) (= 7 n)))))
(check-expect (even-or-7 2) #true)
(check-expect (even-or-7 7) #true)
(check-expect (even-or-7 3) #false)
(check-expect (even-or-7 77) #false)

(define (intersect s1 s2)
  (lambda (n)
    (and (s1 n) (s2 n))))

(define even-and-divisible-by-10
  (intersect even divisible-by-10))
(check-expect (even-and-divisible-by-10 10) #true)
(check-expect (even-and-divisible-by-10 2) #false)
(check-expect (even-and-divisible-by-10 22220) #true)