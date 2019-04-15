#lang racket
;grid graphics

(provide (all-defined-out))

(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)
(require 2htdp/planetcute)

(define grid (build-vector 10 (lambda (x) (make-vector 10 0))))
(define Scene (square 1000 "solid" "white"))
(define red-sqr (square 50 "solid" "red"))
(define blue-sqr (square 50 "solid" "blue"))
(define yellow-sqr (square 50 "solid" "yellow"))
(define table (square 500 "solid" "yellow"));initial grid (all yellow)

(define (2d-vector-set! vec r c val)
  (vector-set! (vector-ref vec r) c val))

(define initial-pic
  (place-images (list table
                      red-sqr;1
                      blue-sqr;-2
                      yellow-sqr
                      (text "hello" 30 "orange"));-3
                (list (make-posn 250 250)
                      (make-posn 750 250)
                      (make-posn 750 500)
                      (make-posn 750 750)
                      (make-posn 250 750))
                Scene))

(define (mouse-pic w x y me)
  (if (mouse=? me "button-down") (cond [(and (< x 500) (< y 500)) (let* ([r (quotient x 50)]
                                                                         [c (quotient y 50)])
                                                                    (begin
                                                                      (2d-vector-set! grid c r (second w))
                                                                      (list (render-pic (list (first w) (second w) r c))
                                                                            (second w)
                                                                            r
                                                                            c)))]
                                       [(and (>= x 725) (<= x 775)) (cond [(and (>= y 225) (<= y 275)) (list (car w) 1 (third w) (fourth w))]
                                                                          [(and (>= y 475) (<= y 525)) (list (car w) -2 (third w) (fourth w))]
                                                                          [(and (>= y 725) (<= y 775)) (list (car w) -3 (third w) (fourth w))]
                                                                          [else w])]
                                       [else w])
      w))
  
(define (render-pic w)
  (let* ([iter (second w)]
         [img (cond [(= iter 1) red-sqr]
                    [(= iter -2) blue-sqr]
                    [(= iter -3) yellow-sqr])]
         [i (+ 25 (* 50 (third w)))]
         [j (+ 25 (* 50 (fourth w)))])
    (place-image img i j (first w))))

(define (return-first w)
  (first w))

;(list image selected-sqr row column)
(define (edit)
  (define bb (big-bang (list initial-pic -3 -1 -1)
               [on-mouse mouse-pic]
               [to-draw return-first]))
  grid)