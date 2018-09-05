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

(check-expect (atom? "yes") #true)
(check-expect (atom? 'symbol) #true)
(check-expect (atom? 3.14) #true)
(check-expect (atom? '()) #false)
(check-expect (atom? (cons 123 '())) #false)

(define (atom? at)
  (or
   (string? at)
   (number? at)
   (symbol? at)))

(check-expect (count '() 'yes) 0)
(check-expect (count (list 'yes 'no 'no) 'yes) 1)
(check-expect (count (list 'yes (list 'no 'yes 'no (list 'no))) 'yes) 2)
(check-expect (count (list 'no (list 'no 'no 'no (list 'no))) 'yes) 0)
(check-expect (count (list 'yes (list 'no 'yes "no" (list 123))) 'yes) 2)

; S-expr Symbol -> N 
; counts all occurrences of sy in sexp 
(define (count sexp sy)
  (local (
          (define (count-sl sl)
            (cond
              [(empty? sl) 0]
              [else
               (+ (count (first sl) sy) (count-sl (rest sl)))]))
          (define (count-atom at)
            (cond
              [(number? at) 0]
              [(string? at) 0]
              [(symbol? at) (if (symbol=? at sy) 1 0)]))
          )
    (cond
      [(atom? sexp) (count-atom sexp)]
      [else (count-sl sexp)])))

(check-expect (depth 'one) 1)
(check-expect (depth '()) 2)
(check-expect (depth (cons 2 '())) 2)
(check-expect (depth (cons (cons 'three '()) '())) 3)
(check-expect (depth (list (list (list (list 5))))) 5)

(define (depth sexp)
  (local (
          (define (depth-atom at) 1)
          (define (depth-sl sl)
            (cond
              [(empty? sl) 1]
              [else
               (max (depth (first sl))
                    (depth-sl (rest sl)))]))
          )
    (cond
      [(atom? sexp) (depth-atom sexp)]
      [else (add1 (depth-sl sexp))])))

; skipped 319 - 321

(define-struct no-info [])
(define NONE (make-no-info))
 
(define-struct node [ssn name left right])

(check-expect (contains-bt? 7 NONE) #false)
(check-expect (contains-bt? 7 (make-node 8 "a" NONE NONE)) #false)
(check-expect (contains-bt? 8 (make-node 8 "a" NONE NONE)) #true)
(check-expect (contains-bt? 8 (make-node 88 "a"
                                         (make-node 8 "b" NONE NONE) NONE)) #true)
(check-expect (contains-bt? 8 (make-node 888 "a"
                                         (make-node 88 "b" NONE NONE)
                                         (make-node 8 "c" NONE NONE))) #true)

(define (contains-bt? ssn bt)
  (cond
    [(no-info? bt) #false]
    [else
     (if (equal? ssn (node-ssn bt))
         #true
         (or
          (contains-bt? ssn (node-left bt))
          (contains-bt? ssn (node-right bt))))]))

(check-expect (search-bt 7 NONE) #false)
(check-expect (search-bt 7 (make-node 8 "a" NONE NONE)) #false)
(check-expect (search-bt 8 (make-node 8 "a" NONE NONE)) "a")
(check-expect (search-bt 8 (make-node 88 "a"
                                      (make-node 8 "b" NONE NONE) NONE)) "b")
(check-expect (search-bt 8 (make-node 888 "a"
                                      (make-node 88 "b" NONE NONE)
                                      (make-node 8 "c" NONE NONE))) "c")

(define (search-bt ssn bt)
  (cond
    [(no-info? bt) #false]
    [else
     (if (equal? ssn (node-ssn bt))
         (node-name bt)
         (if (contains-bt? ssn (node-left bt))
             (search-bt ssn (node-left bt))
             (search-bt ssn (node-right bt))))]))

; TODO 324 - 327