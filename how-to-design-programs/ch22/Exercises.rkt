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

(check-expect
 (bulletize (text "one" SIZE 'black))
 (beside/align 'center BT (text "one" SIZE 'black)))

(check-expect
 (render-item '(li (word ((text "one")))))
 (beside/align 'center BT (text "one" SIZE 'black)))

(check-expect
 (render-enum '(ul (li (word ((text "one"))))))
 (bulletize (text "one" SIZE 'black)))

(check-expect
 (render-enum '(ul
                (li (word ((text "one"))))
                (li (word ((text "two"))))
                (li (word ((text "three"))))))
 (above/align 'left (bulletize (text "one" SIZE 'black))
              (above/align 'left (bulletize (text "two" SIZE 'black))
                           (above/align 'left (bulletize (text "three" SIZE 'black)) empty-image))))

(check-expect
 (render-enum '(ul
                (li (word ((text "one"))))
                (li (word ((text "two"))))
                (li (ul
                 (li (word ((text "a"))))
                 (li (word ((text "b"))))))))
 (above/align 'left (bulletize (text "one" SIZE 'black))
              (above/align 'left (bulletize (text "two" SIZE 'black))
                           (bulletize (above/align 'left (bulletize (text "a" SIZE 'black))
                                                   (above/align 'left (bulletize (text "b" SIZE 'black)) empty-image))))))

 ; skipped 374 - 378

(require 2htdp/universe)
(require 2htdp/image)

; Figure 129

; An FSM is a [List-of 1Transition]
; A 1Transition is a list of two items:
;   (cons FSM-State (cons FSM-State '()))
; An FSM-State is a String that specifies a color
 
; data examples 
(define fsm-traffic
  '(("red" "green") ("green" "yellow") ("yellow" "red")))
 
; FSM FSM-State -> FSM-State 
; matches the keys pressed by a player with the given FSM 
(define (simulate state0 transitions)
  (big-bang state0 ; FSM-State
    [to-draw
      (lambda (current)
        (square 100 "solid" current))]
    [on-key
      (lambda (current key-event)
        (find transitions current))]))
 
; [X Y] [List-of [List X Y]] X -> Y
; finds the matching Y for the given X in alist
(define (find alist x)
  (local ((define fm (assoc x alist)))
    (if (cons? fm) (second fm) (error "not found"))))

(check-error (find '(("nothing" "here")) "anything") "not found")

(check-expect (find '(("something" "value")) "something") "value")
(check-expect (find '(("not here" "wrong") ("here" "value") ("not here either" "wrong")) "here") "value")

; skipped 380 - 381

; Figure 130

(define xm0
  '(machine ((initial "red"))
     (action ((state "red") (next "green")))
     (action ((state "green") (next "yellow")))
     (action ((state "yellow") (next "red")))))

; XMachine -> FSM-State 
; interprets the given configuration as a state machine 
(define (simulate-xmachine xm)
  (simulate (xm-state0 xm) (xm->transitions xm)))
 
; XMachine -> FSM-State 
; extracts and translates the transition table from xm0
 
(check-expect (xm-state0 xm0) "red")
 
(define (xm-state0 xm0)
  (find-attr (xexpr-attr xm0) 'initial))

(check-expect (find-attr '() 'something) #false)
(check-expect (find-attr '((not-here nothin) (here value)) 'here) 'value)

(define (find-attr l s)
  (cond
   [(empty? l) #false]
   [else (if (equal? (first (first l)) s)
             (second (first l))
             (find-attr (rest l) s))]))
 
; XMachine -> [List-of 1Transition]
; extracts the transition table from xm
 
(check-expect (xm->transitions xm0) fsm-traffic)
 
(define (xm->transitions xm)
  (local (; X1T -> 1Transition
          (define (xaction->action xa)
            (list (find-attr (xexpr-attr xa) 'state)
                  (find-attr (xexpr-attr xa) 'next))))
    (map xaction->action (xexpr-content xm))))

(define bw
  '(machine ((initial "black"))
     (action ((state "black") (next "white")))
     (action ((state "white") (next "black")))))

(check-expect (xm-state0 bw) "black")

(check-expect (xm->transitions bw)
              '(("black" "white") ("white" "black")))