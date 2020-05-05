#!/usr/bin/env bash

str='mh_dylib'

# Case 1: use `==`
if [ ${str} == "mh_dylib" ]; then
    echo "equal (use '==')"
else
    echo "not equal (use '==')"
fi

# Case 2: use `=`
if [ ${str} = "mh_dylib" ]; then
    echo "equal (use '=')"
else
    echo "not equal (use '=')"
fi

# Case 3: regex match
# @see https://stackoverflow.com/a/229606
string='My long string'
if [[ $string = *"My long"* ]]; then
    echo "It's there! (use '=')"
fi

if [[ $string == *"My long"* ]]; then
    echo "It's there! (use '==')"
fi
