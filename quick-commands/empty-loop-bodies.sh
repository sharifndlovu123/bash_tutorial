#!/usr/bin/env bash
# Bash has no `pass` keyword (that's Python). Use the `:` no-op builtin
# when a loop or branch needs a body but there is nothing to do.

while read -r line; do
    :
done

# `pass` here would try to run a command called "pass" on every iteration.
