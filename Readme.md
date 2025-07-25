

# Week 1: Linux Basics & Networking Foundations (RHEL 9)

**Objective:** Build foundational Linux and networking skills.

---

## Day 1: Introduction to Linux

### What is Linux? History and Distributions (RHEL 9, Ubuntu 24.04, Fedora)

**Linux** is a free and open-source operating system based on the Unix operating system. It's a powerful, secure, and flexible OS widely used for servers, desktops, mobile devices, and embedded systems. At its core is the **Linux kernel**, originally created by Linus Torvalds in 1991.

---

### History of Linux

* **1969–1980s: Unix Origins**
    Unix was developed at Bell Labs and became popular for its portability, multitasking, and multi-user capabilities. However, it was proprietary.

* **1983: GNU Project**
    Richard Stallman started the GNU Project to create a free Unix-like OS. Many components were developed (like compilers and shells), but a kernel was missing.

* **1991: Linux Kernel Released**
    Linus Torvalds, a Finnish student, wrote a new kernel and released it under the GNU General Public License (GPL). The combination of the Linux kernel and GNU tools formed a full operating system.

* **1990s–2000s: Rapid Growth**
    Linux gained traction among developers, hobbyists, and eventually enterprise users due to its reliability and cost-effectiveness.

---

### What is a Linux Distribution?

A **Linux distribution (distro)** is a complete operating system built around the Linux kernel. It may include package managers, graphical interfaces, utilities, and applications. Each distro may focus on different goals: user-friendliness, performance, stability, or cutting-edge features.

---

### Popular Linux Distributions

1.  **Red Hat Enterprise Linux (RHEL 9)**
    * **Developer:** Red Hat (now part of IBM)
    * **Release:** RHEL 9 launched in May 2022
    * **Use case:** Enterprise environments, servers, cloud infrastructure
    * **Key features:**
        * Stable and secure
        * Long-term support (10+ years)
        * Subscription-based with professional support
        * SELinux integration (advanced security)
        * Uses `dnf` for package management (RPM packages)
        * Certified for enterprise software (Oracle, SAP, etc.)

2.  **Ubuntu 24.04 LTS ("Noble Numbat")**
    * **Developer:** Canonical Ltd.
    * **Release:** April 2024
    * **Use case:** Desktops, servers, cloud, IoT
    * **Key features:**
        * **Long-Term Support (LTS):** 5 years of updates
        * Based on Debian
        * Uses `apt` for package management (DEB packages)
        * User-friendly with GUI options like GNOME
        * Widely used in education, web hosting, and development

3.  **Fedora (e.g., Fedora 40)**
    * **Developer:** Fedora Project (sponsored by Red Hat)
    * **Use case:** Developers, open-source enthusiasts, desktop users
    * **Key features:**
        * Cutting-edge features and software
        * Community-driven and freely available
        * Shorter lifecycle (about 13 months)
        * Often a testing ground for RHEL features
        * Uses `dnf` (RPM-based like RHEL)

---

### Comparison Table

| Feature           | RHEL 9                      | Ubuntu 24.04 LTS         | Fedora (e.g., 40)             |
| :---------------- | :-------------------------- | :----------------------- | :---------------------------- |
| **Based on** | Red Hat (RPM)               | Debian (DEB)             | Red Hat (RPM)                 |
| **Release Type** | Stable, enterprise-grade    | Stable (LTS)             | Bleeding-edge                 |
| **Package Manager** | `dnf` (RPM)                 | `apt` (DEB)              | `dnf` (RPM)                   |
| **GUI Option** | GNOME (default)             | GNOME (default), others  | GNOME (default), others       |
| **Target Users** | Enterprises                 | General users, devs      | Developers, enthusiasts       |
| **Support Cycle** | ~10 years (with support)    | 5 years (LTS)            | ~13 months                    |
| **License** | Subscription-based          | Free and open-source     | Free and open-source          |

---

### Linux vs. Windows, Cloud Context (AWS EC2)

Here's a comparison of Linux vs. Windows in a cloud context, especially for AWS EC2 (Elastic Compute Cloud):

---

#### ☁️ Linux vs. Windows on AWS EC2

