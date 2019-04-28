#lang racket
(provide (all-defined-out))

(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)
(require 2htdp/planetcute)
(require "graphics.rkt")
;(require "MAIN.rkt")
;;w1
(define picture w1)
(define path-coordinates (list (cons 1 1) (cons 3 4) (cons 13 2) (cons 8 9) (cons 11 19)))

(define (draw-path w) (if (null? (cdr (second w))) '(() ())
   (let* ([img-scene (car w)]
         [coordinate (second w)]
         [initial (car coordinate)]
         [final (second coordinate)]
         [x1 (+ margin-x  (*  (car initial) SIZE) (/ SIZE 2))]
         [y1 (+ margin-y  (*  (cdr initial) SIZE) (/ SIZE 2))]
         [x2 (+ margin-x  (*  (car final) SIZE) (/ SIZE 2))]
         [y2 (+ margin-y  (*  (cdr final) SIZE) (/ SIZE 2) )]
         [new-img (add-line img-scene x1 y1 x2 y2 (pen "purple" 6 "short-dash" "projecting" "bevel"))])
    (list  new-img (cdr coordinate)))))
     
     
     
 ;(define (func w ) (not (draw-path w)))
         
(define (last-world? w) (if (= (length (second w)) 0) #t #f))


(define (path) (big-bang
                   (list picture path-coordinates)
                 
                 [on-tick draw-path 0.5]
                 [to-draw car]
                 [stop-when  last-world?]
                 [close-on-stop 1]
                 ))
                 


