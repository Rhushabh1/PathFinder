#lang racket
;testing planetcute and grid specs

(require 2htdp/planetcute)
(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)

(define crop-scaled-grass (crop -1 27 50 50 (scale/xy 10/21 50/88 grass-block)))
(define scaled-grass (scale/xy 10/21 50/88 grass-block))

(define sqr-50 (rectangle 50 50 "solid" "red"))
(define Scene (empty-scene 500 500))
(define initial-pic
  (place-images (list scaled-grass
                      scaled-grass)
                (list (make-posn 25 75);(+ 3 85/2))
                      (make-posn 35 45))
                Scene))

;initial-pic
;crop-scaled-grass
;-------------------------------------------------upto this point, i have cropped the img to fit into 50x50
;stacking up the imgs to satisfy perspective

;arguments :- (list imgs) x-last-img y-last-img
(define (stack-up imgs x y)
  (cond [(null? (cdr imgs)) (place-image (car imgs)
                                         x y
                                         Scene)]
        [else (place-image (car imgs)
                           x y
                           (stack-up (cdr imgs) x (- y 50)))]))

(stack-up (build-list 5 (lambda (x) scaled-grass)) 25 (+ 25 (* 4 50)))

                                                         