
(library (box2d-lite vec)

  (export make-vec

	  vec-x
	  vec-y

	  vec-x-set!
	  vec-y-set!

	  is-vec
	  import-vec

	  vec::set
	  vec::length
	  vec::abs
	  vec::neg

	  v+ v- v* v/

	  v+n v*n

	  n+v
	  n-v
	  n*v

	  vec-dot

	  vxv

	  vxn

	  nxv

	  v-v
	  
	  )

  (import (rnrs)
	  (box2d-lite util define-record-type))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (define-record-type++ vec
    is-vec
    import-vec
    
    (fields (mutable x)
	    (mutable y))
    
    (methods (set    vec::set)
	     (length vec::length)
	     (abs    vec::abs)))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (define (vec::set v new-x new-y)
    (import-vec v)
    (x! new-x)
    (y! new-y))

  (define (vec::length v)
    (import-vec v)
    (sqrt (+ (* x x) (* y y))))

  (define (vec::abs v)
    (is-vec v)
    (make-vec (abs v.x) (abs v.y)))

  (define (vec::neg v)
    (is-vec v)
    (make-vec (- v.x) (- v.y)))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (define (v+ a b)

    (is-vec a)
    (is-vec b)

    (make-vec (+ a.x b.x)
	      (+ a.y b.y)))

  (define (v- a b)

    (is-vec a)
    (is-vec b)

    (make-vec (- a.x b.x)
	      (- a.y b.y)))

  (define (v* a b)

    (is-vec a)
    (is-vec b)

    (make-vec (* a.x b.x)
	      (* a.y b.y)))

  (define (v/ a b)

    (is-vec a)
    (is-vec b)

    (make-vec (/ a.x b.x)
	      (/ a.y b.y)))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (define (v+n v n)

    (is-vec v)

    (make-vec (+ v.x n)
	      (+ v.y n)))

  (define (n*v n v)

    (is-vec v)

    (make-vec (* n v.x)
	      (* n v.y)))

  (define (v*n v n)

    (is-vec v)

    (make-vec (* n v.x)
	      (* n v.y)))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (define (n+v n v)

    (is-vec v)

    (make-vec (+ n v.x)
	      (+ n v.y)))

  (define (n-v n v)

    (is-vec v)

    (make-vec (- n v.x)
	      (- n v.y)))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  

  

  (define (vec-dot a b)

    (is-vec a)
    (is-vec b)

    (+ (* a.x b.x)
       (* a.y b.y)))

  (define (vxv a b)

    (is-vec a)
    (is-vec b)

    (- (* a.x b.y)
       (* a.y b.x)))

  (define (vxn v n)

    (is-vec v)

    (make-vec (*    n  v.y)
	      (* (- n) v.x)))

  (define (nxv n v)

    (is-vec v)

    (make-vec (* (- n) v.y)
	      (*    n  v.x)))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (define-syntax v-v
    (syntax-rules ()
      ((v-v a b)
       (v- a b))
      ((v-v a b c ...)
       (v-v (v- a b) c ...))))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  )