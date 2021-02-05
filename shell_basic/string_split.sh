#!/usr/bin/env bash

# @see https://stackoverflow.com/a/10586169
string='x86_64 i386'
IFS=', ' read -r -a array <<< "$string"
echo ${array[0]}
echo ${array[1]}

. ../shell_tool/string_tool.sh



