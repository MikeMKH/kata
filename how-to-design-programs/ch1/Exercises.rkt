;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define x 3)
(define y 4)

(define (sq x) (* x x))

(define (distance x y)
  (sqrt
   (+ (sq x) (sq y))))


(define prefix "hello")
(define suffix "world")

(define str (string-append prefix suffix))
(define ith 5)

(define (insert-at i ch s)
  (string-append
   (substring s 0 i)
   ch
   (substring s i)))

(define (remove-at i s)
  (string-append
   (substring s 0 i)
   (substring s (add1 i))))

; skipped 5 and 6

(define sunny #true)
(define friday #false)

(define (mall-day? sunny? friday?)
  (or
   (not sunny?)
   friday?))

; skipped 8

(require 2htdp/image)

(define (in x)
  (cond
    [(string? x) (string-length x)]
    [(image? x) (* (image-width x) (image-height x))]
    [(and (number? x) (> x 0)) (sub1 x)]
    [(boolean? x) (if x 10 20)]
    [else x]))

; skipped 10 ;)