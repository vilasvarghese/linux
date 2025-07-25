

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


## Day 2: Linux Basic File Management Commands Tutorial


# Linux Basic File Management Commands Tutorial

This tutorial covers essential Linux commands for navigating the filesystem and managing files and directories.

## 1. `pwd` (Print Working Directory) - Where Am I? 📍

The `pwd` command tells you your **current location** in the file system hierarchy.

* **Purpose:** To display the absolute path of your current working directory.
* **Syntax:** `pwd`

**Example:**

```
pwd
# Output Example: /home/your_username/Documents
2. ls (List) - Seeing What's There 📄
The ls command is used to list the contents of a directory. It's like opening a folder to see its files and subfolders.

Purpose: To display files and directories.

Syntax: ls [OPTIONS] [FILE...]

Basic Examples:

List contents of the current directory:



ls
Example Output:

Documents  Downloads  Music  Public  Templates  Videos
List contents of a specific directory:



ls /home/your_username/Documents
# Or, if you are already in your home directory:
ls Documents
Example Output:

report.txt  presentation.pptx  notes/  project_plan.docx
Common Options & Advanced Examples:

-l (long format): Displays a detailed list including file permissions, number of hard links, owner, group, size, and last modification date.



ls -l
Example Output:

total 20
drwxr-xr-x 2 user user 4096 Jul 23 10:00 notes/
-rw-r--r-- 1 user user 1500 Jul 22 14:30 presentation.pptx
-rw-r--r-- 1 user user  250 Jul 24 11:15 report.txt
-rw-r--r-- 1 user user 3000 Jul 20 09:00 project_plan.docx
-a (all): Shows all files, including hidden files (those starting with a .).



ls -a
Example Output:

.   ..  .rc  Documents  Downloads  .hidden_file.txt  Music
-h (human-readable): Use with -l to show file sizes in a more readable format (e.g., K for kilobytes, M for megabytes, G for gigabytes).



ls -lh
Example Output:

total 20K
drwxr-xr-x 2 user user 4.0K Jul 23 10:00 notes/
-rw-r--r-- 1 user user 1.5K Jul 22 14:30 presentation.pptx
-rw-r--r-- 1 user user  250 Jul 24 11:15 report.txt
-rw-r--r-- 1 user user 3.0K Jul 20 09:00 project_plan.docx
-R (recursive): Lists contents of subdirectories recursively.



ls -R
Example Output:

.:
notes  presentation.pptx  report.txt  project_plan.docx

./notes:
meeting_minutes.txt  todo.txt
Combining options: You can combine multiple options.



ls -lah # Long format, all files, human-readable sizes
3. cd (Change Directory) - Moving Around 🚶‍♂️
The cd command is used to change your current working directory.

Purpose: To navigate between directories.

Syntax: cd [DIRECTORY]

Examples:

Change to your home directory:



cd
# Or explicitly:
cd ~
This is very useful for quickly returning to your starting point.

Change to a subdirectory (relative path):



cd Documents
Change to a parent directory:



cd ..
If you are in /home/user/Documents, cd .. will take you to /home/user.

Change to the root directory:



cd /
Change to the previous directory you were in:



cd -
If you were in /var/log and then went to /home/user, cd - will take you back to /var/log.

Change to an absolute path:



cd /var/log
4. file - What Kind of File Is It? ❓
The file command helps you determine the type of a file. It inspects the file's content, not just its extension.

Purpose: To identify the type of a file.

Syntax: file [OPTIONS] FILE...

Examples:

Check the type of a text file:



file my_document.txt
# Output Example: my_document.txt: ASCII text
Check the type of a directory:



file my_folder
# Output Example: my_folder: directory
Check the type of an executable program:



file /bin/ls
# Output Example: /bin/ls: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 3.2.0, BuildID[sha1]=..., stripped
5. mkdir (Make Directory) - Creating Folders 📁
The mkdir command is used to create new directories (folders).

Purpose: To create one or more new directories.

Syntax: mkdir [OPTIONS] DIRECTORY...

Examples:

Create a single directory:



mkdir new_project
Create multiple directories at once:



mkdir dir1 dir2 dir3
Create a directory with parent directories (if they don't exist):
The -p (parents) option is very useful for creating nested directory structures in one go.



mkdir -p my_app/src/main/java
This will create my_app, then my_app/src, then my_app/src/main, and finally my_app/src/main/java.

6. touch - Creating Empty Files or Updating Timestamps 📝
The touch command is primarily used to create empty new files or to update the access and modification times of existing files.

Purpose: To create empty files or change file timestamps.

Syntax: touch [OPTIONS] FILE...

Examples:

Create an empty new file:



touch my_new_file.txt
If my_new_file.txt doesn't exist, it will be created empty.

Update the timestamp of an existing file:



touch existing_document.txt
If existing_document.txt exists, its "last modified" and "last accessed" timestamps will be updated to the current time, without changing its content.

7. cp () - Duplicating Files and Directories 📋
The cp command is used to  files and directories.

Purpose: To make copies of files or directories.

Syntax: cp [OPTIONS] SOURCE DESTINATION

Examples:

 a file to the same directory with a new name (effectively renaming a ):



cp report.txt report_backup.txt
 a file to a different directory:



cp document.pdf /home/your_username/Documents/archives/
# Or to a relative path:
cp document.pdf ../backups/
 a directory (and its contents):
The -r (recursive) option is mandatory when ing directories, as cp by default only copies files.



cp -r my_folder new_folder_
Common Options:

-r (recursive): Required for ing directories.

-i (interactive): Prompts you before overwriting an existing file. Highly recommended for safety.



cp -i file1.txt file1_.txt
-v (verbose): Shows what's being copied.



cp -v file1.txt /tmp/
# Output: 'file1.txt' -> '/tmp/file1.txt'
8. mv (Move / Rename) - Moving or Renaming Files and Directories ➡️
The mv command is used to move files or directories from one location to another, or to rename them.

Purpose: To move or rename files and directories.

Syntax: mv [OPTIONS] SOURCE DESTINATION

Examples:

Rename a file (same directory, new name):



mv old_name.txt new_name.txt
Move a file to a different directory:



mv document.odt /home/your_username/Downloads/
# Or to a relative path:
mv my_image.jpg ../archive/images/
Move a directory:



mv project_old project_archive/
This moves the entire project_old directory and its contents into the project_archive directory.

Common Options:

-i (interactive): Prompts before overwriting an existing file. Recommended.

-v (verbose): Shows what's being moved/renamed.

9. rm (Remove) - Deleting Files and Directories 🗑️
The rm command is used to remove (delete) files or directories. Use rm with extreme caution, as deleted files are generally not recoverable, especially on Linux where there's no "Recycle Bin" equivalent for command-line deletions.

Purpose: To delete files or directories.

Syntax: rm [OPTIONS] FILE...

Examples:

Remove a single file:



rm unwanted_file.txt
Remove multiple files:



rm file1.txt file2.txt temp_data.csv
Remove a directory and its contents (recursive):
*The -r (recursive) option is mandatory for deleting non-empty directories. Be very, very careful with this!



rm -r old_project_files/
Common Options (Use with Caution!):

-i (interactive): Prompts before every deletion. Highly recommended to prevent accidental deletion.



rm -i my_file_to_delete.txt
# Output: rm: remove regular file 'my_file_to_delete.txt'? (y/n)
-f (force): Forces deletion, ignoring non-existent files and never prompting. Extremely dangerous! Only use if you are absolutely sure. Often combined with -r as rm -rf.



rm -rf /path/to/directory_to_delete # AVOID THIS UNLESS YOU ARE 100% CERTAIN
10. find - Locating Files and Directories 🔍
The find command is a powerful tool for searching for files and directories based on various criteria (name, type, size, modification time, permissions, etc.).

Purpose: To search for files and directories in a directory hierarchy.

Syntax: find [PATH...] [EXPRESSION]

PATH: The starting directory for the search (e.g., . for current, / for root).

EXPRESSION: Consists of options, tests, actions, and operators.

Examples:

Find a file by name (case-sensitive) in the current directory and its subdirectories:



find . -name "report.txt"
Find a file by name (case-insensitive):



find . -iname "Report.txt"
Find all .log files in /var/log:



find /var/log -name "*.log"
Find directories only:



find . -type d -name "my_project*"
Find files only:



find . -type f -name "config.*"
Find files larger than 1 Megabyte:



find . -type f -size +1M
Size units: b (512-byte blocks), c (bytes), k (kilobytes), M (megabytes), G (gigabytes).

Find files modified in the last 7 days:



find . -type f -mtime -7
+7 for older than 7 days, 7 for exactly 7 days old.

Find files by owner:



find . -user john -name "*.log"
Find and execute a command on found files (e.g., delete backup files):

The -exec option runs a command for each found item.

{} is a placeholder for the found filename.

\; marks the end of the -exec command.



find . -name "*.bak" -exec rm {} \;
Use -exec rm {} \; with extreme caution! Always test find without -exec first to ensure it's selecting the correct files.

Find files and pipe them to another command (using xargs for efficiency):



find . -name "*.tmp" -print0 | xargs -0 rm
-print0 and xargs -0 handle filenames with spaces or special characters correctly.


---

### Tutorial 2: Wildcards (`*`, `?`), Relative vs. Absolute Paths

Here's a detailed tutorial on wildcards and paths.

```markdown
# Linux Wildcards and Paths Tutorial

