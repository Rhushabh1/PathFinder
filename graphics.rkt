#lang racket
(provide (all-defined-out))
;(provide bb)
(provide w1)
(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)
(require 2htdp/planetcute)
(require "input.rkt")

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


(define start-button (bitmap "graphics-start.png"))

(define template1help  (bitmap "template1.png") )
(define template-height-h (image-height template1help))
(define template-width-h (image-width template1help))

(define template1h (scale/xy (/ 80 262) (/ 40 75) (bitmap "template1.png") ))

(define template-height (image-height template1h))
(define template-width (image-width template1h))

(define template1 (scale/xy (/ 80 template-width-h) (/ 40  template-height-h)  (bitmap "template1.png")))
(define template2 (scale/xy (/ 80 template-width-h) (/ 40  template-height-h) (bitmap "template2.png")))
(define template3 (scale/xy (/ 80 template-width-h) (/ 40  template-height-h) (bitmap "template3.png")))
(define template4 (scale/xy (/ 80 template-width-h) (/ 40  template-height-h) (bitmap "template4.png")))
(define template5 (scale/xy (/ 80 template-width-h) (/ 40  template-height-h) (bitmap "template5.png")))




(define background2 (scale/xy (/ 1500 1024) (/ 1000 570) (bitmap "graphics-background2.png")))
(define background1 (scale/xy (/ 1500 800) (/ 1000 441) (bitmap "graphics-background1.jpg")))


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

(define (row-col-set)
  (set! ROW row)
  (set! COL col))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define SIZE (/ boundry-length-x ROW))

(define SCENE (frame background2))
               ;(rectangle  1500 1000 "solid" "white")))


(define grid (build-vector ROW (lambda (x) (make-vector COL 1))))

(define table (frame (square 800 "solid" "white")))

(define red-sqr (frame (square 50 "solid" "red")))
(define blue-sqr (frame (square 50 "solid" "blue")))
(define yellow-sqr (frame (square 50 "solid" "yellow")))
(define white-sqr (frame (square 50 "solid" "white")))


(define red-box (circle (/ SIZE 2) "solid" "red"))
(define blue-box  (circle (/ SIZE 2) "solid" "blue"))
(define yellow-box (frame (square SIZE "solid" "yellow")))
(define white-box  (square SIZE "solid" "white"))

(define margin-x 100)
(define margin-y 100)

(define game-boundry-x (+ margin-x boundry-length-x))
(define game-boundry-y (+ margin-y boundry-length-y))


(define button-pos-red-x 1350)
(define button-pos-red-y 200)
(define button-pos-blue-x 1350)
(define button-pos-blue-y 350)
(define button-pos-yellow-x 1350)
(define button-pos-yellow-y 500)
(define button-pos-white-x 1350)
(define button-pos-white-y 650)
(define button-pos-start-x 1350)
(define button-pos-start-y 800)

(define button-pos-template1-x 90)
(define button-pos-template1-y 950)
(define button-pos-template2-x 180)
(define button-pos-template2-y 950)
(define button-pos-template3-x 270)
(define button-pos-template3-y 950)
(define button-pos-template4-x 360)
(define button-pos-template4-y 950)
(define button-pos-template5-x 450)
(define button-pos-template5-y 950)


(define text-red-x 1350)
(define text-red-y 250)
(define text-blue-x 1350)
(define text-blue-y 400)
(define text-yellow-x 1350)
(define text-yellow-y 550)
(define text-white-x 1350)
(define text-white-y 700)
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

(define (in-button-white-x x)
  (and (>= x (- button-pos-white-x 25)) (<= x (+ button-pos-white-x 25))))
  
(define (in-button-white-y y)
  (and (>= y (- button-pos-white-y 25)) (<= y (+ button-pos-white-y 25))))

(define (in-button-start-x x)
  (and (>= x (- button-pos-start-x (/ (image-width start-button) 2))) (<= x (+ button-pos-start-x (/ (image-width start-button) 2)))))
  