| Feature/Aspect        | Linux                                          | Windows                                                    |
| :-------------------- | :--------------------------------------------- | :--------------------------------------------------------- |
| **Cost** | Free or low cost (license-free)                | Higher cost (Windows license fees apply)                   |
| **Boot Time** | Fast                                           | Slower                                                     |
| **Resource Usage** | Low memory and CPU overhead                    | Higher system resource consumption                         |
| **Instance Availability** | Widely available (Amazon Linux, Ubuntu, RHEL, etc.) | Available but limited to certain AMIs                      |
| **Security** | Strong, customizable (SELinux, `iptables`, etc.) | Secure but closed-source; patch management is critical     |
| **SSH Access** | Native, easy setup                             | Requires RDP setup                                         |
| **File System** | `ext4`, `XFS`, etc.                            | NTFS                                                       |
| **Customization** | Highly customizable                            | More rigid, registry-based configuration                   |
| **CLI (Command Line)** | Powerful  and scripting                    | PowerShell (advanced but different syntax)                 |
| **Use Cases** | Web servers, containers, big data, dev/test    | Windows-native apps (.NET, IIS, Active Directory)          |
| **Software Ecosystem** | Open-source, flexible (Nginx, Apache, MySQL, etc.) | Microsoft ecosystem (IIS, SQL Server, Exchange)            |
| **Automation Tools** | Ansible, Terraform, , cloud-init           | PowerShell DSC, Chocolatey, AWS Systems Manager            |
| **Market Share (AWS)** | ~70–75% of EC2 workloads run on Linux-based AMIs | ~25–30% run on Windows-based AMIs                          |

---

#### When to Use Linux on AWS

**Best for:**
* Web apps (Nginx, Apache)
* Containers (Docker, Kubernetes)
* DevOps and automation
* Python, Node.js, Java apps
* High-performance computing (HPC)
* Cost-sensitive workloads

**Popular Linux AMIs:**
* Amazon Linux 2023
* Ubuntu 24.04 LTS
* RHEL 9
* SUSE Linux Enterprise Server
* Debian 12

---

#### When to Use Windows on AWS

**Best for:**
* Applications built on .NET or ASP.NET
* Microsoft SQL Server
* Microsoft Office applications (RDP use)
* Active Directory domain controllers
* Legacy Windows workloads

**Common Windows AMIs:**
* Windows Server 2019/2022 Base
* Windows Server with SQL Server
* Windows Server with Containers

---

#### Cost Example (as of 2025)

* **t3.micro Linux EC2 (Amazon Linux):** ~$0.0104/hour (on-demand) – no OS license fee
* **t3.micro Windows EC2:** ~$0.0200/hour (on-demand) – includes Windows license

---

#### Summary

| Use Case                        | Best Choice |
| :------------------------------ | :---------- |
| Cost-effective, open-source stack | Linux       |
| Microsoft-based enterprise stack  | Windows     |
| DevOps automation, containers   | Linux       |
| RDP access to desktop apps      | Windows     |
| SQL Server + IIS hosting        | Windows     |

---

### Installation: RHEL 9 in VirtualBox or WSL2

---

### Shell Basics: `whoami`, `date`, `man`, `clear`

---

#### 1. `whoami` — "Who am I?"

* **Description:** The `whoami` command shows the username of the current user.
* **Why is it useful?** When working on a system (especially remote servers), you might want to verify which user account you're currently using.
* **Syntax:** `whoami`
* **Example Output:**
    ```
    john
    ```
* **Related Commands:**
    * `id` – Shows more details like UID, GID, and groups.
    * `who` – Shows who is logged into the system.

#### 2. `date` — Show the current date and time

* **Description:** Displays the current date, time, and timezone information. Can also be used to format or set system time (admin privileges required for setting).
* **Basic Usage:**
    ```
    date
    ```
* **Example Output:**
    ```
    Thu Jul 24 22:12:08 IST 2025
    ```
* **Formatting Examples:**
    * Display only the date:
        ```
        date +"%Y-%m-%d"
        # Output: 2025-07-24
        ```
    * Display only the time:
        ```
        date +"%H:%M:%S"
        # Output: 22:12:08
        ```
    * Custom format with day:
        ```
        date +"%A, %d %B %Y"
        # Output: Thursday, 24 July 2025
        ```
* **Set the system date (admin only):**
    ```
    sudo date --set="25 July 2025 10:00:00"
    ```
