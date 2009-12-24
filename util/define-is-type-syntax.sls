
(library (box2d-lite util define-is-type-syntax)

  (export define-field-syntax
	  define-is-type-syntax
	  )

  (import (rnrs)
	  (dharmalab misc gen-id))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (define-syntax define-get-field-syntax
    (lambda (stx)
      (syntax-case stx ()
	((_ var type field)
	 (with-syntax ((var.field (gen-id #'var #'var  "." #'field))
		       (getter    (gen-id #'var #'type "-" #'field)))
	   #'(define-syntax var.field
	       (identifier-syntax
		(getter var))))))))

  (define-syntax define-set-field-syntax
    (lambda (stx)
      (syntax-case stx ()
	((_ var type field)
	 (with-syntax ((var.field! (gen-id #'var #'var  "." #'field "!"))
		       (setter     (gen-id #'var #'type "-" #'field "-set!")))
	   #'(define-syntax var.field!
	       (syntax-rules ()
		 ((var.field! val)
		  (setter var val)))))))))

  (define-syntax define-field-syntax
    (syntax-rules ()
      ((define-field-syntax var type field)
       (begin
	 (define-get-field-syntax var type field)
	 (define-set-field-syntax var type field)))))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (define-syntax define-record-method-syntax
    (lambda (stx)
      (syntax-case stx ()
	((_ var name proc)
	 (with-syntax ((var.name (gen-id #'var #'var "." #'name)))
	   (syntax
	    (define-syntax var.name
	      (syntax-rules ()
		((var.name arg (... ...))
		 (proc var arg (... ...)))))))))))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (define-syntax define-is-type-syntax
    (syntax-rules (fields methods)
      ((_ is-type type (fields field ...) (methods (name proc) ...))
       (define-syntax is-type
	 (syntax-rules ()
	   ((is-type var)
	    (begin
	      (define-field-syntax var type field)
	      ...
	      (define-record-method-syntax var name proc)
	      ...)))))))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  )