This tutorial explains the use of wildcards for pattern matching and the fundamental concepts of relative and absolute paths in the Linux filesystem.

## 1. Wildcards (Globbing) - Pattern Matching for Files

Wildcards are special characters that allow you to specify patterns to match multiple filenames with a single expression. This is incredibly useful for selecting groups of files for commands like `ls`, `cp`, `mv`, `rm`, etc.

### a. The `*` Wildcard (Asterisk) - Matches Any Sequence of Characters

* **Meaning:** Matches any sequence of zero or more characters.
* **Use Case:** Ideal for matching parts of filenames.

**Examples:**

1.  **Match all files ending with `.txt`:**
    ```
    ls *.txt
    ```
    *If you have `document.txt`, `notes.txt`, `report.pdf`, `image.png`*
    *Output:*
    ```
    document.txt  notes.txt
    ```

2.  **Match all files starting with `report`:**
    ```
    ls report*
    ```
    *If you have `report.txt`, `report_final.pdf`, `archive_report.zip`*
    *Output:*
    ```
    report.txt  report_final.pdf
    ```

3.  **Match all files containing `data`:**
    ```
    ls *data*
    ```
    *If you have `raw_data.csv`, `processed_data.json`, `my_document.txt`*
    *Output:*
    ```
    processed_data.json  raw_data.csv
    ```

