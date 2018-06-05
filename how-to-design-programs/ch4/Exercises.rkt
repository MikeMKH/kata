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

; skipped 53

(check-expect (not #false) #true)

(require 2htdp/image)

(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define YDELTA 3)
 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
 
(define CENTER (/ (image-height ROCKET) 2))

(define (place-rocket position)
  (place-image ROCKET (- position CENTER) BACKG))

; skipped 56 and 57

(check-expect (sales-tax 0) 0)
(check-expect (sales-tax 999) 0)
(check-expect (sales-tax 1000) (* 0.05 1000))
(check-expect (sales-tax 9999) (* 0.05 9999))
(check-expect (sales-tax 10000) (* 0.08 10000))
(check-expect (sales-tax 10001) (* 0.08 10001))

(define (sales-tax p)
  (cond
    [(and (<= 0 p)
          (< p 1000)) 0]
    [(and (<= 1000 p)
          (< p 10000)) (* 0.05 p)]
    [(>= p 10000) (* 0.08 p)]))

; I am not sure if BSL supports lambda :(

(check-expect (tl-next "red") "green")
(check-expect (tl-next "green") "yellow")
(check-expect (tl-next "yellow") "red")
(check-expect (tl-next (tl-next (tl-next "red"))) "red")

(define (tl-next cs)
  (cond
    [(string=? "red" cs) "green"]
    [(string=? "green" cs) "yellow"]
    [(string=? "yellow" cs) "red"]))

; 60, no since 0-2 have no meaning in the problem domain

; 61, tl-symbolic since modulo is not part of the problem domain

(define LOCKED "locked")
(define CLOSED "closed")
(define OPEN   "open")

(check-expect (door-closer LOCKED) LOCKED)
(check-expect (door-closer CLOSED) CLOSED)
(check-expect (door-closer OPEN)   CLOSED)

(define (door-closer ds)
  (cond
    [(string=? OPEN ds) CLOSED]
    [else ds]))

(define UNLOCK "u")
(define LOCK   "l")
(define PUSH   " ")

(check-expect (door-action LOCKED UNLOCK) CLOSED)
(check-expect (door-action CLOSED LOCK)   LOCKED)
(check-expect (door-action CLOSED PUSH)   OPEN)
(check-expect (door-action OPEN   UNLOCK) OPEN)

(define (door-action ds act)
  (cond
    [(and (string=? LOCKED ds)
          (string=? UNLOCK act)) CLOSED]
    [(and (string=? CLOSED ds)
          (string=? LOCK act)) LOCKED]
    [(and (string=? CLOSED ds)
          (string=? PUSH act)) OPEN]
    [(string=? OPEN ds) OPEN]))