;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect (argmax identity (list 1 2 3)) 3)
(check-error (argmax identity '())
             "argmax: expects a value that is a list and a value that is not an empty as 2nd argument, given '()")

(check-expect (build-list 0 add1) (build-l*st 0 add1))
(check-expect (build-list 3 add1) (build-l*st 3 add1))
(check-expect (build-list 10 add1) (build-l*st 10 add1))

(define (build-l*st n f)
  (cond
    [(zero? n) '()]
    [else
     (append (build-l*st (sub1 n) f)
             (list (f (sub1 n))))]))

; skipped 258 - 259

(check-expect (inf-min (range 0 1000 1)) (inf-local (range 0 1000 1)))

(define (inf-local l)
  (cond
    [(empty? (rest l)) (first l)]
    [else
     (local ((define smallest-in-rest (inf-local (rest l))))
       (if (< (first l) smallest-in-rest)
           (first l)
           smallest-in-rest))]))

(define (inf-min l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (min (first l)
               (inf-min (rest l)))]))

; skipped 261

(check-expect (identityM 0) '())
(check-expect (identityM 1) (list (list 1)))
(check-expect (identityM 2) '((1 0)
                              (0 1)))
(check-expect (identityM 3) '((1 0 0)
                              (0 1 0)
                              (0 0 1)))

(define (identityM m)
  (local (
    (define cols m)
    (define (generate-matrix n)
      (cond
        [(zero? n) '()]
        [else
         (cons
           (generate-row n cols)
           (generate-matrix (sub1 n)))]))
    (define (generate-row a b)
      (cond
        [(zero? b) '()]
        [else
         (cons (if (= a b) 1 0)
               (generate-row a (sub1 b)))])))
    (generate-matrix m)))

; did 265 - 266