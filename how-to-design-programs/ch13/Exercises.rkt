;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect '(1 "a" 2 #false 3 "c") (list 1 "a" 2 #false 3 "c"))
(check-expect '() (list))
(check-expect
 '(("alan" 1000)
  ("barb" 2000)
  ("carl" 1500))
 (list (list "alan" 1000)
       (list "barb" 2000)
       (list "carl" 1500)))

(check-expect
 '(1 "a" 2 #false 3 "c")
 (cons 1 (cons "a" (cons 2 (cons #false (cons 3 (cons "c" '())))))))
(check-expect
 '(("alan" 1000)
  ("barb" 2000)
  ("carl" 1500))
 (list (cons "alan" (cons 1000 '()))
       (cons "barb" (cons 2000 '()))
       (cons "carl" (cons 1500 '()))))

(check-expect
 `(1 "a" 2 #false 3 "c")
 (list 1 "a" 2 #false 3 "c"))
(check-expect
 `(("alan" ,(* 2 500))
  ("barb" 2000)
  (,(string-append "carl" " , the great") 1500)
  ("dawn" 2300))
 (list (list "alan" (* 2 500))
       (list "barb" 2000)
       (list (string-append "carl" " , the great") 1500)
       (list "dawn" 2300)))

; skipped 232, not sure how to use html et al

(check-expect
 `(0 ,@'(1 2 3) 4)
 (list 0 1 2 3 4))
(check-expect
 `(("alan" ,(* 2 500))
  ("barb" 2000)
  (,@'("carl" " , the great")   1500)
  ("dawn" 2300))
 (list (list "alan" (* 2 500))
       (list "barb" 2000)
       (list "carl" " , the great" 1500)
       (list "dawn" 2300)))

; skipped 234