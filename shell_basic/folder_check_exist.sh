#!/usr/bin/env bash

# @see https://stackoverflow.com/questions/59838/how-can-i-check-if-a-directory-exists-in-a-bash-shell-script

# Case 1
DIRECTORY=/usr/bin
if [[ -d "$DIRECTORY" ]]; then
  echo "'${DIRECTORY}' exists"
fi

if [[ ! -d "$DIRECTORY" ]]; then
  echo "'${DIRECTORY}' not exists"
fi

# Case 2
DIRECTORY=/usr/bin/env
if [[ -d "$DIRECTORY" ]]; then
  echo "'${DIRECTORY}' exists"
fi

if [[ ! -d "$DIRECTORY" ]]; then
  echo "'${DIRECTORY}' not exists"
fi

# Case 3
DIRECTORY=/some/folder/not/exists
if [[ -d "$DIRECTORY" ]]; then
  echo "'${DIRECTORY}' exists"
fi

if [[ ! -d "$DIRECTORY" ]]; then
  echo "'${DIRECTORY}' not exists"
fi