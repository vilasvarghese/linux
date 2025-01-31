#!/bin/bash
# START #
#Usage: ./file.sh one "two words" three

echo "'$*' output is $*"
#"'$*' expands to all the command-line 

echo "'$#' output is $#"
#$#: number of command-line arguments.

echo "'$1 & $2' output $1 and $2"
#The actual first and second parameter 

echo "'$@' output of $@"
#$@: expands to all the command-line arguments, but as separate words (separate strings). 

echo "'$?' output is $?"
#$?: exit status of the most recently executed command. 0 - success, others value indicates an error.
echo "'$$' output is $$"
#$$: process ID (PID) of the current shell running the script.

sleep 400 &
echo "'$!' output is $!"
#$!: process ID (PID) of the most recently backgrounded process (the sleep 400 command in this case).

echo "'$0' your current program name is $0"

# END #