# vmstat: A Detailed Tutorial for Linux Performance Monitoring

`vmstat` (virtual memory statistics) is a powerful command-line utility in Linux that provides a quick and comprehensive overview of various system activities, including memory, paging, CPU, and I/O. It's an indispensable tool for system administrators and developers alike when troubleshooting performance issues or simply monitoring system health.

This tutorial will cover `vmstat`'s output, common usage patterns, and how to interpret its data effectively.

---

## 1. Basic Usage

The simplest way to use `vmstat` is to just type `vmstat` in your terminal:

```bash
vmstat
This will display a single snapshot of the current system statistics since the last reboot.

Example Output:

procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 1  0      0 102456 123456 456789    0    0    10    20  100  200  5  2 93  0  0
2. Understanding the Output Columns
The vmstat output is divided into several sections, each providing insights into a specific aspect of system performance.

2.1. procs (Processes)
r (runqueue): The number of processes waiting for run time (in the run queue). A consistently high r value might indicate a CPU bottleneck.

b (blocked): The number of processes in uninterruptible sleep. This often indicates processes waiting for I/O completion. A high b value could point to disk I/O issues.

2.2. memory
swpd (swapped): The amount of virtual memory used (kB). This includes memory that has been swapped out to disk.

free: The amount of idle memory (kB). This is truly unused memory.

buff (buffers): The amount of memory used as buffers (kB). Buffers are used for block device I/O, typically for raw disk access.

cache: The amount of memory used as cache (kB). Cache is used by the kernel for filesystem caching, improving performance by storing frequently accessed files in RAM.

Note on free, buff, and cache: In Linux, "free" memory isn't always truly free. The kernel aggressively uses available RAM for buffers and cache to optimize performance. A low free value combined with high buff and cache is usually healthy and indicates efficient memory usage. Worry when swpd is high and free is low.

2.3. swap
si (swap in): Amount of memory swapped in from disk (kB/s).

so (swap out): Amount of memory swapped out to disk (kB/s).

Interpretation: Persistent non-zero values for si and so indicate that the system is actively swapping, which can severely degrade performance as disk I/O is much slower than RAM access. This often suggests a memory shortage.

2.4. io (Input/Output)
bi (blocks in): Blocks received from a block device (blocks/s). Typically indicates read operations from disk.

bo (blocks out): Blocks sent to a block device (blocks/s). Typically indicates write operations to disk.

Interpretation: High bi and bo values indicate significant disk activity. If these values are high and CPU idle time is low, it could point to an I/O bottleneck.

2.5. system
in (interrupts): The number of interrupts per second, including the clock.

**cs (context switches): The number of context switches per second.

Interpretation: High values for in and cs can sometimes indicate a very busy system, especially if coupled with high CPU utilization. However, these are generally normal on modern systems with many processes.

2.6. cpu
us (user time): Percentage of CPU time spent running non-kernel code (user space).

sy (system time): Percentage of CPU time spent running kernel code (kernel space). This includes time spent on I/O, context switches, etc.

id (idle time): Percentage of CPU time spent idle.

wa (wait I/O): Percentage of CPU time spent waiting for I/O completion.

st (steal time): Percentage of CPU time "stolen" from a virtual machine by the hypervisor (relevant in virtualized environments).

Interpretation:

High us + high sy + low id: The CPU is busy.

High wa: The CPU is spending a lot of time waiting for disk I/O. This often points to a disk bottleneck.

High id (and low us, sy, wa): The CPU is not the bottleneck.

3. Advanced Usage and Options
vmstat offers several options to customize its output and behavior.

3.1. Continuous Monitoring
To get real-time updates, you can specify a delay (in seconds) between reports. This is one of the most common and useful ways to use vmstat.

Bash

vmstat [delay] [count]
delay: The delay in seconds between each report.

count: The number of reports to generate. If count is omitted, vmstat will report indefinitely until interrupted (Ctrl+C).

Example: Report every 2 seconds, 5 times:

Bash

vmstat 2 5
3.2. Displaying Slab Information
The -S option can be used to display slab cache information, which is memory used by the kernel for its own data structures.

Bash

vmstat -S [unit]
unit: The unit for the output (k for kilobytes, m for megabytes, g for gigabytes).

Example: Display memory statistics in megabytes:

Bash

vmstat -S m
3.3. Displaying Disk Statistics
The -d option displays disk statistics. This provides a more detailed breakdown of disk I/O activity.

Bash

vmstat -d
Example Output:

disk- ------------reads------------ ------------writes----------- ---io---
       total merged  sectors      ms  total merged  sectors      ms cur active  ms
sda       10      0       80       4      1      0        8       0   0      1   4
dm-0       5      0       40       2      1      0        8       0   0      1   2
total: Total number of reads/writes completed.

merged: Number of grouped reads/writes (requests merged into one).

sectors: Number of sectors read/written.

ms: Milliseconds spent reading/writing.

cur: Current I/O operations in progress.

active: Average number of I/O operations in progress during the sample.

ms: Average milliseconds spent on I/O operations.

3.4. Displaying Partition Statistics
The -p option displays statistics for a specific partition.

Bash

vmstat -p /dev/sda1
3.5. Displaying Fork Statistics
The -f option displays the number of forks since boot.

Bash

vmstat -f
3.6. Displaying Event Counters and Memory Statistics
The -s option displays a table of various event counters and memory statistics. This provides a more detailed and historical view of system events.

Bash

vmstat -s
Example Output Snippet:

          16738980 total memory
           102456 free memory
           123456 buffer memory
           456789 cache memory
                0 active memory
                0 inactive memory
           104856 swap total
                0 swap free
          1048560 dirty
           100000 writeback
             ...
3.7. Displaying Slab Memory Information
The -m option provides detailed information about slab memory usage. This is useful for debugging kernel memory leaks or understanding kernel memory consumption.

Bash

vmstat -m
4. Interpreting vmstat Output for Troubleshooting
Here's how to use vmstat to identify common performance bottlenecks:

4.1. CPU Bottleneck
Symptoms:

High us and/or sy values (close to 100% combined).

Low id value.

High r (runqueue) value.

Action: Identify CPU-intensive processes using top, htop, or ps aux --sort=-%cpu. Consider optimizing code, scaling up CPU resources, or distributing workload.

4.2. Memory Bottleneck (Swapping)
Symptoms:

Consistently high si and so values.

Low free memory, even with high buff and cache.

High swpd.

Action: This is a serious issue. The system is constantly moving data between RAM and disk, leading to slow performance. Identify memory-hungry applications (top, htop). Consider adding more RAM, optimizing application memory usage, or increasing swap space (as a temporary measure, not a solution).

4.3. I/O Bottleneck (Disk)
Symptoms:

High wa (wait I/O) in the cpu section.

High bi and bo values.

High b (blocked processes) in the procs section.

Action: Identify processes performing heavy I/O (iotop, strace). Check disk health (smartctl). Consider faster storage (SSDs), optimizing disk access patterns, or distributing I/O across multiple disks.

4.4. General System Slowness
If no single metric points to a clear bottleneck, look for a combination of factors. For instance, moderate CPU usage with moderate swapping and I/O could indicate an overall overloaded system.

Use vmstat in conjunction with other tools like top, iostat, netstat, and lsof for a more holistic view.

5. Practical Examples
5.1. Monitor CPU, Memory, and I/O every 3 seconds for 10 reports:
Bash

vmstat 3 10
5.2. Check disk I/O activity for sda and sdb every 5 seconds:
Bash

vmstat -d 5
(You'll need to filter the output or run it for specific devices if you have many)

5.3. Get a quick snapshot of all available vmstat statistics:
Bash

vmstat -s
```