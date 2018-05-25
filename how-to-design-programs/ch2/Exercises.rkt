;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (distance-to-origin x y)
  (sqrt (+ (sqr x) (sqr y))))

(define (cvolume length)
  (* length length length))

(define (string-first str)
  (string-ith str 0))

(define (string-last str)
  (string-ith str
              (sub1 (string-length str))))

(define (==> premise conclusion)
  (or (not premise) conclusion))

; skipped 16 and 17

(define (string-join s1 s2)
  (string-append s1 "_" s2))

(define (string-insert str i)
  (string-append
   (substring str 0 i)
   "_"
   (substring str (add1 i))))

(define (string-delete str i)
  (string-append
   (substring str 0 i)
   (substring str (add1 i))))

(define (ff x) (* 10 x))

(ff (ff 1))
(+ (ff 1) (ff 1))

(distance-to-origin 3 4)

(==> #true #false)

(string-insert "helloworld" 6)

(define BASE-ATTENDACE 120)
(define BASE-TICKET-PRICE 5.0)
(define AVG-ATTENDACE-CHG (/ 15 0.1))
(define BASE-PERFORMANCE-COST 180)
;(define AVG-COST-PER-ATTENDEE 0.04)
(define AVG-COST-PER-ATTENDEE 1.5)

(define (attendees ticket-price)
  (- BASE-ATTENDACE (* (- ticket-price BASE-TICKET-PRICE) AVG-ATTENDACE-CHG)))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
;  (+ BASE-PERFORMANCE-COST (* AVG-COST-PER-ATTENDEE (attendees ticket-price))))
  (* AVG-COST-PER-ATTENDEE (attendees ticket-price)))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

; not sure how to do map with BSL
(profit 1)
(profit 2)
(profit 3)
(profit 4)
(profit 5)

; skipped 31 and 32 ;)