#!/usr/bin/env bash

# Note: use /usr/local/bin/7z instead of 7z for Automator
cmd=/usr/local/bin/7z

if ! [[ -x "$(command -v ${cmd})" ]]; then
  echo "Error: ${cmd} is not installed. Please brew install p7zip" >&2
  exit 1
fi

# Enter the first file's directory
current_path=$(dirname "$1")
cd "${current_path}"

#echo ${current_path}

args=""
for f in "$@"
do
  args="${args} \"$f\""
done

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
command="${cmd} a Archive@${timestamp}.7z ${args}"

#echo ${command} >&2
#exit 1
status=$(eval "${command}")

#echo ${status}

exit 0
