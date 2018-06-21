;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; did 116 - 120 in head

(check-expect (+ 1 18)
              (+ (* (/ 12 8) 2/3)
                 (- 20 (sqrt 4))))

(check-expect #false
              (cond
                [(= 0 0) #false]
                [(> 0 1) (string=? "a" "a")]
                [else (= (/  1 0) 9)]))

(check-expect #true
              (cond
                [(= 2 0) #false]
                [(> 2 1) (string=? "a" "a")]
                [else (= (/  1 2) 9)]))

(define (f x y)
  (+ (* 3 x) (* y y)))

(check-expect (+ 7 7)
              (+ (f 1 2) (f 2 1)))

(check-expect (+ 3 36)
              (f 1 (* 2 3)))

(check-expect (f 39 19)
              (f (f 1 (* 2 3)) 19))

(check-expect (if #true "then" "else")
              (cond
                [#true "then"]
                [else "else"]))

(check-expect (if #false "then" "else")
              (cond
                [#false "then"]
                [else "else"]))

; did 124 in head

