(define-library (shen primitives)
  (import (scheme base) (scheme case-lambda) (scheme eval)
          (scheme write) (scheme file) (scheme time) (scheme char)
          (srfi 69)
          (chibi match)
          (only (scheme) call-with-output-string)
          (only (chibi pathname) make-path)
          (only (chibi filesystem) file-exists?)
          (only (chibi io) port->string read-u8))

  (export
   $$set-shen-environment!
   $$function-binding
   $$toggle-tracing!
   $$read-file-as-bytelist
   $$read-file-as-string
   $$eval-in-shen
   kl:if
   kl:and
   kl:or
   kl:cond
   kl:intern
   kl:pos
   kl:tlstr
   kl:cn
   kl:str
   kl:string?
   kl:string->n
   kl:n->string
   kl:set
   kl:value
   kl:simple-error
   kl:trap-error
   kl:error-to-string
   kl:cons
   kl:hd
   kl:tl
   kl:cons?
   kl:defun
   kl:lambda
   kl:let
   kl:=
   kl:eval-kl
   kl:freeze
   kl:type
   kl:absvector
   kl:<-address
   kl:address->
   kl:absvector?
   kl:pr
   kl:read-byte
   kl:open
   kl:close
   kl:get-time
   kl:+
   kl:-
   kl:*
   kl:/
   kl:>
   kl:<
   kl:>=
   kl:<=
   kl:number?

   kl->scheme)
  (include "primitives.scm"))
