;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define sample-graph
  '((A (B E))
    (B (E F))
    (C (D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))

(check-expect (neighbors 'A '()) '())
(check-expect (neighbors 'A '((A (B C)))) '(B C))
(check-expect (neighbors 'B '((A (B C)))) '())
(check-expect (neighbors 'B '((A (B C)) (B (E F)))) '(E F))
(check-expect (neighbors 'G sample-graph) '())

(define (neighbors node graph)
  (local ((define (process-graph lon)
            (cond
              [(empty? lon) '()]
              [else
               (if (symbol=? (first (first lon)) node)
                   (append (rest (first lon)) (process-graph (rest lon)))
                   (process-graph (rest lon)))])))
    (cond
    [(empty? graph) '()]
    [else
     (foldl append '() (process-graph graph))])))

; Figure 169

; Node Node Graph -> [Maybe Path]
; finds a path from origination to destination in G
; if there is no path, the function produces #false
(define (find-path origination destination G)
  (cond
    [(symbol=? origination destination) (list destination)]
    [else (local ((define next (neighbors origination G))
                  (define candidate
                    (find-path/list next destination G)))
            (cond
              [(boolean? candidate) #false]
              [else (cons origination candidate)]))]))
 
; [List-of Node] Node Graph -> [Maybe Path]
; finds a path from some node on lo-Os to D
; if there is no path, the function produces #false
(define (find-path/list lo-Os D G)
  (cond
    [(empty? lo-Os) #false]
    [else (local ((define candidate
                    (find-path (first lo-Os) D G)))
            (cond
              [(boolean? candidate)
               (find-path/list (rest lo-Os) D G)]
              [else candidate]))]))

(check-expect (find-path 'A 'G sample-graph) '(A B E F G))

; skipped 473

; TODO 474 - 475