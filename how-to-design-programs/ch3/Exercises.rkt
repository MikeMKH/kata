;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect (string-first "hello") "h")
(check-expect (string-first "a") "a")

(define (string-first s)
  (substring s 0 1))

(check-expect (string-last "hello") "o")
(check-expect (string-last "a") "a")

(define (string-last s)
  (substring s (sub1 (string-length s))))

; skipped 36

(check-expect (string-rest "hello") "ello")
(check-expect (string-rest "a") "")

(define (string-rest s)
  (substring s 1))

(check-expect (string-remove-last "hello") "hell")
(check-expect (string-remove-last "a") "")

(define (string-remove-last s)
  (substring s 0 (sub1 (string-length s))))

; skipped 39

(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

(define (tock ws)
  (+ ws 3))

; skipped 41 and 42

(check-expect (tick 20) 21)
(check-expect (tick (tick 78)) 80)

(define (tick as)
  (add1 as))

; done? 44

; skipped 45 and 46

(check-expect (guage-tick 0) 0)
(check-expect (guage-tick 0.1) 0)
(check-expect (guage-tick 42.1) 42.0)

(define (guage-floor ws dec)
  (cond [(<= (- ws dec) 0) 0]
        [else (- ws dec)]))  

(define (guage-tick ws)
  (guage-floor ws 0.1))

(check-expect (guage-pet 0) 1/5)
(check-expect (guage-pet 1) 6/5)
(check-expect (guage-pet 100) 100)

(define (guage-ceiling ws inc)
  (cond [(>= (+ ws inc) 100) 100]
        [else (+ ws inc)]))  

(define (guage-pet ws)
  (guage-ceiling ws 1/5))

(check-expect (guage-feed 0) 1/3)
(check-expect (guage-feed 1) 4/3)
(check-expect (guage-feed 100) 100)

(define (guage-feed ws)
  (guage-ceiling ws 1/3))