;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect (cross '(a) '(1)) '((a 1)))
(check-expect (cross '(a b c) '(1 2)) '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2)))

(define (cross col1 col2)
  (local (
          (define (cross-1 elm col)
            (cond
              [(empty? col) '()]
              [else
               (cons (list elm (first col))
                     (cross-1 elm (rest col)))])))
    (cond
      [(empty? col1) '()]
      [else
       (append (cross-1 (first col1) col2)
               (cross (rest col1) col2))])))

(define-struct employee [name ssn pay-rate])
(define-struct work [name hours])

(check-expect '()
 (weekly-wage (make-work "not found" 40) (list (make-employee "Bob" "123-45-6789" 5.50))))

(check-expect '("Bob" 220)
 (weekly-wage (make-work "Bob" 40) (list (make-employee "Bob" "123-45-6789" 5.50))))

(check-expect '("Bob" 220)
 (weekly-wage (make-work "Bob" 40)
              (list (make-employee "Rob" "555-55-5555" 6.50) (make-employee "Bob" "123-45-6789" 5.50))))

(define (weekly-wage hours employees)
  (cond
    [(empty? employees) '()]
    [else
     (if (equal? (work-name hours) (employee-name (first employees)))
         (list (work-name hours)
               (* (employee-pay-rate (first employees))
                  (work-hours hours)))
         (weekly-wage hours (rest employees)))]))

(check-expect '(("Bob" 220) ("Jim" 226))
              (wages* (list (make-work "Bob" 40) (make-work "Jim" 40))
                      (list (make-employee "Jim" "111-11-1111" 5.65) (make-employee "Bob" "123-45-6789" 5.5))))

(check-expect '(() ("Jim" 226))
              (wages* (list (make-work "unknown" 40) (make-work "Jim" 40))
                      (list (make-employee "Jim" "111-11-1111" 5.65) (make-employee "Bob" "123-45-6789" 5.5))))

(define (wages* hours employees)
  (cond
    [(empty? hours) '()]
    [else
     (cons
       (weekly-wage (first hours) employees)
       (wages* (rest hours) employees))]))

(check-expect '(('a 1) ('b 2)) (zip '('a 'b) '(1 2)))
(check-expect '(('a 1)) (zip '('a) '(1 2)))
(check-expect '(('a 1)) (zip '('a 'b) '(1)))
(check-expect '() (zip '() '()))

(define (zip xs ys)
  (cond
    [(or (empty? xs)
         (empty? ys)) '()]
    [else
     (cons (list (first xs) (first ys))
           (zip (rest xs) (rest ys)))]))

(define-struct branch [left right])

(check-expect (tree-pick 'a '()) 'a)
(check-expect (tree-pick (make-branch 'l 'r) '(left)) 'l)
(check-expect (tree-pick (make-branch 'l 'r) '(right)) 'r)
(check-expect 'yass
              (tree-pick (make-branch (make-branch (make-branch 'no (make-branch 'yass 'no)) 'no) 'no) '(left left right left)))

(check-error (tree-pick 'a '(left)) "found symbol instead of branch")
(check-error (tree-pick (make-branch 'no 'no) '()) "found branch instead of symbol")

(define (tree-pick tree path)
  (cond
    [(and
      (empty? path)
      (symbol? tree)) tree]
    [(and
      (not (empty? path))
      (not (symbol? tree)))
     (local ((define direction (first path)))
       (tree-pick
        (cond
          [(equal? 'left direction) (branch-left tree)]
          [(equal? 'right direction) (branch-right tree)])
        (rest path)))]
    [(symbol? tree)
     (error "found symbol instead of branch")]
    [else
     (error "found branch instead of symbol")]))

(check-expect (replace-eol-with '() 2) '(2))
(check-expect (replace-eol-with (cons 1 '()) 2) '(1 2))

(define (replace-eol-with col with)
  (cond
    [(empty? col) (list with)]
    [else (cons (first col) (replace-eol-with (rest col) with))]))

(check-expect (union '() '()) '())
(check-expect (union '() '(1)) '(1))
(check-expect (union '(1) '()) '(1))
(check-expect (sort (union '(1 2 3) '(3 4 5)) <) '(1 2 3 4 5))
(check-expect (sort (union '(1 2 3 4 5) '(1 2 3 4 5)) <) '(1 2 3 4 5))

(define (union s1 s2)
  (cond
    [(empty? s2) s1]
    [(empty? s1) s2]
    [else (if (member? (first s2) s1)
              (union s1 (rest s2))
              (cons (first s2) (union s1 (rest s2))))]))

(check-expect (intersect '() '()) '())
(check-expect (intersect '() '(1)) '())
(check-expect (intersect '(1) '()) '())
(check-expect (intersect '(1) '(1)) '(1))
(check-expect (intersect '(1 2) '(1 3)) '(1))
(check-expect (intersect '(1 2 3 4 5) '(1 3 5 7)) '(1 3 5))

(define (intersect s1 s2)
  (cond
    [(or (empty? s1) (empty? s2)) '()]
    [else
     (if (member? (first s2) s1)
         (cons (first s2) (intersect s1 (rest s2)))
         (intersect s1 (rest s2)))]))

(check-expect (sort<? '()) #true)
(check-expect (sort<? '(1)) #true)
(check-expect (sort<? '(1 2 3)) #true)
(check-expect (sort<? '(1 3 2)) #false)

(define (sort<? lon)
  (cond
    [(or (empty? lon) (empty? (rest lon))) #true]
    [else
     (if (or (= (first lon) (second lon))
             (< (first lon) (second lon)))
         (sort<? (rest lon))
         #false)]))

(check-satisfied (merge '(1 2 3 4 5) '(4 5 6 7 8 9)) sort<?)
(check-expect (merge '() '()) '())
(check-expect (merge '(1) '()) '(1))
(check-expect (merge '() '(1)) '(1))
(check-expect (merge '(1) '(1)) '(1 1))
(check-expect (merge '(1 2) '(1 3)) '(1 1 2 3))

(define (merge s1 s2)
  (cond
    [(empty? s1) s2]
    [(empty? s2) s1]
    [else
     (local (
             (define elm1 (first s1))
             (define elm2 (first s2)))
       (if (or (= elm1 elm2) (< elm1 elm2))
           (cons elm1 (merge (rest s1) s2))
           (cons elm2 (merge s1 (rest s2)))))]))

(check-expect (take '() 1) '())
(check-expect (take '(1) 1) '(1))
(check-expect (take '(1) 2) '(1))
(check-expect (take '(1 2) 1) '(1))
(check-expect (take '(1 2) 2) '(1 2))

(define (take col n)
  (cond
    [(or (empty? col)
         (zero? n)) '()]
    [else
     (cons (first col) (take (rest col) (sub1 n)))]))

(check-expect (drop '() 1) '())
(check-expect (drop '(1) 1) '())
(check-expect (drop '(1) 2) '())
(check-expect (drop '(1 2) 1) '(2))
(check-expect (drop '(1 2 3 4 5 6 7 8 9) 3) '(4 5 6 7 8 9))

(define (drop col n)
  (cond
    [(or (empty? col)
         (zero? n)) col]
    [else
     (drop (rest col) (sub1 n))]))

; skipped 396 - 402