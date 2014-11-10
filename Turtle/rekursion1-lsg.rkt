#lang racket
(require "racketturtle.rkt")

(define width 800) ; Determines the window's size (turtles' playground)
(define height 800)

(define dc (start width height))

(define harald (new turtle%
                    [tname 'Harald]
                    [xpos 400][ypos 500][direction 90]
                    [tcolor "YellowGreen"]
                    [tdc dc]))

;;; Lösungen der ÜA  (Programmierparadigmen)

; Aufgabe 1

(define rechteck
  (lambda (tl a b)
    (send tl forward! a)
    (send tl right! 90)
    (send tl forward! b)
    (send tl right! 90)
    (send tl forward! a)
    (send tl right! 90)
    (send tl forward! b)
    (send tl right! 90)))

; Aufgabe 2

(define nikolaus
  (lambda (tl seite)
    (let ([dach (sqrt (/ (* seite seite) 2))]
          [diagonale (sqrt (* 2 (* seite seite)))])
      (send tl forward! seite)
      (send tl right! 90)
      (send tl forward! seite)
      (send tl left! 135)
      (send tl forward! dach)
      (send tl left! 90)
      (send tl forward! dach)
      (send tl left! 90)
      (send tl forward! diagonale)
      (send tl left! 135)
      (send tl forward! seite)
      (send tl left! 135)
      (send tl forward! diagonale)
      (send tl left! 135)
      (send tl forward! seite)
      (send tl left! 90))))

; Aufgabe 3

(define kreisbogen
  (lambda (tl n)
    (if (= n 0)
        'finished
        (begin
          (send tl forward! 3)
          (send tl right! 1)
          (kreisbogen tl (- n 1))))))

; (kreisbogen harald 360)
; Schrittweite mind. 2 wählen

; Aufgabe 4

(define tree
  (lambda (side turtle)
    (if (< side 5)
        (send turtle crow)
        (begin
          (send turtle forward! side)
          (send turtle left! 45)
          (send turtle sleep 200)
          (tree (/ side 2) turtle)
          (send turtle right! 90)
          (send turtle sleep 200)
          (tree (/ side 2) turtle)
          (send turtle left! 45)
          (send turtle backward! side)))))

; (tree 100 harald)

; Aufgabe 5

(define rosette
  (lambda (tl seite winkel n)
    (if (= n 0)
        'fertig
        (begin
          (rechteck tl seite seite)
          (send tl right! winkel)
          (rosette tl seite winkel (- n 1))))))

; (rosette harald 100 10 36)






