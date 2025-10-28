#!/bin/bash

# Function to calculate the size of a directory
function dir_size() {
  local dir="$1"
  local size=0

  find "$dir" -type f -exec du -h {} + | awk '{ size += $1 } END { print size }' 
}

# Get the directory path from the user
read -p "Enter the directory path: " dir_path


dir_size "$dir_path"
#du -h {} + | awk '{ size += '/d/PraiseTheLord/HSBGInfotech/Others/vilas/linux/ShellScripting' } END { print size }'

#du -h $1