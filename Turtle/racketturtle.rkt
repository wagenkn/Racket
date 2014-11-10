;;; A turtle system for Racket (Christian Wagenknecht, 2014)

#lang racket
(require racket/gui/base)

(provide start turtle%)   ; for module reasons

;; Initialization of the window including the canvas

(define (start w h)   ; returns a dc for drawing on canvas
  (let* ([tpg (new frame% 
                   [label "The turtles playground"]
                   [width w]
                   [height h])]
         [tcanvas (new canvas% [parent tpg])])
    (send tpg show #t)
    (printf "Window size~n width (x): ~a, height (y): ~a~n" w h)
    (send tcanvas get-dc)))

;; turtle%-class definition

(define turtle%
  (class object%
    (super-new)
    (init tname xpos ypos tcolor direction tdc)  ; initialization arguments
    
    ; private fields
    
    (define name tname)     
    (define x xpos)
    (define y ypos)
    (define dc tdc)
    (define angle direction)     
    (define turtle-color tcolor)
    (define initial-pen-color "Orange")
    (define pen-color "Orange") 
    (define bgcolor "White")
    (define visible? #t) 
    (define pendown? #t)
    
    ; private methods
    
    (define/private (draw-triangle x1 y1 x2 y2 x3 y3 turtlecolor)
      (send dc set-pen (send the-color-database find-color turtlecolor) 1 'solid)
      (send dc draw-line x1 y1 x2 y2)
      (send dc draw-line x2 y2 x3 y3)
      (send dc draw-line x3 y3 x1 y1))
    
    (define/private (draw-turtle)
      (let ((wa (* angle (/ pi 180))))
        (let ((xa (- x (/ (* (cos wa) 30) 2)))
              (ya (+ y (/ (* (sin wa) 30) 2))))
          (let ((x1 (+ xa (* 30 (cos wa))))
                (y1 (- ya (* 30 (sin wa))))
                (x2 (+ xa (* 10 (sin wa))))
                (y2 (+ ya (* 10 (cos wa))))
                (x3 (- xa (* 10 (sin wa))))
                (y3 (- ya (* 10 (cos wa)))))            
            (if visible?
                (draw-triangle x1 y1 x2 y2 x3 y3 turtle-color)
                (draw-triangle x1 y1 x2 y2 x3 y3 bgcolor))))))
    
    (define/private (move dist)
      (let ([xold x] [yold y])
        (remove-turtle)
        (set! x (+ x (* dist (cos (* angle (/ pi 180))))))
        (set! y (- y (* dist (sin (* angle (/ pi 180))))))
        (if pendown?
            (begin
              (send dc set-pen (send the-color-database find-color pen-color) 2 'solid)
              (send dc draw-line xold yold x y))
            'hidden)
        (draw-turtle)))
    
    (define/private (remove-turtle)
      (let ([current-visible? visible?])
        (set! visible? #f)
        (draw-turtle)
        (set! visible? current-visible?)))
    
    ; public methods
    
    (define/public (show!)
      (set! visible? #t)
      (draw-turtle))
    
    (define/public (hide!) 
      (set! visible? #f)
      (remove-turtle))
    
    (define/public (crow)  ; to crow = vor Freude quietschen
      (bell)  ;(play-sound "beep.wav" #f) - takes too much time
      (sleep-for-a-while 150)) ; (beep) goes asynchronous    
    
    (define/public (sleep ms)
      (sleep-for-a-while ms)
      'awaked)
    
    (define/public (say-your-name)(display name)(newline))
    
    (define/public (forward! dist) (move dist))
    (define/public (backward! dist) (move (- dist)))
    
    (define/public (right! a)
      (remove-turtle)
      (set! angle (- angle a))
      (draw-turtle))
    
    (define/public (left! a)
      (remove-turtle)
      (set! angle (+ angle a))
      (draw-turtle))
    
    (define/public (pen-up!)
      (set! pen-color initial-pen-color)
      (set! pendown? #f))
    
    (define/public (pen-down!) 
      (set! pen-color initial-pen-color)
      (set! pendown? #t))
    
    (define/public (pen-erase!)
      (set! pen-color bgcolor)
      (set! pendown? #t))
    
    (define/public (set-pen-color! col) 
      (set! initial-pen-color col)
      (set! pen-color col))
    
    (define/public (set-turtle-color! col) 
      (set! turtle-color col)
      (draw-turtle))
    
    (define/public (clone)
      (let ([my-name (string->symbol (string-append (symbol->string name) "-c"))])
        (let 
            ([cloned-turtle
              (new turtle% 
                   [tname my-name] 
                   [xpos x] [ypos y] [direction angle] 
                   [tcolor turtle-color] [tdc dc])])
          (send cloned-turtle hide!)
          cloned-turtle)))))

;; Note: Working with two different pens does not contribute to improve the 
;  quality of the drawing. (little gaps on the line caused by the turtle redrawings)

; ------------------------

;; utility procedures

(define sleep-for-a-while
  (lambda (pause)
    (let ([start (current-milliseconds)])
      (define waiter
        (lambda ()
          (if (>= (current-milliseconds) (+ start pause))
              (void)
              (waiter))))
      (waiter))))

;(sleep-for-a-while 1000)  ; waits for one second

