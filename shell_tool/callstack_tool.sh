#!/usr/bin/env bash

##
# print call stack of the file contains this function call
#
# @return the call stack info. The format is
# [frame no.] <filename>:<lineno> <routine>: <source code line>
#
# @see https://stackoverflow.com/a/62757929
#
function callstack {
   # Note: index `i` start with 1, not 0, will ignore this function call
   # For more accurate, let i start with 0
   local i=0 line file func
   while read -r line func file < <(caller $i); do
      echo >&2 "[$i] $file:$line $func(): $( if [[ -f $file ]]; then sed -n ${line}p $file; fi )"
      ((i++))
   done
}

# zsh version of callstack
function callstack_zsh {
   # Note: index `i` start with 1, and include this function call
   local i=1 line file
   frame=$funcfiletrace[$i]

   while [[ ! -z $frame ]]; do
       IFS=":"
       read -r file line <<< "$frame"
       echo >&2 "[$i] $file:$line: $( if [[ -f $file ]]; then sed -n ${line}p $file; fi )"
       ((i++))
       frame=$funcfiletrace[$i]
   done
}
