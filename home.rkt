#lang racket
(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)
(require 2htdp/planetcute)
(require "graphics.rkt")
(provide home)


;(define home-row 0)
;(define home-col 0)
;
;(define row-button (frame (rectangle 100 50 "solid" "white")))
;(define col-button (frame (rectangle 100 50 "solid" "white")))
;
;(define button-pos-row-x  700)
;(define button-pos-row-y  200)
;
;(define button-pos-column-x 700)
;(define button-pos-column-y 300)
;
;(define (in-row-x x)
;  (and (>= x (- button-pos-row-x (/ (image-width row-button) 2))) (<= x (+ button-pos-row-x (/ (image-width row-button) 2)))))
;(define (in-row-y y)
;  (and (>= y (- button-pos-row-y (/ (image-height row-button) 2))) (<= y (+ button-pos-row-y (/ (image-height row-button) 2)))))
;
;(define (in-column-x x)
;  (and (>= x (- button-pos-column-x (/ (image-width col-button) 2))) (<= x (+ button-pos-column-x (/ (image-width col-button) 2)))))
;(define (in-column-y y)
;  (and (>= y (- button-pos-column-y (/ (image-height col-button) 2))) (<= y (+ button-pos-column-y (/ (image-height col-button) 2)))))

(define factor-x (/ 15 8))
(define factor-y (/ 20 9))


(define img (scale/xy factor-x factor-y (bitmap "homepage.png")))
(define but (scale/xy factor-x factor-y (bitmap "homebutton.png")))

(define fra (place-images (list but) (list (make-posn (* factor-x 400) (* factor-y 300))
                                                               
                                                                 ) img))

(define (mouse-pic w x y me)
  (if (mouse=? me "button-down") (cond [(and (>= x (* factor-x (- 400 (/ 311 2)))) (<= x (* factor-x (+ 400 (/ 311 2)))))
                                             (cond [(and (>= y (* factor-y 260)) (<= y (* factor-y 340))) (list fra 'graphics)]
                                                   [else w])]
[else w])
w))


(define (return-first1 w)
  (first w))

(define (stop? w)
  (equal? 'graphics (second w)))

;(define (home)
  ;(list frame grid exit-condition)

  (define (home) (big-bang (list fra 'not-select)
               [on-mouse mouse-pic]
               [to-draw return-first1]
               [stop-when stop?]
               [close-on-stop 1]))

  ;(second home-bb))

 