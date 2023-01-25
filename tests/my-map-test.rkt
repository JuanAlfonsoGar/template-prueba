#lang racket
(require rackunit)
(require rackunit/text-ui)
(require "../solucion.rkt")

(run-tests (test-suite "Ejercicio 1"
    #:before (lambda () (display "my-map: \n" ))
    (test-case "my-map"
        (check-equal? (my-map (lambda (n) (+ n 1)) '(1 2 3 4 5)) '(2 3 4 5 6))
        (check-equal? (my-map (lambda (n) (- n 1)) '(1 2 3 4 5)) '(0 1 2 3 4))
        (check-equal? (my-map (lambda (n) (+ n 1)) '()) '())
    'normal)))
