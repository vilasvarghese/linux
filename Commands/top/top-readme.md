Markdown

# Linux `top` and `htop` Command Tutorial (Detailed)

`top` and `htop` are powerful command-line utilities used for monitoring system processes and resource usage in real-time. They provide a dynamic, constantly updated view of the running processes, CPU usage, memory usage, swap space, and average load. `htop` is an enhanced and more user-friendly alternative to `top`.

## 1. `top` Command Tutorial

`top` is a standard utility available on virtually all Unix-like operating systems. It provides a real-time summary of system performance and a list of processes or threads currently being managed by the kernel.

### Basic Usage

Simply type `top` in your terminal:

```bash
top
Understanding the top Output
The top display is divided into two main sections:

a) Header Summary Area (Top Part)
This section provides an overview of the system's current state.

top - 08:00:00 up 1 day, 1:23,  2 users,  load average: 0.10, 0.15, 0.20
Tasks: 190 total,   1 running, 189 sleeping,   0 stopped,   0 zombie
%Cpu(s):  1.5 us,  0.8 sy,  0.0 ni, 97.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :   7890.1 total,   4567.8 free,   1234.5 used,   2087.8 buff/cache
MiB Swap:   2048.0 total,   2048.0 free,      0.0 used.  6455.6 avail Mem
First Line (top - ...):

Current time: 08:00:00

Uptime: up 1 day, 1:23 (how long the system has been running).

Logged-in users: 2 users

Load average: 0.10, 0.15, 0.20 (average number of processes in the run queue or waiting for I/O over the last 1, 5, and 15 minutes). Lower is better.

Tasks Line:

total: Total number of processes.

running: Processes currently using CPU.

sleeping: Processes waiting for an event.

stopped: Processes stopped (e.g., by Ctrl+Z).

zombie: Zombie processes (terminated but not reaped by parent, indicates issues).

%Cpu(s) Line: CPU utilization (percentage).

us: User CPU time (CPU time spent running user processes).

sy: System CPU time (CPU time spent running kernel processes).

ni: Nice CPU time (CPU time spent running niced (priority-adjusted) user processes).

id: Idle CPU time.

wa: Wait I/O (CPU time waiting for I/O to complete).

hi: Hardware IRQ (CPU time servicing hardware interrupts).

si: Software IRQ (CPU time servicing software interrupts).

st: Steal time (CPU time stolen by hypervisor for other virtual machines, if in a VM).

MiB Mem Line: Physical memory usage.

total: Total physical RAM.

free: Unused RAM.

used: RAM currently in use by processes.

buff/cache: Memory used for buffers and caches (can be freed if needed).

MiB Swap Line: Swap space usage.

total: Total swap space.

free: Unused swap space.

used: Swap space currently in use.

avail Mem: Estimated available memory for new processes (includes free memory plus reclaimable cache).

b) Process List Area (Bottom Part)
This section lists individual processes with their details.

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
12345 user      20   0 1564.0m 250.0m 120.0m S   1.5   3.1   0:10.50 firefox
  6789 root      20   0  350.0m  50.0m  30.0m S   0.8   0.6   0:05.10 mysqld
  123 root      20   0  100.0m  10.0m   8.0m S   0.0   0.1   0:00.10 systemd
PID: Process ID.

USER: User name of the process owner.

PR: Priority (actual kernel priority).

NI: Nice value (user-modifiable scheduling priority, -20 (highest) to 19 (lowest)).

VIRT: Virtual Memory Size (total virtual memory used by the process, including code, data, and shared libraries).

RES: Resident Set Size (physical memory currently held by the process, non-swapped). This is a good indicator of actual RAM usage.

SHR: Shared Memory Size (memory shared with other processes).

S: Process status (S=Sleeping, R=Running, D=Uninterruptible sleep, Z=Zombie, T=Stopped).

%CPU: CPU usage percentage since last update.

%MEM: Memory usage percentage (based on RES).

TIME+: Total CPU time used by the process since it started, in hundredths of a second.

COMMAND: The command name (often truncated) or full command line.

Interactive Commands within top
While top is running, you can press various keys to interact with it:

k: Kill a process. It will prompt for PID and then the signal (default 15 for SIGTERM).

r: Renice a process. Change its nice value (priority). It will prompt for PID and then the nice value.

q: Quit top.

h: Display help.

M: Sort processes by memory usage (%MEM).

P: Sort processes by CPU usage (%CPU, default).

T: Sort processes by running time (TIME+).

l: Toggle display of load average and uptime info.

t: Toggle display of tasks/CPU states.

m: Toggle display of memory information.

1: (Number one) Toggle display of individual CPU cores (if your system has multiple cores).

u: Filter by a specific user. It will prompt for username.

z: Toggle color/bold display.

s: Change the update interval (delay). It will prompt for seconds (default 3 seconds).

Customizing top (Persistent Configuration)
top saves its configuration in ~/.toprc. You can make changes interactively (like sorting, displaying fields) and then press W (capital W) to write the current settings to ~/.toprc for future sessions.

2. htop Command Tutorial
htop is an interactive process viewer that aims to be a more user-friendly and powerful alternative to top. It offers a more visually appealing interface, easier navigation, and more features out-of-the-box.

Installation
htop is not usually installed by default, but it's available in most distribution repositories:

Debian/Ubuntu: sudo apt install htop

CentOS/RHEL/Fedora: sudo yum install htop or sudo dnf install htop

Basic Usage
Simply type htop in your terminal:

Bash

htop
Understanding the htop Output
htop's layout is generally more intuitive than top's.

a) Header Summary Area (Top Part)
Similar to top, but often displayed with graphical meters.

  CPU[||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| 50.0%]
  Mem[||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| 50.0%]
  Swp[||||||||||||||                                                                   25.0%]
  Tasks: 190, 1 running
  Load average: 0.10 0.15 0.20
  Uptime: 1 day, 1:23:45
CPU/Mem/Swp Meters: Visual representation of usage. If you have multiple CPU cores, you'll see a meter for each core.

Tasks: Total processes and running processes.

Load average & Uptime: Same as top.

b) Process List Area (Bottom Part)
The process list is displayed in a more organized and colorful way.

  PID USER      PRI NI VIRT  RES  SHR S CPU% MEM%   TIME+ Command
12345 user       20  0 1.5G 250M 120M S  50.0  3.1  0:10.50 /usr/lib/firefox/firefox
  6789 root       20  0 350M  50M  30M S   0.8  0.6  0:05.10 /usr/sbin/mysqld
  123 root       20  0 100M  10M   8M S   0.0  0.1  0:00.10 /sbin/init
The columns are largely the same as top, but htop often shows full command lines by default.

Interactive Commands and Features within htop
htop is designed for interactivity, often using function keys and mouse clicks.

Arrow Keys (Up/Down): Navigate the process list.

Left/Right Arrow Keys: Scroll horizontally if more columns are displayed than fit the screen.

F1 or h: Help.

F2 or S: Setup (customize display, columns, meters, colors).

F3 or /: Search for a process (by name).

F4 or \: Filter the process list (live filtering as you type).

F5 or t: Tree view (shows parent-child relationships).

F6 or < / >: Sort by column (select a column and then use F6).

F7 or ]: Nice (decrease priority) - make a process run less often.

F8 or [: Nice (increase priority) - make a process run more often.

F9 or k: Kill a process. It presents a list of signals to choose from (SIGTERM, SIGKILL, etc.).

F10 or q: Quit htop.

Spacebar: Tag/untag a process (select multiple processes to act on).

U: Untag all processes.

s: Strace a process (attach strace to selected process, requires strace to be installed).

l: List open files for a selected process (requires lsof to be installed).

Customizing htop (Persistent Configuration)
htop's setup menu (F2) allows extensive customization:

Setup Columns: Choose which columns to display and their order.

Setup Meters: Configure the top meters (CPU, Memory, Swap, Load Average, etc.) and their display style (text, bar, LED, graph).

Colors: Change the color scheme.

Display Options: Toggle various display features like tree view, showing custom values, etc.

All changes made in the setup menu are saved automatically to ~/.config/htop/htoprc (or ~/.htoprc on older systems).

Choosing Between top and htop
top:

Pros: Universally available (standard on all Linux/Unix systems), lightweight.

Cons: Less intuitive interface, harder to navigate, lacks some features without manual configuration.

htop:

Pros: More user-friendly, colorful, interactive (mouse support, F-keys), easier to kill/renice processes, tree view,
search/filter, extensible with lsof/strace integrations.

Cons: Not installed by default, slightly more resource-intensive than top (negligibly for most modern systems).

Recommendation: For daily use and a better user experience, htop is generally recommended due to its superior interactivity and readability. If htop is not available (e.g., on a minimal system or a very old distribution), top is your go-to tool.

Both top and htop are invaluable for diagnosing system performance issues, identifying resource hogs, and generally keeping an eye on your Linux system.
```