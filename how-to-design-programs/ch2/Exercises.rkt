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