#!/bin/bash

function main
{
	read -p "Drag a folder here: " folder
	check_dir "$folder"
	if [ $? != 0 ]; then
		echo "it's not a folder! try again." >&1
		main
		return 1
	fi
	
	echo $folder >&1
}

## check $1 if a folder
function check_dir
{
	dir=$1
	if [[ ! -d $dir ]]; then
		return 1
	fi
	
	return 0
}

main