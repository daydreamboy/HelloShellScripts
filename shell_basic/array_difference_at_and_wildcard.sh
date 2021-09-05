#!/usr/bin/env bash

# Tutorial: https://unix.stackexchange.com/questions/135010/what-is-the-difference-between-and-when-referencing-bash-array-values

# Example1: use ${array[@]}
array=(1 2 3)
for i in "${array[@]}"; do
    echo "example.$i"
done

echo '---------------'

# Example2: use ${array[*]}
array=(1 2 3)
for i in "${array[*]}"; do
    echo "example.$i"
done

# Example3: use ${array[@]}, ${array[*]} with printf
printf 'data: ---%s---\n' "${array[@]}"
printf 'data: ---%s---\n' "${array[*]}"
