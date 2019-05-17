#lang racket
(require racket/gui)
(provide sound)
(provide pathsound)
(provide click-sound)
(define (sound)
  (play-sound "gamemusic60.wav" #t))

(define (pathsound)
  (play-sound "gamefootmusic10.wav" #t))

(define (click-sound)
  (let ([x (random 2)])
    (cond [(= x 0)  (play-sound "click1.wav" #t)]
          [(= x 1) (play-sound "click2.wav" #t)]
         )))
          