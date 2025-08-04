You are absolutely right to point that out! My apologies. When I say "include markdown code in output," what I mean is that the output itself is formatted using Markdown. So, when you view it in a Markdown renderer (like GitHub, a Markdown editor, or certain web platforms), it will appear correctly formatted with bold text, headings, code blocks, etc.

It seems there's a misunderstanding on how the output is being rendered by your browser or client. The previous responses do contain the Markdown syntax.

For example, when I wrote:

Markdown

# My Heading
This is **bold text**.
I meant that the output would literally contain # My Heading and This is **bold text**, which then a Markdown renderer would display as:

My Heading
This is bold text.

It's not that I'm missing the Markdown syntax, but rather that your viewing environment is rendering it.

To see the raw Markdown code, you typically need to view the source of the response, or copy the text and paste it into a plain text editor (like Notepad, VS Code, Sublime Text, or a simple text area) that doesn't interpret Markdown.

Let me re-present the dnf tutorial in a way that shows the raw Markdown syntax explicitly, by wrapping the entire content in a large Markdown code block. This way, you will see the #, **, ````bash`, etc., as literal characters.

Markdown

# DNF: The Next-Generation Package Manager for RHEL & Fedora

`dnf` (Dandified YUM) is the default package manager for Red Hat Enterprise Linux (RHEL) 8 and later, CentOS Stream 8 and later, and Fedora. It is the successor to `yum` and offers improved performance, dependency resolution, and a cleaner API. This tutorial will provide a comprehensive guide to using `dnf` for managing software packages on your system.

## Table of Contents

