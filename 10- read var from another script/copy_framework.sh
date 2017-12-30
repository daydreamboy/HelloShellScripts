#!/bin/sh

# Require no arguments for calling this scripts
if [ "$#" -ne 0 ]; then
  echo "Usage: bash $0" >&2
  exit 1
fi

# Get script current dir
current_script_dir=$(dirname "$0")

# Import configurations
. ${current_script_dir}/scripts_configuration.sh

# Expand ~
# @see https://stackoverflow.com/questions/3963716/how-to-manually-expand-a-special-variable-ex-tilde-in-bash
TBWangXin_Dir_Expanded="${TBWangXin_Dir/#\~/$HOME}"

FRAMEWORK="WangXinKit"

FRAMEWORK_PATH="${BUILD_DIR}/${CONFIGURATION}-iphoneuniversal/${FRAMEWORK}.framework"

rsync -arv "${FRAMEWORK_PATH}" "${TBWangXin_Dir_Expanded}/Pods/${FRAMEWORK}/"
