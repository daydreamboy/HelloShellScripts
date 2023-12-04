#!/usr/bin/env bash

source '../../shell_tool/dump_tool.sh'

text='"http": "https://www.baidu.com/"'

# Note: The issue case
# Step1: find "http" word
# Step2: change `"` to a space
# Step3: only select first line
# Step4: split by whitespace into three parts: http : https://www.baidu.com/
# If grep has color option, awk '{print $3}' maybe not get the correct part
#
result=$(echo $text | grep '"http"' | sed -e 's/"/ /g' | sed -n "1p" | awk '{print $3}')
echo "$result"
dump_var result true

# Note: use expected index $3 to get correct part
result=$(echo $text | grep '"http"' --color=never | sed -e 's/"/ /g' | sed -n "1p" | awk '{print $3}')
dump_var result true
