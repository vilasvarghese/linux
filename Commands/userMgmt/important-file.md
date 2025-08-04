
Understanding Linux User and Privilege Configuration Files

This tutorial explains the purpose and structure of /etc/passwd, /etc/shadow, and /etc/sudoers.d/, which are fundamental for user authentication and authorization on RHEL 9 and similar Linux distributions.


1. /etc/passwd
1.1 Purpose
The /etc/passwd file is a plain text file that contains a list of all user accounts on the system. Historically, it also stored user passwords, but for security reasons, passwords are now stored in a separate, more secure file (/etc/shadow).

Key Information Stored: User account details (username, UID, GID, home directory, login shell, full name/comment).

1.2 Structure
Each line in /etc/passwd represents a single user account and consists of seven fields, separated by colons (:):

username:password_placeholder:UID:GID:GECOS:home_directory:login_shell

username: The user's login name (e.g., root, john, nginx). Must be unique.

password_placeholder:

x: Indicates that the actual (encrypted) password is stored in /etc/shadow. This is the standard and most secure setup.

* or !: Indicates a locked or disabled account.

(Empty): Historically meant no password required (highly insecure, never use).

UID (User ID): A unique numerical identifier for the user.

0: Reserved for the root (superuser) account.

1-999: Typically reserved for system accounts (e.g., bin, daemon, nginx). These often don't have a login shell.

1000+: Typically used for regular user accounts.

GID (Group ID): The numerical ID of the user's primary group. Every user must belong to at least one primary group.

GECOS (General Electric Comprehensive Operating System): A comment field (often called the "comment" field). It typically stores the user's full name, office number, phone number, etc. (e.g., "John Doe, IT Dept"). This field is often ignored by applications.

home_directory: The absolute path to the user's home directory (e.g., /root, /home/john). This is where the user's personal files and configuration are stored.

login_shell: The absolute path to the program that runs when the user logs in interactively.

/bin/bash: Common interactive shell.

/sbin/nologin: Prevents direct interactive login (often used for system accounts).

/bin/false: Another common way to disable interactive login.

1.3 Example Entry
john:x:1001:1001:John Doe, Project Team:/home/john:/bin/bash
In this example:

john is the username.

x indicates the password is in /etc/shadow.

1001 is the User ID (UID).

1001 is the Primary Group ID (GID).

John Doe, Project Team is the GECOS comment.

/home/john is the home directory.

/bin/bash is the login shell.

2. /etc/shadow
2.1 Purpose
The /etc/shadow file stores the encrypted password information and password aging parameters for user accounts. It is crucial for system security because it prevents unauthorized users from easily accessing password hashes. Unlike /etc/passwd, /etc/shadow is only readable by the root user.

Key Information Stored: Encrypted passwords, password expiration, account expiration.

2.2 Structure
Each line in /etc/shadow corresponds to an entry in /etc/passwd and consists of nine fields, separated by colons (:):

username:encrypted_password:last_changed:min_days:max_days:warn_days:inactive_days:expiry_date:reserved

username: The user's login name. Must match a username in /etc/passwd.

encrypted_password: The hashed password.

Starts with $ followed by a number indicating the hashing algorithm (e.g., $6$ for SHA-512, $5$ for SHA-256).

!, *, or !!: Indicates a locked account (user cannot log in with a password).

(Empty): No password set (user can log in without a password, highly insecure).

last_changed: The number of days since January 1, 1970, that the password was last changed.

min_days: The minimum number of days required between password changes. A user cannot change their password again until this many days have passed since the last change. 0 means no minimum.

max_days: The maximum number of days a password is valid. After this many days, the user will be forced to change their password. 99999 (or a very large number) typically means no maximum.

warn_days: The number of days before password expiry that the user will be warned to change their password.

inactive_days: The number of days after a password expires that the account will become permanently disabled. If the password expires and the user doesn't log in within this period, the account is locked.

expiry_date: The number of days since January 1, 1970, when the account will be permanently disabled, regardless of password status. This is an absolute account expiration date. (e.g., set with useradd -e or usermod -e).

reserved: A reserved field, currently unused.

