#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

input_file="$1"
temp_file="${input_file}.temp"

awk 'NR % 2 == 1' "$input_file" > "$temp_file" && mv "$temp_file" "$input_file"

echo "Every second line deleted. Content modified in $input_file"