4.  **Match all files (effectively `ls -a` if no other options are used):**
    ```
    ls *
    ```
    *This will list all non-hidden files and directories.*

### b. The `?` Wildcard (Question Mark) - Matches Any Single Character

* **Meaning:** Matches any single character.
* **Use Case:** Useful when you know the number of characters but not their exact value.

**Examples:**

1.  **Match `file1.txt`, `file2.txt`, but not `file10.txt`:**
    ```
    ls file?.txt
    ```
    *If you have `file1.txt`, `fileA.txt`, `file_new.txt`, `file10.txt`*
    *Output:*
    ```
    file1.txt  fileA.txt
    ```

2.  **Match files like `doc-A.txt`, `doc-B.txt`:**
    ```
    ls doc-?.txt
    ```

3.  **Match files with exactly 3 characters before the extension:**
    ```
    ls ???.log
    ```
    *Matches `abc.log`, `123.log`, but not `abcd.log` or `ab.log`.*

### c. Character Sets `[ ]` - Matches Any Character Within the Brackets

* **Meaning:** Matches any single character that is part of the specified set.
* **Use Case:** When you need to match specific characters at a position.

**Examples:**

1.  **Match files ending in `.txt` or `.log`:**
    ```
    ls *.[tl]xt
    ```
    *This is a bit simplified; better to use `ls *.txt *.log` for OR conditions across extensions.*

2.  **Match `file1.txt` or `file2.txt` (but not `file3.txt`):**
    ```
    ls file[12].txt
    ```

3.  **Match filenames with a digit (0-9):**
    ```
    ls *[0-9]*
    ```

## 2. Paths: Relative vs. Absolute

Understanding how to refer to files and directories using paths is fundamental to navigating and managing your Linux system.

### a. Absolute Paths (Full Paths)

* **Definition:** An absolute path is the **complete path from the root directory (`/`)** to the file or directory you are referencing.
* **Characteristics:**
    * Always start with a forward slash (`/`).
    * Uniquely identifies the location of a file or directory regardless of your current working directory.
* **Analogy:** Like giving someone full directions from a well-known landmark (e.g., "From the Empire State Building, go north 5 blocks...").

**Examples:**

* `/home/your_username/Documents/report.txt`
    * Starts from the root (`/`), goes into `home`, then `your_username`, then `Documents`, then `report.txt`.
* `/etc/passwd`
* `/var/log/syslog`
* `/usr/bin/ls`

**When to use Absolute Paths:**

* When you need to refer to a file or directory from *any* location in the filesystem.
* In scripts, configuration files, or cron jobs where the current working directory is unpredictable.
* When you want to be explicit and avoid ambiguity.

