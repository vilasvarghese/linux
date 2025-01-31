#!/bin/bash
fruits=("apple" "banana" "cherry" "red grape") # Added an element with a space

for fruit in "${fruits[@]}"; do  # Correct way to iterate - double quotes crucial!
    echo "I like to eat $fruit."
done

# Another robust way to iterate using indices (recommended for complex cases):
for i in "${!fruits[@]}"; do  # Iterate over the *indices*
  echo "Fruit at index $i is: ${fruits[$i]}" # Access the element using the index
done