#lang racket
(provide (all-defined-out))

(require 2htdp/planetcute)
(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)

(define cs-grass-block (crop 3 27 51 53 (scale/xy 13/21 50/88 grass-block)))

(define cs-dirt-block (crop 3 27 51 53 (scale/xy 13/21 50/88 dirt-block)))

(define cs-stone-block (crop 3 27 51 53 (scale/xy 13/21 50/88 stone-block)))

(define cs-water-block (crop 3 27 51 53 (scale/xy 13/21 50/88 water-block)))

(define cs-plain-block (crop 3 27 51 53 (scale/xy 13/21 50/88 plain-block)))

(define cs-wood-block (crop 3 27 51 53 (scale/xy 13/21 50/88 wood-block)))

(define cs-wall-block (crop 3 27 53 53 (scale/xy 13/21 50/88 wall-block)))

(define cs-tree-short (crop 3 28 51 53 (scale/xy 12/21 47/88 tree-short)))

(define cs-tree-ugly (crop 0 28 51 53 (scale/xy 11/21 47/88 tree-ugly)))

(define cs-character-boy (crop 7 32 51 53 (scale/xy 14/21 52/88 character-boy)))

(define cs-yellow-star (crop 5 34 51 53 (scale/xy 14/21 54/88 yellow-star)))

(define cs-rock (crop 3 31 50 50 (scale/xy 12/21 45/88 rock)))

(define cs-heart (crop 0 23 51 53 (scale/xy 11/21 47/88 heart)))

(define cs-character-cat-girl (crop 7 29 51 53 (scale/xy 14/21 50/88 character-cat-girl)))

(define cs-ramp-east (crop 0 23 51 53 (scale/xy 12/21 39/88 ramp-east)))

(define cs-ramp-west (crop 6 23 51 53 (scale/xy 12/21 39/88 ramp-west)))

;(define sqr-50 (rectangle 50 50 "solid" "red"))
;(define Scene (empty-scene 500 500))
;(define pic cs-ramp-west)
;(define initial-pic
;  (place-images (list pic
;                      sqr-50
;                      pic
;                      pic)
;                (list (make-posn 75 25)
;                      (make-posn 75 75)
;                      (make-posn 25 25)
;                      (make-posn 125 75))
;                Scene))
;initial-pic
