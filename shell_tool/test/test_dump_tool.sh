#!/usr/bin/env bash
source '../dump_tool.sh'

MY_VAR='hello, world'

test_dump_var() {
    echo "<<< test begin: ${FUNCNAME[0]}"

    dump_var PATH # This is comment
    dump_var MY_VAR

    echo ">>> test end: ${FUNCNAME[0]}"
}

test_dump_var