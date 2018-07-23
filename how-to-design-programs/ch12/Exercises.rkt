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

; skipped 197 - 208

(check-expect (string->word "cat") (list "c" "a" "t"))

(define (string->word str) (explode str))

(check-expect (word->string (list "c" "a" "t")) "cat")
(check-expect (word->string (string->word "hello world")) "hello world")

(define (word->string word) (implode word))

(check-expect (words->strings '()) '())
(check-expect (words->strings (list '())) (list ""))
(check-expect (words->strings (list (string->word "hello") (string->word "world"))) (list "hello" "world"))

(define (words->strings ws)
  (cond
    [(empty? ws) '()]
    [(cons? ws)
     (cons (word->string (first ws)) (words->strings (rest ws)))]))

(check-expect (in-dictionary (list "words") '()) '())
(check-expect (in-dictionary (list "yes") (list "yes")) (list "yes"))
(check-expect (in-dictionary (list "yes") (list "no-zzz" "yes")) (list "yes"))
(check-expect (in-dictionary (list "hello" "world") (list "hello" "world")) (list "hello" "world"))
(check-expect (in-dictionary (list "maybe" "yes") (list "maybe" "no-zzz" "yes")) (list "maybe" "yes"))

(define (in-dictionary dictionary los)
  (cond
    [(empty? los) '()]
    [(cons? los)
     ; BSL does not have a when, so we need to remove unmatched
     (remove-all #false (cons
      (if (member? (first los) dictionary)
          (first los)
          #false)
      (in-dictionary dictionary (rest los))))]))

(check-expect
 (list (string->word "cat") (string->word "act"))
 (list (cons "c" (cons "a" (cons "t" '()))) (cons "a" (cons "c" (cons "t" '())))))

(check-expect
 (insert-everywhere/in-words "z" '())
 (string->word "z"))

(check-expect
 (insert-everywhere/in-words "z" (string->word "a"))
 (string->word "zaz"))

(check-expect
 (insert-everywhere/in-words "z" (string->word "ab"))
 (string->word "zazbz"))

(define (insert-everywhere/in-words letter word)
  (cond
    [(empty? word) (list letter)]
    [(cons? word)
     (cons letter
           (cons (first word)
                 (insert-everywhere/in-words letter (rest word))))]))

(check-expect
 (insert-everywhere/in-all-words "z" '()) '())

(check-expect
 (insert-everywhere/in-all-words "z" (list (string->word "cat")))
 (list (string->word "zczaztz")))

(check-expect
 (insert-everywhere/in-all-words "z" (list (string->word "cat") (string->word "act")))
 (list (string->word "zczaztz") (string->word "zazcztz")))

(define (insert-everywhere/in-all-words letter ws)
  (cond
    [(empty? ws) '()]
    [(cons? ws)
     (cons (insert-everywhere/in-words letter (first ws))
           (insert-everywhere/in-all-words letter (rest ws)))]))

; skipped 124 - 225

(define-struct transition [current next])

(check-expect (state=? "green" "red") #false)
(check-expect (state=? "green" "green") #true)
(check-expect (state=? "red" "red") #true)
(check-expect (state=? "yellow" "yellow") #true)
(check-expect (state=? "yellow" "green") #false)
(check-expect (state=? "yellow" 7) #false)

(define (state=? st1 st2)
  (cond
    [(and (string? st1) (string? st2))
      (string=? st1 st2)]
    [else #false]))

(check-expect (flip "black") "white")
(check-expect (flip "white") "black")
(check-expect (flip (flip "black")) "black")
(check-expect (flip (flip "white")) "white")

(define (flip bwsm)
  (cond
    [(string=? bwsm "black") "white"]
    [(string=? bwsm "white") "black"]))

; skipped 229

(define-struct fsm [initial trans final])
(define-struct trans [current key next])

; a(b|c)*d
(define fsm-abcd (make-fsm
               "a"
               (list
                (make-trans "a" "b" "b")
                (make-trans "b" "b" "b")
                (make-trans "b" "c" "b")
                (make-trans "b" "d" "d")
                )
               "d"))

(check-expect (find fsm-abcd "b") "b")
(check-expect (find fsm-abcd "c") "b")
(check-error (find fsm-abcd "z") "not found: z")

(define (find-transition transitions key)
  (cond
    [(empty? transitions) (error (string-append "not found: " key))]
    [else
     (if (string=? (trans-key (first transitions)) key)
         (trans-next (first transitions))
         (find-transition (rest transitions) key))]))

(define (find fsm key)
  (find-transition (fsm-trans fsm) key))