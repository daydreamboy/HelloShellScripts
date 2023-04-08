#!/usr/bin/env zsh

#echo $funcfiletrace[3]
#echo $funcsourcetrace
#echo $funcstack
#
#frame=`echo $funcfiletrace[3]`
#echo $frame
#
#if [[ ! -z $frame ]]; then
#  echo "frame is empty"
#fi

source '../callstack_tool.sh'
callstack_zsh