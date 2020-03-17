#!/usr/bin/env bash
shen-scheme script scripts/do-build.shen
raco exe -o shen-racket ++lib racket/gui/base ++lib racket/gui ++lang racket ++lang racket/gui shen-scheme.scm
