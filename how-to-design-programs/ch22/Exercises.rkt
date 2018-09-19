;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; skipped 363

(define x364-1 '(transition ((from "seen-e") (to "seen-f"))))
(define x364-2 '(ul (li (word) (word)) (li (word))))

; skipped 365

(define a0 '((initial "X")))
 
(define e0 '(machine))
(define e1 `(machine ,a0))
(define e2 '(machine (action)))
(define e3 '(machine () (action)))
(define e4 `(machine ,a0 (action) (action)))

(check-expect (xexpr-attr e0) '())
(check-expect (xexpr-attr e1) '((initial "X")))
(check-expect (xexpr-attr e2) '())
(check-expect (xexpr-attr e3) '())
(check-expect (xexpr-attr e4) '((initial "X")))

; Figure 126
(define (xexpr-attr xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (local ((define loa-or-x
                 (first optional-loa+content)))
         (if (list-of-attributes? loa-or-x)
             loa-or-x
             '()))])))

(define (list-of-attributes? x)
  (cond
    [(empty? x) #true]
    [else
     (local ((define possible-attribute (first x)))
       (cons? possible-attribute))]))

(check-expect (xexpr-name e0) 'machine)
(check-expect (xexpr-name e1) 'machine)
(check-expect (xexpr-name e2) 'machine)
(check-expect (xexpr-name e3) 'machine)
(check-expect (xexpr-name e4) 'machine)

(check-error (xexpr-name '()) "xexpr-name: invalid xexpr")

(define (xexpr-name xe)
  (cond
    [(empty? xe) (error "xexpr-name: invalid xexpr")]
    [else (first xe)]))

(check-expect (xexpr-content e0) '())
(check-expect (xexpr-content e1) '())
(check-expect (xexpr-content e2) '((action)))
(check-expect (xexpr-content e3) '((action)))
(check-expect (xexpr-content e4) '((action) (action)))

(define (xexpr-content xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (local ((define loa-or-x
                 (first optional-loa+content)))
         (if (not (list-of-attributes? loa-or-x))
             optional-loa+content
             (rest optional-loa+content)))])))

; skipped 367 - 369

(check-expect (word? '(word ((text "a")))) #true)
(check-expect (word? '(word ((text "b")))) #true)
(check-expect (word? '(not-word ((text "a")))) #false)

(define (word? w)
  (and (cons? w)
       (equal? (first w) 'word)))

(check-expect (word-text '(word ((text "a")))) "a")
(check-expect (word-text '(word ((text "b")))) "b")

(define (word-text w)
  (second (first (second w))))

; skipped 371 - 372

(require 2htdp/image)

; Figure 128

(define SIZE 12) ; font size 
(define COLOR "black") ; font color 
(define BT ; a graphical constant 
  (beside (circle 1 'solid 'black) (text " " SIZE COLOR)))
 
; Image -> Image
; marks item with bullet  
(define (bulletize item)
  (beside/align 'center BT item))
 
; XEnum.v2 -> Image
; renders an XEnum.v2 as an image 
(define (render-enum xe)
  (local ((define content (xexpr-content xe))
          ; XItem.v2 Image -> Image 
          (define (deal-with-one item so-far)
            (above/align 'left (render-item item) so-far)))
    (foldr deal-with-one empty-image content)))
 
; XItem.v2 -> Image
; renders one XItem.v2 as an image 
(define (render-item an-item)
  (local ((define content (first (xexpr-content an-item))))
    (bulletize
      (cond
        [(word? content)
         (text (word-text content) SIZE 'black)]
        [else (render-enum content)]))))

(define u0
  '(ul
    (li (word ((text "one"))))
    (li (word ((text "two"))))))

(define u0-rendered
  (above/align
   'left
   (beside/align 'center BT (text "one" 12 'black))
   (beside/align 'center BT (text "two" 12 'black))))

(define u1
  '(ul
    (li (word ((text "one"))))
    (li (word ((text "two"))))
    (ul
     (li (word ((text "a"))))
     (li (word ((text "b"))))
     (ul
      (ul
       (li (word ((text "*"))))
       (li (word ((text "#")))))
      (li (word ((text "i"))))
      (li (word ((text "ii"))))
      ))))

(check-expect
 (bulletize (text "one" SIZE 'black))
 (beside/align 'center BT (text "one" SIZE 'black)))

; TODO render-enum and render-item