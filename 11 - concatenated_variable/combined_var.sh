#!/usr/bin/env bash


# @see https://stackoverflow.com/a/18124325

suffix=bzz
declare prefix_$suffix=mystr
#declare prefix_$suffix=

varname=prefix_$suffix
echo ${!varname}
echo ${varname}
