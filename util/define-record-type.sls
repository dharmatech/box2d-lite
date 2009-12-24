
(library (box2d-lite util define-record-type)

  (export define-record-type++)

  (import (rnrs)
	  (box2d-lite util define-is-type-syntax)
	  (box2d-lite util define-import-type-syntax))

  (define-syntax define-record-type++
    
    (syntax-rules (fields methods)
      
      ((define-record-type++ type
	 is-type
	 import-type
	 (fields (mutable field)
		 ...)
	 (methods (name proc)
		  ...))
       
       (begin

	 (define-record-type type
	   (fields (mutable field)
		   ...))

	 (define-is-type-syntax is-type
	   type
	   (fields field ...)
	   (methods (name proc) ...))

	 (define-import-type-syntax import-type
	   type
	   (fields field ...)
	   (methods (name proc) ...))))))

  )