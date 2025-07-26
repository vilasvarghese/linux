Markdown

# Linux `df` Command Tutorial (Detailed)

The `df` (disk free) command in Linux is used to display the amount of available disk space usage on file systems. It provides information about the total space, used space, available space, and percentage of used space for mounted file systems. It's an essential tool for monitoring disk usage and preventing storage-related issues.

## Basic Syntax

```bash
df [OPTIONS] [FILE_SYSTEM]...
FILE_SYSTEM: You can specify a particular mount point or device (e.g., /dev/sda1, /home). If no FILE_SYSTEM is specified, df reports on all currently mounted file systems.

How df Works
df retrieves information directly from the kernel about mounted file systems. It reports on actual disk space, unlike du which calculates space used by files and directories (which can differ due to sparse files, block sizes, etc.).

Examples and Use Cases
1. Display Disk Space Usage of All Mounted File Systems (Default)
When run without any arguments or options, df shows a report for all currently mounted file systems. Sizes are typically in 1KB blocks.

Bash

df
Output Explanation (simplified):

Filesystem     1K-blocks    Used Available Use% Mounted on
udev             4060888       0   4060888   0% /dev
tmpfs             814400    1708    812692   1% /run
/dev/sda1       40810368 8976524  29788052  24% /
tmpfs            4072000       0   4072000   0% /dev/shm
tmpfs               5120       4      5116   1% /run/lock
tmpfs            4072000       0   4072000   0% /sys/fs/cgroup
/dev/sdb1       99998848 1024000  98974848   2% /data
Filesystem: The name of the device or pseudo-filesystem (e.g., /dev/sda1 is a partition, tmpfs is a RAM-based filesystem).

1K-blocks: Total size of the filesystem in 1-Kilobyte blocks.

Used: Amount of space currently used on the filesystem.

Available: Amount of free space available for use.

Use%: Percentage of disk space currently in use.

Mounted on: The mount point (directory) where the filesystem is attached to the tree.

2. Display Human-Readable Sizes (-h)
This is the most common and useful option, as it makes the output much easier to understand by appending unit suffixes (G for gigabytes, M for megabytes, K for kilobytes).

Bash

df -h
Output:

Filesystem      Size  Used Avail Use% Mounted on
udev            3.9G     0  3.9G   0% /dev
tmpfs           796M  1.7M  795M   1% /run
/dev/sda1        39G  8.6G   29G  24% /
tmpfs           3.9G     0  3.9G   0% /dev/shm
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
tmpfs           3.9G     0  3.9G   0% /sys/fs/cgroup
/dev/sdb1        96G  1.0G   94G   2% /data
3. Display Sizes in Specific Units (-B)
You can specify the block size explicitly using the -B (or --block-size=) option.

df -B M: Displays sizes in Megabytes.

df -B G: Displays sizes in Gigabytes.

df -B K: Displays sizes in Kilobytes.

Bash

df -BM # Display in Megabytes
df -BG # Display in Gigabytes
4. Display Disk Usage for a Specific Filesystem or Directory
You can specify the mount point or a file/directory within it. df will report on the filesystem where that file/directory resides.

Bash

df -h /home
df -h /dev/sda1
df -h /var/log/
5. Display Inode Information (-i)
Inodes are data structures that store information about files and directories (metadata), excluding their actual content. Each file and directory uses one inode. A filesystem can run out of inodes even if it has free disk space.

Bash

df -i
Output Explanation (simplified):

Filesystem        Inodes   IUsed   IFree IUse% Mounted on
udev             1015222     412 1014810    1% /dev
tmpfs            1018000     826 1017174    1% /run
/dev/sda1        2570240  245000 2325240   10% /
tmpfs            1018000       1 1017999    1% /dev/shm
Inodes: Total number of inodes available.

IUsed: Number of inodes currently in use.

IFree: Number of free inodes.

IUse%: Percentage of inodes in use.

6. Exclude Specific Filesystems by Type (-x)
You can exclude certain types of filesystems (e.g., pseudo-filesystems like tmpfs, devtmpfs, sysfs) from the output using the -x (or --exclude-type=) option.

Bash

df -h -x tmpfs -x devtmpfs -x squashfs
This command is useful for getting a cleaner view of only the "real" disk partitions.

7. Include Specific Filesystems by Type (-t)
Conversely, you can show only specific types of filesystems using the -t (or --type=) option.

Bash

df -h -t ext4
This will show only ext4 filesystems.

8. Display Pseudo-Filesystems (-a)
By default, df often omits certain pseudo-filesystems (like proc, sysfs, cgroup). Use -a (or --all) to show them.

Bash

df -a
9. Print Total for All Filesystems (-total)
The --total option (GNU extension) displays a grand total line at the end of the output.

Bash

df -h --total
Practical Use Cases
Quick Health Check: df -h is often the first command to run when investigating disk space alerts or performance issues. High Use% on / (root partition) or /var (logs) is a common problem.

Identifying Inode Exhaustion: If df -h shows plenty of free space but you can't create new files, df -i might reveal that you've run out of inodes. This often happens with applications that create many tiny files (e.g., mail servers, web caches).

Capacity Planning: Track disk growth over time to plan for future storage needs.

Scripting Alerts: df can be parsed by scripts to trigger alerts when disk usage exceeds a certain threshold. For example:

Bash

#!/bin/bash
THRESHOLD=90
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if (( DISK_USAGE > THRESHOLD )); then
    echo "Disk usage on / is ${DISK_USAGE}%! Alert!"
    # Add notification logic here (e.g., send email, Slack message)
fi
df vs. du
It's important to understand the difference between df and du:

df (disk free): Reports on filesystem usage. It tells you how much space is used and available on the mounted partitions as seen by the kernel. It accounts for all files and directories, including those that might be deleted but still held open by a running process.

du (disk usage): Reports on directory/file usage. It calculates the space consumed by files and directories from the perspective of their actual data blocks. If a file is deleted but a process still holds it open, du will not show its space usage (because the directory entry is gone), while df will still count it as used space until the process releases the file handle.

A common scenario where df and du show different results is when large log files are deleted while a logging service still has them open. df will show the disk space as still in use, while du will not. Restarting the logging service (or the entire system) typically releases the file handle and frees the space.

Conclusion
The df command is an indispensable tool for understanding and managing disk space on Linux systems. Its various options allow for flexible reporting, from a quick human-readable overview to detailed inode usage. Regularly checking disk space with df is a key part of system administration and preventative maintenance.
```