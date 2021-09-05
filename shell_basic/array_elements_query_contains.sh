#!/usr/bin/env bash

# Tutorial: https://stackoverflow.com/questions/3685970/check-if-a-bash-array-contains-a-value


function example_contains() {
    array=(1 2 3)
    value=1

    if [[ " ${array[*]} " =~ " ${value} " ]]; then
        echo "contains \"${value}\""
    fi

    if [[ ! " ${array[*]} " =~ " ${value} " ]]; then
        echo "not contains \"${value}\""
    fi
}

function example_not_contains() {
    array=(1 2 3)
    value=4

    if [[ " ${array[*]} " =~ " ${value} " ]]; then
        echo "contains \"${value}\""
    fi

    if [[ ! " ${array[*]} " =~ " ${value} " ]]; then
        echo "not contains \"${value}\""
    fi
}

function example_string_not_contains() {
    array=(1 2 3)
    value='1 '

    if [[ " ${array[*]} " =~ " ${value} " ]]; then
        echo "contains \"${value}\""
    fi

    if [[ ! " ${array[*]} " =~ " ${value} " ]]; then
        echo "not contains \"${value}\""
    fi
}

function example_not_correct_when_remove_space() {
    array=(1 2 3)
    value='1 '

    echo "${array[*]}"

    if [[ "${array[*]}" =~ "${value}" ]]; then
        echo "contains \"${value}\""
    fi

    if [[ ! "${array[*]}" =~ "${value}" ]]; then
        echo "not contains \"${value}\""
    fi
}

example_contains
echo '-------------'
example_not_contains
echo '-------------'
example_string_not_contains
echo '-------------'
example_not_correct_when_remove_space
echo '-------------'
