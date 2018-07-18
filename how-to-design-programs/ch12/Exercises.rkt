;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)

(define LOCATION "/usr/share/dict/words")
(define AS-LIST (read-lines LOCATION))

(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

(check-expect (starts-with# "a" '()) 0)
(check-expect (starts-with# "a" (list "b")) 0)
(check-expect (starts-with# "a" (list "a")) 1)
(check-expect (starts-with# "a" (list "a" "b")) 1)
(check-expect (starts-with# "a" (list "a" "aa" "ant" "bad" "bat")) 3)

(define (starts-with# letter dictionary)
  (cond
    [(empty? dictionary) 0]
    [(cons? dictionary)
     (+
       (if (string=? letter (substring (first dictionary) 0 1)) 1 0)
      (starts-with# letter (rest dictionary)))]))

; (starts-with# "e" AS-LIST)
; 7818

; (starts-with# "z" AS-LIST)
; 719

(define-struct letter-count [letter count])

(check-expect (count-by-letter '())
              (list (make-letter-count "a" 0)
                    (make-letter-count "b" 0)
                    (make-letter-count "c" 0)
                    (make-letter-count "d" 0)
                    (make-letter-count "e" 0)
                    (make-letter-count "f" 0)
                    (make-letter-count "g" 0)
                    (make-letter-count "h" 0)
                    (make-letter-count "i" 0)
                    (make-letter-count "j" 0)
                    (make-letter-count "k" 0)
                    (make-letter-count "l" 0)
                    (make-letter-count "m" 0)
                    (make-letter-count "n" 0)
                    (make-letter-count "o" 0)
                    (make-letter-count "p" 0)
                    (make-letter-count "q" 0)
                    (make-letter-count "r" 0)
                    (make-letter-count "s" 0)
                    (make-letter-count "t" 0)
                    (make-letter-count "u" 0)
                    (make-letter-count "v" 0)
                    (make-letter-count "w" 0)
                    (make-letter-count "x" 0)
                    (make-letter-count "y" 0)
                    (make-letter-count "z" 0)))

(check-expect (count-by-letter (list "a" "aa" "b" "cat" "zoo"))
              (list (make-letter-count "a" 2)
                    (make-letter-count "b" 1)
                    (make-letter-count "c" 1)
                    (make-letter-count "d" 0)
                    (make-letter-count "e" 0)
                    (make-letter-count "f" 0)
                    (make-letter-count "g" 0)
                    (make-letter-count "h" 0)
                    (make-letter-count "i" 0)
                    (make-letter-count "j" 0)
                    (make-letter-count "k" 0)
                    (make-letter-count "l" 0)
                    (make-letter-count "m" 0)
                    (make-letter-count "n" 0)
                    (make-letter-count "o" 0)
                    (make-letter-count "p" 0)
                    (make-letter-count "q" 0)
                    (make-letter-count "r" 0)
                    (make-letter-count "s" 0)
                    (make-letter-count "t" 0)
                    (make-letter-count "u" 0)
                    (make-letter-count "v" 0)
                    (make-letter-count "w" 0)
                    (make-letter-count "x" 0)
                    (make-letter-count "y" 0)
                    (make-letter-count "z" 1)))

(define (count-by-list letters dictionary)
  (cond
    [(empty? letters) '()]
    [(cons? letters)
     (append '()
      (list (make-letter-count
       (first letters)
       (starts-with# (first letters) dictionary)))
      (count-by-list (rest letters) dictionary))]))

(define (count-by-letter dictionary)
  (count-by-list LETTERS dictionary))