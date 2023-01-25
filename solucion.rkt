#|
SOLUCION PRACTICA 1
Compiladores 2023-2
Autor: Juan Alfonso Garduño Solis
|#

#lang nanopass
(provide (all-defined-out))

#|-------Ejercicio 1-------|#
(define (my-map f l)
  (match l
    ['() '()]
    [(cons h t) (cons (f h) (my-map f t))]))
(define (my-filter p l)
  (match l
    ['() '()]
    [(cons h t) (if (p h) (cons h (my-filter p t)) (my-filter p t))]))
(define (my-foldr f i l)
  (match l
    ['() i]
    [(cons h t) (f h (my-foldr f i t))]))
(define (my-foldl f acc l)
  (match l
    ['() acc]
    [(cons h t) (my-foldl f (f acc h) t)]))

#|-------Ejercicio 2-------|#

(define (caesar-char c n)
    (let* ([cn (char->integer c)])
        (cond
            [(char-upper-case? c)
                (integer->char (+ (modulo (+ n (- cn 65)) 26) 65))]
            [(and (>= cn 97) (<= cn 122)
                (integer->char (+ (modulo (+ n (- cn 97)) 26) 97)))]
            [else c])))

(define (caesar-encoder s n)
    (let* ([sl (string->list s)])
        (list->string (my-map (lambda (c) (caesar-char c n)) sl))))

(define (caesar-decoder s n)
    (let* ([sl (string->list s)])
        (list->string (my-map (lambda (c) (caesar-char c (- 0 n))) sl))))

#|-------Ejercicio 3-------|#
; public int[] twoSum(int[] nums, int target) {
;         HashMap<Integer, Integer> m= new HashMap<>();
;         int comp;
;         for (int i=0; i<nums.length ; i++) {
;             comp = target - nums[i];
;             if (m.containsKey(comp)) {
;                 return  new int[] {m.get(comp),i};
;             }
;             m.put(nums[i],i);
;         }
;         throw new IllegalArgumentException("No solution");
;     }


(define (get-two l o)
        (define indx 0)
        (define r '("error"))
        (let* ([m (make-hash)])
            (for-each (lambda (i)  (if (hash-has-key? m (- o i))
                                   (set! r (list (hash-ref m (- o i)) indx))
                                   (begin  (hash-set! m i indx)
                                           (set! indx (add1 indx))) )) l)
            r))

#|-------Ejercicio 4-------|#
(define (palindromo a)
        (cond
          [(integer? a) (equal? (string->list (~v a)) (my-reversel (string->list (~v a))))]
          [(string? a) (equal? (string->list (string-downcase a)) (my-reversel (string->list (string-downcase a))))]
          [(list? a) (equal? a (my-reversel a))]))


(define (quita c m)
        (if (hash-has-key? m c) (hash-ref m c) c))

(define (es-anagrama s1 s2 m)
        (equal? s1 (sort (my-map (lambda (c) (quita c m)) (string->list (string-downcase s2))) char<?)))

(define (anagramas-de a l)
    (let ([m (make-hash)]
          [a-ord (sort (string->list (string-downcase a)) char<?)])
        (begin
         (hash-set*! m #\á #\a #\é #\e #\í #\i #\ó #\o #\ú #\u)
         (set! a-ord (my-map (lambda (c) (quita c m)) a-ord))
         (my-filter (lambda (p) (es-anagrama a-ord p m)) l))))


#|-------Ejercicio 5-------|#
; collatz :: Int -> Int
; collatz n
;         | even n = div n 2
;         | otherwise = n * 3 + 1

; listaCollatz :: Int -> [Int]
; listaCollatz 1 = [1]
; listaCollatz n = n : listaCollatz (collatz n)

; pasosCollatz :: Int -> Int
; pasosCollatz n = length (listaCollatz n) - 1


(define (collatz n)
        (if (even? n) (/ n 2) (+ (* 3 n) 1)))

(define (lista-collatz n)
        (cond
          [(eq? n 1) (list 1)]
          [else (cons n (lista-collatz (collatz n)))]))

(define (pasos-collarz n)
        (my-lengthl (lista-collatz n)))

#|-------Ejercicio extra-------|#
#|Con foldr|#
(define (my-lengthr l)
        (my-foldr (lambda (x l) (+ 1 l)) 0 l))
(define (my-reverser l)
        (my-foldr (lambda (h t) (append t (list h))) '() l))
(define (my-appendr l1 l2)
        (my-foldr (lambda (h t) (cons h t)) l2 l1))
(define (my-concatenater l)
        (my-foldr (lambda (h t) (append h t)) '() l))

#|Con foldl|#
(define (my-lengthl l)
        (my-foldl (lambda (n t) (+ n 1)) 0 l))
(define (my-reversel l)
     (my-foldl (lambda (acc h) (cons h acc)) '() l))
(define (my-appendl l1 l2)
        (my-foldl (lambda (acc h) (append (list h) acc)) l2 l1))
(define (my-concatenatel l)
        (my-foldl (lambda (acc h) (append acc h)) '() l))