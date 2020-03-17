;; Copyright (c) 2012-2019 Bruno Deferrari.  All rights reserved.
;; BSD 3-Clause License: http://opensource.org/licenses/BSD-3-Clause

(define-syntax raise-error
  (syntax-rules ()
    ((_ location message obj ...)
     (error location message obj ...))))

(define raise-error error)
(define *shen-globals* (make-hashtable symbol-hash eq?))

(define (shen-global-parameter-set! var parameter)
  (hashtable-set! *shen-globals* var parameter))

(define (shen-global-set! var value)
  (hashtable-set! *shen-globals* var value)
  value)

(define *hash-table-default* (string-append "_" "-"))

(define (shen-global-get var default)
  (let ((res (hashtable-ref *shen-globals* var *hash-table-default*)))
    (if (eq? res *hash-table-default*)
        (default var)
        (res))))

(define (kl-var-clean sym)
  (if (symbol? sym)
      (let* ((str (symbol->string sym))
             (len (string-length str)))
        (if (and (> len 3)
                 (string=? "kl:" (substring str 0 3)))
         (string->symbol (substring str 3 len))
         sym))
      sym))
(define-condition-type &format &condition
  make-format-condition format-condition?)
(define (error-message e)
  (let* ((msg (condition-message e))
         (irritants (if (irritants-condition? e) (condition-irritants e) '())))
    (cond ((format-condition? e) (apply format msg (map kl-var-clean irritants)))
          ((null? irritants) msg)
          (else (format "~a: ~{~s~}" msg irritants)))))

(define (error-location e)
  (if (who-condition? e)
      (condition-who e)
      '*unknown-location*))

(define (full-path-for-file filename)
  (if (absolute-path? filename)
      filename
      (string-append (path->string (current-directory))
                     ;"/";(string (directory-separator))
                     filename)))

(define (open-binary-input-file filename)
  (open-file-input-port filename))

(define (open-binary-output-file filename)
  (open-file-output-port filename (file-options no-fail)))

(define (time->float t)
  (+ (time-second t)
     (/ (time-nanosecond t) 1e+9)))

(define (swrite-byte byte o)
  (write-byte o byte)
  (flush-output-port o)
  byte)

(define (sread-byte i)
  (let ((byte (read-byte i)))
    (if (eof-object? byte)
        -1
        byte)))

(define (read-file-as-string filename)
  (call-with-input-file (full-path-for-file filename)
    (lambda (in)
      (let ((s (get-string-all in)))
        (if (eof-object? s)
            ""
            s)))))

(define (read-file-as-bytelist filename)
  (let* ((in (open-file-input-port (full-path-for-file filename)))
         (bytes (port->bytes in)))
    (close-input-port in)
    (if (eof-object? bytes)
        '()
        (bytes->list bytes))))

(define (hashtable-fold ht f init)
  (let-values (((keys values) (hashtable-entries ht)))
    (let ((limit (vector-length keys)))
      (let loop ((i 0)
                 (acc init))
        (if (fx=? i limit)
            acc
            (let ((k (vector-ref keys i))
                  (v (vector-ref values i)))
              (loop (fx+ i 1) (f k v acc))))))))
