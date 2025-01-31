#!/bin/bash
function add {
    local sum=$(( $1 + $2 ))  # Use `local` for local variables
    echo $sum
}

result=$(add 5 10)  # Call the function and capture the "return" value
echo $result        # Prints: 15
 