;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect (reward 10) "bronze")
(check-expect (reward 18) "silver")
(check-expect (reward 21) "gold")

(define (reward n)
  (cond
    [(<= 0 n 10) "bronze"]
    [(and (< 10 n)
          (<= n 20) )"silver"]
    [else "gold"]))

(check-expect (ex49 100) 100)
(check-expect (ex49 210) 200)

(define (ex49 n)
  (- 200 (cond
           [(> n 200) 0]
           [else n])))

(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")
(check-expect (traffic-light-next
               (traffic-light-next
                (traffic-light-next "red"))) "red")

(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

; skipped 51, but red

; [3, 5] = 3, 4, 5
; (3, 5] = 4, 5
; [3, 5) = 3, 4
; (3, 5) = 4

