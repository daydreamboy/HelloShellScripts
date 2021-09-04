#!/usr/bin/env bash
source '../string_tool.sh'
source '../../library/assert.sh/assert.sh'

test_string_split() {
    echo "<<< test begin: ${FUNCNAME[0]}"

    assert_eq $(string_split ' ' 0 'x86_64 i386') 'x86_64' 'not equivalent!'
    assert_eq $(string_split ' ' 1 'x86_64 i386') 'i386' 'not equivalent!'

    echo ">>> test end: ${FUNCNAME[0]}"
}

test_string_split_contains() {
    echo "<<< test begin: ${FUNCNAME[0]}"

    string_split_contains ' ' 'x86_64' 'x86_64 i386'
    string_split_contains ' ' 'arm64' 'x86_64 i386'

    echo ">>> test end: ${FUNCNAME[0]}"
}

test_string_split_not_contains() {
    echo "<<< test begin: ${FUNCNAME[0]}"

    string_split_not_contains ' ' 'x86_64' 'x86_64 i386'
    string_split_not_contains ' ' 'arm64' 'x86_64 i386'

    echo ">>> test end: ${FUNCNAME[0]}"
}

test_string_split "${@}"
test_string_split_contains "${@}"
test_string_split_not_contains "${@}"
