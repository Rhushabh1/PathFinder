#lang racket
(define maps%
  (class object%
    (init-field ROW)
    (init-field COL)
    (init-field obstacles) ;list of coordinates of obstacles
    (super-new)
    (define temp-vector (build-vector ROW (lambda (x) (make-vector COL 0))))
    (field [ MAP (build temp-vector obstacles ROW COL)])
    
    ))

;checks whether pair is present in obstacle list or not
  (define (check pair obstacle)
      (if (null? obstacle) #f
      (if (equal? pair (car obstacle)) #t
          (check pair (cdr obstacle)))))

 
(define (build vec obstacle ROW COL)
  (define i 0)
  ;iterate and update on one row of 2d-vector 
  (define (row-build row-vec )
    (define j 0)
    (define (iter)
      (if (> j (- COL 1)) (void 1)
          (begin (if (check (cons i j) obstacle) (vector-set! row-vec j 1) (void 1))
                 (set! j (+ j 1))
                 (iter))))
    (iter))

  ; send each row of vec to iter (above)
  (define (iter1)
    (if (> i (- ROW 1)) (void 1) 
        (begin (row-build (vector-ref  vec i))
               (set! i (+ i 1))
               (iter1))))
  (begin (iter1)
         vec) ;return updated vec
  ) 

(define lst (list (cons 1 1) (cons 2 2) (cons 3 3)))
(define vec1 (build-vector 5 (lambda (x) (make-vector 5 0))))

(define ex (build vec1 lst 5 5))

(define ex1 (make-object maps% 8 8 lst))


  