1.  [What is DNF?](#1-what-is-dnf)
2.  [Why DNF Instead of YUM?](#2-why-dnf-instead-of-yum)
3.  [Basic DNF Syntax](#3-basic-dnf-syntax)
4.  [Key DNF Commands](#4-key-dnf-commands)
    * 4.1 [Installation](#41-installation)
    * 4.2 [Removal](#42-removal)
    * 4.3 [Updating and Upgrading](#43-updating-and-upgrading)
    * 4.4 [Searching and Information](#44-searching-and-information)
    * 4.5 [Repository Management](#45-repository-management)
    * 4.6 [History and Rollback](#46-history-and-rollback)
    * 4.7 [Cleaning Cache](#47-cleaning-cache)
    * 4.8 [Module Management (RHEL/CentOS Stream 8+, Fedora)](#48-module-management-rhelcentos-stream-8-fedora)
5.  [Common DNF Options](#5-common-dnf-options)
6.  [DNF Configuration Files](#6-dnf-configuration-files)
    * 6.1 [`/etc/dnf/dnf.conf`](#61-etcdnfdnfconf)
    * 6.2 [`/etc/yum.repos.d/*.repo`](#62-etcumreposdrepo)
7.  [Best Practices and Tips](#7-best-practices-and-tips)
8.  [Conclusion](#8-conclusion)

---

## 1. What is DNF?

`dnf` is the next-generation RPM package manager that replaced `yum` in recent RHEL-based distributions. It's built on top of `libsolv` (for dependency resolution) and `hawkey` (for high-level package queries) and is written in Python.

## 2. Why DNF Instead of YUM?

`dnf` offers several improvements over `yum`:

* **Improved Performance:** Faster dependency resolution and metadata synchronization.
* **Better Dependency Resolution:** More robust and reliable handling of complex dependencies.
* **Rich API:** A well-defined API for extensions and plugins.
* **Modular Content (Modules/Streams):** Supports managing different versions of software (e.g., Python 3.8 vs. Python 3.9) more easily.
* **Clearer Output:** Often provides more user-friendly output and error messages.

While `yum` commands often still work as aliases to `dnf` for backward compatibility, it's highly recommended to use `dnf` directly on modern systems.

## 3. Basic DNF Syntax

All `dnf` commands typically require root privileges or `sudo`.

````bash
sudo dnf [options] <command> [package(s)]
Example:

Bash

sudo dnf install httpd
4.1 Key DNF Commands
Let's dive into the most frequently used dnf commands.

4.1 Installation
Install a single package:

Bash

sudo dnf install <package_name>
# Example: sudo dnf install nginx
Install multiple packages:

Bash

sudo dnf install <package1> <package2> ...
# Example: sudo dnf install mariadb-server php php-fpm
Install a package without GPG key check (use with extreme caution!):

Bash

sudo dnf install <package_name> --nogpgcheck
# WARNING: This bypasses package integrity verification. Only use if you absolutely trust the source.
Install a package group:
Package groups bundle related software (e.g., "Development Tools", "Server with GUI").

Bash

sudo dnf group install "<group name>"
# Example: sudo dnf group install "Development Tools"
To list available groups:

Bash

sudo dnf group list
4.2 Removal
Remove a package:

Bash

sudo dnf remove <package_name>
# Example: sudo dnf remove nginx
Remove unused dependencies:
autoremove removes packages that were installed as dependencies for other packages but are no longer needed by any installed package.

Bash

sudo dnf autoremove
Remove a package group:

Bash

sudo dnf group remove "<group name>"
# Example: sudo dnf group remove "Development Tools"
4.3 Updating and Upgrading
Check for available updates:

Bash

sudo dnf check-update
Update all installed packages to their latest versions:
This is often referred to as a "system upgrade" or "system update."

Bash

sudo dnf update
# or the alias: sudo dnf upgrade
Update a specific package:

Bash

sudo dnf update <package_name>
# Example: sudo dnf update firefox
Synchronize installed packages with available packages:
distro-sync (or dnf sync) is useful for resolving dependency issues or downgrading packages to match the repository versions. It tries to make the installed packages match the latest versions available in the repositories, even if it means downgrading.

Bash

sudo dnf distro-sync
4.4 Searching and Information
Search for packages by keyword:

Bash

sudo dnf search <keyword>
# Example: sudo dnf search "web server"
List packages:

List all available and installed packages:

Bash

sudo dnf list all
List only installed packages:

Bash

sudo dnf list installed
List only available (not installed) packages:

Bash

sudo dnf list available
List available updates:

Bash

sudo dnf list updates
List packages installed but not from any configured repository:

Bash

sudo dnf list extras
List packages that have been obsoleted by a newer package:

Bash

sudo dnf list obsoletes
Show detailed information about a package:

Bash

sudo dnf info <package_name>
# Example: sudo dnf info httpd
Find which package provides a specific file or command:

Bash

sudo dnf provides <file_path>
# Example: sudo dnf provides /usr/bin/htpasswd
# Example: sudo dnf provides '*php.ini'
4.5 Repository Management
List configured repositories:

List all enabled and disabled repositories:

Bash

sudo dnf repolist all
List only enabled repositories:

Bash

sudo dnf repolist
List only disabled repositories:

Bash

sudo dnf repolist disabled
Enable a disabled repository:

Bash

sudo dnf config-manager --set-enabled <repo_id>
# Example: sudo dnf config-manager --set-enabled epel
Disable an enabled repository:

Bash

sudo dnf config-manager --set-disabled <repo_id>
# Example: sudo dnf config-manager --set-disabled fedora-debuginfo
Add a new repository from a URL (often a .repo file URL):

Bash

sudo dnf config-manager --add-repo <repo_url>
# Example: sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
4.6 History and Rollback
dnf keeps a history of all transactions, allowing you to review and even undo/rollback changes.

Show transaction history:

Bash

sudo dnf history
This will show a list of transaction IDs, actions, and dates.

Show details of a specific transaction:

Bash

sudo dnf history info <transaction_id>
# Example: sudo dnf history info 5
Undo a transaction (reverts the change):
This will attempt to remove packages that were installed or install packages that were removed in that transaction.

Bash

sudo dnf history undo <transaction_id>
# Example: sudo dnf history undo 5
Rollback to a specific transaction:
This will undo all transactions that occurred after the specified transaction ID.

Bash

sudo dnf history rollback <transaction_id>
# Example: sudo dnf history rollback 5
4.7 Cleaning Cache
dnf caches metadata and downloaded packages. You might need to clean the cache to resolve issues or free up space.

Clean all cached files:

Bash

sudo dnf clean all
Clean only metadata cache:

Bash

sudo dnf clean metadata
Clean only downloaded packages:

Bash

sudo dnf clean packages
Force expiration of metadata cache (next command will re-download):

Bash

sudo dnf clean expire-cache
4.8 Module Management (RHEL/CentOS Stream 8+, Fedora)
Modules (or streams) allow multiple major versions of software to coexist or be easily switched between (e.g., Python 3.6 vs. 3.9, Node.js 12 vs. 16).

List available modules and their streams:

Bash

sudo dnf module list
# Example output:
# Name      Stream    Profiles     Summary
# python39  3.9 [d]   common [d]   Python programming language
# python38  3.8       common       Python programming language
[d] indicates the default stream.

Enable a specific module stream:
You must enable a stream before installing packages from it. This makes it the default for new installations.

Bash

sudo dnf module enable <module_name>:<stream_version>
# Example: sudo dnf module enable python39:3.9
Disable a module stream:

Bash

sudo dnf module disable <module_name>
# Example: sudo dnf module disable python38
Install a package from a specific module stream and profile:
A profile is a set of packages within a stream (e.g., 'common', 'devel').

Bash

sudo dnf module install <module_name>:<stream_version>/<profile>
# Example: sudo dnf module install python39:3.9/common
Reset a module to its default state:
This effectively disables the currently enabled stream and allows you to pick a new one or revert to the system default.

Bash

sudo dnf module reset <module_name>
# Example: sudo dnf module reset python39
5. Common DNF Options
You can combine these options with various dnf commands:

-y, --assumeyes: Automatically answer yes to all prompts. Use with caution as it bypasses confirmation.

Bash

sudo dnf install httpd -y
--enablerepo=<repo_id>: Temporarily enable a disabled repository for the current command.

Bash

sudo dnf install mypackage --enablerepo=epel
--disablerepo=<repo_id>: Temporarily disable an enabled repository for the current command.

Bash

sudo dnf update --disablerepo=updates-testing
--exclude=<package_spec>: Exclude specific packages from installation/update.

Bash

sudo dnf update --exclude=kernel*
--best: Try to install the best candidate packages for the requested operation, even if it means trying other packages that are not default.

Bash

sudo dnf install --best myapp
--allowerasing: Allow erasing of installed packages to resolve dependencies. Useful during update or install when a new package requires an old one to be removed. Use with caution.

Bash

sudo dnf install newpackage --allowerasing
6. DNF Configuration Files
DNF's behavior is configured by global settings and repository definitions.

6.1 /etc/dnf/dnf.conf
This is the main DNF configuration file. It contains global options that affect all DNF operations.

Common directives:

gpgcheck=1: (Default) Enables GPG signature checking for packages. Keep this enabled for security.

installonly_limit=3: Keeps a maximum of 3 kernel packages installed.

keepcache=0: (Default) Deletes downloaded packages after a successful installation. Change to 1 to keep them.

metadata_expire=7d: How often to check for new repository metadata (e.g., 7 days).

fastestmirror=True: (Default) Enables the fastest mirror plugin.

6.2 /etc/yum.repos.d/*.repo
This directory contains individual .repo files, each defining one or more software repositories. These files are plain text and are the primary way to manage where DNF finds packages.

Example myrepo.repo file:

Ini, TOML

[myrepo-base]
name=My Custom Repository
baseurl=http://repo.example.com/rhel/$releasever/BaseOS/$basearch/os/
enabled=1
gpgcheck=1
gpgkey=http://repo.example.com/RPM-GPG-KEY-MyRepo
Key directives in a .repo file:

[repository_id]: A unique identifier for the repository.

name: A human-readable name for the repository.

baseurl: The URL(s) where the packages are located.

$releasever: Placeholder for the RHEL/Fedora major version (e.g., 8, 9, 39).

$basearch: Placeholder for the system architecture (e.g., x86_64, aarch64).

enabled=1 or 0: Whether the repository is enabled (1) or disabled (0) by default.

gpgcheck=1 or 0: Whether to perform GPG signature checking for packages from this repo.

gpgkey: URL(s) to the GPG public key(s) used to sign packages from this repository.

priority: (Optional, requires dnf-plugins-core and configuration) Assigns a priority to the repository (lower number = higher priority).

7. Best Practices and Tips
Always use sudo: DNF modifies system files and requires root privileges.

Regular Updates: Keep your system secure and stable by regularly running sudo dnf update.

Understand GPG Checks: Never disable gpgcheck unless you fully understand the security implications and absolutely trust the package source. It protects your system from tampered packages.

Manage Repositories Carefully: Only add trusted third-party repositories. Misconfigured or malicious repositories can compromise your system.

Utilize dnf history: This is a powerful feature for debugging issues after updates or installations. You can easily see what changed and even revert if necessary.

Leverage Modules/Streams: For applications that require specific versions (e.g., databases, scripting languages), use DNF modules to manage them cleanly.

Read man dnf: The DNF manual page (man dnf) is an excellent resource for detailed information on all commands and options.

8. Conclusion
dnf is a robust, modern, and efficient package manager that is central to administering RHEL and Fedora systems. By understanding its core commands, configuration, and best practices, you can effectively manage software on your Linux servers and workstations, ensuring they are secure, up-to-date, and configured to your needs.

```