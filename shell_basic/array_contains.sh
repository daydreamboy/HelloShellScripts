#!/usr/bin/env bash

string='x86_64 i386'
IFS=', ' read -r -a array <<< "$string"
echo ${array[0]}
echo ${array[1]}

value=${array[0]}

if [[ " ${array[@]} " =~ " ${value} " ]]; then
    # whatever you want to do when array contains value
    echo "contains"
fi

if [[ ! " ${array[@]} " =~ " ${value} " ]]; then
    # whatever you want to do when array doesn't contain value
    echo "not contains"
fi