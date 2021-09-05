#!/usr/bin/env bash

# Tutorial: https://serverfault.com/questions/477503/check-if-array-is-empty-in-bash/477506

array1=()
if [[ ${#array1[@]} -eq 0 ]]; then
    echo "empty"
else
    echo "not empty"
fi

if [[ ! ${#array1[@]} -eq 0 ]]; then
    echo "not empty"
else
    echo "empty"
fi

