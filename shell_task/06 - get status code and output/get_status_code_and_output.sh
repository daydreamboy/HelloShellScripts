#!/bin/bash

function execute_git
{
	output=$( /usr/bin/git clone "https://github.com/daydreamboy/HelloObjCRuntime.git" )
	echo $?
	echo $output
}

execute_git