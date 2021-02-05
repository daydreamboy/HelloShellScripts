#!/usr/bin/env bash

# @see https://stackoverflow.com/questions/2953646/how-can-i-declare-and-use-boolean-variables-in-a-shell-script
the_world_is_flat=true
# ...do something interesting...
if [[ "$the_world_is_flat" = true ]] ; then
    echo 'Be careful not to fall off!'
fi

