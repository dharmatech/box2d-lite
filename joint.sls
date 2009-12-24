
(library (box2d-lite joint)

  (export make-joint

	  joint::pre-step
	  joint::apply-impulse
	  )

  (import (rnrs)
	  (box2d-lite util define-record-type)
	  (box2d-lite vec)
	  (box2d-lite mat)
	  (box2d-lite body)
	  (box2d-lite world-parameters)
	  )

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (define-record-type++ joint
    is-joint
    import-joint
    (fields (mutable m)
	    (mutable local-anchor-1)
	    (mutable local-anchor-2)
	    (mutable r1)
	    (mutable r2)
	    (mutable bias)
	    (mutable p)
	    (mutable body-1)
	    (mutable body-2)
	    (mutable bias-factor)
	    (mutable softness))
    (methods)
    )

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (define (joint::pre-step j inv-dt)

    (import-joint j)

    (is-body body-1)
    (is-body body-2)

    (is-vec r1)
    (is-vec r2)

    (is-vec bias)
    (is-vec p)

    (r1! (m*v (angle->mat body-1.rotation) local-anchor-1))
    (r2! (m*v (angle->mat body-2.rotation) local-anchor-2))

    (m!
     (mat::invert
      (m+m
       (mat-by-rows (+ body-1.inv-mass body-2.inv-mass) 0.0
		    0.0 (+ body-1.inv-mass body-2.inv-mass))
       
       (mat-by-rows (* body-1.inv-i r1.y r1.y   ) (* body-1.inv-i r1.x r1.y -1)
		    (* body-1.inv-i r1.x r1.y -1) (* body-1.inv-i r1.x r1.x   ))

       (mat-by-rows (* body-2.inv-i r2.y r2.y   ) (* body-2.inv-i r2.x r2.y -1)
		    (* body-2.inv-i r2.x r2.y -1) (* body-2.inv-i r2.x r2.x   ))

       (mat-by-rows softness 0
		    0 softness))))

    (if (position-correction)
	(bias! (n*v (* -1 bias-factor inv-dt)
		    (v- (v+ body-2.position r2)
			(v+ body-1.position r1))))
	(bias.set 0.0 0.0))

    (if (warm-starting)

	(begin

	  (body-1.velocity! (v- body-1.velocity (n*v body-1.inv-mass p)))

	  (body-1.angular-velocity!
	   (- body-1.angular-velocity (* body-1.inv-i (vxv r1 p))))

	  (body-2.velocity! (v+ body-2.velocity (n*v body-2.inv-mass p)))

	  (body-2.angular-velocity!
	   (+ body-2.angular-velocity (* body-2.inv-i (vxv r2 p)))))

	(p.set 0.0 0.0)))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (define (joint::apply-impulse j)

    (import-joint j)

    (is-body body-1)
    (is-body body-2)

    (let ((dv (v- (v- (v+ body-2.velocity
			  (nxv body-2.angular-velocity
			       r2))
		      body-1.velocity)
		  (nxv body-1.angular-velocity r1))))

      (let ((impulse (m*v m (v- (v- bias dv) (n*v softness p)))))

	(body-1.velocity! (v- body-1.velocity (n*v body-1.inv-mass impulse)))

	(body-1.angular-velocity!
	 (- body-1.angular-velocity (* body-1.inv-i (vxv r1 impulse))))

	(body-2.velocity! (v+ body-1.velocity (n*v body-2.inv-mass impulse)))

	(body-2.angular-velocity!
	 (+ body-2.angular-velocity (* body-2.inv-i (vxv r2 impulse))))

	(p! (v+ p impulse)))))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  )
	    
    