2.3 Example Entry
john:$6$fWzE.C.1$b.2q4F4g6Z7Y3X2U1T0S9R8Q7P6O5N4M3L2K1J0I9H8G7F6E5D4C3B2A1Z0Y9X8W7V6U5T4S:/home/john:19808:0:99999:7:::
In this (truncated) example:

john is the username.

$6$... is the SHA-512 encrypted password.

19808 indicates the password was last changed on 19808 days after Jan 1, 1970 (around May 2024, depending on the exact date).

0: No minimum days between changes.

99999: Password never expires.

7: User will be warned 7 days before password expiry (though the password never expires in this case, so this warning won't trigger for expiry).

The last three fields are empty, meaning no inactivity period, no absolute account expiry, and the reserved field is empty.

3. /etc/sudoers.d/
3.1 Purpose
The /etc/sudoers.d/ directory is a feature introduced to make sudo configuration more modular and easier to manage, especially in complex environments or for automation. Instead of placing all sudo rules directly into the single /etc/sudoers file, you can create separate files within this directory.

3.2 How it Works
The main /etc/sudoers file contains a line (usually towards the end) that includes all files in /etc/sudoers.d/:

#includedir /etc/sudoers.d
When sudo is executed, it reads /etc/sudoers and then processes all readable files (that are not symlinks or don't end with a ~) found in /etc/sudoers.d/.

3.3 Why Use It?
Modularity: You can create separate files for different users, groups, applications, or roles (e.g., dbadmins, webmasters, devops_scripts).

Easier Management: Adding or removing specific sudo rules becomes as simple as adding or deleting a file in this directory, without modifying the main /etc/sudoers file.

Reduced Conflicts: Multiple administrators or automation tools can add their own sudo configurations without directly editing a shared, monolithic file, reducing the risk of merge conflicts or accidental deletions.

Automated Deployment: Configuration management tools (like Ansible, Puppet, Chef) can easily drop specific sudo rule files into this directory.

Security: visudo still validates each file when you create/edit it using the correct method.

3.4 Creating a Configuration File
WARNING: Just like /etc/sudoers, files in /etc/sudoers.d/ MUST BE EDITED SAFELY.

Always use visudo -f /etc/sudoers.d/your_file_name to create or edit files in this directory. This ensures syntax checking before saving.

Files in this directory must have strict permissions: 0440 (read-only for root and members of the sudo group) is highly recommended. visudo will usually set this for you.

Steps:

Open visudo for a new file:

Bash

sudo visudo -f /etc/sudoers.d/my_custom_rules
Add your sudo rules (using the same syntax as /etc/sudoers).

Save and exit the editor. visudo will check the syntax.

Verify permissions:

Bash

ls -l /etc/sudoers.d/my_custom_rules
# Expected output: -r--r----- 1 root root 123 Jul 29 09:00 my_custom_rules
# Or -r--r----- 1 root sudo 123 Jul 29 09:00 my_custom_rules (on some systems)
3.5 Example Configuration File (/etc/sudoers.d/apache_restart)
This file would allow a user webuser to only restart the Apache web server.

Code snippet

# File: /etc/sudoers.d/apache_restart
# Allows 'webuser' to restart httpd service
webuser ALL=/usr/bin/systemctl restart httpd
4. Security Considerations
/etc/passwd: Read-only for all users (0644) so anyone can see usernames and other public information.

/etc/shadow: Read-only for root only (0640). This is critical. If non-root users can read it, your system is severely compromised.

/etc/sudoers and /etc/sudoers.d/*: Read-only for root and members of the sudo group (0440). This ensures that only authorized administrators can view or modify the sudo rules. Any incorrect permissions on these files will be flagged by sudo itself or by security scanners.

visudo: Always use visudo (with or without -f) to edit sudoers files. It performs crucial syntax checks, preventing errors that could lock you out of administrative access.

Principle of Least Privilege: When configuring sudo rules, always grant the minimum necessary permissions. Avoid giving ALL=(ALL) ALL unless the user is a full system administrator.

Understanding and correctly managing these files are fundamental skills for any Linux system administrator.

