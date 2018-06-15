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

; todo 105