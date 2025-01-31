'''
[[ ]] is for conditional testing, offering more advanced features than [ ].
{} has multiple uses: variable expansion, brace expansion, and command grouping.

Both used in bash scripting only 

[[ ]] (Double Brackets):

	Purpose: 
		Used for conditional testing (if condition or similar). 
		more powerful and flexible way to evaluate conditions compared to [ ] (single brackets).

Key Features and When to Use:

	Enhanced String Comparisons: 
		Supports regular expression matching 
			(=~) and 
			pattern matching (==).
	Safer Quoting: 
		Handles quoting of variables more gracefully, 
		reducing the risk of word splitting and globbing issues.
	Logical Operators: 
		Uses && (AND), || (OR), and ! (NOT) for logical operations
		more intuitive than -a, -o, and ! used with [ ].
	File Testing: 
		Can be used for file testing (e.g., -f, -d, -x).
When to Use:

	In Bash scripts when you need more advanced string comparisons (regex, pattern matching).
	When you want to simplify quoting and avoid word splitting/globbing issues.
	When you prefer the more common &&, ||, and ! logical operators.
Example:


file="my file.txt"

if [[ -f "$file" && $name =~ ^J.* ]]; then  # Check if file exists and name starts with J
  echo "File exists and name starts with J"
fi



{} (Curly Braces):
-----------------

Purpose: Used for various purposes, including:

	Variable Expansion: 
		To clearly delimit variable names, 
			especially when concatenating them with other characters.
		
			When you have a variable name directly followed by other characters (e.g., ${variable}suffix).
			When you are working with arrays (e.g., ${my_array[0]}).
	Brace Expansion: 
		To generate sequences of strings.
		To generate a sequence of numbers or letters (e.g., {1..10}).
		To create a list of strings (e.g., {apple,banana,orange}).

	Command Grouping: 
		To group commands together.
		To group commands so they are treated as a single unit (e.g., { command1; command2; }).
		To redirect the output of multiple commands (e.g., { command1; command2; } > output.txt).


Examples:

Bash

# Variable Expansion
name="John"
echo "Hello, ${name}!"

# Brace Expansion
echo {1..5}      # Output: 1 2 3 4 5
echo {a,b,c}    # Output: a b c

# Command Grouping
{ ls -l; pwd; }  # List files and print current directory
'''