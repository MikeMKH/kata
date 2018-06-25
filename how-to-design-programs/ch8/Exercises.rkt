;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define solar-system
  (cons "Mercury"(cons "Venus" (cons "Earth" (cons "Mars" (cons "Jupiter" (cons "Saturn" (cons "Uranus" (cons "Neptune" '())))))))))

(check-expect (first solar-system) "Mercury")
(check-expect (first (rest solar-system)) "Venus")
(check-expect (first (rest (rest solar-system))) "Earth")
(check-expect (first (rest (rest (rest solar-system)))) "Mars")
(check-expect (first (rest (rest (rest (rest solar-system))))) "Jupiter")
(check-expect (first (rest (rest (rest (rest (rest solar-system)))))) "Saturn")
(check-expect (first (rest (rest (rest (rest (rest (rest solar-system))))))) "Uranus")
(check-expect (first (rest (rest (rest (rest (rest (rest (rest solar-system)))))))) "Neptune")
(check-expect (rest (rest (rest (rest (rest (rest (rest (rest solar-system)))))))) '())

(define meal
  (cons "steak"
        (cons "french fries"
              (cons "beans"
                    (cons "bread"
                          (cons "water"
                                (cons "Brie cheese"
                                      (cons "custard" '()))))))))

(check-expect (first (rest meal)) "french fries")

(define colors
  (cons "read" (cons "green" (cons "blue" '()))))

(check-expect (rest colors) (cons "green" (cons "blue" '())))

; skipped 130

; 131
; List-of-booleans
; - '()
; - (cons Boolean List-of-booleans)