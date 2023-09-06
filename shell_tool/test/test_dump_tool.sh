#!/usr/bin/env bash
source '../dump_tool.sh'

MY_VAR='hello, world'

test_dump_var() {
    echo "<<< test begin: ${FUNCNAME[0]}"

    dump_var PATH # This is comment
    dump_var MY_VAR

    echo ">>> test end: ${FUNCNAME[0]}"
}

test_dump_var_verbose_mode() {
    echo "<<< test begin: ${FUNCNAME[0]}"

    dump_var PATH true # This is comment
    dump_var MY_VAR true

    echo ">>> test end: ${FUNCNAME[0]}"
}

test_dump_var
test_dump_var_verbose_mode