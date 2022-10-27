#!/usr/bin/env bash

## Usage:
# ./modify_pod_version_string.sh "<pod name>" "<pod version>" "<file path> or <dir path>"

# Note: use set -x won't display as original string, for example, check the sed command when turn on set -x
# @see https://unix.stackexchange.com/questions/342931/bash-single-quotes-being-added-to-double-quotes
isDebug=false
if [[ "$isDebug" = true ]] ; then
  set -x
  set -e
fi

POD_NAME=$1
POD_VERSION=$2
FILE_PATH=$3

# Note: the regex components, maybe change by yourself
COMMAND=pod
QUOTES="('|\")"
SPACE="[ \t]"

# pod 'xxx'
# pod 'xxx', '<old version>'
# ==>
# pod 'xxx', '<new version>'
#
# Note: use \1 to reserve the space ahead of pod
sed -i "" -E "s/(${SPACE}*${COMMAND})${SPACE}*${QUOTES}${POD_NAME}${QUOTES}${SPACE}*,?.*/\1 '${POD_NAME}', '${POD_VERSION}'/" ${FILE_PATH}

# pod 'xxx/yyy', '<old version>'
#sed -i "" "s/\([ \t]*pod.*'$POD_NAME\/[a-zA-Z]*'.*,\).*[0-9a-z\-\.]*.*/\1 \'$POD_VERSION\'/" $FILE_PATH
