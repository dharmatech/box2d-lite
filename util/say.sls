
(library (box2d-lite util say)

  (export say say-expr)

  (import (rnrs))

  (define (say . elts)
    (for-each display elts)
    (newline))

  (define-syntax say-expr
    (syntax-rules ()
      ((say-expr expr)
       (begin
	 (display 'expr)
	 (display "	")
	 (display expr)
	 (newline)))))

  )