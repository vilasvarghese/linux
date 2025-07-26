Markdown

# Linux `ps` Command Tutorial (Detailed)

The `ps` (process status) command in Linux is used to display information about currently running processes. It allows users to see what processes are active on the system, their PIDs (Process IDs), CPU and memory usage, terminal information, and more. Understanding `ps` is fundamental for monitoring system health, troubleshooting issues, and managing processes.

## Basic Syntax

```bash
ps [OPTIONS]
ps is unique in that it has several distinct syntax styles:

Unix-style options: Preceded by a single dash (e.g., ps -ef).

BSD-style options: Not preceded by a dash (e.g., ps aux).

GNU long options: Preceded by two dashes (e.g., ps --forest).

The output columns vary significantly depending on the options used.

Common ps Command Combinations and Examples
1. Unix-style: Display All Processes (Common)
Bash

ps -ef
This is one of the most common ways to use ps.

-e: Select all processes.

-f: Do a full-format listing.

Output Explanation (simplified):

UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 Jul24 ?        00:00:01 /sbin/init
root       500     1  0 Jul24 ?        00:00:00 /usr/lib/systemd/systemd-journald
user       12345 1234  0 08:30 pts/0    00:00:00 bash
user       12346 12345 0 08:30 pts/0    00:00:00 ps -ef
UID: User ID of the process owner.

PID: Process ID.

PPID: Parent Process ID. The PID of the process that started this one.

C: CPU utilization (legacy field, often 0).

STIME: Start time of the process.

TTY: Terminal associated with the process (? means no controlling terminal, like daemon processes).

TIME: Cumulative CPU time.

CMD: The command that started the process (including arguments).

2. BSD-style: Display All Processes (Common)
Bash

ps aux
Another very common and often preferred way to view processes due to its more detailed, human-readable output format.

a: Show processes for all users (including those not attached to a terminal).

u: Display user-oriented format (shows user, %CPU, %MEM, etc.).

x: Show processes not associated with a terminal.

Output Explanation (simplified):

USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0 169420  9980 ?        Ss   Jul24   0:01 /sbin/init
root         500  0.0  0.1 123456 10000 ?        Sl   Jul24   0:00 /usr/lib/systemd/systemd-journald
user       12345  0.1  0.1 123456  5000 pts/0    Ss   08:30   0:00 bash
user       12346  0.0  0.0 200000  2000 pts/0    R+   08:30   0:00 ps aux
USER: User name of the process owner.

PID: Process ID.

%CPU: CPU utilization of the process.

%MEM: Memory utilization (Resident Set Size).

VSZ: Virtual Memory Size (total virtual memory used by the process in KiB).

RSS: Resident Set Size (non-swapped physical memory the process has used in KiB).

TTY: Terminal associated with the process.

STAT: Process state (e.g., S=Sleeping, R=Running, Z=Zombie, T=Stopped, s=session leader, l=multi-threaded, +=in foreground group).

START: Start time of the process.

TIME: Cumulative CPU time.

COMMAND: The command that started the process (often truncated).

3. Display Processes by User
To see processes owned by a specific user:

Bash

ps -u username
Example:

Bash

ps -u apache
This will show processes owned by the apache user.

4. Display Processes in a Tree Format
The --forest option (GNU style) draws a tree hierarchy of processes, showing parent-child relationships. This is incredibly useful for understanding how processes are launched.

Bash

ps -ef --forest
# Or with BSD style
ps aux --forest
Output:

UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 Jul24 ?        00:00:01 /sbin/init
root       500     1  0 Jul24 ?        00:00:00  \_ /usr/lib/systemd/systemd-journald
user       12345 1234  0 08:30 pts/0    00:00:00  \_ bash
user       12346 12345 0 08:30 pts/0    00:00:00      \_ sshd: user@pts/0
user       12347 12346 0 08:30 pts/0    00:00:00          \_ firefox
5. Display Custom Output Columns
You can specify exactly which columns you want to display using the -o (or --format) option. This gives you fine-grained control over the output. Use ps -eo help or man ps to see a full list of available format specifiers.

Bash

ps -eo pid,user,comm,%cpu,%mem,start_time,time,cmd
pid: Process ID

user: User owner

comm: Command name (basename only)

%cpu: CPU usage percentage

%mem: Memory usage percentage

start_time: Start time

time: Cumulative CPU time

cmd: Full command line

6. Display Only Processes for the Current Terminal
Bash

ps
When ps is run without any options, it typically shows processes associated with the current terminal.

7. Filter Processes with grep
ps is frequently piped to grep to find specific processes by name.

Bash

ps aux | grep firefox
This command lists all processes and then filters for lines containing "firefox". Be aware that grep firefox itself will show up in the output.

To exclude the grep process itself, you can use:

Bash

ps aux | grep [f]irefox
By putting f in brackets, grep matches "firefox" but its own command line becomes "grep [f]irefox", so it doesn't match itself.

8. Display Processes with Specific PIDs
Bash

ps -p 12345,67890
This shows information about processes with PIDs 12345 and 67890.

9. Display Processes by Command Name
The -C (or --command) option (Unix-style) can be used to select by command name.

Bash

ps -C sshd
This will show all processes whose executable name is sshd.

10. Display Multi-Threaded Processes
The -L option can show threads within processes.

Bash

ps -Lef
Output will include LWP (Light Weight Process/Thread ID) and NLWP (Number of Light Weight Processes/Threads) columns.

11. Real-time Monitoring with watch
While ps provides a snapshot, you can use watch to get periodic updates.

Bash

watch -n 1 'ps aux --sort=-%mem'
This command will refresh ps aux every 1 second, sorting the output by memory usage in descending order (highest memory users at the top). Press Ctrl+C to exit watch.

Important STAT Codes (Process State)
The STAT column in ps aux output provides valuable information about a process's current state:

R: Running (or runnable, on run queue).

S: Sleeping (waiting for an event to complete).

D: Uninterruptible sleep (usually I/O; process cannot be killed directly).

Z: Zombie (terminated but parent hasn't reaped it; indicates a problem).

T: Stopped (by a job control signal or being traced).

<: High-priority process.

N: Low-priority (niced) process.

L: Pages are locked into memory (real-time processes).

s: Is a session leader.

l: Is multi-threaded (uses forks).

+: Is in the foreground process group.

When to use ps?
Identify runaway processes: Find processes consuming excessive CPU or memory.

Process troubleshooting: Determine if a service is running, its PID, and its command line.

Resource monitoring: Get a snapshot of system resource usage by processes.

Scripting: Automate tasks that involve checking process status.

Security: Identify unknown or suspicious processes.

ps is a fundamental diagnostic tool in Linux. While top and htop offer interactive real-time views, ps excels at providing detailed, customizable snapshots of processes, especially useful when combined with grep for specific filtering.
```