### b. Relative Paths

* **Definition:** A relative path specifies the location of a file or directory **in relation to your current working directory**.
* **Characteristics:**
    * Does *not* start with a forward slash (`/`).
    * Depends on where you currently are in the filesystem.
* **Analogy:** Like giving directions from your current location ("Go left, then straight two blocks").

**Key Relative Path Notations:**

* `.` (single dot): Represents the **current directory**.
* `..` (double dot): Represents the **parent directory** (one level up).

**Examples:**

Let's assume your current working directory is `/home/your_username/Documents/`:

1.  **Referring to a file in the current directory:**
    ```
    ls report.txt      # Lists report.txt within /home/your_username/Documents/
    ls ./report.txt    # Same as above, explicitly using '.'
    ```

2.  **Referring to a directory in the current directory:**
    ```
    cd notes/          # Changes to /home/your_username/Documents/notes/
    ```

3.  **Referring to a file in a subdirectory:**
    ```
    cat notes/meeting_minutes.txt # Displays content of file in the 'notes' subdirectory
    ```

4.  **Referring to a file in the parent directory:**
    ```
    ls ../Downloads/my_download.zip # Lists a file in /home/your_username/Downloads/
    ```

5.  **Referring to a file two directories up:**
    ```
    cp ../../another_file.txt . # Copies another_file.txt from /home/your_username/ to current directory
    ```

**When to use Relative Paths:**

* When navigating within a specific project structure.
* When the exact absolute path might change (e.g., if you move a project folder).
* For shorter, more convenient typing in the command line.

**Comparison:**

| Feature            | Absolute Path                       | Relative Path                                |
| :----------------- | :---------------------------------- | :------------------------------------------- |
| **Starting Point** | Always from the root (`/`)          | From the current working directory           |
| **Ambiguity** | No ambiguity, always the same path  | Can be ambiguous if current directory changes |
| **Typing Effort** | Generally longer                    | Generally shorter                            |
| **Use Case** | Scripts, configuration, cross-system | Interactive shell, within project structures |

