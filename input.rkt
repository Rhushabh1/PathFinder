#lang racket
(require racket/gui)
;(require "graphics.rkt")
(provide row col input state-input)

(define col 0)
(define row 0)
(define state-input 0)
(define frame (new frame%
                   [label "Example"]
                   [width 400]
                   [height 200]))
(define no-of-cols (new text-field%
                        [label "Enter no. of columns:"]
                        [parent frame]
                        [callback (lambda (t e) (void 1))]
                         
                         [vert-margin 10]
                         [horiz-margin 50]))

(define no-of-rows (new text-field%
                        [label "Enter no. of rows:"]
                        [parent frame]
                        [callback (lambda (t e) (void 1))]
                         
                         [vert-margin 0]
                         [horiz-margin 70]))

(new button% [parent frame]
             [label "Ok"]
             [callback (lambda (button event)
                         (set! row (string->number (send no-of-rows get-value)))
                         (set! col (string->number (send no-of-cols get-value)))
                         (set! state-input 1)
                         (send frame show #f))]
             [vert-margin 10]
             [horiz-margin 200])


(define (input)
  
(send frame show #t)
  

  )