
(library (box2d-lite compute-incident-edge)

  (export compute-incident-edge)

  (import (rnrs)
	  (dharmalab misc is-vector)
	  (box2d-lite util say)
	  (box2d-lite util define-record-type)
	  (box2d-lite util math)
	  (box2d-lite vec)
	  (box2d-lite mat)
	  (box2d-lite clip-vertex)
	  (box2d-lite feature-pair)
	  (box2d-lite edge-numbers)
	  )

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (define (compute-incident-edge c h pos rot normal)

    (define i 0)

    (is-vector       c i)
    (is-clip-vertex  c.i)
    (is-vec          c.i.v)
    (is-feature-pair c.i.fp)
    (is-edges        c.i.fp.e)

    (is-vec h)

    (is-mat rot)

    ;; (say "compute-incident-edge")

    (let ((rot-t (rot.transpose)))

      (let ((n (vec::neg (m*v rot-t normal))))

	(let ((n-abs (vec::abs n)))
	  
	  (is-vec n)
	  (is-vec n-abs)

	  ;; (say "n		" n)

	  (if (> n-abs.x n-abs.y)

	      (if (> (sign n.x) 0.0)

		  (begin

		    ;; (say "********** BRANCH A B **********")

		    (set! i 0)

		    (c.i.v.set h.x (- h.y))
		    (c.i.fp.e.in-edge-2!  EDGE3)
		    (c.i.fp.e.out-edge-2! EDGE4)

		    (set! i 1)
		    
		    (c.i.v.set h.x h.y)
		    (c.i.fp.e.in-edge-2!  EDGE4)
		    (c.i.fp.e.out-edge-2! EDGE1))

		  (begin

		    ;; (say "********** BRANCH A C **********")

		    (set! i 0)

		    (c.i.v.set (- h.x) h.y)
		    (c.i.fp.e.in-edge-2!  EDGE1)
		    (c.i.fp.e.out-edge-2! EDGE2)

		    (set! i 1)
		    
		    (c.i.v.set (- h.x) (- h.y))
		    (c.i.fp.e.in-edge-2!  EDGE2)
		    (c.i.fp.e.out-edge-2! EDGE3)

		    ))

	      (if (> (sign n.y) 0.0)

		  (begin

		    ;; (say "********** BRANCH D E **********")

		    (set! i 0)

		    (c.i.v.set h.x h.y)
		    (c.i.fp.e.in-edge-2!  EDGE4)
		    (c.i.fp.e.out-edge-2! EDGE1)

		    (set! i 1)
		    
		    (c.i.v.set (- h.x) h.y)
		    (c.i.fp.e.in-edge-2!  EDGE1)
		    (c.i.fp.e.out-edge-2! EDGE2))

		  (begin

		    ;; (say "********** BRANCH D F **********")

		    (set! i 0)

		    (c.i.v.set (- h.x) (- h.y))
		    (c.i.fp.e.in-edge-2!  EDGE2)
		    (c.i.fp.e.out-edge-2! EDGE3)

		    (set! i 1)
		    
		    (c.i.v.set h.x (- h.y))
		    (c.i.fp.e.in-edge-2!  EDGE3)
		    (c.i.fp.e.out-edge-2! EDGE4)))))))

    (set! i 0) (c.i.v! (v+ pos (m*v rot c.i.v)))
    (set! i 1) (c.i.v! (v+ pos (m*v rot c.i.v)))

    )

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  )