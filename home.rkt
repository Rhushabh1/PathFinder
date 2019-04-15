#lang racket
(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)
(require 2htdp/planetcute)
(require "grid-gui.rkt")
(provide home)

(define img (bitmap "homepage.png"))
(define but (bitmap "homebutton.png"))
(define fra (place-images (list but) (list (make-posn 400 300)) img))

(define (mouse-pic w x y me)
  (if (mouse=? me "button-down") (cond [(and (>= x (- 400 (/ 311 2))) (<= x (+ 400 (/ 311 2)))) (cond [(and (>= y 260) (<= y 340)) (list fra (edit) (third w))]
                                                                                                      [else w])]
                                       [else w])
      w))

(define (return-first1 w)
  (first w))
(define (stop? w)
  (= 1 (third w)))

(define (home)
  ;(list frame grid exit-condition)
  (define bb (big-bang (list fra -3 0)
               [on-mouse mouse-pic]
               [to-draw return-first1]
               [stop-when stop?]))
  (second bb))

