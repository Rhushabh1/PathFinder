#lang racket

;(require "Algorithm.rkt")
(provide (all-defined-out))

(define ROW 10)
(define COL 10)

(define (isValid row col)
  (and (>= row 0) (>= col 0) (< row ROW) (< col COL)))


(define (2d-vector-ref vec r c)
  (vector-ref (vector-ref vec r) c))


(define (isUnblocked grid row col)
  (= (2d-vector-ref grid row col) 1)) ;;cell is unblocked when equal to 1 not 0

(define (isDestination row col dest)
  (and (= row (car dest)) (= col (cdr dest))))

(define (calculateHValue row col dest)
  (let ([x (- (car dest) row)]
        [y (- (cdr dest) col)])
    (sqrt (+ (* x x) (* y y)))))



