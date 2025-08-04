1. What is sudo?
sudo stands for "substitute user do" (or sometimes "super user do"). It's a program that allows an authorized user to execute commands as another user (by default, the root user). It provides a more secure and auditable alternative to directly logging in as root or using su to become root.

2. Why Use sudo Instead of su (Switch User)?
Granular Control: With sudo, you can configure exactly which commands a user or group is allowed to run, and as which user. su simply gives you full root access (if you know the root password).

No Root Password Sharing: You don't need to share the root password. Users use their own password to authenticate with sudo.

Accountability & Auditing: Every sudo command executed is logged, often in /var/log/secure (RHEL/CentOS) or /var/log/auth.log (Debian/Ubuntu), providing an audit trail of who did what, when.

Reduced Risk: Users only gain elevated privileges for the specific command they run, reducing the risk of accidental damage compared to being logged in as root indefinitely.

Password Timeout: sudo remembers your password for a short period (typically 5 minutes), so you don't need to re-enter it for every administrative command.

3. Basic sudo Usage
To execute a command with root privileges using sudo, simply prefix the command with sudo:

Bash

sudo <command_to_execute>
Example:

Bash

sudo dnf update -y
When you run sudo for the first time in a session, it will prompt you for your own user password (not the root password):

[sudo] password for youruser:
After successful authentication, the command will execute with root privileges.

4. The sudoers File (/etc/sudoers)
The sudoers file is the heart of sudo's configuration. It defines who can run what, where, and how.

WARNING: A syntax error in the sudoers file can lock you out of sudo access, potentially requiring single-user mode to fix. ALWAYS use visudo to edit this file.

4.1 Editing sudoers with visudo
visudo is a command-line utility designed specifically for safely editing the sudoers file. It performs syntax checking before saving the file, preventing lockout due to errors.

Bash

sudo visudo
This command opens /etc/sudoers in a text editor (usually vi by default).

4.2 Understanding sudoers Syntax
The basic format for an entry in sudoers is:

user    host=(runas_user)    commands
Or for groups:

%group  host=(runas_user)    commands
Let's break down each part:

User Specification
Individual User: The username of the user.

youruser

Group: A group name prefixed with a percent sign (%). Any member of this group will inherit the permissions.

%wheel (a common administrative group on RHEL)

User Alias: A predefined alias for a list of users (e.g., User_Alias ADMINS = user1, user2).

Host Specification
ALL: The rule applies to all hosts (common for single servers).

ALL

Hostname: A specific hostname.

server.example.com

IP Address: A specific IP address.

192.168.1.10

Network Address: A network in CIDR notation.

192.168.1.0/24

Host Alias: A predefined alias for a list of hosts.

RunAs Specification
ALL: The user can run commands as any user (and optionally any group). This is the most common and least restrictive.

(ALL)

Specific User: The user can run commands only as this specific user.

(root)

(nginx)

Specific User and Group: The user can run commands as a specific user and group.

(john:developers)

RunAs Alias: A predefined alias for a list of users.

Command Specification
ALL: The user can run any command. Use with extreme caution.

ALL

Full Path to Command: The absolute path to a specific command. This is crucial for security as it prevents malicious users from creating a fake command in their PATH.

/usr/bin/dnf

/usr/sbin/systemctl restart httpd

Directory of Commands: All commands within a specific directory.

/usr/sbin/ (dangerous, generally avoid unless specific use case)

Command Alias: A predefined alias for a list of commands.

Tags
NOPASSWD:: Allows the user to run the specified commands without being prompted for a password. Use very sparingly and for specific, low-risk commands.

NOEXEC:: Prevents the specified command from executing other commands.

SETENV:: Allows the user to set environment variables.

NOSETENV:: Prevents the user from setting environment variables.

5. Common sudoers Configurations
Here are common examples of entries you might add to /etc/sudoers using visudo.

5.1 Allowing a User to Run All Commands as Root
This is the most common setup for administrative users.

Code snippet

youruser ALL=(ALL) ALL
youruser: The specific user.

ALL: Can run sudo from any host.

(ALL): Can run commands as any user (and group).

ALL: Can run any command.

5.2 Allowing a Group to Run All Commands as Root
RHEL's default sudoers often has a line for the wheel group. To use this, simply add your user to the wheel group:

Bash

sudo usermod -aG wheel youruser
The corresponding line in /etc/sudoers (often uncommented by default):

Code snippet

%wheel  ALL=(ALL)       ALL
%wheel: Any user in the wheel group.

ALL: Can run sudo from any host.

(ALL): Can run commands as any user.

ALL: Can run any command.

5.3 Allowing Specific Commands
This is much more secure, granting only the necessary privileges.

Example: Allow user webmaster to restart the httpd service:

Code snippet

webmaster ALL=/usr/bin/systemctl restart httpd
Example: Allow user dbadmin to restart the mariadb service and dump databases:

