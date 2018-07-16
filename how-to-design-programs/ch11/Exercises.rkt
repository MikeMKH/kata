;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect
 (cons "a" (cons "b" (cons "c" (cons "d" '()))))
 (list "a" "b" "c" "d"))

(check-expect
 (cons (cons 1 (cons 2 '())) '())
 (list (list 1 2)))

(check-expect
 (cons "a" (cons 1 (cons #false '())))
 (list "a" 1 #false))

(check-expect
 (cons (cons "a" (cons 2 '())) (cons "hello" '()))
 (list (list "a" 2) "hello"))

(check-expect
 (cons (cons 1 (cons 2 '()))
      (cons (cons 2 '())
            '()))
 (list (list 1 2)
       (list 2)))

(check-expect
 (list 0 1 2 3 4 5)
 (cons 0 (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 '())))))))

(check-expect
 (list (list "he" 0) (list "it" 1) (list "lui" 14))
 (list (cons "he" (cons 0 '())) (cons "it" (cons 1 '())) (cons "lui" (cons 14 '()))))

(check-expect
 (list 1 (list 1 2) (list 1 2 3))
 (list 1 (cons 1 (cons 2 '())) (cons 1 (cons 2 (cons 3 '())))))

(check-expect
 (cons "a" (list 0 #false))
 (list "a" 0 #false))

(check-expect
 (list (cons 1 (cons 13 '())))
 (list (list 1 13)))

(check-expect
 (cons (list 1 (list 13 '())) '())
 (list (list 1 (list 13 '()))))

(check-expect
 (list '() '() (cons 1 '()))
 (list '() '() (list 1)))

(check-expect
 (cons "a" (cons (list 1) (list #false '())))
 (list "a" (list 1) #false '()))

(check-expect
 (list (string=? "a" "b") #false)
 (list #false #false))

(check-expect
 (list (+ 10 20) (* 10 20) (/ 10 20))
 (list 30 200 1/2))

(check-expect
 (list "dana" "jane" "mary" "laura")
 (list "dana" "jane" "mary" "laura"))

(check-expect
 (first (list 1 2 3))
 1)

(check-expect
 (rest (list 1 2 3))
 (list 2 3))

(check-expect
 (second (list 1 2 3))
 2)

(check-expect
 (third (list 1 2 3))
 3)

(check-expect
 (fourth (list 1 2 3 4))
 4)