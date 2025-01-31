#!/bin/bash

fruits=("apple" "banana" "cherry" "red grape" "kiwi")

for i in "${!fruits[@]}"; do
  fruit="${fruits[$i]}"  # Store the fruit in a variable for easier use

  if [[ $((i % 2)) -eq 0 ]]; then  # Check if the index is even
    echo "I like this fruit: $fruit"
  else  # Index is odd
    echo "I don't like this fruit: $fruit"
  fi
done