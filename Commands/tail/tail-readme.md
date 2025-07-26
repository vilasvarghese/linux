Markdown

# Linux `tail` Command Tutorial

The `tail` command in Linux is used to display the end (the "tail") of a file. By default, it outputs the last 10 lines of each file given to it. It's an essential utility for quickly checking recent additions to log files, monitoring ongoing processes, or simply inspecting the end of any text file.

## Basic Syntax

```bash
tail [OPTION]... [FILE]...
Examples and Use Cases
1. Display the last 10 lines of a single file (default behavior):
Bash

tail my_document.txt
This will print the last 10 lines of my_document.txt to your terminal.

2. Display a specific number of lines from the end:
You can use the -n (or --lines=) option followed by the number of lines you want to display.

Bash

tail -n 20 /var/log/syslog
This command will show only the last 20 lines of the /var/log/syslog file.

You can also use a plus sign with -n to display lines starting from the Nth line.

Bash

tail -n +100 my_large_file.txt
This will display my_large_file.txt starting from line 100 to the end of the file. This is less common for tail but useful sometimes.

3. Display a specific number of bytes (characters) from the end:
Use the -c (or --bytes=) option to specify the number of bytes to output.

Bash

tail -c 100 access.log
This will display the last 100 characters (bytes) of access.log. This can be useful for quickly checking the very end of binary files or very long lines.

You can also use human-readable suffixes with -c like k for kilobytes, m for megabytes, g for gigabytes.

Bash

tail -c 5K large_data.csv
This displays the last 5 kilobytes of large_data.csv.

4. Display the last lines of multiple files:
When you provide multiple file names, tail will display the last 10 lines of each, with a header indicating the filename.

Bash

tail file1.txt file2.txt /var/log/auth.log
Output will look something like this:

==> file1.txt <==
Line -9 of file1
Line -8 of file1
...
Line -1 of file1
Line 0 of file1

==> file2.txt <==
Line -9 of file2
Line -8 of file2
...
Line -1 of file2
Line 0 of file2

==> /var/log/auth.log <==
Jul 25 22:00:01 hostname sshd[12345]: Accepted password for user...
Jul 25 22:00:02 hostname sudo: user : TTY=pts/0 ; PWD=/home/user ...
... (more log lines)
5. Suppress headers when displaying multiple files:
If you're processing multiple files and don't want the ==> filename <== headers, use the -q (or --quiet, --silent) option.

Bash

tail -q file1.txt file2.txt
This will concatenate the last 10 lines of file1.txt and file2.txt without any separating headers.

6. Always print headers (even for a single file):
The -v (or --verbose) option forces tail to print headers, even if only one file is provided (which it normally wouldn't do).

Bash

tail -v my_document.txt
Output:

==> my_document.txt <==
Line -9 of my_document
Line -8 of my_document
...
7. Following a file (real-time monitoring) - The most powerful feature!
This is arguably the most common and powerful use of tail. The -f (or --follow) option allows tail to monitor a file for new content. As new lines are added to the file by another process, tail -f will display them in real-time. This is invaluable for monitoring log files.

Bash

tail -f /var/log/apache2/error.log
This command will continuously display new error messages from your Apache web server's error log as they are written.

To stop tail -f, press Ctrl+C.

You can combine -f with -n to start following from a specific number of lines:

Bash

tail -n 50 -f /var/log/nginx/access.log
This will show the last 50 lines of the access log initially, and then continue to show new lines as they arrive.

8. Following a file by name (--follow=name or -F):
Sometimes, log files are rotated (e.g., logfile.log becomes logfile.log.1, and a new logfile.log is created). The standard tail -f will continue to follow the old file (the inode). To handle log rotation gracefully, use -F.

Bash

tail -F /var/log/myapp/application.log
tail -F is a combination of --follow=name --retry. It will:

Follow the file by its name, not its inode.

Reopen the file if it's renamed or recreated (e.g., during log rotation).

Keep retrying if the file becomes inaccessible.

This is the recommended way to follow log files that undergo rotation.

9. Piping output to tail:
While less common than piping to head, you can use tail to get the last part of piped output. However, tail needs to read the entire input stream before it can determine the "end," so it won't show anything until the piping command finishes.

Bash

cat large_file.txt | tail -n 20
This will display the last 20 lines of large_file.txt (after cat has finished reading the entire file).

When to use tail?
Log monitoring: The most common use, particularly with tail -f or tail -F, to observe real-time activity in system, application, or web server logs.

Recent changes: Quickly check the latest entries in a configuration file or data file.

Debugging: See output from a script or program that writes to a file as it runs.

tail is an indispensable command for system administrators, developers, and anyone who needs to quickly access the most recent information from files in a Linux environment.
```
