#lang racket

(require 2htdp/image)
(require 2htdp/universe)

(define (render lst)
  (place-image (circle (car lst)  "solid" "blue") (second lst) (third lst) (empty-scene 500 500)))

(define (sub lst)
  (cons (- (car lst) 1) (cdr lst)))

(define (zero lst)
  (= 0 (car lst)))


(define (act-mouse w x y mouse-event)
  (cond [(mouse=? mouse-event "button-down") (list 85 x y)]
        [else w]))


;(big-bang (list 100 250 250) ;(on-tick sub)
;              (to-draw render)
;               (stop-when zero)
;  (on-mouse act-mouse))
;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define SIZE 40)
(define WIDTH 800) 
(define HEIGHT 800)
(define SEGMENT-SIDE 10)
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define GRID-IMAGE (square SIZE 'solid 'green))

(define ROW 10)
(define COL 10)


(struct cell (color ) #:transparent #:mutable)

;(define SEGMENT-IMAGE (square SEGMENT-SIDE 'solid 'red))

;(define SNAKE-INIT (make-snake 'right (list (make-posn 10 10))))
;(define FOOD-INIT (make-posn 200 200))
;(define WORLD-INIT (make-world SNAKE-INIT FOOD-INIT))

(define squ (square SIZE 'outline 'black))
(define bg-x (beside squ squ squ squ squ squ squ squ squ squ))
(define bg (above bg-x bg-x bg-x bg-x bg-x bg-x bg-x bg-x bg-x bg-x))

;goto (i j) coordinates of vec
(define (vec-ref vec i j)
  (vector-ref (vector-ref vec i) j))

;set vec
(define (vec-set! vec r c val)
  (vector-set! (vector-ref vec r) c val))


(define cellDetails (build-vector ROW
                                  (lambda (x) (make-vector COL
                                                           (cell "white")))))

(define (bg-update x y color)
  (if (equal? color "white") (void 3)
  (set! bg (place-image (frame (square SIZE "solid" color)) x y bg))))


(define (drawer details)
  (define i 0)
  (define j 0)
  (define (helper)
    (let ([cell-1 (vec-ref details i j)]
          [x (+ (/ SIZE 2) (* SIZE i))]
          [y (+ (/ SIZE 2) (* SIZE j))])
      (begin (bg-update x y (cell-color cell-1))

             (if (and (= i (- ROW 1)) (= j (- COL 1))) bg
                 (if (< i (- ROW 1)) (begin (set! i (+ i 1)) (helper))
                     (begin (set! i 0)
                            (set! j (+ j 1))
                            (helper)))))))
  (helper))
    
      
          



(define (mouse-handle w x y action)
  (cond [(equal? action "button-down")
         (update w x y)]
        [else w]))

(define (next color)
      (cond [(equal? color "white" ) "green"]
            [(equal? color "green" ) "blue"]
            [(equal? color "blue" ) "red"]
            [(equal? color "red" ) "white"]))
  


(define (update w x y)
  (let* ([a (quotient x SIZE)]
       [b (quotient y SIZE)]
       [colour (cell-color (vec-ref w a b))])
    (begin (vec-set! w a b (cell (next colour)))
           cellDetails)))

           
           

           
           


(big-bang cellDetails
  (to-draw drawer)   
  ;(on-tick ticker)
  (on-mouse mouse-handle))







