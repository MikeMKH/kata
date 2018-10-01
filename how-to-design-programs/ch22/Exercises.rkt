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

(require 2htdp/universe)
(require 2htdp/image)
(require 2htdp/batch-io)
(require 2htdp/abstraction)

(define URL-PREFIX "https://www.google.com/search?q=")
(define FONT-SIZE 22) ; font size 
 
(define-struct data [price delta])
; A StockWorld is a structure: (make-data String String)
 
; String -> StockWorld
; retrieves the stock price of co and its change every 15s
(define (stock-alert co)
  (local ((define url (string-append URL-PREFIX co))
          ; [StockWorld -> StockWorld]
          (define (retrieve-stock-data __w)
            (local ((define x (read-xexpr/web url)))
              (make-data (get x "price")
                         (get x "priceChange"))))
          ; StockWorld -> Image 
          (define (render-stock-data w)
            (local (; [StockWorld -> String] -> Image
                    (define (word sel col)
                      (text (sel w) FONT-SIZE col)))
              (overlay (beside (word data-price 'black)
                               (text "  " FONT-SIZE 'white)
                               (word data-delta 'red))
                       (rectangle 300 35 'solid 'white)))))
    (big-bang (retrieve-stock-data 'no-use)
      [on-tick retrieve-stock-data 15]
      [to-draw render-stock-data])))

; Xexpr.v3 String -> String
; retrieves the value of the "content" attribute 
; from a 'meta element that has attribute "itemprop"
; with value s
(check-expect
  (get '(meta ((content "+1") (itemprop "F"))) "F")
  "+1")
 
(define (get x s)
  (local ((define result (get-xexpr x s)))
    (if (string? result)
        result
        (error "not found"))))

;; Xexpr.v3 String -> [Maybe String]
(define (get-xexpr x s)
  (local (;; Symbol [AL or Xexpr.v3] -> [Maybe String]
          (define (get-content-xexpr name al-or-xexpr)
            (if (and (equal? name 'meta)
                     (equal? s (find-attr al-or-xexpr 'itemprop)))
                (find-attr al-or-xexpr 'content)
                #false))

          ;; [AL or Xexpr.v3] XL-> [Maybe String]
          (define (get-from-rest al-or-xexpr xl)
            (if (list-of-attributes? al-or-xexpr)
                (get-xexpr-list xl s)
                (get-xexpr-list (cons al-or-xexpr xl s)))))
    (match x
      [(? symbol?) #false]
      [(? string?) #false]
      [(? number?) #false]
      [(cons symbol (cons al-or-xexpr xl))
       (local ((define potential-data (get-content-xexpr symbol al-or-xexpr)))
         (if (string? potential-data)
             potential-data
             (get-from-rest al-or-xexpr xl)))])))

;; XL String -> [Maybe String]
(define (get-xexpr-list xl s)
  (cond
   [(empty? xl) #false]
   [else (local ((define first-result (get-xexpr (first xl) s)))
           (if (string? first-result)
               first-result
               (get-xexpr-list (rest xl) s)))]))

; skipped 384 - 385

(check-expect
  (get '(meta ((content "+1") (itemprop "F"))) "F")
  "+1")

(check-error
  (get '(meta ((content "+1") (itemprop "F"))) "T")
  "not found")
