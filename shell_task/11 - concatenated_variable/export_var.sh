#!/usr/bin/env bash

suffix=bzz
#declare prefix_$suffix=mystr

varname=prefix_$suffix
export
echo ${!varname}
echo ${varname}


$ var1=hello
$ var2=var1
$ echo ${!var2}