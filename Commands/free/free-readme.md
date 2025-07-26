# Linux `free` Command Tutorial (Detailed)

The `free` command in Linux is used to display the amount of free and used physical and swap memory in the system. It provides crucial insights into how your system's memory is being utilized, which is essential for diagnosing performance issues, understanding memory pressure, and making informed decisions about resource allocation.

## Basic Syntax

```bash
free [OPTIONS]
Understanding Memory Concepts in Linux
Before diving into free's output, it's important to understand a few Linux memory concepts:

Physical Memory (RAM): The actual hardware memory installed in your system.

Swap Memory: A dedicated disk space (or file) used as virtual memory when physical RAM runs low. Data is swapped between RAM and swap space.

Used Memory: Memory currently occupied by applications, processes, and the kernel.

Free Memory: Memory that is completely unused and available for immediate allocation.

Buffers: Memory used by the kernel to buffer I/O operations (e.g., block device I/O). These are temporary storage for raw disk blocks and can be quickly repurposed.

Cache: Memory used by the kernel to cache files read from disk. This speeds up subsequent access to the same files. Cached memory is technically "used" but is readily available to applications if they need it (it's called "reclaimable memory").

Shared Memory: Memory that can be accessed by multiple processes.

Available Memory (since kernel 3.14): A more accurate estimate of how much memory is actually available for starting new applications, without significant swapping. It attempts to account for reclaimable buffer/cache memory.

Examples and Use Cases
1. Basic Output (Default Behavior)
Running free without any options displays memory usage in kilobytes (KiB) by default.

Bash

free
Output Explanation (Simplified):

              total        used        free      shared  buff/cache   available
Mem:        8144000     1234567     4567890      123456     2234567     6789012
Swap:       2048000           0     2048000
total: Total installed memory (physical RAM or swap space).

used: Amount of used memory.

free: Amount of unused memory.

shared: Memory used by tmpfs (a RAM-based filesystem) and for shared memory segments.

buff/cache: Combined memory used for kernel buffers and page cache. This memory is typically reclaimable.

available: An estimate of how much memory is available for new applications without swapping. This is derived from free plus reclaimable buff/cache memory. This is the most important field for gauging truly usable memory on modern Linux systems.

Understanding used vs. available (Crucial for Modern Linux)
On modern Linux systems, the free column often shows very little free memory. This is normal and by design! The kernel uses "free" memory for buffers and caches to improve performance. This buff/cache memory is reclaimable and will be given back to applications as soon as they need it.

Therefore, for a realistic understanding of available memory, you should look at the available column, not just free. A low available value (especially combined with high Swap usage) indicates actual memory pressure.

2. Display Human-Readable Output (-h)
This is the most common and useful option, as it makes the output much easier to understand by appending unit suffixes (G for gigabytes, M for megabytes, K for kilobytes).

Bash

free -h
Output:

              total        used        free      shared  buff/cache   available
Mem:          7.8Gi       1.2Gi       4.4Gi       120Mi       2.1Gi       6.5Gi
Swap:         2.0Gi          0B       2.0Gi
3. Display Output in Specific Units (-b, -k, -m, -g)
You can force free to display output in specific units:

-b (or --bytes): Bytes

-k (or --kilo): Kilobytes (default)

-m (or --mega): Megabytes

-g (or --giga): Gigabytes

Bash

free -m  # Display in Megabytes
free -g  # Display in Gigabytes
4. Display Total (-t)
The -t (or --total) option displays a line showing the total of physical and swap memory.

Bash

free -h -t
Output:

              total        used        free      shared  buff/cache   available
Mem:          7.8Gi       1.2Gi       4.4Gi       120Mi       2.1Gi       6.5Gi
Swap:         2.0Gi          0B       2.0Gi
Total:        9.8Gi       1.2Gi       6.4Gi
5. Display Low and High Memory Statistics (-l)
On systems with specific memory architectures (e.g., older 32-bit systems with more than 4GB RAM), memory might be divided into "low" and "high" memory. The -l (or --lohi) option shows separate statistics for these areas. This is less common on modern 64-bit systems.

Bash

free -l
6. Display Output in Wide Format (-w)
The -w (or --wide) option provides a wider output, which can be useful to prevent truncation of numbers or headings, especially in older terminal emulators or with very large memory values.

Bash

free -hw
7. Repeated Output (Monitoring) (-s)
You can make free update its output at a specified interval using the -s (or --seconds=) option. This is useful for real-time monitoring of memory usage over time.

Bash

free -h -s 5
This command will update the memory statistics every 5 seconds. Press Ctrl+C to stop.

8. Display System-Wide Memory (Old Kernels)
On very old Linux kernels, free used to show buffers and cached as separate columns and didn't have the available column. The "truly free" memory was often calculated as free + buffers + cached.

While modern free handles this with the available column, if you're on a very old system or prefer the old view, you might see something like:

              total        used        free      shared     buffers     cached
Mem:        8144000     1234567     4567890      123456      500000     1500000
-/+ buffers/cache:      -USED-       -FREE-
Swap:       2048000           0     2048000
In this old output:

buffers: Memory for block device I/O buffers.

cached: Memory for page cache.

-/+ buffers/cache line:

The first number (-USED-) is used - buffers - cached. This represents memory actively used by applications and not easily reclaimable.

The second number (-FREE-) is free + buffers + cached. This is the total memory effectively available for applications, similar to the available column in modern free.

9. Scripting and Automation
free is often used in scripts to monitor memory usage and trigger alerts or actions when memory becomes critically low.

Example (simple check for low available memory):

Bash

#!/bin/bash

# Define a threshold for available memory in MB
THRESHOLD_MB=500

# Get available memory in MB
AVAILABLE_MEM=$(free -m | awk 'NR==2 {print $7}') # Column 7 for 'available'

if (( AVAILABLE_MEM < THRESHOLD_MB )); then
    echo "WARNING: Available memory is low (${AVAILABLE_MEM}MB)! Consider taking action."
    # Add notification logic here (e.g., send email, log alert, restart service)
else
    echo "Memory status OK. Available: ${AVAILABLE_MEM}MB"
fi
When to use free?
Quick Memory Check: Immediately see your system's memory and swap status.

Troubleshooting Performance: Determine if a system is experiencing memory pressure (high used memory coupled with low available memory and/or high Swap usage).

Capacity Planning: Track memory usage trends for resource planning.

Scripting: Automate memory monitoring and alerting.

Remember, a low free value does not necessarily mean your system is running out of memory. Always check the available column for a more accurate picture of usable memory on modern Linux systems.
```