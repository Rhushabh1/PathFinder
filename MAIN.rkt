#lang racket
;MAIN
(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)
(require 2htdp/planetcute)
(provide (all-defined-out))
(require "Algorithm.rkt")
(require "graphics.rkt")
(require "home.rkt")
;(require "path-generator.rkt")



;----------------------------------------------------------------homepage
;(home)
;-----------------------------------------------------------------getting the data through gui
(define state '())
(define gr grid)

(define world-state '())

;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                                                               


(define list-of-obstacles '())
(define initial-point '())
(define end-point '())

(define (flat-grid g)
  (define r-new -1)
  (define c-new -1)
  (define (flatten-grid g r c)
    (if (>= r (vector-length g))
        (void 1);exit condition
        (begin
          (if (= c (- (vector-length (vector-ref g r)) 1)) (begin
                                                             (set! c-new 0)
                                                             (set! r-new (+ r 1)))
              (begin
                (set! c-new (+ c 1))
                (set! r-new r)))
          (let* ([res (vec-ref g r c)])
            (cond [(= res -2) (begin
                                (set! initial-point (cons  c  r))
                                (vec-set! g r c 1)
                                (flatten-grid g r-new c-new))]
                  [(= res -1) (begin
                                (set! end-point (cons c r))
                                (vec-set! g r c 1)
                                (flatten-grid g r-new c-new))]
                  [(<= res 0) (begin
                               (vec-set! g r c 0)
                               (set! list-of-obstacles (append list-of-obstacles (list (cons r c))))
                               (flatten-grid g r-new c-new))]
                  [(>= res 1) (begin
                               (vec-set! g r c 1)
                               (flatten-grid g r-new c-new))]
                  [else (flatten-grid g r-new c-new)])))))
    (flatten-grid g 0 0))

;;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
(define picture w1)
;(define path-coordinates (list (cons 1 1) (cons 3 4) (cons 13 2) (cons 8 9) (cons 11 19)))

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
                   (list picture PATH)
                 
                 [on-tick draw-path 0.5]
                 [to-draw car]
                 [stop-when  last-world?]
                 [close-on-stop 1]
                 ))
                 

;;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@








;GRID is now flattened and ready to be given to algo

;-----------------------------------------------------------------finding the path
(define (astar)
(aStarSearch gr initial-point end-point))
;PATH stores the shortest path
;---------------------------------------------------------------displaying the shortest path

(define (controller state1) (cond  [(equal? 'home state1) (let ([new (home)])
                                                          (begin (set! state (second new))
                                                                 (controller state))
                                                            )]
                               ;    [(equal? 'graphics state1) (begin (bb))]))
                                   [(equal? 'graphics state1) (begin (let ([world-state1 (bb)])
                                                                       (set! world-state world-state1))
                                                                     (flat-grid gr)
                                                                     (astar)
                                                                     ;w(set! path-coordinates PATH)
                                                                     (set! picture (car world-state))
                                                                     (path))]))
                                                                     











