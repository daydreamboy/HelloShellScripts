#!/usr/bin/env bash

foo() {
    echo ${FUNCNAME[0]}  # prints 'foo'
    echo ${FUNCNAME[1]}  # prints 'bar'
    echo ${FUNCNAME[2]}  # prints 'main'
    echo ${FUNCNAME[3]}  # no output
    echo ${FUNCNAME[4]}  # no output
}

bar() { foo; }
bar
