#!/usr/bin/env bash

# Tutorial: https://linuxhint.com/return-string-bash-functions/
# Three styles to return a value from the function

# Style 1: use global variable
function return_value_using_global_variable() {
    return_value1='return value from function return_value_using_global_variable'
}

echo ${return_value1}
return_value_using_global_variable
echo ${return_value1}

# Style 2: use echo command and $(func)
function return_value_using_echo() {
    local return_value='return value from function return_value_using_echo'
    echo ${return_value}
}

return_value2=$(return_value_using_echo)
echo ${return_value2}

# Style 3: use return clause
function return_value_using_return_clause() {
    return 35
}

return_value3=$(return_value_using_return_clause)
echo ${return_value3}

return_value_using_return_clause
echo $?

# use nameref for indirection on Bash version 4.3+
#function return_value_using_out_parameter() {
#    local -n return_value=$1  # use nameref for indirection on Bash version 4.3+
#    return_value='return value from function return_value_using_echo'
#}
#
#return_value_using_out_parameter ${return_value4}
#echo ${return_value4}

