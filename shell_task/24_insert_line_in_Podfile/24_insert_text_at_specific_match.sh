#!/usr/bin/env bash

#set -x
set -e

# CONFIG: file path
FILE="./Podfile"
# CONFIG: the match line
MATCH_LINE="def main_pods"
# CONFIG: insert line
INSERT_TEXT="  #--auto--#"

# Note: check the INSERT_TEXT if exist at the specific line.
# Note: grep exit status code is 0 which for success
if ! grep --color=never -qF "${INSERT_TEXT}" "${FILE}"; then
    # Note: insert a text at the match line
    # @see https://superuser.com/questions/434329/use-os-xs-sed-in-a-script-to-find-a-string-and-append-a-line-beneath-it-includi
    sed -i '' "/${MATCH_LINE}/ a\\
${INSERT_TEXT}\\
" "${FILE}"
    echo "Inserted: '${INSERT_TEXT}' after line ${MATCH_LINE}"
    echo "---Modified content[begin]"
    cat "${FILE}"
    echo "---Modified content[end]"
else
    echo "The line already exists"
fi
