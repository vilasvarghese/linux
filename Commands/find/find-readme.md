Markdown

# Linux `find` Command Tutorial (Detailed)

The `find` command in Linux is a powerful and versatile utility used to search for files and directories in a directory hierarchy based on a wide range of criteria. It can locate files by name, type, size, modification time, ownership, permissions, and much more. Once found, it can also execute various actions on the located files.

## Basic Syntax

```bash
find [STARTING_POINT...] [EXPRESSION]
STARTING_POINT...: One or more directories where the search should begin. If omitted, find searches the current directory (.).

EXPRESSION: This is the most crucial part, composed of options, tests, and actions.

Options: Control overall find behavior (e.g., -H, -L).

Tests: Define the criteria for selecting files (e.g., -name, -type, -size).

Actions: Specify what to do with the found files (e.g., -print, -delete, -exec).

Understanding the EXPRESSION (Options, Tests, Actions)
find processes its expression from left to right.

Common Options
These options generally affect how find traverses the directory tree.

-L (or --dereference): Follow symbolic links. If a symbolic link points to a directory, find will traverse that directory. (This is often the default behavior on some systems for find, but explicitly using it ensures it.)

-H: Don't follow symbolic links unless specified on the command line.

-P (or --no-dereference): Never follow symbolic links. This is generally the safest default.

-maxdepth LEVELS: Descend at most LEVELS (a non-negative integer) levels below the starting points. find . -maxdepth 1 will only search the current directory and not its subdirectories.

-mindepth LEVELS: Do not apply any tests or actions at levels less than LEVELS. find . -mindepth 2 will only start processing files from the second level of subdirectories onwards.

Common Tests
Tests are conditions that a file must meet to be selected.

By Name
-name PATTERN: Matches files whose basename (filename only, no path) matches PATTERN. PATTERN can include wildcards (*, ?, []), but you usually need to quote them to prevent the shell from expanding them.

Bash

find . -name "*.log"          # Finds all files ending with .log in current dir and subdirs
find /etc -name "host*"       # Finds files/dirs starting with 'host' under /etc
find . -name "report_??.txt"  # Finds report_01.txt, report_AB.txt, etc.
-iname PATTERN: Same as -name, but case-insensitive.

Bash

find . -iname "document.pdf"  # Matches Document.pdf, document.pdf, DOCUMENT.PDF
-path PATTERN: Matches files whose full path matches PATTERN.

Bash

find /var/log -path "*nginx*access.log" # Finds access.log files within any 'nginx' subdirectory
-ipath PATTERN: Same as -path, but case-insensitive.

-regex PATTERN: Matches files whose full path matches the regular expression PATTERN. This uses Emacs-style regular expressions by default.

-iregex PATTERN: Same as -regex, but case-insensitive.

By Type
-type TYPE: Matches files of a specific type.

f: Regular file

d: Directory

l: Symbolic link

c: Character device

b: Block device

p: Named pipe (FIFO)

s: Socket

Bash

find . -type d                # Finds all directories
find /tmp -type f -name "*.tmp" # Finds regular files ending with .tmp in /tmp
find / -type l -name "lib*.so" # Finds symbolic links named lib*.so
By Size
-size N[cwbkMG]: Matches files with a size of N.

c: bytes

w: two-byte words

b: 512-byte blocks (default)

k: Kilobytes (1024 bytes)

M: Megabytes (1048576 bytes)

G: Gigabytes (1073741824 bytes)

+N: Greater than N

-N: Less than N

N: Exactly N (less common)

Bash

find /home -size +1G           # Finds files larger than 1 Gigabyte in /home
find . -size -10k             # Finds files smaller than 10 Kilobytes in current dir
find /tmp -size +50M -size -100M # Finds files between 50MB and 100MB
By Time
-atime N: Files accessed N days ago.

-mtime N: Files modified N days ago.

-ctime N: Files whose status (metadata, permissions, owner) was changed N days ago.

+N: More than N days ago (e.g., -mtime +7 means modified more than 7 days ago).

-N: Less than N days ago (e.g., -mtime -7 means modified less than 7 days ago, i.e., within the last 7 days).

N: Exactly N days ago.

Bash

find /var/log -mtime +30      # Files in /var/log modified more than 30 days ago
find ~/Documents -atime -2    # Files in Documents accessed in the last 2 days
-amin N, -mmin N, -cmin N: Same as atime, mtime, ctime but in minutes.

Bash

find . -type f -mmin -60      # Files modified in the last 60 minutes
-newermt REFERENCE_DATE: True if file was modified more recently than REFERENCE_DATE. REFERENCE_DATE can be YYYY-MM-DD HH:MM:SS.

Bash

find /backups -newermt "2024-01-01 00:00:00" # Finds files modified after Jan 1, 2024
-newer FILE: True if file was modified more recently than FILE.

Bash

find . -newer template.txt    # Finds files modified more recently than template.txt
By Permissions
-perm MODE: Files with exact permissions MODE. MODE can be octal (e.g., 644) or symbolic (e.g., u=rw,g=r,o=r).

-perm -MODE: Files with at least the permissions MODE. All bits in MODE must be set.

-perm /MODE (or -perm +MODE - deprecated): Files with any of the permissions MODE set. At least one bit in MODE must be set.

Bash

find . -perm 755              # Files with exact rwxr-xr-x permissions
find . -perm -u=r,o=w         # Files where owner can read AND others can write
find . -perm /4000            # Files with SUID bit set
By Ownership
-user USER: Files owned by USER (username or UID).

-group GROUP: Files owned by GROUP (group name or GID).

-nouser: Files that belong to a user not listed in /etc/passwd.

-nogroup: Files that belong to a group not listed in /etc/group.

Bash

find /var/www -user apache    # Files owned by user 'apache'
find /tmp -type f -nogroup    # Regular files in /tmp with no valid group owner
Combining Tests (Logical Operators)
find supports logical operators to combine tests. Operators are evaluated from left to right.

-a (or implicit AND): Logical AND. test1 -a test2 (or test1 test2) means both test1 AND test2 must be true. AND is the default.

-o (or --or): Logical OR. test1 -o test2 means either test1 OR test2 must be true.

! (or -not): Logical NOT. Inverts the result of the following test.

(): Grouping of tests. Requires quoting to prevent shell interpretation.

Bash

find . -type f -name "*.txt" -o -name "*.log" # Finds .txt OR .log files
find . -type f \( -name "*.txt" -o -name "*.log" \) # Same, but explicitly grouped for clarity/complex operations
find /var/log -type f -mtime +7 ! -name "*.gz" # Log files older than 7 days, NOT compressed
find /home -user john -a -size +1M             # Files owned by john AND larger than 1MB
Common Actions
Actions are performed on each file that passes all the preceding tests.

-print: Prints the full path of the file to standard output. (This is the default action if no other action is specified).

Bash

find . -type f -name "*.conf" -print
-delete: Deletes the found files. Use with extreme caution! It's irreversible.

Bash

find /tmp -type f -name "*.tmp" -mtime +7 -delete # Delete .tmp files in /tmp older than 7 days
-exec COMMAND {} \;: Executes COMMAND for each found file.

{}: A placeholder for the current filename.

\;: Terminates the COMMAND.

Bash

find . -type f -name "*.bak" -exec rm {} \; # Delete all .bak files
find /var/log -type f -name "*.log" -mtime +30 -exec gzip {} \; # Compress log files older than 30 days
-exec COMMAND {} +: Executes COMMAND with multiple found files as arguments. This is more efficient than \; for many files, as it reduces the number of COMMAND invocations.

Bash

find . -type f -name "*.html" -exec chmod 644 {} + # Change permissions for all .html files in one go
-ok COMMAND {} \;: Similar to -exec, but prompts the user for confirmation before executing COMMAND for each file.

Bash

find . -type f -name "*.old" -ok rm {} \; # Asks before deleting each .old file
-ls: Prints the output in ls -dils format, showing inode, blocks, permissions, owner, group, size, date, and name.

Bash

find /home/user/pictures -size +5M -ls
-print0: Prints the full file name on the standard output, followed by a null character. This is crucial when piping find's output to other commands that can handle null-terminated strings (like xargs -0), preventing issues with filenames containing spaces or special characters.

Bash

find . -name "*.txt" -print0 | xargs -0 grep "keyword"
Advanced Examples
1. Find and Change Permissions of Files Only (but not Directories)
Bash

find /var/www/html -type f -exec chmod 644 {} +
This ensures that only regular files get 644 permissions, leaving directories with their original permissions (e.g., 755).

2. Find and Change Permissions of Directories Only
Bash

find /var/www/html -type d -exec chmod 755 {} +
This ensures that only directories get 755 permissions.

3. Find Empty Files or Directories
Bash

find . -empty                 # Finds all empty files AND empty directories
find . -type f -empty         # Finds only empty files
find . -type d -empty         # Finds only empty directories
4. Find Files by Inode Number
Useful when a file name contains unprintable characters or you need to find hard links.

Bash

ls -i my_problem_file.txt     # Get the inode number
# Output: 123456 my_problem_file.txt
find . -inum 123456
5. Find Files Created by a Specific User in the Last 24 Hours
This combines ownership and time tests.

Bash

find /home -user john -type f -mtime -1
6. Search for Executable Files
Bash

find . -type f -perm /u=x,g=x,o=x # Files executable by user OR group OR others
find . -type f -perm /111         # Same as above (using octal)
find . -type f -executable        # A simpler, more portable way to find executable files
7. Remove Empty Directories
Bash

find . -type d -empty -delete
This will delete empty directories recursively, starting from the deepest empty directory upwards.

8. Find Files with Specific Permissions and Delete Them
Bash

find /tmp -type f -perm 666 -delete
This command finds and deletes regular files in /tmp that have exactly rw-rw-rw- permissions.

Best Practices and Cautions
Always test first: When using -delete or -exec rm, it's a very good practice to first run the find command without the deletion/execution part, or use -print to review the list of files it would act upon.

Bash

# FIRST, see what it would do:
find /tmp -type f -name "*.old" -mtime +180 -print

# THEN, if satisfied, add -delete:
find /tmp -type f -name "*.old" -mtime +180 -delete
Or use -ok for confirmation:

Bash

find /tmp -type f -name "*.old" -mtime +180 -ok rm {} \;
Quoting: Always quote wildcards (*, ?, []) in -name, -path, -regex patterns to prevent the shell from expanding them prematurely.

Performance: For very large file systems, find can be resource-intensive. Be specific with your starting points and use -maxdepth if you know the files are within a certain depth.

xargs vs. -exec \; vs. -exec +:

-exec COMMAND {} \;: Executes COMMAND once for each found file. Less efficient for many files due to many process spawns.

-exec COMMAND {} +: Executes COMMAND once for multiple found files (like xargs), more efficient.

| xargs: Offers even more flexibility and control, especially with xargs -0 for filenames with spaces or special characters. Generally preferred for complex operations involving other commands.

find is an extremely powerful and flexible command. Mastering its various options, tests, and actions is crucial for effective file system management and automation in Linux.
```