
(library (box2d-lite world-parameters)

  (export accumulate-impulses
	  warm-starting
	  position-correction)

  (import (rnrs)
	  (surfage s39 parameters))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (define accumulate-impulses (make-parameter #t))
  (define warm-starting       (make-parameter #t))
  (define position-correction (make-parameter #t))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  )