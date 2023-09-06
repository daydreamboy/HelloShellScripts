#!/usr/bin/env bash
# 
# References:
#   http://www.dreamsyssoft.com/unix-shell-scripting/ifelse-tutorial.php

if [ -f 'if_else.sh' ]; then
    echo 'if_else.sh does exist.'
else
    echo 'if_else.sh not exists.'
fi

if [ -f 'if_else2.sh' ]; then
    echo 'if_else2.sh does exist.'
else
    echo 'if_else2.sh not exists.'
fi