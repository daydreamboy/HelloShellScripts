#!/bin/bash
# @see https://stackoverflow.com/a/4444733

# Array pretending to be a Pythonic dictionary
#ARRAY=( "cow:moo"
#        "dinosaur:roar"
#        "bird:chirp"
#        "bash:rock" )

#ARRAY=( "cow:moo" "dinosaur:roar" "bird:chirp" "bash:rock" )
ARRAY='{"git":"git@gitlab.alibaba-inc.com:wx-ios/wxopenimsdk.git";"branch":"feature/171115/pod";"commit":"12ab";"tag":"0.0.1";"podspecs":{"WXOpenIMSDK":{"path":"./wxopenimsdk/WXOpenIMSDK_Dynamic.podspec";"use_framework":true};"WangXinKit":{"path":"./wxopenimsdk/WangXinKit.podspec";"use_framework":true;"is_dynamic":false;"run_script_path":"./${PROJECT_DIR}/../wxopenimsdk/Scripts/copy_resource_bundle_to_WangXinKit_framework.sh"}}}'
array=(${ARRAY//,/ })

echo $array

#for animal in "${ARRAY[@]}" ; do
#    KEY="${animal%%:*}"
#    VALUE="${animal##*:}"
#    printf "%s likes to %s.\n" "$KEY" "$VALUE"
#done
#
#printf "%s is an extinct animal which likes to %s\n" "${ARRAY[1]%%:*}" "${ARRAY[1]##*:}"