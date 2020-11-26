#!/usr/bin/env bash

# Note: redirect the output of cat command
# This command same as the followings:
#   cat foo.txt bar.txt >new.txt
#   cat >new.txt foo.txt bar.txt
> test.txt cat foo.txt bar.txt
