#lang racket
(require "racketturtle.rkt")

;;; How to use:

(define width 800) ; Determines the window's size (turtles' playground)
(define height 800)

(define dc (start width height))  ; drawing context

(define bob (new turtle% 
                 [tname 'Bob]
                 [xpos (/ width 2)][ypos (/ height 2)][direction 90]
                 [tcolor "YellowGreen"]
                 [tdc dc]))

;(send bob show!)


; ------------------------

;;; Examples

(define harald (new turtle% 
                    [tname 'Harald]
                    [xpos 400][ypos 500][direction 90]
                    [tcolor "YellowGreen"]
                    [tdc dc]))

;(send harald show!)
;(send harald forward! 50)

(define square
  (lambda (side turtle)
    (send turtle forward! side)
    (send turtle right! 90)
    (send turtle forward! side)
    (send turtle right! 90)
    (send turtle forward! side)
    (send turtle right! 90)
    (send turtle forward! side)
    (send turtle right! 90)))

;(square 100 harald)

(define square2
  (lambda (side turtle)
    (for ([n (in-range 4)])
      (send turtle forward! side)
      (send turtle right! 90))))

;(square2 100 harald)

(define tree
  (lambda (side turtle)
    (if (< side 5)
        (send turtle crow)   ; better than (void) or returning a symbol
        (begin
          (send turtle forward! side)
          (send turtle left! 45)
          (send turtle sleep 100)
          (tree (/ side 2) turtle)
          (send turtle right! 90)
          (send turtle sleep 100)
          (tree (/ side 2) turtle)
          (send turtle left! 45)
          (send turtle backward! side)))))

;(tree 200 harald)

(define harald2 (new turtle% 
                    [tname 'Harald2]
                    [xpos 600][ypos 500][direction 90]
                    [tcolor "YellowGreen"]
                    [tdc dc]))

(define startposition
  (lambda ()
    (send harald2 set-turtle-color! "Blue")
    (send harald set-pen-color! "Green")
    (send harald2 set-pen-color! "Red")
    (send harald pen-up!)
    (send harald right! 90)
    (send harald backward! 150)
    (send harald left! 90)
    (send harald pen-down!)
    (send harald2 show!)))

;(startposition)

(define rosette
  (lambda (n side phi turtle)
    (if (zero? n)
        (send turtle crow)
        (begin
          (square2 side turtle) 
          (send turtle right! phi)
          (rosette (- n 1) side phi turtle)))))

; (rosette 36 100 10 harald)
; (rosette 36 100 10 harald2)

(define randomwalk
  (lambda (steps distance angle turtle)
    (if (zero? steps)
        (send turtle crow)
        (begin
          (send turtle forward! distance)
          (send turtle left! angle)
          (send turtle sleep 70)         
          (randomwalk (- steps 1)(random 100)(random 361) turtle)
          (send turtle sleep 70)          
          (send turtle pen-erase!)
          (send turtle right! angle)
          (send turtle backward! distance)))))

;(randomwalk 80 (random 100)(random 361) harald)

; Threaded verison of the procedure

(define threaded-tree
  (lambda (side turtle)
    (cond
      [(< side 5) (send turtle show!)]
      [else
       (sleep 0.2)
       (send turtle say-your-name)
       (send turtle forward! side)
       (let ([t1 (send turtle clone)][t2 (send turtle clone)])
         (send t1 left! 45)
         (send t2 right! 45)
         (thread (lambda () (threaded-tree (/ side 2) t1)))
         (thread (lambda () (threaded-tree (/ side 2) t2))))])))

;(threaded-tree 250 harald)

