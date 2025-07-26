Markdown

# Linux `sed` Command Tutorial (Detailed)

`sed` (stream editor) is a powerful, non-interactive command-line text processing tool in Linux. It reads text streams (files or standard input) line by line, applies a series of editing commands, and then writes the modified lines to standard output. `sed` is primarily used for text substitution, deletion, insertion, and selection based on patterns. It's often referred to as a "stream editor" because it processes text in a single pass without needing to load the entire file into memory, making it highly efficient for large files.

## Basic Syntax

```bash
sed [OPTIONS] SCRIPT [FILE...]
OPTIONS: Control sed's behavior (e.g., -n, -i, -E).

SCRIPT: The editing command(s) to apply. This is often enclosed in single quotes '...' to prevent shell expansion.

FILE...: The input file(s). If no file is specified, sed reads from standard input.

How sed Works (The Cycle)
sed operates in a cycle:

Read: Reads one line from the input stream into a temporary buffer called the "pattern space."

Execute: Applies all commands in the SCRIPT to the pattern space.

Print: Prints the contents of the pattern space to standard output.

Loop: Clears the pattern space and repeats the cycle for the next input line.

Key Concepts and Options
Address Filtering
sed commands can be applied to all lines or to specific lines (addresses). Addresses can be:

Line Numbers: 1, 5, $ (last line).

Ranges: 1,5 (lines 1 to 5), /pattern1/,/pattern2/ (from line matching pattern1 to line matching pattern2).

Regular Expressions: /pattern/ (applies to lines matching pattern).

Common Commands
The most common sed command is s (substitute).

s/OLD/NEW/FLAGS: Substitute OLD (a regular expression) with NEW on the current line.

OLD: Regular expression to search for.

NEW: Replacement string.

FLAGS: Modifiers for substitution:

g: Global replacement (replace all occurrences on the line, not just the first).

i (or I): Case-insensitive match for OLD.

p: Print the pattern space if a substitution was made (often used with -n).

w FILE: Write the pattern space to FILE if a substitution was made.

NUMBER: Replace only the Nth occurrence of OLD on the line.

Other Commands
d: Delete the current line.

p: Print the current line (pattern space).

a\text: Append text after the current line.

i\text: Insert text before the current line.

c\text: Change (replace) the current line with text.

n: Read the next line into the pattern space (and print the current one, unless -n is used).

N: Append the next line to the pattern space.

y/set1/set2/: Transliterate characters from set1 to set2 (one-to-one mapping).

Important Options
-n (or --quiet, --silent): Suppress automatic printing of pattern space. Used when you only want to print lines explicitly with p command.

-i (or --in-place[=SUFFIX]): Edit files in place. Use with extreme caution! It modifies the original file. A SUFFIX can create a backup (e.g., -i.bak).

-E (or -r, --regexp-extended): Enable extended regular expressions (ERE), which allows +, ?, |, () without needing to escape them. This makes regexes much cleaner.

-f SCRIPT_FILE (or --file=SCRIPT_FILE): Read sed commands from SCRIPT_FILE. Useful for complex scripts.

Examples and Use Cases
Let's assume we have a file named sample.txt with the following content:

Hello World
This is a test line.
Another line with World.
The quick brown fox.
Line 5.
1. Simple Substitution
Replace the first occurrence of "World" with "Universe" on each line.

Bash

sed 's/World/Universe/' sample.txt
Output:

Hello Universe
This is a test line.
Another line with Universe.
The quick brown fox.
Line 5.
2. Global Substitution (g flag)
Replace all occurrences of "line" with "text" on each line.

Bash

sed 's/line/text/g' sample.txt
Output:

Hello World
This is a test text.
Another text with World.
The quick brown fox.
text 5.
3. Case-Insensitive Substitution (i flag)
Replace "world" (case-insensitive) with "galaxy".

Bash

sed 's/world/galaxy/gi' sample.txt
Output:

Hello galaxy
This is a test line.
Another line with galaxy.
The quick brown fox.
Line 5.
4. Substitute only the Nth occurrence
Replace only the second "l" with "X" on lines that have it.

Bash

sed 's/l/X/2' sample.txt
Output:

HeXlo World
This is a test line.
Another Xine with World.
The quick brown fox.
Line 5.
5. Deleting Lines (d command)
a) Delete a specific line by number:
Bash

sed '5d' sample.txt # Delete the 5th line
b) Delete a range of lines:
Bash

sed '2,4d' sample.txt # Delete lines from 2 to 4
c) Delete lines matching a pattern:
Bash

sed '/World/d' sample.txt # Delete lines containing "World"
d) Delete empty lines:
Bash

sed '/^$/d' sample.txt # '^$' matches empty lines
6. Inserting Text (i and a commands)
a) Insert text before a specific line:
Bash

sed '3i\*** New line inserted here ***' sample.txt
b) Append text after a specific line:
Bash

sed '3a\*** New line appended here ***' sample.txt
c) Insert/append text relative to a pattern:
Bash

sed '/test/a\This line was added after "test".' sample.txt
7. Changing (Replacing) Entire Lines (c command)
Replace lines matching a pattern with new text.

Bash

sed '/quick/c\This line completely replaced the fox line.' sample.txt
8. Printing Specific Lines (p command with -n)
Print only lines that match a pattern.

Bash

sed -n '/World/p' sample.txt # Print only lines containing "World"
-n: Suppresses default output, so only explicitly printed lines appear.

9. Multiple Commands (Separated by ; or Multiple -e)
You can combine multiple sed commands.

Bash

# Using ;
sed 's/World/Earth/; s/test/exam/' sample.txt

# Using -e
sed -e 's/World/Earth/' -e 's/test/exam/' sample.txt
10. In-place Editing (-i)
BE CAREFUL with -i! It modifies the original file directly.

Bash

sed -i 's/World/Universe/g' sample.txt # Modifies sample.txt directly
To create a backup of the original file:

Bash

sed -i.bak 's/test/exam/g' sample.txt
This creates sample.txt.bak with the original content and modifies sample.txt.

11. Extended Regular Expressions (-E)
Using -E simplifies regular expressions by removing the need to escape special characters.

Bash

# Without -E (needs escaping for ?)
echo "color colour" | sed 's/colou\?r/COLOUR/g'

# With -E (no escaping needed for ?)
echo "color colour" | sed -E 's/colou?r/COLOUR/g'
Both examples will output: COLOUR COLOUR

12. Transliteration (y command)
Replace characters one-to-one.

Bash

echo "hello world" | sed 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/'
Output:

HELLO WORLD
13. Grouping with () and Backreferences
Use () to capture parts of the matched pattern and \1, \2, etc., to refer to them in the replacement. With -E, you don't need to escape ().

Bash

echo "FirstName LastName" | sed -E 's/([A-Za-z]+) ([A-Za-z]+)/\2, \1/'
([A-Za-z]+): Captures a sequence of letters (first name).

([A-Za-z]+): Captures another sequence of letters (last name).

\2, \1: Replaces with the second captured group, a comma, a space, and the first captured group.

Output:

LastName, FirstName
14. Add Blank Lines
a) Add a blank line before every non-empty line:
Bash

sed G sample.txt
The G command appends the contents of the hold space to the pattern space. By default, the hold space is empty, so it appends a newline.

b) Add a blank line after every non-empty line:
Bash

sed 's/$/\n/' sample.txt # Not quite, this adds a blank line.
# More correctly, insert a newline character at the end of each line
sed '$!G' sample.txt # Append an empty line to all but the last line
Or to insert a blank line after every non-empty line:

Bash

sed '/./G' sample.txt # If line has content, append a newline (empty hold space)
When to use sed?
Simple find and replace operations: Especially when you need to change text across multiple files or within a stream.

Filtering lines: Deleting lines based on content or line number.

Text transformation: Reformatting lines, reordering fields, or adding/removing characters.

Batch processing: Efficiently modifying large text files.

In shell scripts: sed is a go-to tool for text manipulation in automation scripts.

Limitations and Alternatives
Non-Interactive: sed is not for interactive editing.

Line-by-Line Processing: While efficient, it's not ideal for tasks that require looking far ahead or backward in the file (though the hold space and pattern space manipulation can help for limited contexts).

No Variables/Complex Logic: sed has limited support for variables, loops, or complex conditional logic beyond simple pattern matching.

For more complex text processing, especially involving conditional logic, arithmetic, or processing data as records:

awk: Is a much more powerful and versatile text processing language, capable of more complex operations, calculations, and structured data handling.

perl / python: For very complex text processing tasks that go beyond what sed or awk can easily handle, general-purpose scripting languages are often a better choice.

sed is a fundamental and powerful tool for command-line text manipulation in Linux. Mastering its substitution and addressing capabilities will significantly enhance your ability to work with text files efficiently.
```