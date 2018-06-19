;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; skipped 94 - 102

(define-struct spider [legs space])
(define-struct elephant [space])
(define-struct boa [length girth space])
(define-struct armadillo [space])

(check-expect (spider-space (make-spider 8 1)) 1)
(check-expect (elephant-space (make-elephant 100)) 100)
(check-expect (boa-space (make-boa 10 2 20)) 20)
(check-expect (armadillo-space (make-armadillo 5)) 5)

(check-expect (fits? (make-spider 8 1) 1) #true)
(check-expect (fits? (make-spider 8 1) 2) #true)
(check-expect (fits? (make-spider 8 2) 1) #false)
(check-expect (fits? (make-elephant 50) 25) #false)
(check-expect (fits? (make-boa 3 1 3) 3) #true)
(check-expect (fits? (make-armadillo 3) 5) #true)

(define (fits? animal cage)
  (cond
    [(spider? animal) (<= (spider-space animal) cage)]
    [(elephant? animal) (<= (elephant-space animal) cage)]
    [(boa? animal) (<= (boa-space animal) cage)]
    [(armadillo? animal) (<= (armadillo-space animal) cage)]))

(define-struct vehicle [passengers plate mpg])

(check-expect (vehicle-passengers (make-vehicle 5 "ZHZ 100" 25.3)) 5)

(check-expect (vehicle-fits? (make-vehicle 5 "ZHZ 200" 25.0) 6) #false)
(check-expect (vehicle-fits? (make-vehicle 5 "ZHZ 200" 25.0) 5) #true)
(check-expect (vehicle-fits? (make-vehicle 5 "ZHZ 200" 25.0) 4) #true)

(define (vehicle-fits? vehicle people)
  (>= (vehicle-passengers vehicle) people))

(define-struct coordinate [upper lower])

(check-expect (posn-x (coordinate-upper (make-coordinate (make-posn 10 0) (make-posn 20 0)))) 10)
(check-expect (posn-y (coordinate-upper (make-coordinate (make-posn 0 10) (make-posn 0 20)))) 10)
(check-expect (posn-x (coordinate-lower (make-coordinate (make-posn 10 0) (make-posn 20 0)))) 20)
(check-expect (posn-y (coordinate-lower (make-coordinate (make-posn 0 10) (make-posn 0 20)))) 20)

; skipped 106 - 107

(define-struct cross-state [person count])

(check-expect (cross-state-person (make-cross-state "stop" 0)) "stop")
(check-expect (cross-state-person (make-cross-state "go" 0)) "go")
(check-expect (cross-state-person (make-cross-state "counter" 10)) "counter")
(check-expect (cross-state-count (make-cross-state "counter" 10)) 10)

(check-expect (next-state (make-cross-state "stop" 0)) (make-cross-state "go" 0))
(check-expect (next-state (make-cross-state "go" 0)) (make-cross-state "count" 10))
(check-expect (next-state (make-cross-state "counter" 0)) (make-cross-state "stop" 0))
(check-expect (next-state (make-cross-state "counter" 10)) (make-cross-state "counter" 9))

(define (next-state state)
  (cond
    [(string=? (cross-state-person state) "stop") (make-cross-state "go" 0)]
    [(string=? (cross-state-person state) "go") (make-cross-state "count" 10)]
    [(and
      (string=? (cross-state-person state) "counter")
      (= (cross-state-count state) 0)) (make-cross-state "stop" 0)]
    [(string=? (cross-state-person state) "counter") (cross-state-sub1 state)]))

(define (cross-state-sub1 state)
  (make-cross-state
   "counter"
   (sub1 (cross-state-count state))))

(check-error (checked-area-of-disk "one") "area-of-disk: positive number expected")
(check-error (checked-area-of-disk -1) "area-of-disk: positive number expected")
(check-expect (checked-area-of-disk 0) 0.0)
(check-expect (checked-area-of-disk 1) 3.14)
(check-expect (checked-area-of-disk 2) (* 3.14 2 2))

(define (checked-area-of-disk r)
  (cond
    [(and
      (number? r)
      (>= r 0)) (* 3.14 r r)]
    [else (error "area-of-disk: positive number expected")]))

(define-struct vec [x y])

(check-error (checked-make-vec 2 "two") "make-vec: positive number expected")
(check-error (checked-make-vec "two" 2) "make-vec: positive number expected")
(check-error (checked-make-vec "two" "two") "make-vec: positive number expected")
(check-error (checked-make-vec 2 -2) "make-vec: positive number expected")
(check-error (checked-make-vec -2 2) "make-vec: positive number expected")
(check-error (checked-make-vec -2 -2) "make-vec: positive number expected")
(check-expect (checked-make-vec 2 2) (make-vec 2 2))

(define (checked-make-vec x y)
  (cond
    [(and
      (number? x) (number? y)
      (>= x 0) (>= y 0)) (make-vec x y)]
    [else (error "make-vec: positive number expected")]))

(check-expect (missile-or-not? #false) #true)
(check-expect (missile-or-not? (make-posn 1 2)) #true)
(check-expect (missile-or-not? #true) #false)
(check-expect (missile-or-not? "nope") #false)

(define (missile-or-not? v)
  (cond
    [(or
      (false? v)
      (posn? v)) #true]
    [else #false]))

; skipped 113