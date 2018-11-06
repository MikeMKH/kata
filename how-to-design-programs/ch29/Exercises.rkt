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

; skipped 473 - 478

(define (threatening? qp1 qp2)
  (local ((define x1 (posn-x qp1))
          (define y1 (posn-y qp1))
          (define x2 (posn-x qp2))
          (define y2 (posn-y qp2)))
    (or
     (= x1 x2)
     (= y1 y2)
     (= (abs (- x1 x2))
        (abs (- y1 y2))))))

(check-expect (threatening? (make-posn 1 1) (make-posn 1 2)) #true)
(check-expect (threatening? (make-posn 1 1) (make-posn 2 1)) #true)
(check-expect (threatening? (make-posn 1 1) (make-posn 2 2)) #true)
(check-expect (threatening? (make-posn 3 3) (make-posn 2 2)) #true)
(check-expect (threatening? (make-posn 1 1) (make-posn 2 4)) #false)

; skipped 480

(define (n-queens-solution? n)
  (local ((define (not-threatening? lop)
            (cond
              [(or (empty? lop)
                   (empty? (rest lop))) #true]
              [else
               (and (andmap
                     (lambda (q)
                       (not (threatening? (first lop) q)))
                       (rest lop))
                    (not-threatening? (rest lop)))])))
    (lambda (solution)
      (and (= n (length solution))
           (not-threatening? solution)))))

(check-expect #true
              ((n-queens-solution? 4)
               (list (make-posn 0 1)
                     (make-posn 1 3)
                     (make-posn 2 0)
                     (make-posn 3 2))))

(check-expect #false
              ((n-queens-solution? 4)
               (list (make-posn 0 1)
                     (make-posn 1 3)
                     (make-posn 3 0)
                     (make-posn 3 2))))

(check-expect #false
              ((n-queens-solution? 4)
               (list (make-posn 0 1)
                     (make-posn 1 2)
                     (make-posn 2 0)
                     (make-posn 3 2))))

(check-expect #false
              ((n-queens-solution? 4)
               (list (make-posn 0 1)
                     (make-posn 1 3)
                     (make-posn 2 0)
                     (make-posn 2 1))))

; skipped 482 - 483