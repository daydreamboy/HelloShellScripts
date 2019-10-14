#!/usr/bin/env bash

# @see https://stackoverflow.com/questions/8654051/how-to-compare-two-floating-point-numbers-in-bash

xcode_version=`xcodebuild -version | head -n 1 | cut -d' ' -f2`
xcode_10=10

if (( $(echo "$xcode_version >= $xcode_10" | bc -l) )); then
    echo "if"
else
    echo "else"
fi

