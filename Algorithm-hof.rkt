#lang racket
;;main program for A* algorithm
(require "Examples.rkt")
(require "graphics.rkt")
(require racket/mpair)
(provide (all-defined-out))

(define INF 99999)

;;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  ;Auxiliary functions
;ROW and COL are from graphics.rkt
(define (isValid row col)
  (and (>= row 0) (>= col 0) (< row ROW) (< col COL)))

(define (2d-vector-ref vec r c)
  (vector-ref (vector-ref vec r) c))

(define (isUnblocked grid row col)
  (>= (2d-vector-ref grid row col) 1)) ;;cell is unblocked when greater than or equal to 1, not 0

(define (isDestination row col dest);dest = (i-col, j-row)
  (and (= row (cdr dest)) (= col (car dest))))

(define (calculateHValue row col dest);dest = (i-col, j-row)
  (let ([x (- (cdr dest) row)]
        [y (- (car dest) col)])
    (sqrt (+ (* x x) (* y y)))))

;goto (i j) coordinates of vec
(define (vec-ref vec r c)
  (vector-ref (vector-ref vec r) c))

;set vec
(define (vec-set! vec r c val)
  (vector-set! (vector-ref vec r) c val))

;;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
;cell attributes except - i , j
(struct cell (p_i p_j g h f ) #:transparent #:mutable)

(define PATH '())

;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--main hof algorithm

(define (aStarSearch grid src dest)
  
  ;-----------------------------------------------data variables ,global for each function call
  ;openlist having each element as '(f i j)
  (define openList '())
  
  ;2-d grid of boolean values (#t if cell is processed)
  (define closedList (build-vector ROW (lambda (x) (make-vector COL #f))))

  ;contains 2-d grid of struct type - cell 
  (define cellDetails (build-vector ROW
                                    (lambda (x) (make-vector COL
                                                             (cell -1 -1 INF INF INF)))))

  ;------------------------------------------------tracing function-geenerating path, being stored in PATH
  ;traces path from dest to source
  (define (tracePath cellDetails dest)
    
    ;initialise acc = '() 
    (define (parent-follower i j acc)
      (let* ([p-i (cell-p_i (vec-ref cellDetails j i))]
             [p-j (cell-p_j (vec-ref cellDetails j i))])
        (cond [(and (equal? p-i i) (equal? p-j j)) (cons (cons i j) acc)]
              [else (parent-follower p-i p-j (cons (cons i j) acc))]))) 
    
    ;  ;p = acc (of parent-follower)
    ;  (define (printPath p)
    ;    (if (null? p) (begin (newline)(void 3))
    ;    (begin
    ;      (display (car p))
    ;      (display "-->")
    ;      (printPath (cdr p)))))
    
    (begin
      ;(displayln "The path is :")
      (parent-follower (car dest) (cdr dest) '())));car-i,cdr-j
  (define foundDest #f)
  
  ;------------------------------------------------------------------driver function for the algorithm
  (define (looper)
    (cond [(null? openList) (if foundDest (void 1) "Failed to find the Destination Cell")]
          [else (let* ([sorted-open-list (sort openList (lambda (x y) (< (car x) (car y))))]
                       [top (car sorted-open-list)]
                       [i (second top)]
                       [j (third top)])
                  (begin
                    (set! openList (cdr sorted-open-list))
                    (vec-set! closedList j i #t)
                    (successor i j 7)
                    (if foundDest (void 1);(display "done")
                        (looper))))])) 

;Cell-->Popped Cell (i, j) 
;        N -->  North       (i-1, j) 7
;        S -->  South       (i+1, j) 6
;        E -->  East        (i, j+1) 5
;        W -->  West           (i, j-1) 4
;        N.E--> North-East  (i-1, j+1) 3
;        N.W--> North-West  (i-1, j-1) 2
;        S.E--> South-East  (i+1, j+1) 1
;        S.W--> South-West  (i+1, j-1) 0
  
  ;iter = successor number
  (define (successor c r iter);c-i,r-j
    (cond [(= iter -1) (void 3)]
          [else (let* ([i (cond [(= iter 7) (- c 1)]
                                [(= iter 6) (+ c 1)]
                                [(= iter 5) c]
                                [(= iter 4) c]
                                [(= iter 3) (- c 1)]
                                [(= iter 2) (- c 1)]
                                [(= iter 1) (+ c 1)]
                                [(= iter 0) (+ c 1)])]
                       [j (cond [(= iter 7) r]
                                [(= iter 6) r]
                                [(= iter 5) (+ r 1)]
                                [(= iter 4) (- r 1)]
                                [(= iter 3) (+ r 1)]
                                [(= iter 2) (- r 1)]
                                [(= iter 1) (+ r 1)]
                                [(= iter 0) (- r 1)])]) 
                  (begin
                    (if (isValid j i)
                        (cond [(isDestination j i dest) (begin
                                                          (set-cell-p_i! (vec-ref cellDetails j i) c)
                                                          (set-cell-p_j! (vec-ref cellDetails j i) r)
                                                          ;(displayln "The destination cell is found")
                                                          (set! PATH (tracePath cellDetails dest))
                                                          (set! foundDest #t)
                                                          (void 3))]
                              [(and (not (vec-ref closedList j i)) (isUnblocked grid j i))
                               (let* ([parent-cell-val (vec-ref grid r c)]
                                      [successor-cell-val (vec-ref grid j i)]
                                      [avg (/ (+ parent-cell-val successor-cell-val) 2)]
                                      [g-new (+ avg (cell-g (vec-ref cellDetails r c)))]
                                      [h-new (* avg (calculateHValue j i dest))]
                                      [f-new (+ g-new h-new)]
                                      [CELL (vec-ref cellDetails j i)])
                                 (if (or (equal? INF (cell-f CELL))
                                         (> (cell-f CELL) f-new))
                                     (begin
                                       (set! openList (cons (list f-new i j) openList))
                                       (vec-set! cellDetails j i (cell c r g-new h-new f-new)))
                                     (successor c r (- iter 1))))])  
                        (successor c r (- iter 1)))
                    (if foundDest (void 3) (successor c r (- iter 1)))))]))
                  
  ;car-i-COL, cdr-j-ROW
  (cond [(not (isValid (cdr src) (car src))) "Source is invalid"]
        [(not (isValid (cdr dest) (car dest))) "Destination is invalid"]
        [(not (or (isUnblocked grid (cdr src) (car src))
                  (isUnblocked grid (cdr dest) (car dest)))) "Source or the destination is blocked"]
        [(isDestination (cdr src) (car src) dest) "We are already at the destination"]
        [else (let* ([i (car src)]
                     [j (cdr src)])
                (begin
                  (vec-set! cellDetails j i (cell i j 0.0 0.0 0.0))
                  (set! openList (cons (list 0.0 i j) openList))
                  (looper)))]))

;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--command lines
;(define my-grid (get-field MAP ex1))
;(aStarSearch my-grid (cons 0 0) (cons 6 7))
(define my-grid2 (get-field MAP ex2))
(define new2-ins (aStarSearch my-grid2 (cons 0 0) (cons 7 7)))














