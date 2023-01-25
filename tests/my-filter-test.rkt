#lang racket
(require rackunit)
(require rackunit/text-ui)
(require "../solucion.rkt")

(run-tests (test-suite "Ejercicio 1"
    #:before (lambda () (display "my-filter: \n" ))
    (test-case "my-filter"
        (check-equal? (my-filter (lambda (n) (> n 1)) '(1 2 3 4 5)) '(2 3 4 5 6))
        (check-equal? (my-filter (lambda (n) (>= n 1)) '(1 2 3 4 5)) '(1 2 3 4 5))
        (check-equal? (my-filter (+ 1 2) '()) '())
    'normal)))