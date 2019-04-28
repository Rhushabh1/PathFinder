#lang racket
(require racket/gui)
(define col 0)
(define row 0)

(define frame (new frame%
                   [label "Example"]
                   [width 400]
                   [height 200]))
(define no-of-cols (new text-field%
                        [label "Enter no. of columns:"]
                        [parent frame]
                        [callback (lambda (t e) (set! col (string->number (send t get-value))))]
                         
                         [vert-margin 10]
                         [horiz-margin 50]))

(define no-of-rows (new text-field%
                        [label "Enter no. of rows:"]
                        [parent frame]
                        [callback (lambda (t e) (set! row (string->number (send t get-value))))]
                         
                         [vert-margin 0]
                         [horiz-margin 70]))

(new button% [parent frame]
             [label "Ok"]
             [callback (lambda (button event) (send frame show #f))]
             [vert-margin 10]
             [horiz-margin 200])



(send frame show #t)