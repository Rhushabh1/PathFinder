#lang racket
;;main program for A* algorithm

(provide all-defined-out)

(require "examples.rkt")
(require "trivial func.rkt")
(require racket/mpair)

(define INF 1000000)

;cell attributes except - i , j
(struct cell [p_i p_j g h f #:mutable] #:transparent )

;Global items------------------------------------------------------------------

;to be made as an HOF
(define ROW 10)
(define COL 10)

;openlist having each element as '(f i j)
(define openList '())

;2-d grid of boolean values (#t if cell is processed)
(define closedList (build-vector ROW (lambda (x) (make-vector COL #f))))

;contains 2-d grid of struct type - cell 
(define cellDetails (build-vector ROW
                                  (lambda (x) (make-vector COL
                                                           (cell -1 -1 INF INF INF)))))

;functions------------------------------------------------------------------

;goto (i j) coordinates of vec
(define (vec-ref vec i j)
  (vector-ref (vector-ref vec i) j))

;set vec
(define (vec-set! vec r c val)
  (vector-set! (vector-ref vec r) c val))

;traces path from dest to source
(define (tracePath cellDetails dest)

  ;initialise acc = '() 
  (define (parent-follower r c acc)
    (let* ([p-r (cell-p_i (vec-ref cellDetails r c))]
           [p-c (cell-p_j (vec-ref cellDetails r c))])
      (cond [(and (equal? p-r r) (equal? p-c c)) acc]
            [else (parent-follower p-r p-c (cons (cons r c) acc))])))

  ;p = acc (of parent-follower)
  (define (printPath p)
    (begin
      (displayln (car p))
      (printPath (cdr p))))

  (begin
    (displayln "The path is :")
    (printPath (parent-follower (car dest) (cdr dest) '()))))

;main A* algo
(define foundDest #f)

(define (aStarSearch grid src dest)

  (define (looper)
    (cond [(null? openList) (if foundDest (void 1) "Failed to find the Destination Cell")]
          [else (let* ([top (car openList)]
                       [i (second top)]
                       [j (third top)])
                  (begin
                    (set! openList (cdr openList))
                    (vec-set! closedList i j #t)
                    (successor i j 7)))]))

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
  (define (successor r c iter)
    (cond [(= iter 0) (void 1)]
          [else (let* ([i (cond [(= iter 7) (- r 1)]
                                [(= iter 6) (+ r 1)]
                                [(= iter 5) r]
                                [(= iter 4) r]
                                [(= iter 3) (- r 1)]
                                [(= iter 2) (- r 1)]
                                [(= iter 1) (+ r 1)]
                                [(= iter 0) (+ r 1)])]
                       [j (cond [(= iter 7) c]
                                [(= iter 6) c]
                                [(= iter 5) (+ c 1)]
                                [(= iter 4) (- c 1)]
                                [(= iter 3) (+ c 1)]
                                [(= iter 2) (- c 1)]
                                [(= iter 1) (+ c 1)]
                                [(= iter 0) (- c 1)])])
                  (begin
                    (if (isValid i j)
                        (cond [(isDestination i j dest) (begin
                                                          (set-cell-p_i! (vec-ref cellDetails i j) r)
                                                          (set-cell-p_j! (vec-ref cellDetails i j) c)
                                                          (]
                              [(and (not (vec-ref closedList i j)) (isUnBlocked grid  i j))
                               ]
                        (void 1))
                    (successor r c (- iter 1))))]))
                  
  
  (cond [(not (isValid (car src) (cdr src))) "Source is invalid"]
        [(not (isValid (car dest) (cdr dest))) "Destination is invalid"]
        [(not (or (isUnblocked grid (car src) (cdr src))
                  (isUnblocked grid (car dest) (cdr dest)))) "Source or the destination is blocked"]
        [(isDestination (car src) (cdr src) dest) "We are already at the destination"]
        [else (let* ([i (car src)]
                     [j (cdr src)])
                (begin
                  (vec-set! cellDetails i j (cell i j 0.0 0.0 0.0))
                  (set! openList (cons (list 0.0 i j) openList))
                  (looper)))]))
























