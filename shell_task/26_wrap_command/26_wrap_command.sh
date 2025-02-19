#!/usr/bin/env bash

copy_files() {
    if [ "$(uname)" = "Darwin" ]; then
        echo "rsync -vh --progress"
    else
        echo "cp -fp"
    fi
}
echo "$(copy_files) \"./1.txt\" \"./temp\""
$(copy_files) "./1.txt" "./temp"