* **Full formatting options:** [GNU date format specifiers](https://www.gnu.org/software/coreutils/manual/html_node/date-invocation.html)

#### 3. `man` — Manual pages

* **Description:** The `man` command lets you view the manual (help documentation) for any Linux command.
* **Basic Usage:**
    ```
    man command_name
    ```
* **Example:**
    ```
    man ls
    ```
    This opens the manual for the `ls` command.
* **Navigation:**
    * `Space` – Scroll down
    * `b` – Scroll up
    * `/pattern` – Search for "pattern"
    * `n` – Next search result
    * `q` – Quit
* **Sections of man:**
    Manuals are divided into sections like:

    | Section | Content                          |
    | :------ | :------------------------------- |
    | 1       | User commands                    |
    | 5       | File formats and configuration   |
    | 8       | System administration            |

    For example:
    ```
    man 5 passwd
    ```
    Shows the config file format of `/etc/passwd`.

#### 4. `clear` — Clear the terminal

* **Description:** This command clears the terminal screen, making it clean and readable.
* **Usage:**
    ```
    clear
    ```
    Same as pressing `Ctrl+L` in most terminals.
* **Technical Note:** It just moves the terminal content up by sending ANSI escape sequences; it does not delete the command history.

---

### Summary Table

| Command | Purpose                     | Example              |
| :------ | :-------------------------- | :------------------- |
| `whoami`  | Show current user           | `whoami`               |
| `date`    | Show or set system date/time | `date +"%d/%m/%Y"`     |
| `man`     | View command manuals        | `man ls`, `man 5 passwd` |
| `clear`   | Clear terminal screen       | `clear`                |

---

### Lab: Install RHEL 9, navigate terminal.

---

## Day 2: Filesystem and File Management

### Filesystem Hierarchy: `/etc`, `/var`, `/usr`, `/home`

Refer to "The Hierarchy of the File System" section in a comprehensive Linux basics resource for detailed understanding of these directories:
* `/etc`: Configuration files for the system and applications.
* `/var`: Variable data, such as logs (`/var/log`), mail queues, and temporary files.
* `/usr`: User programs and data, often considered "Unix System Resources."
* `/home`: Home directories for regular users.

---

### Commands: `ls`, `pwd`, `cd`, `file`, `mkdir`, `touch`, `cp`, `mv`, `rm`, `find`

---

#### `ls` (List) - Seeing What's There 📄

The `ls` command is used to **list the contents of a directory**. It's like opening a folder to see its files and subfolders.

* **Purpose:** To display files and directories.
* **Syntax:** `ls [OPTIONS] [FILE...]`

**Examples:**
1.  **List contents of the current directory:** `ls`
2.  **List contents of a specific directory:** `ls /home/your_username/Documents` or `ls Documents`
* **Common Options:**
    * `-l` (long format): Detailed list (permissions, owner, size, date).
    * `-a` (all): Shows all files, including hidden files (starting with `.`).
    * `-h` (human-readable): Use with `-l` to show file sizes (KB, MB, GB).
    * `-R` (recursive): Lists contents of subdirectories.
    * **Combining options:** `ls -lah`

#### `pwd` (Print Working Directory) - Where Am I? 

The `pwd` command tells you your **current location** in the file system hierarchy.

* **Purpose:** To display the absolute path of your current working directory.
* **Syntax:** `pwd`

**Example:**
```
pwd
# Output Example: /home/your_username/Documents
cd (Change Directory) - Moving Around 
The cd command is used to change your current working directory.

Purpose: To navigate between directories.

Syntax: cd [DIRECTORY]

Examples:

Change to your home directory: cd or cd ~

Change to a subdirectory: cd Documents

Change to a parent directory: cd ..

Change to the root directory: cd /

Change to the previous directory: cd -

Change to an absolute path: cd /var/log

file - What Kind of File Is It? 
The file command helps you determine the type of a file. It inspects the file's content, not just its extension.

Purpose: To identify the type of a file.

Syntax: file [OPTIONS] FILE...

Examples:

Check the type of a text file: file my_document.txt

Check the type of a directory: file my_folder

Check the type of an executable program: file /bin/ls

mkdir (Make Directory) - Creating Folders 
The mkdir command is used to create new directories (folders).

Purpose: To create one or more new directories.

Syntax: mkdir [OPTIONS] DIRECTORY...

Examples:

Create a single directory: mkdir new_project

Create multiple directories at once: mkdir dir1 dir2 dir3

Create a directory with parent directories (if they don't exist): mkdir -p /home/your_username/projects/my_app/src/main/java

The -p (parents) option is very useful.

touch - Creating Empty Files or Updating Timestamps 
The touch command is primarily used to create empty new files or to update the access and modification times of existing files.

Purpose: To create empty files or change file timestamps.

Syntax: touch [OPTIONS] FILE...

Examples:

Create an empty new file: touch my_new_file.txt

Update the timestamp of an existing file: touch existing_document.txt

cp (Copy) - Duplicating Files and Directories 
The cp command is used to copy files and directories.

Purpose: To make copies of files or directories.

Syntax: cp [OPTIONS] SOURCE DESTINATION

Examples:

Copy a file to the same directory with a new name: cp report.txt report_backup.txt

Copy a file to a different directory: cp document.pdf /home/your_username/Documents/archives/

Copy a directory (and its contents): cp -r my_folder new_folder_copy

The -r (recursive) option is mandatory when copying directories.

Common Options:

-r (recursive): Required for copying directories.

-i (interactive): Prompts you before overwriting.

-v (verbose): Shows what's being copied.

mv (Move / Rename) - Moving or Renaming Files and Directories 
The mv command is used to move files or directories from one location to another, or to rename them.

Purpose: To move or rename files and directories.

Syntax: mv [OPTIONS] SOURCE DESTINATION

Examples:

Rename a file: mv old_name.txt new_name.txt

Move a file to a different directory: mv document.odt /home/your_username/Downloads/

Move a directory: mv project_old project_archive/

Common Options:

-i (interactive): Prompts before overwriting.

-v (verbose): Shows what's being moved/renamed.

rm (Remove) - Deleting Files and Directories 
The rm command is used to remove (delete) files or directories. Use rm with extreme caution, as deleted files are generally not recoverable.

Purpose: To delete files or directories.

Syntax: rm [OPTIONS] FILE...

Examples:

Remove a single file: rm unwanted_file.txt

Remove a directory and its contents (recursive): rm -r old_project_files/

The -r (recursive) option is mandatory for deleting non-empty directories. Be very careful!

Common Options (Use with Caution!):

-i (interactive): Prompts before every deletion. Highly recommended.

-f (force): Forces deletion, ignoring non-existent files and never prompting. Extremely dangerous!

find - Locating Files and Directories 
The find command is a powerful tool for searching for files and directories based on various criteria.

Purpose: To search for files and directories in a directory hierarchy.

Syntax: find [PATH...] [EXPRESSION]

Examples:

Find a file by name: find . -name "report.txt"

Find a file by name (case-insensitive): find . -iname "Report.txt"

Find all .log files in /var/log: find /var/log -name "*.log"

Find directories only: find . -type d -name "my_project*"

Find files larger than 1 Megabyte: find . -type f -size +1M

Find files modified in the last 7 days: find . -type f -mtime -7

Find and delete files: find . -name "*.bak" -exec rm {} \; (Use with extreme caution!)

Wildcards: *, ?, Relative vs. Absolute Paths
Wildcards:

*: Matches any sequence of zero or more characters. (e.g., ls *.txt lists all .txt files).

?: Matches any single character. (e.g., ls file?.txt matches file1.txt, fileA.txt, etc.).

Relative Paths: Paths that start from your current working directory. (e.g., Documents/reports/report.pdf)

Absolute Paths: Paths that start from the root directory (/) of the filesystem. They always start with /. (e.g., /home/your_username/Documents/reports/report.pdf)

Lab: Create directories, manage files.
Day 3: Permissions and Essential Commands
Permissions: rwx, chmod, chown (RHCSA 4.14)
rwx (Read, Write, Execute):

r: Read permission (view contents of a file, list contents of a directory).

w: Write permission (modify contents of a file, create/delete files in a directory).

x: Execute permission (run a file as a program, enter a directory).

Users/Groups: Permissions are assigned to three categories:

User (u): The owner of the file/directory.

Group (g): The group that owns the file/directory.

Others (o): Everyone else.

chmod (Change Mode): Changes file/directory permissions.

Symbolic Mode: chmod u+x file.sh, chmod go-rw file.txt

Octal Mode: chmod 755 script.sh (owner rwx, group rx, others rx)

chown (Change Owner): Changes the owner and/or group of a file/directory.

chown user file.txt

chown user:group file.txt

Viewing Files: cat, less, more, head, tail
cat (Catenate): Displays the entire content of a file to the screen.



cat filename.txt
less: A pager that allows you to view file content page by page, scroll forward/backward, and search. Excellent for large files.



less large_log_file.log
# Inside less: Space to scroll down, 'b' to scroll up, '/' to search, 'q' to quit.
more: Similar to less but with fewer features, primarily allows forward scrolling.



more another_log.log
head: Displays the first few lines (default 10) of a file.



head filename.txt
head -n 5 filename.txt # Show first 5 lines
tail: Displays the last few lines (default 10) of a file. Essential for monitoring logs.



tail access.log
tail -n 20 access.log # Show last 20 lines
tail -f access.log # Follows the file in real-time as new lines are added
I/O: stdin, stdout, stderr, Pipes, Redirection (RHCSA 4.7)
stdin (Standard Input): Default input stream (usually keyboard).

stdout (Standard Output): Default output stream (usually terminal screen).

stderr (Standard Error): Default error output stream (usually terminal screen).

Redirection (>, >>, <):

>: Redirects stdout to a file, overwriting the file if it exists.



ls -l > file_list.txt # Saves ls output to file_list.txt
>>: Redirects stdout to a file, appending to it if it exists.



echo "New line" >> file_list.txt
<: Redirects stdin from a file.



grep "error" < log.txt # Greps 'error' from log.txt
2>: Redirects stderr to a file.



command_that_might_fail 2> error.log # Only errors go to error.log
&> or >&: Redirects both stdout and stderr to a file.



command &> output_and_error.log
Pipes (|): Connects the stdout of one command to the stdin of another command.



ls -l | less # Pipe ls output to less for paging
cat access.log | grep "ERROR" | wc -l # Count lines with "ERROR"
Monitoring: top, htop, vmstat, journalctl
1. top: The Classic Process Monitor
top (table of processes) is a traditional, powerful, and real-time command-line utility that provides a dynamic view of running processes. It displays information about CPU and memory usage, process ID (PID), user, and much more.

1.1 Basic Usage and Output Explained
Just type top in your terminal and press Enter.

top - 09:30:01 up 2 days, 16:30,  1 user,  load average: 0.00, 0.01, 0.05
Tasks: 200 total,    1 running, 199 sleeping,    0 stopped,    0 zombie
%Cpu(s):  0.1 us,  0.1 sy,  0.0 ni, 99.8 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :    7987.9 total,    7000.0 free,     500.0 used,     487.9 buff/cache
MiB Swap:    4096.0 total,    4096.0 free,       0.0 used.    7200.0 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
      1 root      20   0  169420   9980   6720 S   0.0   0.1   0:15.23 systemd
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.04 kthreadd
    ... (more processes)
Understanding the Output Sections:

Header (First 5 lines): System summary (time, uptime, users, load average), task summary (total, running, sleeping, etc.), CPU usage percentages (us, sy, id, wa etc.), Physical Memory (total, free, used, buff/cache), and Swap Usage.

Process List (Table): Details for each process (PID, USER, PR (priority), NI (nice value), VIRT (virtual memory), RES (resident memory), SHR (shared memory), S (status), %CPU, %MEM, TIME+, COMMAND).

1.2 Interactive Commands within top
While top is running, you can press several keys to interact with it:

q: Quit top.

k: Kill a process (prompts for PID, then signal, e.g., 9 for KILL).

r: Renice a process (change its nice value/priority).

d or s: Change the update delay (in seconds).

1: Toggle display of individual CPU cores.

P: Sort by %CPU (default).

M: Sort by %MEM.

T: Sort by TIME+.

u: Filter by user (prompts for username).

h or ?: Display help screen.

1.3 Running top with Options
You can also start top with command-line options:

top -d 2: Update every 2 seconds.

top -u username: Show processes for a specific user.

top -p PID: Monitor a specific process by PID.

top -n 1: Run once and exit (useful in scripts).

2. htop: The Enhanced Interactive Process Viewer
htop is an interactive, real-time process viewer that is an enhancement over top. It offers a more user-friendly interface, easier navigation, and more features. It's not usually installed by default on RHEL, but it's highly recommended.

2.1 Installation


sudo dnf install htop -y
2.2 Basic Usage and Output Explained
Just type htop in your terminal and press Enter.

  CPU[|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||50.0%]
  Mem[|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||600M/7.94G]
  Swp[|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||0K/4.00G]
  Tasks: 60, 0 thr; 1 running
  Load average: 0.00 0.01 0.05
  Uptime: 2 days, 16:30:01

    PID USER      PRI NI VIRT  RES  SHR S CPU% MEM%  TIME+ Command
  1 root       20  0 169M 9.9M 6.7M S  0.0  0.1 0:15.23 /sbin/init
  ...
Key Improvements over top:

Visual CPU/Memory Meters: Clear, colored bar graphs at the top.

Scrollable Process List: Use arrow keys to scroll.

Tree View: Press F5 to toggle a tree view, showing parent-child relationships.

Function Keys (F1-F10): Common actions mapped to function keys at the bottom.

Mouse Support: Click on columns to sort, or on processes to select them.

2.3 Interactive Commands within htop
F1 or h: Help screen.

F2: Setup (customize display).

F3: Search for a process.

F4: Filter processes by text.

F5: Tree view / flat view toggle.

F6: Sort by a different column.

F7: Nice - (increase priority).

F8: Nice + (decrease priority).

F9: Kill process (select process, then choose signal).

F10 or q: Quit htop.

Spacebar: Tag (select) multiple processes.

u: Filter by user.

3. vmstat: Virtual Memory Statistics
vmstat (virtual memory statistics) is a versatile command-line utility used to report information about processes, memory, paging, block I/O, traps, and CPU activity. It's particularly useful for diagnosing memory bottlenecks and overall system activity.

3.1 Basic Usage and Output Explained
vmstat without any options gives a single snapshot of average statistics since boot.



vmstat
Output:

procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 1  0      0 7000000 4879000 5000000    0    0     0     0  100  200  0  0 99  0  0
Understanding the Columns:

procs (Processes): r (runnable/running), b (uninterruptible sleep/I/O wait).

memory: swpd (swap used), free, buff (buffers), cache (page cache).

swap: si (swap in), so (swap out). High values here indicate memory shortage.

io (Input/Output): bi (blocks in/read), bo (blocks out/write).

system: in (interrupts), cs (context switches).

cpu: us (user), sy (system), id (idle), wa (I/O wait), st (steal time).

3.2 Running vmstat with Options
vmstat is most useful when run in a continuous monitoring mode.

vmstat 1: Update every 1 second (continuous).

vmstat 1 5: Update every 1 second, but only 5 times.

vmstat -s: Display a table of event counters and memory statistics.

vmstat -d: Display disk statistics.

Example: Continuous monitoring of CPU and Memory every 2 seconds:



vmstat 2
Look for:

High r (processes waiting for CPU)

High b (processes waiting for I/O)

Significant si and so (swapping)

High wa in CPU (I/O wait)

4. journalctl: Systemd Journal Logs
journalctl is the command-line utility used to query and display messages from the systemd journal. The journal is a centralized logging system introduced with systemd in modern Linux distributions like RHEL, replacing fragmented log files.

4.1 Basic Usage and Output Explained
Just type journalctl in your terminal.



journalctl
This displays all log messages from the oldest to the newest. It uses a pager (like less), so you can scroll, search, and navigate.

4.2 Important journalctl Options
journalctl -b: Show logs from the current boot. (Most frequently used).

journalctl -b -1: Show logs from the previous boot.

journalctl -f: Follow the journal in real-time (like tail -f). Excellent for live debugging.

journalctl -u <unit_name>: Show logs for a specific systemd unit (service).

Example: journalctl -u httpd.service (for Apache web server)

Example: journalctl -u sshd.service (for SSH daemon)

journalctl --since "YYYY-MM-DD HH:MM:SS": Show logs since a specific date/time.

journalctl --since "today": Show today's logs.

journalctl --since "1 hour ago": Show logs from the last hour.

journalctl -p <priority>: Filter by message priority (e.g., err, warning, info).

Example: journalctl -p err -b (Show errors from current boot).

journalctl -k: Show only kernel messages.

journalctl -x: Add explanations to some log messages.

journalctl --disk-usage: Show how much disk space the journal logs are consuming.

4.3 Combining Options and Filtering
You can combine journalctl options for powerful filtering.

Monitor Apache errors in real-time:



journalctl -u httpd.service -p err -f
See all warnings and errors from the previous boot:



journalctl -b -1 -p warning..err
(Note: warning..err means priority warning and higher, i.e., warning, err, crit, alert, emerg)

4.4 Journal Persistence
By default, the systemd journal might be volatile and lost on reboot. To make it persistent (store logs across reboots in /var/log/journal/), create the directory:



sudo mkdir -p /var/log/journal
sudo systemctl restart systemd-journald
The journal will then automatically start saving logs to this persistent location.