**Practice:**
Navigate to `/var/log`. Now, try to `ls` the contents of `/home/your_username/Documents` using both an absolute path and a relative path. (Hint for relative: you'll need `../` multiple times to get up to the root or `home` from `/var/log`).

```
# From /var/log:
ls /home/your_username/Documents # Absolute path
ls ../../home/your_username/Documents # Relative path (assuming typical Linux structure)

---

### Tutorial 3: Lab - Create Directories, Manage Files

This tutorial walks you through practical exercises using the commands learned above.

```markdown
# Lab: Create Directories, Manage Files

This hands-on lab will guide you through practical scenarios using the Linux commands for filesystem navigation and file management.

**Objective:** Practice using `pwd`, `ls`, `cd`, `mkdir`, `touch`, `cp`, `mv`, `rm`, `file`, and `find` with relative and absolute paths and wildcards.

---

### Setup (Run these commands first)

Open your terminal (Git , WSL, or Linux terminal). We'll create a dedicated workspace for this lab.

```
# 1. Go to your home directory
cd ~

# 2. Create a new directory for this lab
mkdir -p linux_lab/projects/reports

# 3. Navigate into the main lab directory
cd linux_lab

# 4. Create some initial files
touch README.md
touch notes.txt
touch expenses.csv
echo "My important data" > data.txt
echo "A quick memo" > memo.log
touch report_2024.txt
touch report_2025.txt
touch final_draft.txt

# 5. Create some files in the 'projects' subdirectory
touch projects/project_alpha.md
touch projects/project_beta.js

# 6. Create a hidden file
touch .hidden_config
Exercises
Perform each task, observing the output of each command.

Task 1: Navigation and Listing
Check your current location.



pwd
(Expected: /home/your_username/linux_lab or similar)

List all files and directories in the current folder.



ls
(Observe: data.txt, expenses.csv, final_draft.txt, etc., and the projects directory.)

List all files, including hidden ones.



ls -a
(Observe: ., .., .hidden_config in addition to others.)

List files in long format, showing details and human-readable sizes.



ls -lh
(Observe: Permissions, owner, group, size like 4.0K, 10M, etc.)

Navigate into the projects directory.



cd projects
List the contents of the reports subdirectory using a relative path from your current location.



ls reports
(Expected: Empty output initially, as no files are there yet.)

Navigate back to the linux_lab directory using a relative path.



cd ..
List the contents of the /home/your_username/linux_lab/projects directory using its absolute path.



ls /home/your_username/linux_lab/projects
(Replace /home/your_username with your actual home directory path.)

Task 2: Creating and Identifying Files/Directories
Create a new directory named backups in your linux_lab folder.



mkdir backups
Verify creation:



ls
Create a nested directory structure temp/data/raw inside linux_lab in one go.



mkdir -p temp/data/raw
Verify creation (recursive listing):



ls -R temp
Create an empty file named todo.txt in the current directory.



touch todo.txt
Verify creation:



ls todo.txt
Create an empty file named log_archive.txt inside the temp/data/raw directory.



touch temp/data/raw/log_archive.txt
Determine the file type of data.txt.



file data.txt
(Expected: data.txt: ASCII text)

Determine the file type of the projects directory.



file projects
(Expected: projects: directory)

Task 3: ing and Moving Files/Directories
 README.md to README.backup in the same directory.



cp README.md README.backup
Verify:



ls
 expenses.csv into the backups directory.



cp expenses.csv backups/
Verify:



ls backups/
 both report_2024.txt and report_2025.txt into the projects/reports directory.



cp report_2024.txt report_2025.txt projects/reports/
Verify:



ls projects/reports/
Move notes.txt into the projects directory.



mv notes.txt projects/
Verify (check both locations):



ls # Should no longer see notes.txt here
ls projects/ # Should see notes.txt here
Rename final_draft.txt to final_report.txt in the current directory.



mv final_draft.txt final_report.txt
Verify:



ls
 the entire temp directory (and its contents) to temp_.



cp -r temp temp_
Verify:



ls -R temp_
Move the entire temp_ directory into the backups directory.



mv temp_ backups/
Verify:



ls backups/
Task 4: Using Wildcards and find
List all files in the current directory that end with .txt.



ls *.txt
List all files that start with report and have exactly one character after it, followed by .txt. (e.g., report1.txt, reportA.txt)



ls report?.txt
(If you only created report_2024.txt etc., you might not see any output for this exact pattern unless you create files that match.)

Find all .md files within the linux_lab directory and its subdirectories.



find . -name "*.md"
(Expected: README.md, projects/project_alpha.md)

Find all directories named data within linux_lab.



find . -type d -name "data"
(Expected: ./temp/data)

Find all files in linux_lab that are larger than 100 bytes. (We made data.txt with "My important data" - it should be small, but let's test a larger limit.)



find . -type f -size +1c # Find files larger than 1 byte
# Or for a more realistic size:
# find . -type f -size +1k # Larger than 1 kilobyte
Task 5: Deleting Files and Directories (Carefully!)
Remove the empty todo.txt file.



rm todo.txt
Verify:



ls todo.txt 2>/dev/null # This should give an error indicating file not found
Remove the temp/data/raw directory (which contains log_archive.txt).
You'll need the recursive option for a non-empty directory.



rm -r temp/data/raw
Verify:



ls -R temp # Should no longer see 'raw'
Remove the empty temp/data directory.



rmdir temp/data # rmdir only works on empty directories
Verify:



ls -R temp # Should no longer see 'data'
Remove the remaining empty temp directory.



rmdir temp
Verify:



ls
Remove the .hidden_config file.



rm .hidden_config
Cleanup
To remove the entire linux_lab directory created for this lab:



cd ~
rm -r linux_lab
Be careful with rm -r! Double-check your path.

```


# Day 3: Permissions and Essential Commands

---

## Permissions: `rwx`, `chmod`, `chown` (RHCSA 4.14)

### File Permission Basics (`rwx`)

Linux file permissions are displayed as:
-rwxr-xr--





| Symbol | Meaning       |
|--------|----------------|
| `r`    | Read           |
| `w`    | Write          |
| `x`    | Execute        |
| `-`    | No permission  |

### Permission Sections:

| Section     | Who it applies to |
|-------------|-------------------|
| First char  | File type (`-`=file, `d`=directory) |
| 1–3         | Owner permissions |
| 4–6         | Group permissions |
| 7–9         | Others' permissions |

---

### `chmod` – Change permissions

```
chmod [permissions] filename
Symbolic mode:



chmod u+x script.sh   # Add execute to user
chmod g-w file.txt    # Remove write from group
chmod o=r file.txt    # Set read-only for others
Numeric mode:
Value	Meaning
1	execute
2	write
4	read

Combine values:




chmod 755 script.sh
# u=rwx (7), g=rx (5), o=rx (5)
chown – Change owner



chown user:group filename
Examples:




chown alice file.txt        # Change owner to 'alice'
chown alice:staff file.txt  # Change owner and group
📄 Viewing Files: cat, less, more, head, tail
cat – Concatenate and view



cat file.txt
Combine files: cat file1 file2 > combined.txt

less – Scrollable viewer (best for large files)



less file.txt
Scroll with arrows, / to search, q to quit

more – View page by page



more file.txt
Press SPACE for next page, q to quit

head – Show first lines



head file.txt          # First 10 lines
head -n 5 file.txt     # First 5 lines
tail – Show last lines



tail file.txt          # Last 10 lines
tail -n 20 file.txt    # Last 20 lines
tail -f log.txt        # Follow file updates (live logs)
 I/O: stdin, stdout, stderr, Pipes, Redirection (RHCSA 4.7)
Streams:
stdin (0) – Input

stdout (1) – Output

stderr (2) – Error

Redirection:
Operator	Meaning
>	Redirect stdout (overwrite)
>>	Redirect stdout (append)
2>	Redirect stderr
&>	Redirect both stdout + stderr

Examples:




ls > out.txt           # Save output
ls nonexistent 2> err.txt  # Save errors
command &> all.log     # Save both
Pipes (|) – Pass output of one command as input to another



ps aux | grep apache
Chaining:




cat file.txt | grep "error" | sort | uniq
Monitoring: top, htop, vmstat, journalctl
top – Task Manager



top
Press q to quit

Press P to sort by CPU, M for memory

htop – Enhanced top (install via sudo apt install htop)



htop
Colored display, mouse support

Use F-keys for filtering, killing processes

vmstat – Virtual memory stats



vmstat 1
procs – Processes

memory – RAM/swap

cpu – Usage stats

journalctl – View logs (systemd)



journalctl                 # View all logs
journalctl -b             # Logs since last boot
journalctl -u nginx       # Logs for a unit
journalctl -f             # Live log (like `tail -f`)
```








Markdown

## 1. top: The Classic Process Monitor 

`top` (table of processes) is a traditional, powerful, and real-time command-line utility that provides a dynamic view of running processes. It displays information about CPU and memory usage, process ID (PID), user, and much more.

### 1.1 Basic Usage and Output Explained
Just type `top` in your terminal and press Enter.

top - 09:30:01 up 2 days, 16:30,  1 user,  load average: 0.00, 0.01, 0.05
Tasks: 200 total,    1 running, 199 sleeping,    0 stopped,    0 zombie
%Cpu(s):  0.1 us,  0.1 sy,  0.0 ni, 99.8 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :   7987.9 total,   7000.0 free,    500.0 used,    487.9 buff/cache
MiB Swap:   4096.0 total,   4096.0 free,      0.0 used.   7200.0 avail Mem

PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM    TIME+ COMMAND
  1 root      20   0  169420   9980   6720 S   0.0   0.1   0:15.23 systemd
  2 root      20   0       0      0      0 S   0.0   0.0   0:00.04 kthreadd
... (more processes)

Understanding the Output Sections:

Header (First 5 lines):

* **Line 1 (System Summary):**
    * `top - HH:MM:SS`: Current system time.
    * `up X days, Y hours/minutes`: System uptime.
    * `Z users`: Number of users currently logged in.
    * `load average: L1, L5, L15`: Average number of processes waiting to run over the last 1, 5, and 15 minutes. High numbers indicate a busy system.

* **Line 2 (Tasks/Processes):**
    * `total`: Total number of processes.
    * `running`: Number of processes currently executing.
    * `sleeping`: Processes waiting for an event (e.g., I/O).
    * `stopped`: Processes that have been stopped (e.g., by Ctrl+Z).
    * `zombie`: Zombie processes (terminated but parent hasn't reaped them; indicates a problem).

* **Line 3 (CPU Usage):** Percentages of CPU time spent in various states.
    * `us`: User CPU time (processes running in user space).
    * `sy`: System CPU time (kernel operations).
    * `ni`: Nice CPU time (user processes with modified priority).
    * `id`: Idle CPU time.
    * `wa`: I/O Wait time (CPU waiting for disk or network I/O).
    * `hi`: Hardware Interrupts.
    * `si`: Software Interrupts.
    * `st`: Steal time (relevant in virtualized environments where CPU is "stolen" by the hypervisor).

* **Line 4 (Memory Usage - Physical RAM):**
    * `total`: Total physical memory.
    * `free`: Unused memory.
    * `used`: Memory actively used by processes.
    * `buff/cache`: Memory used by kernel buffers and page cache (can be freed if needed).

* **Line 5 (Swap Usage):**
    * `total`: Total swap space.
    * `free`: Unused swap space.
    * `used`: Used swap space.
    * `avail Mem`: Estimated available memory for new applications (free + reclaimable buff/cache).

**Process List (Table):**

* `PID`: Process ID.
* `USER`: User who owns the process.
* `PR`: Priority (kernel-assigned).
* `NI`: Nice value (user-assigned priority; lower is higher priority).
* `VIRT`: Virtual memory used by the process (including swap and shared libraries).
* `RES`: Resident Set Size (physical memory actually used by the process, not swapped out). This is a key metric for memory usage.
* `SHR`: Shared memory (memory shared with other processes).
* `S`: Process Status (S=sleeping, R=running, Z=zombie, T=stopped).
* `%CPU`: Percentage of CPU time used since the last update.
* `%MEM`: Percentage of total physical memory used.
* `TIME+`: Total CPU time used by the task since it started.
* `COMMAND`: The command name or command line of the process.

### 1.2 Interactive Commands within top
While `top` is running, you can press several keys to interact with it:

* `q`: Quit `top`.
* `k`: Kill a process (prompts for PID, then signal, e.g., 9 for KILL).
* `r`: Renice a process (change its nice value/priority).
* `d` or `s`: Change the update delay (in seconds).
* `z`: Toggle color/bold mode.
* `b`: Toggle bold highlighting of running processes.
* `x`: Highlight sort column.
* `y`: Highlight running tasks.
* `1`: Toggle display of individual CPU cores.
* `m`: Toggle memory display modes (percent, absolute, etc.).
* `P`: Sort by %CPU (default).
* `M`: Sort by %MEM.
* `T`: Sort by TIME+.
* `u`: Filter by user (prompts for username).
* `h` or `?`: Display help screen.

### 1.3 Running top with Options
You can also start `top` with command-line options:

* `top -d 2`: Update every 2 seconds.
* `top -u username`: Show processes for a specific user.
* `top -p PID`: Monitor a specific process by PID.
* `top -n 1`: Run once and exit (useful in scripts).

**Example: Monitor the httpd process (assuming its PID is 12345):**

```
top -p 12345
2. htop: The Enhanced Interactive Process Viewer
htop is an interactive, real-time process viewer that is an enhancement over top. It offers a more user-friendly interface, easier navigation, and more features. It's not usually installed by default on RHEL, but it's highly recommended.

2.1 Installation


sudo dnf install htop -y
sudo apt install htop.
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

Visual CPU/Memory Meters: Clear, colored bar graphs for CPU, Memory, and Swap usage at the top.

Scrollable Process List: You can scroll up and down the process list using arrow keys.

Tree View: Press F5 to toggle a tree view, showing parent-child relationships between processes. This is incredibly useful for understanding process hierarchies.

Function Keys (F1-F10): Common actions are mapped to function keys at the bottom of the screen, making it much more intuitive.

Mouse Support: You can click on columns to sort, or on processes to select them.

2.3 Interactive Commands within htop
F1 or h: Help screen.

F2: Setup (customize what's displayed, meters, columns, colors).

F3: Search for a process.

F4: Filter processes by text.

F5: Tree view / flat view toggle.

F6: Sort by a different column.

F7: Nice - (increase priority, make it less nice).

F8: Nice + (decrease priority, make it nicer).

F9: Kill process (select process, then choose signal).

F10 or q: Quit htop.

Spacebar: Tag (select) multiple processes for batch operations.

u: Filter by user.

K: Toggle kernel threads.

H: Toggle user threads.

Example: Find all httpd processes, view them in a tree, and then kill one:

Type htop.

Press F3, type httpd, and press Enter.

Press F5 to see the hierarchy.

Navigate to the process you want to kill using arrow keys.

Press F9, select 9 SIGKILL, and press Enter.

3. vmstat: Virtual Memory Statistics
vmstat (virtual memory statistics) is a versatile command-line utility used to report information about processes, memory, paging, block I/O, traps, and CPU activity. It's particularly useful for diagnosing memory bottlenecks and overall system activity.

3.1 Basic Usage and Output Explained
vmstat without any options gives a single snapshot of average statistics since boot.



vmstat
Output:

procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b    swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 1  0       0 7000000 4879000 5000000    0    0     0     0  100  200  0  0 99  0  0
Understanding the Columns:

procs (Processes):

r: Number of processes waiting for CPU time (running or runnable). High r values indicate a CPU bottleneck.

b: Number of processes in uninterruptible sleep (waiting for I/O, often disk). High b values indicate an I/O bottleneck.

memory:

swpd: Amount of virtual memory used (swap space).

free: Amount of idle memory.

buff: Amount of memory used as buffers (for block devices).

cache: Amount of memory used as cache (for file system reads).

swap:

si: Amount of memory swapped in from disk (kb/s).

so: Amount of memory swapped out to disk (kb/s). High values here indicate heavy swapping, which points to a memory shortage.

io (Input/Output):

bi: Blocks received from a block device (e.g., disk reads) (blocks/s).

bo: Blocks sent to a block device (e.g., disk writes) (blocks/s).

system:

in: Number of interrupts per second.

cs: Number of context switches per second. High values can indicate high process activity.

cpu: (Similar to top's CPU line)

us: User time.

sy: System time.

id: Idle time.

wa: I/O Wait time.

st: Steal time.

3.2 Running vmstat with Options
vmstat is most useful when run in a continuous monitoring mode.

vmstat 1: Update every 1 second (continuous).

vmstat 1 5: Update every 1 second, but only 5 times.

vmstat -s: Display a table of event counters and memory statistics.

vmstat -a: Display active/inactive memory.

vmstat -d: Display disk statistics.

vmstat -p /dev/sda1: Display detailed partition statistics for /dev/sda1.

Example: Continuous monitoring of CPU and Memory every 2 seconds:



vmstat 2
Look for:

High r (processes waiting for CPU)

High b (processes waiting for I/O)

Significant si and so (swapping)

High wa in CPU (I/O wait)

These patterns can quickly point you to CPU, memory, or disk bottlenecks.

4. journalctl: Systemd Journal Logs
journalctl is the command-line utility used to query and display messages from the systemd journal. The journal is a centralized logging system introduced with systemd in modern Linux distributions like RHEL, replacing fragmented log files (like /var/log/messages, syslog, auth.log, etc.).

4.1 Basic Usage and Output Explained
Just type journalctl in your terminal.



journalctl
This will display all log messages from the oldest to the newest, which can be a very long output. It uses a pager (like less), so you can scroll, search, and navigate.

4.2 Important journalctl Options
journalctl -b: Show logs from the current boot. This is one of the most frequently used options.

journalctl -b -1: Show logs from the previous boot. (-b -2 for the boot before that, etc.).

journalctl -f: Follow the journal in real-time (like tail -f). This is excellent for live debugging.

journalctl -u <unit_name>: Show logs for a specific systemd unit (service).

Example: journalctl -u httpd.service (for Apache web server)

Example: journalctl -u sshd.service (for SSH daemon)

journalctl --since "YYYY-MM-DD HH:MM:SS": Show logs since a specific date/time.

journalctl --until "YYYY-MM-DD HH:MM:SS": Show logs up to a specific date/time.

journalctl --since "today" --until "now": Show today's logs.

journalctl --since "1 hour ago": Show logs from the last hour.

journalctl -p <priority>: Filter by message priority (e.g., emerg, alert, crit, err, warning, notice, info, debug).

Example: journalctl -p err -b (Show errors from current boot).

Example: journalctl -p warning -f (Follow warnings in real-time).

journalctl -k: Show only kernel messages.

journalctl -x: Add explanations to some log messages.

journalctl -n <num>: Show only the last num log entries. (Default is 10).

journalctl --disk-usage: Show how much disk space the journal logs are consuming.

4.3 Combining Options and Filtering
You can combine journalctl options for powerful filtering.

Examples:

Monitor Apache errors in real-time:



journalctl -u httpd.service -p err -f
See all warnings and errors from the previous boot:



journalctl -b -1 -p warning..err
(Note: warning..err means priority warning and higher, i.e., warning, err, crit, alert, emerg)

View kernel messages from the last 24 hours related to USB:



journalctl -k --since "24 hours ago" | grep -i usb
Check audit log denials (often redirected to journal):



journalctl -p err | grep "denied"
# Or specifically for SELinux (if auditd is sending to journal):
journalctl _COMM=auditd -g "AVC denied"
4.4 Journal Persistence
By default, the systemd journal might be volatile (stored in /run/log/journal/) and lost on reboot. To make it persistent (store logs across reboots in /var/log/journal/), you need to create the directory:



sudo mkdir -p /var/log/journal
sudo systemctl restart systemd-journald
The journal will then automatically start saving logs to this persistent location.
```

#Day 4