#lang racket

(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)
(require 2htdp/planetcute)

;(define (render lst)
;  (place-image (circle (car lst)  "solid" "blue") (second lst) (third lst) (empty-scene 500 500)))
;
;(define (sub lst)
;  (cons (- (car lst) 1) (cdr lst)))
;
;(define (zero lst)
;  (= 0 (car lst)))
;
;
;(define (act-mouse w x y mouse-event)
;  (cond [(mouse=? mouse-event "button-down") (list 85 x y)]
;        [else w]))
;

(define (2d-vector-set! vec r c val)
  (vector-set! (vector-ref vec r) c val))
;(big-bang (list 100 250 250) ;(on-tick sub)
;              (to-draw render)
;               (stop-when zero)
;  (on-mouse act-mouse))
;

(define boundry-length-x 800)
(define boundry-length-y 800)
(define ROW 20)
(define COL 20)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define SIZE (/ boundry-length-x ROW))

(define SCENE (frame (rectangle  1500 1000 "solid" "white")))


(define grid (build-vector ROW (lambda (x) (make-vector COL 1))))

(define table (frame (square 800 "outline" "black")))

(define red-sqr (frame (square 50 "solid" "red")))
(define blue-sqr (frame (square 50 "solid" "blue")))
(define yellow-sqr (frame (square 50 "solid" "yellow")))


(define red-box (frame (square SIZE "solid" "red")))
(define blue-box (frame (square SIZE "solid" "blue")))
(define yellow-box (frame (square SIZE "solid" "yellow")))

(define margin-x 100)
(define margin-y 100)

(define game-boundry-x (+ margin-x boundry-length-x))
(define game-boundry-y (+ margin-y boundry-length-y))


(define button-pos-red-x 1350)
(define button-pos-red-y 200)
(define button-pos-blue-x 1350)
(define button-pos-blue-y 500)
(define button-pos-yellow-x 1350)
(define button-pos-yellow-y 800)

