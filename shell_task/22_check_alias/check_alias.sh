#!/usr/bin/env bash

alias_path="./alias_file"

# Note: /Users/xxx/Downloads/folder_alias: MacOS Alias file
if [[ $(file "$alias_path") == *[aA]lias* ]]; then
  echo "is alias file: YES"
  # Style1: use applescript
  #original_path=$(osascript -e "tell application \"Finder\" to get POSIX path of (original item of alias file (POSIX file \"$alias_path\" as alias))")
  # Style2: not work
  #original_path=$(xattr -p com.apple.LSOriginalItemLocation "$alias_path" | xxd -r -p | sed 's/^00//')
  # Style3: custom tool, see https://github.com/rptb1/aliasPath
  original_path=$(./alias_tool "$alias_path")
  echo "$original_path"
else
  echo "is alias file: NO"
fi

alias_path="./alias_folder"
# @see https://stackoverflow.com/a/58405836
if [[ -f "$alias_path" ]] && mdls -raw -name kMDItemContentType "$alias_path" 2>/dev/null | grep -q '^com\.apple\.alias-file$'; then
  echo "is alias file: YES"
  original_path=$(./alias_tool "$alias_path")
  echo "$original_path"
else
  echo "is alias file: NO"
fi