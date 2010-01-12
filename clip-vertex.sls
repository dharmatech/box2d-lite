
(library (box2d-lite clip-vertex)

  (export make-clip-vertex

	  clip-vertex-v
	  ;; clip-vertex-fp
          clip-vertex-e

	  clip-vertex-v-set!
	  ;; clip-vertex-fp-set!
          clip-vertex-e-set!

	  is-clip-vertex
	  import-clip-vertex

	  create-clip-vertex
	  )

  (import (rnrs)
	  (box2d-lite util define-record-type)
	  (box2d-lite vec)
	  (box2d-lite feature-pair)
	  )

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; (define-record-type++ clip-vertex
  ;;   is-clip-vertex
  ;;   import-clip-vertex
  ;;   (fields (mutable v)
  ;;           (mutable fp))
  ;;   (methods))

  (define-record-type++ clip-vertex
    is-clip-vertex
    import-clip-vertex
    (fields (mutable v)
	    (mutable e))
    (methods))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (define (create-clip-vertex)
    (make-clip-vertex
     (make-vec 0.0 0.0)
     (create-edges)))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  )
     