(define (in-button-start-y y)
  (and (>= y (- button-pos-start-y (/ (image-height start-button) 2))) (<= y (+ button-pos-start-y (/ (image-height start-button) 2)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (in-button-template1-x x)
  (and (>= x (- button-pos-template1-x (/ template-width 2))) (<= x (+ button-pos-template1-x (/ template-width 2)))))  
(define (in-button-template1-y y)
  (and (>= y (- button-pos-template1-y (/ template-height 2))) (<= y (+ button-pos-template1-y (/ template-height 2)))))

(define (in-button-template2-x x)
  (and (>= x (- button-pos-template2-x (/ template-width 2))) (<= x (+ button-pos-template2-x (/ template-width 2)))))
(define (in-button-template2-y y)
  (and (>= y (- button-pos-template2-y (/ template-height 2))) (<= y (+ button-pos-template2-y (/ template-height 2)))))


(define (in-button-template3-x x)
  (and (>= x (- button-pos-template3-x (/ template-width 2))) (<= x (+ button-pos-template3-x (/ template-width 2)))))
(define (in-button-template3-y y)
  (and (>= y (- button-pos-template3-y (/ template-height 2))) (<= y (+ button-pos-template3-y (/ template-height 2)))))

(define (in-button-template4-x x)
  (and (>= x (- button-pos-template4-x (/ template-width 2))) (<= x (+ button-pos-template4-x (/ template-width 2)))))
(define (in-button-template4-y y)
  (and (>= y (- button-pos-template4-y (/ template-height 2))) (<= y (+ button-pos-template4-y (/ template-height 2)))))

(define (in-button-template5-x x)
  (and (>= x (- button-pos-template5-x (/ template-width 2))) (<= x (+ button-pos-template5-x (/ template-width 2)))))
(define (in-button-template5-y y)
  (and (>= y (- button-pos-template5-y (/ template-height 2))) (<= y (+ button-pos-template5-y (/ template-height 2)))))
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
(define (button-range x y)
  (cond [(and (in-button-red-x x) (in-button-red-y y)) (lambda(w) (list (car w) -1 (third w) (fourth w)))]
        [(and (in-button-blue-x x) (in-button-blue-y y)) (lambda(w) (list (car w) -2 (third w) (fourth w)))]
       [(and (in-button-yellow-x x) (in-button-yellow-y y)) (lambda(w) (list (car w) -3 (third w) (fourth w)))]
       [(and (in-button-white-x x) (in-button-white-y y)) (lambda(w) (list (car w) 1 (third w) (fourth w)))]
       [(and (in-button-start-x x) (in-button-start-y y)) (lambda(w) (list (car w) -4 (third w) (fourth w)))]
       [(and (in-button-template1-x x) (in-button-template1-y y)) (lambda(w) (begin (set! grid template1-grid)
                                                                               (list template1-image (second w) (third w) (fourth w))))]
       [(and (in-button-template2-x x) (in-button-template2-y y)) (lambda(w) (begin (set! grid template2-grid)
                                                                               (list template2-image (second w) (third w) (fourth w))))]
       [(and (in-button-template3-x x) (in-button-template3-y y)) (lambda(w) (begin (set! grid template3-grid)
                                                                               (list template3-image (second w) (third w) (fourth w))))]
       [(and (in-button-template4-x x) (in-button-template4-y y)) (lambda(w) (begin (set! grid template4-grid)
                                                                               (list template4-image (second w) (third w) (fourth w))))]
       [(and (in-button-template5-x x) (in-button-template5-y y)) (lambda(w) (begin (set! grid template5-grid)
                                                                               (list template5-image (second w) (third w) (fourth w))))]
        [else #f]))

               
(define initial-pic
  (place-images (list table
                      red-sqr;-1
                      blue-sqr;-2
                      yellow-sqr
                      white-sqr
                      (text "CHOOSE-OBSTACLE" 15 "purple" )
                      (text "CHOOSE-INITIAL_POINT" 15 "purple" )
                      (text "CHOOSE-FINAL_POINT" 15 "purple" )
                      (text "UNDO" 15 "purple" )
                      template1
                      template2
                      template3
                      template4
                      template5
                      start-button
                      );-3
                (list (make-posn (+ margin-x (/ boundry-length-x 2)) (+ margin-y (/ boundry-length-y 2)  ))
                      (make-posn button-pos-red-x button-pos-red-y)
                      (make-posn button-pos-blue-x button-pos-blue-y)
                      (make-posn button-pos-yellow-x button-pos-yellow-y)
                      (make-posn button-pos-white-x button-pos-white-y)
                      (make-posn text-yellow-x text-yellow-y)
                      (make-posn text-blue-x text-blue-y)
                      (make-posn text-red-x text-red-y)
                      (make-posn text-white-x text-white-y)
                      
                      (make-posn button-pos-template1-x button-pos-template1-y)
                      (make-posn button-pos-template2-x button-pos-template2-y)
                      (make-posn button-pos-template3-x button-pos-template3-y)
                      (make-posn button-pos-template4-x button-pos-template4-y)
                      (make-posn button-pos-template5-x button-pos-template5-y)
                      
                      (make-posn button-pos-start-x button-pos-start-y))
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
                    [(= iter -3) yellow-box]
                    [(= iter 1) white-box])]
         [i (+ margin-x (+ (/ SIZE 2) (* SIZE (third w))))]
         [j (+ margin-y (+ (/ SIZE 2) (* SIZE (fourth w))))])
    (place-image img i j (first w))))

(define (return-first w)
  (first w))


(define (start? w) (= (second w) -4))
;(list image selected-sqr row column)
(define (bb) (big-bang (list initial-pic -3 -1 -1 )
             [on-mouse mouse-pic]
             [to-draw return-first]
             [stop-when start?]
             [close-on-stop #t]  

               ))




;(big-bang initial-pic
;  [to-draw (lambda (x) x)])


(define w1 initial-pic)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;template-func;;;;;;;;;;;;;;;;
(define (check-grid pair grid)
 (vector-ref  (vector-ref grid (car pair)) (cdr pair)))
;
;
;(define (template-generator in-grid pic)
;  (define i 0)
;  
;  (define (row-build row-vec ) (displayln row-vec)
;    (define j 0)
;    (define (iter)
;      (if (> j (- COL 1)) (void 1)
;          (begin (set! pic (let* ([iter (check (cons i j) in-grid)]
;                                  [img (cond [(= iter -1) red-box]
;                                             [(= iter -2) blue-box]
;                                             [(= iter -3) yellow-box]
;                                             [(= iter 1) white-box])]
;                                  [p (+ margin-x (+ (/ SIZE 2) (* SIZE i)))]
;                                  [q (+ margin-y (+ (/ SIZE 2) (* SIZE j)))])
;                             (place-image img i j pic)))
;                 (set! j (+ j 1))
;                 (iter)
;                 )))
;    
;    (iter))
;   (define (iter1)
;    (if (> i (- ROW 1)) (void 1) 
;        (begin (row-build (vector-ref  in-grid i))
;               (set! i (+ i 1))
;               (iter1))))
;  (begin (iter1)
;         ) ;return updated vec
;  )
(define (update i j pic)
  (let (
        [p (+ margin-x (+ (/ SIZE 2) (* SIZE i)))]
        [q (+ margin-y (+ (/ SIZE 2) (* SIZE j)))])
    (place-image yellow-box q p pic)))

(define (template-generator i j grid-i pic)
  
  (cond [(and (= j  (sub1 COL)) (= i (sub1 ROW))) (update i j pic)]
        [(< j (sub1 COL)) (cond [(= -3 (check-grid (cons i j) grid-i)) (template-generator i (+ 1 j) grid-i (update i j pic))]
                                 [else (template-generator i (+ j 1) grid-i pic)])]
        [(= j (sub1 COL)) (cond [(= -3 (check-grid (cons i j) grid-i)) (template-generator (+ i 1) 0 grid-i (update i j pic))]
                                 [else (template-generator (+ i 1) 0 grid-i pic)])]))

                                  
        


;(define template1-grid (vector  (vector -3 1 1 1 -3 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
;   (vector -3 1 1 1 -3 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
;   (vector -3 1 1 1 -3 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
;  (vector  -3 1 -3 1 -3 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
;  (vector   -3 1 -3 1 -3 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
;  (vector   -3 1 -3 1 -3 1 1 1 1 1 1 1 1 1 1 1 -3 -3 1 1)
;  (vector   -3 1 1 1 -3 1 1 1 1 1 1 1 1 1 1 -3 1 -3 1 1)
;  (vector   -3 1 -3 1 -3 -3 -3 1 1 1 1 1 1 -3 -3 1 1 1 1 1)
; (vector    -3 1 -3 1 1 -3 1 -3 1 1 1 1 -3 1 1 1 1 1 1 1)
;  (vector   -3 1 -3 1 1 1 1 1 1 1 1 -3 1 1 1 1 1 1 1 1)
;  (vector   1 1 1 -3 1 1 1 -3 1 1 1 1 -3 1 1 1 1 1 1 1)
;  (vector   1 1 -3 -3 1 1 1 -3 1 1 1 1 1 1 1 1 1 1 1 1)
; (vector    1 1 -3 -3 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
; (vector    1 1 1 -3 1 1 1 -3 1 1 1 1 1 1 1 1 1 1 1 1)
; (vector    1 1 1 -3 1 1 1 -3 1 1 1 1 1 1 1 1 1 1 1 1)
; (vector    1 1 1 -3 1 1 1 -3 1 1 1 1 1 1 1 1 1 1 1 1)
;  (vector   1 1 1 -3 1 1 1 -3 1 1 1 1 1 1 1 1 1 1 1 1)
;  (vector   1 1 1 -3 1 1 1 -3 1 -3 1 1 1 1 1 1 1 1 1 1)
; (vector    1 1 1 -3 1 1 1 1 -3 1 1 1 1 1 1 1 1 1 1 1)
;  (vector   1 1 1 -3 1 1 1 1 -3 -3 1 1 1 1 1 1 1 1 1 1)))

(define (my-rand)
  (let ([x (random 4)])
    (cond [(= 0 x) 1]
          [(= 2 x) 1]
          [(= 3 x) 1]
          [(= 1 x) -3])))
(define (make-rand-vector COL)
  (cond [(= COL 0) #()]
        [else (vector-append (vector (my-rand)) (make-rand-vector (- COL 1)))]))

(define template1-grid (build-vector ROW (lambda (x) (make-rand-vector COL))))
(define template2-grid (build-vector ROW (lambda (x) (make-rand-vector COL))))
(define template3-grid (build-vector ROW (lambda (x) (make-rand-vector COL))))
(define template4-grid (build-vector ROW (lambda (x) (make-rand-vector COL))))
(define template5-grid (build-vector ROW (lambda (x) (make-rand-vector COL))))

(define template1-image (template-generator 0 0 template1-grid initial-pic))
(define template2-image (template-generator 0 0 template2-grid initial-pic))
(define template3-image (template-generator 0 0 template3-grid initial-pic))
(define template4-image (template-generator 0 0 template4-grid initial-pic))
(define template5-image (template-generator 0 0 template5-grid initial-pic))
;;;;;;









