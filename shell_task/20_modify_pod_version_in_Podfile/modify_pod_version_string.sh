#!/usr/bin/env bash

## Usage:
# ./modify_pod_version_string.sh "<pod name>" "<pod version>" "<file path>"
#
# @discussion Wrap this script in ruby to handle multiple Podfiles in the specific directory
#

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
POD_AHEAD=".*"

# Case1: Change pod without subpod
# pod 'xxx'
# pod 'xxx', '<old version>'
# ==>
# pod 'xxx', '<new version>'
#
# Note: use \1 to reserve the space ahead of pod
sed -i "" -E "s/(${POD_AHEAD}${COMMAND})${SPACE}*${QUOTES}${POD_NAME}${QUOTES}${SPACE}*,?.*/\1 '${POD_NAME}', '${POD_VERSION}'/" ${FILE_PATH}

# Case2: Change pod with subpod
# pod 'xxx/yyy'
# pod 'xxx/yyy', '<old version>'
# ==>
# pod 'xxx/yyy', '<new version>'
#
# Note: use set -x to check the substitution order, \1 \2 \3 and so on
sed -i "" -E "s/(${POD_AHEAD}${COMMAND})${SPACE}*${QUOTES}${POD_NAME}\/([^,]+)${QUOTES}${SPACE}*,?.*/\1 '${POD_NAME}\/\3', '${POD_VERSION}'/" ${FILE_PATH}
