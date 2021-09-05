#!/usr/bin/env bash

# Example1: array of numbers
array1=(1 2 3)
echo ${array1[0]}
echo ${array1[1]}
echo ${array1[2]}

echo '----------------'

# Example2: array of strings
array2=('1' '2' '3')
echo ${array2[0]}
echo ${array2[1]}
echo ${array2[2]}

echo ${array2[@]}

# to print the array with its indexes, to check its state at any stage
declare -p array2

echo '----------------'

# Example3: use string to create an array
string='a b    c'
array3=(${string})
declare -p array3

# Example4: use another array to create an array
init_array1=('x' 'y' 'z')
array4=(${init_array1[@]})
declare -p array4

# Example5: use another array to create an array
init_array2=('x y z')
array5=(${init_array2[@]})
declare -p array5
