# User Management with `useradd` in RHEL 9

The `useradd` command is a powerful, low-level utility in Linux used to create new user accounts. While often wrapped by higher-level tools like `adduser`, understanding `useradd` gives you granular control over the user creation process. This tutorial will cover its essential options and common use cases on RHEL 9.

## Table of Contents

1.  [Introduction to `useradd`](#1-introduction-to-useradd)
2.  [Basic User Creation](#2-basic-user-creation)
3.  [Common `useradd` Options](#3-common-useradd-options)
    * 3.1 [`-c, --comment COMMENT`](#31--c---comment-comment)
    * 3.2 [`-d, --home-dir HOME_DIR`](#32--d---home-dir-home_dir)
    * 3.3 [`-e, --expiredate EXPIRE_DATE`](#33--e---expiredate-expire_date)
    * 3.4 [`-f, --inactive INACTIVE`](#34--f---inactive-inactive)
    * 3.5 [`-g, --gid GROUP`](#35--g---gid-group)
    * 3.6 [`-G, --groups GROUP1[,GROUP2,...]`](#36--g---groups-group1group2)
    * 3.7 [`-k, --skel SKEL_DIR`](#37--k---skel-dir)
    * 3.8 [`-m, --create-home` / `-M, --no-create-home`](#38--m---create-home--m---no-create-home)
    * 3.9 [`-N, --no-user-group`](#39--n---no-user-group)
    * 3.10 [`-p, --password PASSWORD`](#310--p---password-password)
    * 3.11 [`-r, --system`](#311--r---system)
    * 3.12 [`-s, --shell SHELL`](#312--s---shell-shell)
    * 3.13 [`-u, --uid UID`](#313--u---uid-uid)
4.  [Setting User Password](#4-setting-user-password)
5.  [Verifying User Creation](#5-verifying-user-creation)
6.  [Modifying Users with `usermod`](#6-modifying-users-with-usermod)
7.  [Deleting Users with `userdel`](#7-deleting-users-with-userdel)
8.  [Best Practices](#8-best-practices)

---

## 1. Introduction to `useradd`

`useradd` is a command-line utility used to add new users to the Linux system. It modifies system account files (like `/etc/passwd`, `/etc/shadow`, `/etc/group`, `/etc/gshadow`) and creates the user's home directory.

**Prerequisites:**
* You must have root privileges (or use `sudo`) to run `useradd`.

**Default Behavior:**
When `useradd` is run without any options, it typically:
* Creates a new user entry in `/etc/passwd`, `/etc/shadow`.
* Creates a new primary group with the same name as the user in `/etc/group`, `/etc/gshadow`.
* Creates a home directory `/home/username`.
* Copies files from `/etc/skel` to the new home directory.
* Assigns a default shell (usually `/bin/bash` on RHEL).
* Assigns the next available User ID (UID) and Group ID (GID), typically starting from 1000 for regular users.

## 2. Basic User Creation

The simplest way to create a user is by providing just the username:

```bash
sudo useradd mynewuser
This command creates the user mynewuser with default settings.

Home directory: /home/mynewuser

Primary group: mynewuser (with GID same as UID)

Shell: /bin/bash (default on RHEL)

No password set initially (user cannot log in until password is set).

3. Common useradd Options
Let's explore the most frequently used options to customize user accounts.

3.1 -c, --comment COMMENT
Adds a comment or full name for the user in the /etc/passwd file.

Example:

Bash

sudo useradd -c "John Doe, IT Department" jdoe
grep jdoe /etc/passwd
# Output: jdoe:x:1001:1001:John Doe, IT Department:/home/jdoe:/bin/bash
3.2 -d, --home-dir HOME_DIR
Specifies a custom home directory for the user. If this directory doesn't exist, it will be created (unless -M is used).

Example:

Bash

sudo useradd -d /opt/users/appuser appuser
grep appuser /etc/passwd
# Output: appuser:x:1002:1002::/opt/users/appuser:/bin/bash
ls -ld /opt/users/appuser # Check if it was created
3.3 -e, --expiredate EXPIRE_DATE
Sets the date on which the user's account will be disabled. The date format is YYYY-MM-DD.

Example:

Bash

sudo useradd -e 2025-12-31 tempuser
sudo chage -l tempuser # Verify expiry date
3.4 -f, --inactive INACTIVE
Sets the number of days after a password expires until the account is permanently disabled. 0 means the account is never disabled, -1 means this feature is disabled.

Example:

Bash

sudo useradd -f 30 inactiveuser # Account disabled 30 days after password expiry
sudo chage -l inactiveuser # Verify inactive period
3.5 -g, --gid GROUP
Specifies the user's primary group by name or GID. The group must already exist.

Example:

Bash

sudo groupadd developers
sudo useradd -g developers devuser
grep devuser /etc/passwd
# Output: devuser:x:1005:1002::/home/devuser:/bin/bash (Note GID 1002 for developers group)
3.6 -G, --groups GROUP1[,GROUP2,...]
Adds the user to one or more supplementary (secondary) groups. The groups must already exist.

Example:

Bash

sudo groupadd sysadmins
sudo groupadd webadmins
sudo useradd -G sysadmins,webadmins superuser
id superuser # Verify group memberships
# Output will show superuser in its primary group and also sysadmins, webadmins
3.7 -k, --skel SKEL_DIR
Specifies an alternate skeleton directory instead of the default /etc/skel from which to copy files and directories into the new user's home directory.

Example:

Bash

sudo mkdir -p /etc/custom_skel/config
echo "Custom configuration here" | sudo tee /etc/custom_skel/config/myapp.conf

sudo useradd -k /etc/custom_skel customuser
ls -a /home/customuser/
3.8 -m, --create-home / -M, --no-create-home
-m, --create-home: Forces the creation of the home directory, even if /etc/login.defs specifies otherwise or if default behavior is overridden. (Usually implied by default unless -M is used).

-M, --no-create-home: Prevents the creation of the home directory. Useful for service accounts or users who won't have a personal login.

Example:

Bash

sudo useradd -M nohomediruser
ls -ld /home/nohomediruser # Will not exist
3.9 -N, --no-user-group
Prevents useradd from creating a new primary group with the same name as the user. Instead, the user is added to the group specified by the -g option, or to the system's default group (often users or nogroup, depending on system configuration).

Example:

Bash

# This assumes 'users' group exists and is default if not specified
sudo useradd -N nogroupuser
id nogroupuser
# Will show a primary GID that is NOT the same as the user's UID
3.10 -p, --password PASSWORD
Specifies the encrypted password for the new account. Using this option is generally discouraged for security reasons as the password will be visible in your shell history. It's much safer to set the password after creation using passwd. The password must be already encrypted (e.g., with openssl passwd -1).

Example (for demonstration ONLY, not recommended for real use):

Bash

# Generate a salted MD5 hash of "MySecurePass123"
# You MUST replace 'MySecurePass123' with your desired password
ENCRYPTED_PASS=$(openssl passwd -1 "MySecurePass123")
echo "Encrypted password: $ENCRYPTED_PASS"

sudo useradd -p "$ENCRYPTED_PASS" insecureuser
sudo grep insecureuser /etc/shadow
3.11 -r, --system
Creates a system account. System accounts typically have UIDs lower than 1000 (usually 1-999) and do not have a home directory created by default (implies -M). They are used for running services and applications, not for human logins.

Example:

Bash

sudo useradd -r systemsvc
grep systemsvc /etc/passwd
ls -ld /home/systemsvc # Will not exist
3.12 -s, --shell SHELL
Specifies the default login shell for the user. Common shells are /bin/bash, /bin/sh, /bin/zsh, /bin/tcsh, or /sbin/nologin (to prevent interactive logins).

Example:

Bash

sudo useradd -s /bin/zsh zshuser
sudo useradd -s /sbin/nologin noentryuser # For service accounts
grep zshuser /etc/passwd
grep noentryuser /etc/passwd
3.13 -u, --uid UID
Specifies the User ID (UID) for the new user. The UID must be unique and not already in use by another user.

Example:

Bash

sudo useradd -u 2000 specialuid
grep specialuid /etc/passwd
4. Setting User Password
After creating a user with useradd, their account is typically locked or has no password set, preventing login. You must set a password using the passwd command.

Bash

sudo passwd mynewuser
You will be prompted to enter and confirm the new password.

5. Verifying User Creation
After using useradd, you can verify the new user's existence and attributes using several commands:

id <username>: Shows UID, GID, and group memberships.

Bash

id mynewuser
grep <username> /etc/passwd: Shows the user's entry in the password file.

grep <username> /etc/shadow: Shows the user's entry in the shadow password file (encrypted password, expiry info).

grep <username> /etc/group: Shows the user's primary group.

ls -ld /home/<username>: Checks the home directory and its permissions/ownership.

6. Modifying Users with usermod
Once a user is created, you can modify their attributes using the usermod command. It supports many of the same options as useradd.

Examples:

Change home directory: sudo usermod -d /new/home/dir -m existinguser (-m moves contents)

Add to a supplementary group: sudo usermod -aG newgroup existinguser (-a for append, G for supplementary groups)

Change shell: sudo usermod -s /bin/sh existinguser

Expire account: sudo usermod -e 2026-01-01 existinguser

7. Deleting Users with userdel
To remove a user account from the system.

Delete user account (leaves home directory and mail spool):

Bash

sudo userdel myolduser
Delete user account and their home directory (recommended):

Bash

sudo userdel -r myolduser
8. Best Practices
Always use sudo: For all user management commands.

Set Passwords Immediately: After creating a user, set a strong password using sudo passwd <username>.

Use Descriptive Comments: Use -c to add a comment for better user identification.

Manage Groups: Use -g for primary group and -G for supplementary groups to organize users and manage permissions effectively.

Consider /etc/skel for standardization: For new users, modifying /etc/skel is more efficient than scripting post-creation.

System Accounts (-r): Use the -r option for non-human service accounts. Do not assign them a password or a login shell (use /sbin/nologin).

Avoid -p: Do not use the -p option with useradd for security reasons.

```