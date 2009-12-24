
(library (box2d-lite feature-pair)

  (export make-edges

	  edges-in-edge-1
	  edges-out-edge-1
	  edges-in-edge-2
	  edges-out-edge-2

	  edges-in-edge-1-set!
	  edges-out-edge-1-set!
	  edges-in-edge-2-set!
	  edges-out-edge-2-set!

	  is-edges
	  import-edges

	  create-edges

	  edges-equal?

	  make-feature-pair

	  feature-pair-e
	  feature-pair-value

	  feature-pair-e-set!
	  feature-pair-value-set!

	  is-feature-pair
	  import-feature-pair

	  create-feature-pair

	  flip)

  (import (rnrs)
	  (srfi :27 random-bits)
	  (box2d-lite util define-record-type)
	  (box2d-lite edge-numbers)
	  )

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (define-record-type++ edges
    is-edges
    import-edges
    (fields (mutable in-edge-1)
	    (mutable out-edge-1)
	    (mutable in-edge-2)
	    (mutable out-edge-2))
    (methods))

  (define (create-edges)
    (make-edges NO-EDGE NO-EDGE NO-EDGE NO-EDGE))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (define (edges-equal? a b)

    (is-edges a)
    (is-edges b)

    (and (equal? a.in-edge-1  b.in-edge-1)
	 (equal? a.out-edge-1 b.out-edge-1)
	 (equal? a.in-edge-2  b.in-edge-2)
	 (equal? a.out-edge-2 b.out-edge-2)))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (define-record-type++ feature-pair
    is-feature-pair
    import-feature-pair
    (fields (mutable e)
	    (mutable value))
    (methods))

  ;; (define (create-feature-pair)
  ;;   (make-feature-pair (make-edges 0 0 0 0) 0))

  (define (create-feature-pair)
    (make-feature-pair (create-edges)
		       (random-integer 1000000000)
		       ))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (define (flip fp)

    (is-feature-pair fp)
    (is-edges        fp.e)

    (let ((tmp fp.e.in-edge-1))

      (fp.e.in-edge-1! fp.e.in-edge-2)

      (fp.e.in-edge-2! tmp))

    (let ((tmp fp.e.out-edge-1))

      (fp.e.out-edge-1! fp.e.out-edge-2)

      (fp.e.out-edge-2! tmp)))

  )