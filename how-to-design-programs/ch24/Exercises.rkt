;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; N Number N -> Inex
; makes an instance of Inex after checking the arguments
(define (create-inex m s e)
  (cond
    [(and (<= 0 m 99) (<= 0 e 99) (or (= s 1) (= s -1)))
     (make-inex m s e)]
    [else (error "bad values given")]))
 
; Inex -> Number
; converts an inex into its numeric equivalent 
(define (inex->number an-inex)
  (* (inex-mantissa an-inex)
     (expt
       10 (* (inex-sign an-inex) (inex-exponent an-inex)))))

(define-struct inex [mantissa sign exponent])
; An Inex is a structure: 
;   (make-inex N99 S N99)
; An S is one of:
; – 1
; – -1
; An N99 is an N between 0 and 99 (inclusive).

(check-expect
 (inex+ (create-inex 2 1 0)
        (create-inex 2 1 0))
 (create-inex 4 1 0))

(check-expect
 (inex+ (create-inex 4 1 1)
        (create-inex 1 1 1))
 (create-inex 5 1 1))

(check-expect
 (inex+ (create-inex 55 1 0)
        (create-inex 55 1 0))
 (create-inex 11 1 1))

(check-expect
 (inex+ (create-inex 56 -1 0)
        (create-inex 56 -1 0))
 (create-inex 11 -1 1))

(check-expect
 (inex+ (create-inex 11 -1 99)
        (create-inex 11 -1 99))
 (create-inex 22 -1 99))

(check-error
 (inex+ (create-inex 56 1 99)
        (create-inex 56 1 99))
 "overflow")

; lots missing
(define (inex+ a b)
  (local (
          (define man-a (inex-mantissa a))
          (define man-b (inex-mantissa b))
          (define sign (inex-sign a))
          (define exp-a (inex-exponent a))
          (define exp-b (inex-exponent b))
          (define exp (if (< exp-a exp-b)
                          exp-b exp-a))
          (define sum (+ man-a man-b)))
    (cond
      [(and (> sum 99)
            (= exp 99))
       (error "overflow")]
      [(> sum 99)
       (create-inex
        (quotient sum 10)
        sign
        (add1 exp))]
      [else
       (create-inex sum sign exp)])))