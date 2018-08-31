;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct child [father mother name date eyes])
(define-struct no-parent [])
(define NP (make-no-parent))

; Oldest Generation:
(define Carl (make-child NP NP "Carl" 1926 "green"))
(define Bettina (make-child NP NP "Bettina" 1926 "green"))
 
; Middle Generation:
(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva (make-child Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-child NP NP "Fred" 1966 "pink"))
 
; Youngest Generation: 
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))

(check-expect (count-persons NP) 0)
(check-expect (count-persons Carl) 1)
(check-expect (count-persons Adam) 3)
(check-expect (count-persons Gustav) 5)

(define (count-persons ftree)
  (cond
    [(no-parent? ftree) 0]
    [else
     (+ 1
        (count-persons (child-father ftree))
        (count-persons (child-mother ftree)))]))

(check-expect (sum-age NP 2018) 0)
(check-expect (sum-age Carl 1927) 1)
(check-expect (sum-age Adam 1951) 51)

(define (sum-age ftree year)
  (cond
    [(no-parent? ftree) 0]
    [else
     (+ (- year (child-date ftree))
        (sum-age (child-father ftree) year)
        (sum-age (child-mother ftree) year))]))

(check-expect (average-age NP 2018) 0)
(check-expect (average-age Carl 1927) 1)
(check-expect (average-age Adam 1951) 17)

(define (average-age ftree year)
  (cond
    [(no-parent? ftree) 0]
    [else
     (/ (sum-age ftree year) (count-persons ftree))]))

(check-expect (eye-colors NP) '())
(check-expect (eye-colors Carl) '("green"))
(check-expect (eye-colors Adam) '("hazel" "green" "green"))

(define (eye-colors ftree)
  (cond
    [(no-parent? ftree) '()]
    [else
     (cons (child-eyes ftree)
           (append (eye-colors (child-father ftree))
                   (eye-colors (child-mother ftree))))]))

; skipped 313 - 314

(define ff0 (list NP))
(define ff1 (list Carl Bettina))
(define ff2 (list Fred Eva))
(define ff3 (list Fred Eva Carl))

(check-expect (ff-sum-age '() 2018) 0)
(check-expect (ff-sum-age ff0 2018) 0)
(check-expect (ff-sum-age ff1 1927) 2)
(check-expect (ff-sum-age ff1 2018) 184)
(check-expect (ff-sum-age ff2 2018) 289)
(check-expect (ff-sum-age ff3 2018) 381)

(define (ff-sum-age fforest year)
  (cond
    [(empty? fforest) 0]
    [else
     (+ (sum-age (first fforest) year)
        (ff-sum-age (rest fforest) year))]))

(check-expect (ff-count-persons '()) 0)
(check-expect (ff-count-persons ff0) 0)
(check-expect (ff-count-persons ff1) 2)
(check-expect (ff-count-persons ff2) 4)
(check-expect (ff-count-persons ff3) 5)

(define (ff-count-persons fforest)
  (cond
    [(empty? fforest) 0]
    [else
     (+ (count-persons (first fforest))
        (ff-count-persons (rest fforest)))]))

(check-expect (ff-average-age '() 2018) 0)
(check-expect (ff-average-age ff0 2018) 0)
(check-expect (ff-average-age ff1 1927) 1)
(check-expect (ff-average-age ff1 2018) 92)
(check-expect (ff-average-age ff2 2018) 72.25)
(check-expect (ff-average-age ff3 2018) 76.2)

(define (ff-average-age forest year)
  (cond
    [(empty? forest) 0]
    [else
     (local (
       (define count (ff-count-persons forest)))
       (if (zero? count)
           0
           (/ (ff-sum-age forest year) count)))]))