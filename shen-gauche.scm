#!/usr/bin/env gosh -I. -mshen.runner

(import (gauche base) (scheme base))

((setter port-buffering) (current-output-port) :none)
((setter port-buffering) (current-input-port) :none)

(include "shen/runner.sld")
