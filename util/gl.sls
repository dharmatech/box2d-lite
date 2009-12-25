
(library (box2d-lite util gl)

  (export gl-vec)

  (import (rnrs) (gl) (box2d-lite vec))

  (define (gl-vec v)
    (is-vec v)
    (glVertex2d v.x v.y))

  )