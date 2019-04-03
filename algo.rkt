#lang racket
;;main program for A* algorithm

(provide all-defined-out)

;(require examples.rkt)
;(require functions.rkt)
(require racket/mpair)

(define INF 1000000)

;cell attributes except - i , j
(struct cell (p_i p_j g h f)#:transparent #:mutable)

;Global items------------------------------------------------------------------

;to be made as an HOF
(define ROW 10)
(define COL 10)

;openlist having each element as '(f (cons i j))
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
























