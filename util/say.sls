;; Copyright 2016 Eduardo Cavazos
;;
;; Licensed under the Apache License, Version 2.0 (the "License");
;; you may not use this file except in compliance with the License.
;; You may obtain a copy of the License at
;;
;;     http://www.apache.org/licenses/LICENSE-2.0
;;
;; Unless required by applicable law or agreed to in writing, software
;; distributed under the License is distributed on an "AS IS" BASIS,
;; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;; See the License for the specific language governing permissions and
;; limitations under the License.

(library (box2d-lite util say)

  (export say say-expr)

  (import (rnrs))

  (define (say . elts)
    (for-each display elts)
    (newline))

  (define-syntax say-expr
    (syntax-rules ()
      ((say-expr expr)
       (begin
	 (display 'expr)
	 (display "	")
	 (display expr)
	 (newline)))))

  )