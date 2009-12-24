
(library (box2d-lite util math)

  (export FLT-MAX pi sign clamp)

  (import (rnrs))

  (define FLT-MAX 3.40282e+38)

  (define pi 3.14159265358979323846264)

  (define (sign n)
    (if (< n 0) -1 1))

  (define (clamp n low high)
    (max low (min n high)))

  )