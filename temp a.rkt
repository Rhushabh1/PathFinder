#lang racket
(define (aStarSearch src dest)
  (cond [(not (isValid (car src) (cdr src))) "Source is invalid"]
        [(not (isValid (car dest) (cdr dest))) "Destination is invalid"]
        [(not (or (isUnblocked grid (car src) (cdr src)) (isUnblocked grid (car dest) (cdr dest)))) "Source or the destination is blocked"]
        [(isDestination (car src) (cdr src) dest) "We are already at the destination"]
        [else 