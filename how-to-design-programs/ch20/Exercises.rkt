;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; skipped 329

; A Dir.v1 (short for directory) is one of: 
; – '()
; – (cons File.v1 Dir.v1)
; – (cons Dir.v1 Dir.v1)
 
; A File.v1 is a String.

(define part1 "part1-99")
(define part2 "part2-52")
(define part3 "part3-17")
(define hang "hang-8")
(define draw "draw-2")
(define read1 "read!-10")
(define read2 "read!-19")
(define Text (list part1 part2 part3))
(define Code (list hang draw))
(define Docs (list read2))
(define Libs (list Code Docs))
(define TS (list Text read1 Libs))

(check-expect (how-many.v1 (cons "file" '())) 1)
(check-expect (how-many.v1 (list (cons "file" '()) (cons "file" '()))) 2)
(check-expect (how-many.v1 TS) 7)

(define file.v1? string?)

(define (how-many.v1 dir)
  (foldl (lambda (x count)
           (+ count (if (file.v1? x) 1 (how-many.v1 x))))
         0 dir))

; skipped 332 - 337