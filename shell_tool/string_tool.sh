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

    if [[ ! " ${array[@]} " =~ " ${value} " ]]; then
        # whatever you want to do when array doesn't contain value
        echo true
    else
        echo false
    fi
}

test_string_split() {
    string_split ' ' 0 'x86_64 i386'
    string_split ' ' 1 'x86_64 i386'
}

test_string_split_contains() {
    string_split_contains ' ' 'x86_64' 'x86_64 i386'
    string_split_contains ' ' 'arm64' 'x86_64 i386'
}

test_string_split_not_contains() {
    string_split_not_contains ' ' 'x86_64' 'x86_64 i386'
    string_split_not_contains ' ' 'arm64' 'x86_64 i386'
}


if [[ "${1}" == "--test" ]]; then
    test_string_split "${@}"
    test_string_split_contains "${@}"
    test_string_split_not_contains "${@}"
fi