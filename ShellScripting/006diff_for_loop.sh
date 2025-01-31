#!/bin/bash
start=1
end=10

for i in $(seq $start $end); do
  echo "$i"
done

# Method 2: Using brace expansion (Bash-specific, for simple ranges)

for i in {$start..$end}; do  # No spaces around ..
  echo "$i"
done

# Method 3: Using a while loop (more flexible, good for complex conditions)

i=$start
while [ "$i" -le "$end" ]; do # Quotes around $i and $end are essential!
  echo "$i"
  i=$((i + 1))  # Or i=$((i+1)) or i=$(expr "$i" + 1) (older style)
done

# Method 4:  Using a for loop with arithmetic expansion (more portable than brace expansion)

for ((i = start; i <= end; i++)); do
  echo "$i"
done
