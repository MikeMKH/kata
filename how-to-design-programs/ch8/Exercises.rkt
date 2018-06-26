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

(check-expect (contains-flatt?
               (cons "Fagan"
                     (cons "Findler"
                           (cons "Fisler"
                                 (cons "Flanagan"
                                       (cons "Flatt"
                                             (cons "Felleisen"
                                                   (cons "Friedman" '()))))))))
               #true)

(check-expect (contains-flatt? '()) #false)

(define (contains-flatt? col)
  (cond
    [(empty? col) #false]
    [else (or
      (string=? (first col) "Flatt")
      (contains-flatt? (rest col)))]))

(check-expect (contains-flatt?2 (cons "Felleisen" (cons "Flatt" '()))) #true)
(check-expect (contains-flatt?2 '()) #false)

(define (contains-flatt?2 col)
  (cond
    [(empty? col) #false]
    [else (cond
            [(string=? (first col) "Flatt") #true]
            [else (contains-flatt?2 (rest col))])]))

(check-expect (contains? "Mike" (cons "Jack" (cons "Kelsey" '()))) #false)
(check-expect (contains? "2" (cons "1" (cons "2" (cons "3" '())))) #true)

(define (contains? s col)
  (cond
    [(empty? col) #false]
    [else (or
           (string=? s (first col))
           (contains? s (rest col)))]))

(check-expect
 (contains-flatt?
  (cons "Flatt" (cons "C" '()))) #true)

(check-expect
 (contains-flatt?
  (cons "A" (cons "Flatt" (cons "C" '())))) #true)

(check-expect
 (first (cons "a" '())) "a")

(check-expect
 (rest (cons "a" '())) '())