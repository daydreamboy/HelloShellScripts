#!/usr/bin/env bash

source '../../library/assert.sh/assert.sh'

# test examples from https://github.com/daydreamboy/assert.sh

function test_assert_eq() {
    local expected actual
    expected="Hello"
    actual="World!"
    assert_eq "$expected" "$actual" "not equivalent!"
}

function test_log_success() {
    local expected actual
    expected="Hello"
    actual="Hello"
    assert_eq "$expected" "$actual"
    if [[ "$?" == 0 ]]; then
      log_success "assert_eq returns 0 if two words are equal"
    else
      log_failure "assert_eq should return 0"
    fi
}


test_assert_eq
test_log_success