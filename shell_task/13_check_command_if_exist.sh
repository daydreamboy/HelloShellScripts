#!/usr/bin/env bash

# https://stackoverflow.com/a/26759734
cmd=7z

if ! [[ -x "$(command -v ${cmd})" ]]; then
  echo "Error: ${cmd} is not installed." >&2
  exit 1
fi
