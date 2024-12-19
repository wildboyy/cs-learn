(define (over-or-under num1 num2)
    (if (< num1 num2)
        -1
        (if (= num1 num2)
            0
            1
        )
    )

)

(define (make-adder num)
    (lambda (inc) (+ num inc)))

(define (composed f g)
    (lambda (x) (f (g x))))

(define (repeat f n)
    (define (g x)
        (if (= n 0)
            x
            (begin (set! n (- n 1))
                   (g (f x))
                )
            )
        )
    g
    )


(define (max a b)
  (if (> a b)
      a
      b))

(define (min a b)
  (if (> a b)
      b
      a))

(define (gcd a b)
    (if (= (min a b) 0)
        (max a b)
        (gcd (min a b) (modulo (max a b) (min a b)))
        )
    )
