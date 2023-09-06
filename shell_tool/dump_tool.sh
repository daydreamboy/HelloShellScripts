#!/usr/bin/env bash

function dump_var() {
    var_name=$1
    # Note: ${!var_name} is indirect reference
    var_value=${!var_name}

    caller_file=''
    caller_line=''
    caller_code=''

    local i=0 line file func
    while read -r line func file < <(caller $i); do
      #echo >&2 "[$i] $file:$line $func(): $( if [[ -f $file ]]; then sed -n ${line}p $file; fi )"
      caller_file=$file
      caller_line=$line
      caller_code=$( if [[ -f $file ]]; then sed -n ${line}p $file; fi )
      break
    done

    echo "[dump_tool] $var_name = '$var_value' ($caller_file:$caller_line:'$caller_code')"
}

