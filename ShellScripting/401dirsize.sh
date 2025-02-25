function dir_size() {
  local dir="$1"
  local size=0
  du_h=$(du -h)
  size=$(du -h $dir | awk 'NR==2 ${print2}')

  echo "Size of directory '$dir': $size MB" 
}

# Get the directory path from the user
read -p "Enter the directory path: " dir_path


dir_size "$dir_path"