(define text-red-x 1350)
(define text-red-y 280)
;(struct cell ( color) #:transparent #:mutable)
;
;
;;goto (i j) coordinates of vec
;(define (vec-ref vec i j)
;  (vector-ref (vector-ref vec i) j))
;
;;set vec
;(define (vec-set! vec r c val)
;  (vector-set! (vector-ref vec r) c val))
;
;
;(define cellDetails (build-vector ROW
;                                  (lambda (x) (make-vector COL
;                                                           (cell "white")))))
;
;(define (bg-update x y color)
;  (if (equal? color "white") (void 3)
;  (set! bg (place-image (frame (square SIZE "solid" color)) x y bg))))
;
;
;(define (drawer details)
;  (define i 0)
;  (define j 0)
;  (define (helper)
;    (let ([cell-1 (vec-ref details i j)]
;          [x (+ (/ SIZE 2) (* SIZE i))]
;          [y (+ (/ SIZE 2) (* SIZE j))])
;      (begin (bg-update x y (cell-color cell-1))
;
;             (if (and (= i (- ROW 1)) (= j (- COL 1))) bg
;                 (if (< i (- ROW 1)) (begin (set! i (+ i 1)) (helper))
;                     (begin (set! i 0)
;                            (set! j (+ j 1))
;                            (helper)))))))
;  (helper))
;    
;      
;          
;
;
;
;(define (mouse-handle w x y action)
;  (cond [(equal? action "button-down")
;         (update w x y)]
;        [else w]))
;
;(define (next color)
;      (cond [(equal? color "white" ) "green"]
;            [(equal? color "green" ) "blue"]
;            [(equal? color "blue" ) "red"]
;            [(equal? color "red" ) "white"]))
;  
;
;
;(define (update w x y)
;  (let* ([a (quotient x SIZE)]
;       [b (quotient y SIZE)]
;       [colour (cell-color (vec-ref w a b))])
;    (begin (vec-set! w a b (cell (next colour)))
;           cellDetails)))

          
;(define (bb)
;(big-bang cellDetails
;  (to-draw drawer)   
;  ;(on-tick ticker)
;  (on-mouse mouse-handle)))

(define (in-range-x x)
  (and (>= x margin-x) (<= x game-boundry-x)))

(define (in-range-y y)
  (and (>= y margin-y) (<= y game-boundry-y)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (in-button-red-x x)
  (and (>= x (- button-pos-red-x 25)) (<= x (+ button-pos-red-x 25))))

(define (in-button-red-y y)
  (and (>= y (- button-pos-red-y 25)) (<= y (+ button-pos-red-y 25))))

(define (in-button-blue-x x)
  (and (>= x (- button-pos-blue-x 25)) (<= x (+ button-pos-blue-x 25))))
  
(define (in-button-blue-y y)
  (and (>= y (- button-pos-blue-y 25)) (<= y (+ button-pos-blue-y 25))))

(define (in-button-yellow-x x)
  (and (>= x (- button-pos-yellow-x 25)) (<= x (+ button-pos-yellow-x 25))))
  
(define (in-button-yellow-y y)
  (and (>= y (- button-pos-yellow-y 25)) (<= y (+ button-pos-yellow-y 25))))
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
(define (button-range x y)
  (cond [(and (in-button-red-x x) (in-button-red-y y)) (lambda(w) (list (car w) -1 (third w) (fourth w)))]
        [(and (in-button-blue-x x) (in-button-blue-y y)) (lambda(w) (list (car w) -2 (third w) (fourth w)))]
       [(and (in-button-yellow-x x) (in-button-yellow-y y)) (lambda(w) (list (car w) -3 (third w) (fourth w)))]
        [else #f]))

               
(define initial-pic
  (place-images (list table
                      red-sqr;-1
                      blue-sqr;-2
                      yellow-sqr
                      (text "CHOOSE-OBSTACLE" 10 "purple" )
                      );-3
                (list (make-posn (+ margin-x (/ boundry-length-x 2)) (+ margin-y (/ boundry-length-y 2)  ))
                      (make-posn button-pos-red-x button-pos-red-y)
                      (make-posn button-pos-blue-x button-pos-blue-y)
                      (make-posn button-pos-yellow-x button-pos-yellow-y)
                      (make-posn text-red-x text-red-y))
                SCENE))

(define (mouse-pic w x y me)
  
  (if (mouse=? me "button-down") (cond [(and (in-range-x x) (in-range-y y))
                                        (let* ([r (quotient (- x margin-x)  SIZE)]
                                               [c (quotient (- y margin-y) SIZE)])
                                          (begin
                                            (2d-vector-set! grid c r (second w))
                                            (list (render-pic (list (first w) (second w) r c))
                                                  (second w)
                                                  r
                                                  c)))]
                                       [(button-range x y) ((button-range x y) w)] 
;                                       [(and (>= x 725) (<= x 775)) (cond [(and (>= y 225) (<= y 275)) (list (car w) -1 (third w) (fourth w))]
;                                                                          [(and (>= y 475) (<= y 525)) (list (car w) -2 (third w) (fourth w))]
;                                                                          [(and (>= y 725) (<= y 775)) (list (car w) -3 (third w) (fourth w))]
;                                                                          [else w])]
                                       [else w])
      w))
  
(define (render-pic w)
  (let* ([iter (second w)]
         [img (cond [(= iter -1) red-box]
                    [(= iter -2) blue-box]
                    [(= iter -3) yellow-box])]
         [i (+ margin-x (+ (/ SIZE 2) (* SIZE (third w))))]
         [j (+ margin-y (+ (/ SIZE 2) (* SIZE (fourth w))))])
    (place-image img i j (first w))))

(define (return-first w)
  (first w))

;(list image selected-sqr row column)
(define (bb) (big-bang (list initial-pic -3 -1 -1)
             [on-mouse mouse-pic]
             [to-draw return-first]))




;(big-bang initial-pic
;  [to-draw (lambda (x) x)])




