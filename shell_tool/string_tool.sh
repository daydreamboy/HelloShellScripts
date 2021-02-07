#!/usr/bin/env bash

##
# Split string into array and get the item at the index
#
# @param separator
# @param index
# @param string
# @return the item at the index
#
# @see https://stackoverflow.com/a/10586169
#
string_split() {
    separator=$1
    index=$2
    string=$3

    IFS=$1 read -r -a array <<< "$string"
    echo ${array[${index}]}
}

##
# Split string into array and check the item if contained in the array
#
# @param separator
# @param check_item
# @param string
# @return true if the item contained, or false if not contained
#
# @see https://stackoverflow.com/a/15394738
#
string_split_contains() {
    separator=$1
    check_item=$2
    string=$3

    IFS=$1 read -r -a array <<< "$string"
    value=${array[0]}

    if [[ " ${array[@]} " =~ " ${check_item} " ]]; then
        # whatever you want to do when array contains value
        echo true
    else
        echo false
    fi
}

string_split_not_contains() {
    separator=$1
    check_item=$2
    string=$3

    IFS=$1 read -r -a array <<< "$string"
    value=${array[0]}

    if [[ ! " ${array[@]} " =~ " ${check_item} " ]]; then
        # whatever you want to do when array doesn't contain value
        echo true
    else
        echo false
    fi
}

test_string_split() {
    echo "<<< test begin: ${FUNCNAME[0]}"

    string_split ' ' 0 'x86_64 i386'
    string_split ' ' 1 'x86_64 i386'

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


if [[ "${1}" == "--test" ]]; then
    test_string_split "${@}"
    test_string_split_contains "${@}"
    test_string_split_not_contains "${@}"
fi