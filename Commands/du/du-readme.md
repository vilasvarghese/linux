Markdown

# Linux `du` Command Tutorial

The `du` (disk usage) command in Linux is used to estimate file space usage. It summarizes disk usage of the set of files specified, recursively for directories. It's an essential tool for identifying where disk space is being consumed on your system.

## Basic Syntax

```bash
du [OPTION]... [FILE]...
FILE...: The file(s) or directory(ies) whose disk usage you want to estimate. If no FILE is specified, du summarizes disk usage of the current directory.

Examples and Use Cases
1. Estimate Disk Usage of the Current Directory
When run without any arguments, du lists the disk usage of each subdirectory in the current directory, and then the total usage of the current directory at the end. The output is in "blocks" (usually 1KB per block, but this can vary).

Bash

du
Output might look like:

4       ./.config/nvim
8       ./.config/htop
12      ./.config
4       ./documents/reports
16      ./documents
100     ./projects/my_app/src
200     ./projects/my_app
300     ./projects
520     .
2. Display Human-Readable Sizes
The -h (or --human-readable) option is arguably the most frequently used, as it makes the output much easier to understand by appending unit suffixes (K for kilobytes, M for megabytes, G for gigabytes).

Bash

du -h
Output:

4.0K    ./.config/nvim
8.0K    ./.config/htop
12K     ./.config
4.0K    ./documents/reports
16K     ./documents
100K    ./projects/my_app/src
200K    ./projects/my_app
300K    ./projects
520K    .
3. Summarize Total Disk Usage of a Directory
The -s (or --summarize) option displays only a total for each argument. This is extremely useful for getting a quick total size of a directory.

Bash

du -sh /var/log
This will show the total disk space consumed by the /var/log directory in human-readable format.

Bash

du -sh ~/Documents
This shows the total size of your Documents directory.

4. Display Disk Usage of Individual Files
To see the disk usage of specific files, just list them.

Bash

du -h my_document.txt large_image.jpg
5. Exclude Files or Directories
The --exclude=PATTERN option allows you to skip files or directories that match a specific pattern.

Bash

du -h --exclude="*.log" .
This will calculate the disk usage of the current directory, excluding any files ending with .log.

Bash

du -h --exclude="node_modules" ~/my_project
This calculates the size of ~/my_project without including the node_modules subdirectories (which can often be very large).

6. Display in Bytes, Kilobytes, or Megabytes
You can specify the block size directly:

-b or --bytes: Display size in bytes.

-k: Display size in 1-KB blocks (default on many systems).

-m: Display size in 1-MB blocks.

-g: Display size in 1-GB blocks.

Bash

du -bm /path/to/directory
This will show the size in megabytes.

7. Limit Depth of Reporting
The --max-depth=N option controls how many directory levels deep du will go.

Bash

du -h --max-depth=1 /var
This will show the human-readable size of /var and only its immediate subdirectories (one level deep). This is great for quickly identifying large subdirectories without getting overwhelmed by all sub-subdirectories.

8. Displaying Total for all Arguments
If you have multiple arguments and want to see a grand total for all of them, use the -c (or --total) option.

Bash

du -ch /home/user1 /home/user2 /var/log
This will show the individual totals for user1's home, user2's home, and /var/log, plus a final grand total.

9. Displaying the "Apparent Size"
By default, du reports the disk space allocated for files (which can be larger than the actual file content due to block allocation, sparse files, etc.). The --apparent-size option reports the actual size of the files as reported by ls -l.

Bash

du -h --apparent-size large_sparse_file.img
This is rarely what you want for "disk usage" but can be useful for comparing with ls -l output.

10. Combining Options
du commands are often combined for effective analysis.

Bash

# Find the 10 largest directories in the current path (excluding hidden ones)
du -sh * | sort -rh | head -n 10
du -sh *: Summarize human-readable sizes of all files and non-hidden directories in the current directory.

sort -rh: Sort the output numerically in reverse order (largest first) based on human-readable numbers.

head -n 10: Take the top 10 results.

When to use du?
Disk space analysis: Identify which files or directories are consuming the most disk space.

Troubleshooting: Pinpoint the cause of a "disk full" error.

Cleanup: Guide decisions on what files to archive or delete.

Monitoring: Track the growth of specific directories over time.

du is an essential command for any Linux user or system administrator to maintain healthy disk usage and understand storage consumption.
```