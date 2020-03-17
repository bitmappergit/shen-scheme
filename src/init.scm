;; Copyright (c) 2012-2019 Bruno Deferrari.  All rights reserved.
;; BSD 3-Clause License: http://opensource.org/licenses/BSD-3-Clause

(kl:set '*language* "Scheme")
(kl:set '*implementation* "Racket")
(kl:set '*port* "0.22")
(kl:set '*release* (version))
(kl:set '*porters* "Bruno Deferrari, Bram Wyllie (Racket port)")
(kl:set '*home-directory* (current-directory))
(kl:set 'shen.*initial-home-directory* (current-directory))

(register-globals)

(kl:global/*sterror* (standard-error-port))
(kl:global/*stinput* (standard-input-port))
(kl:global/*stoutput* (standard-output-port))

(kl:_scm.initialize-compiler)
