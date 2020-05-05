#!/bin/bash

function main
{
	if [ ! -z "$1" ]; then
		echo "Parsing $1"
		targets=($(/usr/bin/ruby ./get_all_targets.rb "$1"))
    echo ' 💘  '$(basename "$1")' contains the following targets：' >&1
    for i in "${!targets[@]}"; do
        echo '  '$i'）'${targets[$i]}
    done
  else
  	echo "Usage: $0 <path/to/.xcodeproj file>"
	fi
}

main "$1"