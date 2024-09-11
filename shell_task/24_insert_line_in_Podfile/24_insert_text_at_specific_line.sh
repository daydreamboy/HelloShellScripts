#!/usr/bin/env bash

# 文件名
FILE="./Podfile"
# 指定行号
LINE_NUM=4
# 要插入的文本
INSERT_TEXT="    #--auto--#"

# Note: check the INSERT_TEXT if exist at the specific line.
# Note: grep exit status code is 0 which for success
if ! sed -n "${LINE_NUM}p" "$FILE" | grep --color=never -qF "$INSERT_TEXT"; then
    # Note: insert a text at the line
    sed -i "${LINE_NUM}i $INSERT_TEXT" "$FILE"
    echo "Inserted: '$INSERT_TEXT' at line $LINE_NUM"
else
    echo "The line already exists at line $LINE_NUM"
fi
