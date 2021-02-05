#!/usr/bin/env bash

foo() {
    echo foo $1
}

test_foo() {
    foo 1
    foo 2
}

if [[ "${1}" != "--source-only" ]]; then
    test_foo "${@}"
fi
