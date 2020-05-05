#!/bin/bash

#
# Syntax:
#		${parameter##word}, long matching word, e.g. ${empty.tar.gz##*.} to gz
#		${parameter#word}, long matching word, e.g. ${empty.tar.gz#*.} to tar.gz
#
#	Reference:
#		https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameter-Expansion-1
#		http://stackoverflow.com/questions/39381344/what-does-and-mean-in-shell
#

function main
{
	read -p "Drag a folder here: " folder
	check_dir "$folder"
	
	if [ $? != 0 ]; then
		echo "it's not a folder! try again." >&1
		main
	fi
	
	list_all_file_names "$folder"
}

## list all file names in a folder
function list_all_file_names
{
	dir=$1
	
	for file in $(ls "$dir"); do
		echo $file >&1
		echo ${file##*.} >&1
	done
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
