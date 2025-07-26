Markdown

# Linux `head` Command Tutorial

The `head` command in Linux is used to display the beginning of a file. By default, it outputs the first 10 lines of each file given to it. It's a simple yet very useful utility for quickly inspecting the start of a log file, a configuration file, or any text file without having to open the entire file.

## Basic Syntax

```bash
head [OPTION]... [FILE]...
Examples and Use Cases
1. Display the first 10 lines of a single file (default behavior):
Bash

head my_document.txt
This will print the first 10 lines of my_document.txt to your terminal.

2. Display a specific number of lines from the beginning:
You can use the -n (or --lines=) option followed by the number of lines you want to display.

Bash

head -n 5 /etc/passwd
This command will show only the first 5 lines of the /etc/passwd file.

You can also use a negative number with -n to display all but the last N lines (though this is less common and often implies sed or awk for more complex slicing).

Bash

head -n -5 my_document.txt
This would display my_document.txt excluding the last 5 lines.

3. Display a specific number of bytes (characters) from the beginning:
Use the -c (or --bytes=) option to specify the number of bytes to output.

Bash

head -c 50 access.log
This will display the first 50 characters (bytes) of access.log. This is useful for very large files where even 10 lines might be too much, or if you just want to see the very beginning for character encoding issues, etc.

You can also use human-readable suffixes with -c like k for kilobytes, m for megabytes, g for gigabytes.

Bash

head -c 1K large_data.csv
This displays the first 1 kilobyte of large_data.csv.

4. Display the first lines of multiple files:
When you provide multiple file names, head will display the first 10 lines of each, with a header indicating the filename.

Bash

head file1.txt file2.txt /var/log/messages
Output will look something like this:

==> file1.txt <==
Line 1 of file1
Line 2 of file1
...
Line 10 of file1

==> file2.txt <==
Line 1 of file2
Line 2 of file2
...
Line 10 of file2

==> /var/log/messages <==
Jul 25 10:00:01 hostname systemd[1]: Starting ...
Jul 25 10:00:02 hostname kernel: ...
... (more log lines)
5. Suppress headers when displaying multiple files:
If you're processing multiple files and don't want the ==> filename <== headers, use the -q (or --quiet, --silent) option.

Bash

head -q file1.txt file2.txt
This will concatenate the first 10 lines of file1.txt and file2.txt without any separating headers.

6. Always print headers (even for a single file):
The -v (or --verbose) option forces head to print headers, even if only one file is provided (which it normally wouldn't do).

Bash

head -v my_document.txt
Output:

==> my_document.txt <==
Line 1 of my_document
Line 2 of my_document
...
7. Piping output to head:
You can also pipe the output of another command to head. This is useful if you only want to see the first few lines of a command's output.

Bash

ps aux | head -n 3
This will show the header line and the first two processes from the ps aux command output.

Bash

cat large_file.txt | head -n 20 | less
This pipes the entire large_file.txt to head (which takes the first 20 lines), and then pipes those 20 lines to less for easy viewing (though for just 20 lines, less might be overkill).

When to use head?
Quick inspection: You just want a quick glance at the beginning of a file to understand its format or content.

Log files: See the initial entries of a fresh log file.

Configuration files: Check the top-level settings of a config file.

Scripting: In shell scripts, to process only the initial part of a file or output.

head is often used in conjunction with its counterpart, tail (which shows the end of a file), and other text processing commands like grep, awk, sed, and sort for more sophisticated data manipulation.
```