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

; skipped 332 - 338

(require htdp/dir)

(define ch20
  (make-dir '/Users/m/K/htdp/ch20 '()
           (list
            (make-file "#Exercises.rkt#1#" 13219 (make-date 2018 9 7 6 13 35) "")
            (make-file "Exercises.rkt" 1189 (make-date 2018 9 6 6 44 36) "")
            (make-file "Exercises.rkt~" 0 (make-date 2018 9 6 6 13 28) ""))))

(define test
  (make-dir '/Users/mike/Kata/htdp/ch20/test
            (list
             (make-dir '/Users/mike/Kata/htdp/ch20/test/another
                       (list
                        (make-dir '/Users/mike/Kata/htdp/ch20/test/another/level '()
                                  (list (make-file "something.else" 0 (make-date 2018 9 7 6 26 49) ""))))
                       (list (make-file "find.name" 0 (make-date 2018 9 7 6 26 37) ""))))
            '()))

(check-expect #false
              (find? (make-dir '/Users/empty '() '()) "file.name"))
(check-expect #true
              (find? (make-dir '/Users/empty '() (list (make-file "file.name" 0 (make-date 2018 9 6 6 13 28) ""))) "file.name"))
(check-expect #true
              (find? ch20 "Exercises.rkt"))
(check-expect #true
              (find? test "find.name"))
(check-expect #false
              (find? test "missing.file"))

(define (find? dir name)
  (cond
    [(empty? dir) #false]
    [else (or
      (ormap (lambda (file) (string=? (file-name file) name)) (dir-files dir))
      (ormap (lambda (dir1) (find? dir1 name)) (dir-dirs dir)))]))

; skipped 340 - 344 :(