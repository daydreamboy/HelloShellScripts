#!/usr/bin/env bash

# declare an array variable
declare -a arr=("element1" "element2" "element3")

# Tutorial: https://stackoverflow.com/questions/8880603/loop-through-an-array-of-strings-in-bash
# Example1: using $index
for i in "${arr[@]}"
do
   echo "$i" # "$i" will print element, not the index
done

echo '---------'

# Tutorial: https://stackoverflow.com/questions/6723426/looping-over-arrays-printing-both-index-and-value
# Example2: use $array[index]
for i in "${!arr[@]}"; do
   echo "${i} = ${arr[${i}]}" # "$i" will print the index
done


