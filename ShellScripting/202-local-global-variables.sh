#!/bin/bash

# Global variable (accessible in functions)
global_var="This is a global variable"

# Function to demonstrate local variables
my_function() {
  local local_var="This is a local variable inside the function"
  echo "Inside function:"
  echo "Global variable: $global_var"
  echo "Local variable: $local_var"

  # Attempt to access the local variable from outside (will be empty)
  echo "Trying to access local_var from outside the function (will be empty): $local_var"  # Output will be empty
}

# Main part of the script

echo "Outside function (before calling):"
echo "Global variable: $global_var"
#echo "Local variable: $local_var"  # This will produce an error because local_var is not defined here

my_function  # Call the function

echo "Outside function (after calling):"
echo "Global variable: $global_var"
#echo "Local variable: $local_var"  # This will still produce an error

# Demonstrating variable scope with another function

another_function() {
  global_var="Global variable modified in another_function" # Modifying the global variable
  local another_local="Another local variable" # Declaring a local variable in another function
  echo "Inside another_function:"
  echo "Global variable: $global_var"
  echo "Another local variable: $another_local"
}

another_function
echo "Outside function (after calling another_function):"
echo "Global variable: $global_var" # Global variable is modified
#echo "Another local variable: $another_local" # Another local variable is not accessible here.


# Demonstrating how to create a local variable in the main part of the script
local script_local_var="Local to the main script" # local variable in the main part of the script
echo "Local variable in main part of the script: $script_local_var"

exit 0