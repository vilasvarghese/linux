#!/bin/bash
#Purpose: Verifying Difference between quotation marks

# START #
VAR1=1234567
TEST=VilasTest

# Double Quotes
echo "Execute double quotes $VAR1 $TEST"

# Single Quotes
echo 'Excute Single Quotes $VAR1 $TEST'

# Reverse Quotes
echo "The current date and time is: `date`"

# 7END VilasTest

'''
---------------------------------------------------------------------------------------------------
Feature							'single quotes'						"double quotes"
---------------------------------------------------------------------------------------------------
Variable expansion ($VAR)		No									Yes
Command substitution ($(...))	No									Yes
Escape sequences (\n, \")		No									Yes (for limited cases)
Literal text					Yes									Partial
Use case						When you want exact literal text	When you want interpreted text
---------------------------------------------------------------------------------------------------

Single Quotes (' ')

Single quotes preserve the literal value
----------------------------------------
	No variable expansion
		if variable has spaces it fails 
	No command substitution
	No escape sequences

e.g. 
	name="Varghese"
	echo 'Hello $name'
	
	Output:
		Hello $name


	name="Varghese"
	echo "Hello $name"
	echo "Today is $(date)"
	echo "He said \"Hello\""
	
	output 
		Hello Varghese
		Today is Tue Oct 28 10:12:00 IST 2025
		He said "Hello"
		
		

#Command Execution: The command enclosed within the backticks (``) (or $(...)) is executed by the shell.

#Output Capture: The output of that command is captured.

#Substitution: The captured output is then substituted in place of the backticks (or $(...)).

#Usage: The substituted output can be used as an argument to another command, assigned to a variable, or used as part of a string.

#Why $(...) is preferred over backticks:

#Nesting: $(...) can be nested easily.  Backticks require escaping, which can become complex:

#nested_command=$(echo "The result is: $(command_inside)") # Easy nesting
#nested_command=`echo "The result is: \`command_inside\`"` # Backticks nesting requires escaping
#Readability: $(...) is generally considered more readable, especially when nesting is involved.

#Consistency: $(...) is more consistent with other programming languages that use similar syntax for command or expression substitution.
'''