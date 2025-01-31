#!/bin/bash

# Display user and system information

echo "Hello, $USER!"  # Greeting with the username
echo "Your home directory is: $HOME"
echo "Your login name is: $LOGNAME"
echo "Your user ID is: $UID"
echo "Your default shell is: $SHELL"
echo "Your terminal is: $TERM"
echo "Your hostname is: $HOSTNAME"

# Display current directory and path

echo "Your current directory is: $PWD"
echo "Your previous directory was: $OLDPWD (if set)" # OLDPWD might not always be set
echo "Your PATH is: $PATH"

# Display some locale settings

echo "Your language settings are: $LANG"
echo "Character type settings: $LC_CTYPE"
echo "Numeric settings: $LC_NUMERIC"

# Example using $PATH – listing files in /tmp

echo "Files in /tmp (using \$PATH):"
ls /tmp

# Example demonstrating variable usage

message="This is a test message."
echo "$message"

# Example with random number

echo "A random number: $RANDOM"

# Example of setting and using a variable within the script (does not affect the environment)

my_variable="Script-local value"
echo "My local variable: $my_variable"

# Displaying the script name
echo "Running Script: $0"

# Displaying number of arguments passed to script
echo "Number of arguments passed to script: $#"

# Displaying all the arguments passed to script
echo "All the arguments passed to script: $*"

# Displaying first argument passed to script
echo "First argument passed to script: $1"

# Displaying second argument passed to script
echo "Second argument passed to script: $2"

# Displaying process ID of current shell
echo "Process ID of current shell: $$"


# Demonstrating $SECONDS – time elapsed since the script started.

echo "Seconds since script started: $SECONDS"

# Example of using $EDITOR (or a default if $EDITOR is not set).

if [ -z "$EDITOR" ]; then
  editor="vi" # Default if $EDITOR is not set
else
  editor="$EDITOR"
fi

echo "Your preferred editor is: $editor"

# Example using $PAGER (or a default if $PAGER is not set).

if [ -z "$PAGER" ]; then
  pager="less" # Default if $PAGER is not set
else
  pager="$PAGER"
fi

echo "Your preferred pager is: $pager"

# Displaying the number of seconds the shell has been running.

echo "Shell uptime (seconds): $SECONDS"

exit 0
How to use this script:

#Save: Save the script to a file (e.g., my_script.sh).
#Make executable: chmod +x my_script.sh
#Run: ./my_script.sh