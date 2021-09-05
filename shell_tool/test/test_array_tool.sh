#!/usr/bin/env bash

source '../array_tool.sh'
source '../../library/assert.sh/assert.sh'

test_array_remove_elements() {
    echo "<<< test begin: ${FUNCNAME[0]}"

    # Case1
    array=('x86' 'i386' 'arm64')
    to_remove=('arm64')
    declare -a output=($(array_remove_elements array[@] to_remove[@]))
    declare -p output

    assert_eq ${output[0]} 'x86' 'not equivalent!'
    assert_eq ${output[1]} 'i386' 'not equivalent!'

    echo ">>> test end: ${FUNCNAME[0]}"
}

test_array_remove_elements
