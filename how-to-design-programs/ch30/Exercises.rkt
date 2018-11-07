;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; the call to (infL (rest l)) is kept until need for recombining

(define (infL l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (local ((define s (infL (rest l))))
            (if (< (first l) s) (first l) s))]))

(check-expect (infL '(1 2 3)) 1)

(check-expect (sum-tree '(1)) 1)
(check-expect (sum-tree '((1)(2))) 3)
(check-expect 6
              (sum-tree
               '(
                 ((1)(2))
                 (3)
                 )
               ))

(define (sum-tree t)
  (cond
    [(empty? t) 0]
    [(cons? t) (+ (sum-tree (first t)) (sum-tree (rest t)))]
    [else t]))

; skipped 486 - 488