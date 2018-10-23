;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
 (require 2htdp/image)

(define SMALL 8)
(define small-triangle (triangle SMALL "outline" "red"))

(check-expect (sierpinski SMALL)
              small-triangle)
(check-expect (sierpinski (* 2 SMALL))
              (above small-triangle
                     (beside small-triangle small-triangle)))

(define (sierpinski side)
  (cond
    [(<= side SMALL) small-triangle]
    [else
     (local ((define half (sierpinski (/ side 2))))
       (above half
              (beside half half)))]))

(check-expect (poly 2) 0)
(check-expect (poly 4) 0)

(define (poly x)
  (* (- x 2) (- x 4)))

(define (create-check f)
  (lambda (x)
    (<= (abs (f x) ) 0.5)))

(define ε 0.1)

; [Number -> Number] Number Number -> Number
; determines R such that f has a root in [R,(+ R ε)]
; assume f is continuous 
; assume (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; generative divides interval in half, the root is in one of the two
; halves, picks according to assumption 
(define (find-root f left right)
  (local ((define (helper f left right f@left f@right)
            (cond
              [(<= (- right left) ε) left]
              [else
                (local ((define mid (/ (+ left right) 2))
                        (define f@mid (f mid)))
                  (cond
                    [(or (<= f@left 0 f@mid) (<= f@mid 0 f@left))
                     (helper f left mid f@left f@mid)]
                    [(or (<= f@mid 0 f@right) (<= f@right 0 f@mid))
                     (helper f mid right f@mid f@right)]))])))
    (helper f left right (f left) (f right))))

(check-satisfied (find-root poly 0 3) (create-check poly))
(check-satisfied (find-root poly 3 5) (create-check poly))

; skipped 450 - 451