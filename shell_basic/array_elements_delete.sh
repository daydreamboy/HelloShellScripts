#!/usr/bin/env bash


# Tutorial: https://linuxhint.com/remove-specific-array-element-bash/
# Three style to delete elements from the array

# Style1: Remove elements using prefixes matching
function delete_elements_using_divide_sign() {
    array=(hello world hi)
    delete=(hello)
    echo ${array[@]/$delete}
    declare -p array

    delete=(h)
    echo ${array[@]/$delete}
    declare -p array
}


# Style2: Use unset command
function delete_elements_using_unset() {
    array1=(1 2 3)
    unset "array1[0]"

    echo ${array1[@]}
    declare -p array1

    echo ${array1[0]} # not 2, but it's empty
}

# Style3: use subarray
function delete_elements_using_subarray() {
    array=('e1' 'e2' 'e3' 'e4' 'e5' 'e6')
    echo "${array[@]:0:2}" # get subarray [0,2) from the original array
    echo "${array[@]:3}" # get subarray [3,+] from the original array

    new_array=("${array[@]:0:2}" "${array[@]:3}") # make a new array from the two subarrays
    echo "${array[@]}"
}

delete_elements_using_divide_sign
echo '---------------'
delete_elements_using_unset
echo '---------------'
delete_elements_using_subarray
