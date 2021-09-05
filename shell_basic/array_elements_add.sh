#!/usr/bin/env bash

# Tutorial: https://stackoverflow.com/questions/55316852/append-elements-to-an-array-in-bash/55316891


# Example1: use array1+=array2
array1=(1 2 3)
array1+=(4 5 6)

echo ${array1[@]}

element='7'
array1+=(${element})
echo ${array1[@]}

# Example2:  use (array1[@] array2[@])
array2=(8)
array3=(9)
array4=(${array2[@]} ${array3[@]})
echo ${array4[@]}
