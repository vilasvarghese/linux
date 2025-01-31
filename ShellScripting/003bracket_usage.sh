#!/bin/bash
file="my file.txt"  # Contains a space

# [ ] version (quoting is CRUCIAL):
if [ -f "$file" ]; then  # Correct: quotes prevent word splitting
  echo "File exists"
fi

if [ -f $file ]; then    # Incorrect: $file is split into "my" and "file.txt"
  echo "File exists" # This may or may not work as intended!
fi

# [[ ]] version (quoting is less critical, but good practice):
if [[ -f "$file" ]]; then # Correct, even without quotes in this case
  echo "File exists"
fi

if [[ -f $file ]]; then  # Still correct, but quoting is good practice.
  echo "File exists"
fi

'''
Both [ ] (single brackets) and [[ ]] (double brackets) 
	used for conditional testing in shell scripting, 
	
Here's a breakdown of the differences:

1. POSIX Compliance:
'
	[ ]: Is POSIX compliant. 
		Will work in virtually any POSIX-compatible shell 
			(sh, bash, ksh, zsh, etc.).
	[[ ]]: 
		Bash extension. 
		It will only work in Bash. 
		If you need your script to be portable to other shells, you must use [ ].
2. Quoting:

	[ ]: 
		Requires careful quoting of variables, 
			especially if they might contain spaces or special characters (like *, ?, [). 
			Unquoted variables can lead to word splitting and globbing issues.
	[[ ]]: Handles quoting more gracefully. 
		You generally don't need to quote variables unless they contain characters you want to be treated literally (e.g., globbing characters when you don't want globbing).
3. String Comparison:

	[ ]: 
		Uses = and != for string comparisons. 
	[[ ]]: 
		Can support above, but also adds:
		=~: For regular expression matching.
		==: For pattern matching (globbing).
4. Logical Operators:

	[ ]: Uses -a (AND), -o (OR), and ! (NOT) for logical operations.
	[[ ]]: Uses && (AND), || (OR), and ! (NOT). These are generally preferred and more intuitive.
5. Word Splitting and Globbing:

	[ ]: Performs word splitting and globbing on unquoted variables. This is why quoting is so crucial.
	[[ ]]: Does not perform word splitting or globbing on unquoted variables.
6. File Testing:

	Both [ ] and [[ ]] can be used for file testing (e.g., -f, -d, -x, etc.).  The quoting rules still apply.

7. Empty String Handling:

	[ ]: Can have issues with empty strings if not quoted correctly. [ -n "$variable" ] is the correct way to check if a variable is not empty.
	[[ ]]: Handles empty strings more naturally. [[ -n $variable ]] or [[ ! -z $variable ]] works as expected.
Example illustrating quoting differences:


Which to use?

[[ ]]: 
	Use this in Bash scripts and dont want to migrate. 
	It is 
		safer, 
		more powerful, and 
		less error-prone 
			due to its better handling of quoting, strings, and regular expressions.
[ ]: 
	Use this if your script needs to be portable to other POSIX-compliant shells. 
	Be extremely careful with quoting to avoid word splitting and globbing problems.
'''