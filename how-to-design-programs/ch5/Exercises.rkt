;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect (distance-to-0 (make-posn 3 4)) 5)
(check-expect (distance-to-0 (make-posn 6 (* 2 4))) 10)
(check-expect (+ (distance-to-0 (make-posn 12 5)) 10) 23)

(define (distance-to-0 pt)
  (sqrt
   (+
    (sqr (posn-x pt))
    (sqr (posn-y pt)))))

(check-expect (manhattan-distance-to-0 (make-posn 3 4)) 7)

(define (manhattan-distance-to-0 pt)
  (+ (posn-x pt) (posn-y pt)))

(check-expect (movie-title (make-movie "Star Wars" "Gary Kurtz" 1977)) "Star Wars")
(check-expect (person-name (make-person "Mike Harris" "black" "brown" "@MikeMKH")) "Mike Harris")
(check-expect (pet? (make-pet "Jack" "canine")) #true)
(check-expect (pet? (make-movie "千と千尋の神隠し" "Toshio Suzuki" 2001)) #false)
(check-expect (album-artist (make-album "Dance Gavin Dance" "Mothership" 2016)) "Dance Gavin Dance")
(check-expect (sweater-size (make-sweater "cotton" "M" "Old Navy")) "M")

(define-struct movie [title producer year])
(define-struct person [name hair eyes twitter-handle])
(define-struct pet [name type])
(define-struct album [artist title year])
(define-struct sweater [material size producer])

(check-expect (balld-speed (make-balld 10 "UP" 3)) 3)

(define-struct balld [location direction speed])

(check-expect (ballf-deltax (make-ballf 30 40 -10 5)) -10)

(define-struct ballf [x y deltax deltay])

; skipped 69


(define-struct centry [name home office cell])
(define-struct phone [area number])

(define m
  (make-centry
  "Mike"
  (make-phone "111" "111-1111")
  (make-phone "222" "222-2222")
  (make-phone "333" "333-3333")))

(check-expect (phone-area (centry-home m)) "111")
(check-expect (phone-area (centry-office m)) "222")

(define HEIGHT 200)
(define MIDDLE (quotient HEIGHT 2))
(define WIDTH  400)
(define CENTER (quotient WIDTH 2))
 
(define-struct game [left-player right-player ball])
 
(define game0
  (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))

(check-expect (game-ball game0) (make-posn CENTER CENTER))
(check-expect (posn? (game-ball game0)) #true)
(check-expect (game-left-player game0) MIDDLE)

(define-struct phone# [area switch number])

(check-expect (phone#-area (make-phone# "111" "222" "3333")) "111")
(check-expect (phone#-switch (make-phone# "111" "222" "3333")) "222")
(check-expect (phone#-number (make-phone# "111" "222" "3333")) "3333")
(check-expect (phone#-number (make-phone# "I" "am" "coder")) "coder")

(check-expect (posn-update-x (make-posn 1 10) 20) (make-posn 20 10))

(define (posn-update-x p x)
  (make-posn x (posn-y p)))

; skipped 74

(check-expect (posn+ (make-posn 1 1) (make-posn 10 10)) (make-posn 11 11))
(check-expect (posn+ (make-posn 1 0) (make-posn 1 0)) (make-posn 2 0))
(check-expect (posn+ (make-posn 0 1) (make-posn 0 1)) (make-posn 0 2))
(check-expect (posn+ (make-posn 1 0) (make-posn 0 1)) (make-posn 1 1))
(check-expect (posn+ (make-posn 0 1) (make-posn 1 0)) (make-posn 1 1))

(define (posn+ p1 p2)
  (make-posn
   (+ (posn-x p1) (posn-x p2))
   (+ (posn-y p1) (posn-y p2))))

(define-struct vel [deltax deltay])

(check-expect (vposn+ (make-posn 1 2) (make-vel 10 20)) (make-posn 11 22))

(define (vposn+ p v)
  (make-posn
   (+ (posn-x p) (vel-deltax v))
   (+ (posn-y p) (vel-deltay v))))

; skipped 76

;(define-struct pt-time [Number[0-23] Number[0-59] Number[0-59]])
(define-struct pt-time [hours minutes seconds])

(check-expect (pt-time-hours (make-pt-time 21 34 56)) 21)
(check-expect (pt-time-minutes (make-pt-time 21 34 56)) 34)
(check-expect (pt-time-seconds (make-pt-time 21 34 56)) 56)

(define-struct word3 [letter1 letter2 letter3])

(check-expect (word3-letter1 (make-word3 "a" #false "e")) "a")
(check-expect (word3-letter2 (make-word3 "a" #false "e")) #false)
(check-expect (word3-letter3 (make-word3 "a" #false "e")) "e")

; skipped 79