#!/usr/bin/env bash

# Check a script for syntax errors without running it
bash -n filename

# no output means the syntax is valid

# check whether the last command succeeded using its exit code
echo $?

# 0 = success
# anything else = failure
