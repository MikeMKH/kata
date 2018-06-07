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