Code snippet

dbadmin ALL=/usr/bin/systemctl restart mariadb, /usr/bin/mysqldump
Always use full paths for commands. This prevents users from running a malicious script named systemctl in their PATH.

5.4 Allowing Commands Without Password (NOPASSWD)
Use with extreme caution! This means the user does not need to enter their password for the specified commands.

Example: Allow user loguser to view logs without a password:

Code snippet

loguser ALL=(ALL) NOPASSWD: /usr/bin/tail -f /var/log/messages
5.5 Limiting sudo to Specific Hosts (for multi-host environments)
If you have users managing multiple servers, you can limit their sudo access to specific machines.

Example: User devops can administer webserver1 and dbserver1:

Code snippet

devops webserver1=(ALL) ALL, dbserver1=(ALL) ALL
5.6 Using Aliases for Commands
For complex scenarios or multiple commands, aliases improve readability and maintainability.

Code snippet

Cmnd_Alias APACHE_CMDS = /usr/bin/systemctl restart httpd, /usr/bin/systemctl stop httpd, /usr/bin/systemctl start httpd
Cmnd_Alias DNF_CMDS = /usr/bin/dnf update, /usr/bin/dnf install, /usr/bin/dnf remove

webmaster ALL=APACHE_CMDS
sysadmin  ALL=APACHE_CMDS, DNF_CMDS
6. sudo Command Options
sudo itself has several useful command-line options.

6.1 -i, --login
Run the shell specified by the target user's password entry as a login shell. This means it will read the target user's (usually root's) login scripts (e.g., .profile, .bashrc) and change to their home directory.

Bash

sudo -i
# You are now in root's home directory (/root) and acting as if root logged in.
This is similar to sudo su -.

6.2 -s, --shell
Run the shell specified by the SHELL environment variable if it's set, or the user's default shell as a non-login shell. It doesn't change the current directory or load login scripts.

Bash

sudo -s
# You are now root, but typically in your original user's home directory.
6.3 -u, --user <user>
Run the command as a user other than root.

Bash

sudo -u nginx ls /var/www/html/ # List files as the nginx user
sudo -u anotheruser bash        # Start a shell as anotheruser
6.4 -l, --list
List the commands you are allowed to run as root (or another specified user).

Bash

sudo -l # List commands you can run as root
sudo -l -u nginx # List commands you can run as nginx
6.5 -k, --reset-timestamp
Invalidate the user's cached sudo credentials. This forces the user to re-enter their password the next time they use sudo.

Bash

sudo -k
6.6 -v, --validate
Update the user's cached sudo credentials, extending the timeout period without running a command.

Bash

sudo -v
7. sudo Timeout and Timestamp
When you run sudo and successfully authenticate, sudo creates a timestamp file for your user (usually in /var/db/sudo/). This file indicates that you have recently authenticated. The sudo timeout period (typically 5 minutes) determines how long this timestamp is valid. Within this period, you won't be prompted for your password again.

You can configure this timeout in /etc/sudoers using Defaults timestamp_timeout=X where X is minutes. 0 means always ask for password, -1 means never ask again until reboot.

8. Troubleshooting sudo Issues
"user is not in the sudoers file. This incident will be reported."

This means the user is not allowed to use sudo. You need to add an entry for the user or add the user to an authorized group (like wheel) using sudo usermod -aG wheel youruser.

"Sorry, try again."

You entered an incorrect password. Remember, it's your user's password, not root's.

Syntax Errors after visudo:

visudo will usually catch these and prevent saving. If you manage to break it (e.g., by directly editing /etc/sudoers), you might need to boot into single-user mode to fix the file as root.

Command not found or permission denied after sudo:

Ensure you're using the full path to the command in sudoers.

Check the actual permissions of the command itself (ls -l /usr/bin/mycommand).

The command might be trying to access files or resources that the runas_user (e.g., root) does not have permission for (unlikely if running as root, but possible if running as another restricted user).

9. Best Practices for sudo
Least Privilege: Grant users only the necessary sudo permissions they need to perform their tasks. Avoid ALL unless absolutely required for highly trusted administrators.

Use Groups: Whenever possible, manage sudo access by adding users to specific groups (e.g., wheel, sysadmin_group) rather than individual user entries. This simplifies administration.

Full Paths for Commands: Always specify the full, absolute path to commands in sudoers to prevent security vulnerabilities (/usr/bin/command vs. just command).

visudo Only: NEVER edit /etc/sudoers directly with a standard text editor. Always use sudo visudo.

Audit Logs: Regularly review sudo logs (e.g., in /var/log/secure on RHEL) to monitor administrative actions.

Strong Passwords: Ensure all sudo enabled users have strong, unique passwords.

NOPASSWD Sparingly: Only use NOPASSWD for highly specific, low-risk, and idempotent commands that absolutely need to be run without interaction (e.g., certain script executions).