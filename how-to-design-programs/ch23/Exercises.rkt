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

; TODO 388
(define (wages*.v2 hours employees)
  (cond
    [(empty? hours) '()]
    [else
     (cons
       (weekly-wage (first hours) employees)
       (wages*.v2 (rest hours) employees))]))
