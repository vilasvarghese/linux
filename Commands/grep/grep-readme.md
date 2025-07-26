Markdown

# Linux `grep` Command Tutorial

The `grep` (Global Regular Expression Print) command is one of the most powerful and widely used utilities in Linux for searching plain-text data sets for lines that match a regular expression. It's invaluable for filtering log files, configuration files, and any other text-based output.

## Basic Syntax

```bash
grep [OPTIONS] PATTERN [FILE...]
PATTERN: The text string or regular expression you are searching for.

FILE...: The file(s) you want to search. If no file is specified, grep reads from standard input.

How grep Works
grep reads the specified file(s) line by line. For each line, it checks if the line contains the PATTERN. If it finds a match, the entire matching line is printed to standard output.

Examples and Use Cases
1. Basic Search for a String in a File
Search for a simple word or phrase.

Bash

grep "error" /var/log/syslog
This command will display all lines in /var/log/syslog that contain the word "error".

2. Case-Insensitive Search
Use the -i (or --ignore-case) option to perform a search that ignores case.

Bash

grep -i "warning" access.log
This will find lines containing "warning", "Warning", "WARNING", etc.

3. Display Line Numbers
Use the -n (or --line-number) option to show the line number where the pattern was found.

Bash

grep -n "fail" /var/log/auth.log
Output:

123: authentication fail for user 'john'
250: sudo: password fail for 'mary'
4. Count Matches
Use the -c (or --count) option to display only the count of matching lines, not the lines themselves.

Bash

grep -c "GET /index.html" access.log
This will output the total number of times "GET /index.html" appears in access.log.

5. Invert Match (Show Non-Matching Lines)
Use the -v (or --invert-match) option to display lines that do not match the pattern.

Bash

grep -v "#" my_config.conf
This will show all lines in my_config.conf that do not start with # (useful for seeing active configuration lines, excluding comments).

6. Search in Multiple Files
You can specify multiple files. grep will prepend the filename to each matching line.

Bash

grep "failed" /var/log/syslog /var/log/auth.log
Output:

/var/log/syslog:Jul 25 10:30:05 hostname systemd[1]: Failed to start User Manager for UID 1000.
/var/log/auth.log:Jul 25 10:30:10 hostname sshd[12345]: Failed password for invalid user root
7. Recursive Search in Directories
Use the -r (or --recursive) option to search for a pattern recursively in all files within a directory and its subdirectories.

Bash

grep -r "TODO" ~/my_project/
This will search for the string "TODO" in all files under the ~/my_project/ directory.

8. Display Only File Names (of Matching Files)
Use the -l (or --files-with-matches) option to list only the names of files that contain at least one match, without showing the matching lines.

Bash

grep -l "function main" *.c
This will list all .c files in the current directory that contain the string "function main".

9. Suppress Error Messages for Non-Existent Files
Use the -s (or --no-messages) option to suppress error messages about non-existent or unreadable files.

Bash

grep -s "pattern" file1.txt non_existent_file.txt
This will search file1.txt and silently ignore non_existent_file.txt if it doesn't exist.

10. Search for Full Word Matches
Use the -w (or --word-regexp) option to search for the pattern as a whole word, preventing partial matches.

Bash

grep -w "user" /etc/passwd
This will match "user" but not "users" or "username".

11. Search Using Regular Expressions
grep is designed for regular expressions. The pattern can be a simple string or a complex regex.

Bash

# Search for lines containing IP addresses (simple regex example)
grep -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" access.log
-E (or --extended-regexp): Enables extended regular expressions (ERE), which provides more features and often makes regexes cleaner (e.g., +, ?, |).

Common Regex Metacharacters in grep (when using -E or egrep):

.: Matches any single character.

*: Matches zero or more occurrences of the preceding character.

+: Matches one or more occurrences of the preceding character.

?: Matches zero or one occurrence of the preceding character.

^: Matches the beginning of a line.

$: Matches the end of a line.

[abc]: Matches any one character from the set a, b, or c.

[^abc]: Matches any character not in the set a, b, or c.

[a-z]: Matches any lowercase letter.

[0-9]: Matches any digit.

|: OR operator (e.g., error|fail).

(): Grouping.

12. Display Lines Before/After/Context of Matches
-A NUM (or --after-context=NUM): Print NUM lines of trailing context after a match.

-B NUM (or --before-context=NUM): Print NUM lines of leading context before a match.

-C NUM (or --context=NUM): Print NUM lines of context (before and after) a match.

Bash

grep -A 3 "Error processing request" application.log
This will show the line containing "Error processing request" and the 3 lines immediately following it.

Bash

grep -C 2 "Failed login from" /var/log/auth.log
This will show the matching line and 2 lines before and 2 lines after it.

13. Piping Output to grep
grep is frequently used in pipelines to filter the output of other commands.

Bash

ps aux | grep "apache2"
This lists all running processes (ps aux) and then filters that list to show only lines containing "apache2".

Bash

ls -l /usr/bin | grep "zip"
This lists the contents of /usr/bin in long format and filters for files or directories containing "zip" in their name or permissions string.

Useful Aliases and Related Commands
egrep: Equivalent to grep -E (extended regex).

fgrep: Equivalent to grep -F (fixed strings, no regex interpretation, faster for literal searches).

rgrep: Equivalent to grep -r (recursive).

Many users set aliases in their ~/.bashrc or ~/.zshrc for common grep variations, e.g.:

Bash

alias grep='grep --color=auto'
alias grepl='grep -n --color=auto'
The --color=auto option (often aliased to grep by default in modern distros) highlights the matching pattern in the output, making it easier to spot.
```