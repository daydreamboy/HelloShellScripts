#!/bin/bash
# 
# Example:
#		bash ./call_func_from_command.sh testA
#		./call_func_from_command.sh testA 123
#		./call_func_from_command.sh testB 123 456
#		./call_func_from_command.sh -h
#		./call_func_from_command.sh help
#
#	Reference:
#		http://stackoverflow.com/questions/8818119/how-can-i-run-a-function-from-a-script-in-command-line
#


testA() {
  echo "TEST A $1";
}

testB() {
  echo "TEST B $2";
}

-h() {
	echo "-h"
}

help() {
	echo "help"
}

# call arguments verbatim:
"$@"