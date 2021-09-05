#!/usr/bin/env bash

# Tutorial: https://stackoverflow.com/a/24100864

function create_some_array() {
    local -a a=('x86' 'i386' 'arm64')
    echo ${a[@]}
}

declare -a return_value=$(create_some_array)
declare -p return_value

echo '-----------'
for i in ${return_value[@]}; do
   echo "${i}"
done

echo '-----------'

for i in "${return_value[@]}"; do
   echo "${i}"
done

echo '-----------'

real_array1=($(create_some_array))
declare -p real_array1

IFS=', ' read -r -a real_array2 <<< "${return_value}"
declare -p real_array2

for i in "${!real_array2[@]}"; do
   echo "${i} = ${real_array2[${i}]}"
done