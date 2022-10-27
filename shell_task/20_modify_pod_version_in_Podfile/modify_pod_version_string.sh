#!/usr/bin/env bash

## Usage:
# ./modify_pod_version_string.sh "<pod name>" "<pod version>" "<file path> or <dir path>"

POD_NAME=$1
POD_VERSION=$2
FILE_PATH=$3

# Note: suppose use pod in Podfile
COMMAND='pod'


# pod 'xxx', '<old version>'
sed -i "" "s/\([ \t]*pod.*'$POD_NAME'.*,\).*[0-9a-z\-\.]*.*/\1 \'$POD_VERSION\'/" $FILE_PATH
# pod 'xxx/yyy', '<old version>'
sed -i "" "s/\([ \t]*pod.*'$POD_NAME\/[a-zA-Z]*'.*,\).*[0-9a-z\-\.]*.*/\1 \'$POD_VERSION\'/" $FILE_PATH
