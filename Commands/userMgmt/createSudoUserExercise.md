User Creation and sudo Privileges on Linux

	This tutorial covers the step-by-step process of creating new user accounts and granting them sudo (superuser) privileges on both RHEL 9 and Ubuntu 22.04 LTS.

1. Common Prerequisites for Both RHEL and Ubuntu
SSH Access: Ensure you can SSH into your Linux instance (e.g., as the ec2-user on AWS RHEL, or ubuntu on AWS Ubuntu).

Root Privileges: You need to be able to execute commands as root (typically via sudo from your initial user) to create users and modify sudoers files.

Terminal/Shell: You'll be executing commands in a terminal.

2. Part 1: RHEL 9 - User Creation and sudo Configuration
On RHEL, the primary way to grant sudo access is by adding a user to the wheel group.

2.1 Create a New User
We'll use useradd (the underlying command) and passwd to create and set a password for the new user. Let's create devuser1.

Bash

# 1. Create the user account with a comment (full name)
	sudo useradd -c "Development User One" devuser1

# 2. Set a password for the new user
	sudo passwd devuser1

You will be prompted to enter and confirm the password for devuser1. Choose a strong password.

2.2 Grant sudo Privileges (Method 1: Using wheel Group - Recommended)
The wheel group on RHEL is pre-configured in the /etc/sudoers file to allow its members to execute sudo commands. This is the simplest and most common method.

Bash

# Add devuser1 to the 'wheel' supplementary group
	sudo usermod -aG wheel devuser1
Explanation:

usermod: Command to modify user accounts.

-a: Append the user to the specified group(s) without removing them from other existing groups.

-G wheel: Specifies that the user should be added to the wheel group as a supplementary group.

2.3 Grant sudo Privileges (Method 2: Custom sudoers.d Entry)
This method provides more granular control if you don't want the user to have full sudo access (i.e., not putting them in wheel), or if you need specific NOPASSWD rules.

Create a new file in /etc/sudoers.d/ using visudo -f:

Bash

	sudo visudo -f /etc/sudoers.d/devuser1_sudo
This command safely opens a new file named devuser1_sudo within the /etc/sudoers.d/ directory for editing.

Add the sudo rule to the file:
For example, to grant devuser1 full sudo access without needing to be in wheel:

Code snippet

# /etc/sudoers.d/devuser1_sudo
devuser1 ALL=(ALL) ALL
Or, to allow only specific commands (more secure):

Code snippet

# /etc/sudoers.d/devuser1_sudo
devuser1 ALL=/usr/bin/systemctl restart httpd, /usr/bin/dnf update
Or, to allow full sudo access without a password (use with extreme caution!):

Code snippet

# /etc/sudoers.d/devuser1_sudo
devuser1 ALL=(ALL) NOPASSWD: ALL
Save and close the file (Ctrl+X, Y, Enter in nano if visudo uses nano; :wq in vi/vim). visudo will automatically check syntax and set correct permissions (0440).

2.4 Verify sudo Privileges on RHEL
Test sudo from the new user's account:

Open a new terminal or SSH session.

Log in as devuser1 using the password you set.

Try a sudo command:

Bash

sudo dnf update --security
You will be prompted for devuser1's password. After entering it, the command should execute.

Check allowed commands (sudo -l):

As devuser1, type:

Bash

sudo -l
This command lists the commands devuser1 is allowed to run via sudo. You'll be prompted for the password.

If devuser1 is in wheel (Method 1) or has ALL=(ALL) ALL (Method 2 example), you'll see:
User devuser1 may run the following commands on this host: (ALL) ALL

If specific commands were allowed, you'll see a list of those commands.

3. Part 2: Ubuntu 22.04 LTS - User Creation and sudo Configuration
On Ubuntu, the primary way to grant sudo access is by adding a user to the sudo group.

3.1 Create a New User
On Ubuntu, adduser is generally preferred over useradd as it's more interactive and handles home directory, group, and password creation in one go. Let's create opsuser1.

Bash

# 1. Create the user account interactively
sudo adduser opsuser1
Follow the prompts to:

Set a password for opsuser1 (choose a strong one).

Enter full name and other optional details (just press Enter to skip).

Confirm Y at the end.

3.2 Grant sudo Privileges (Method 1: Using sudo Group - Recommended)
Ubuntu's sudo group (similar to RHEL's wheel group) is pre-configured in /etc/sudoers to allow its members full sudo access.

Bash

# Add opsuser1 to the 'sudo' supplementary group
sudo usermod -aG sudo opsuser1
Explanation:

usermod: Command to modify user accounts.

-a: Append the user to the specified group(s).

-G sudo: Specifies that the user should be added to the sudo group.

3.3 Grant sudo Privileges (Method 2: Custom sudoers.d Entry)
This method offers granular control, similar to RHEL.

Create a new file in /etc/sudoers.d/ using visudo -f:

Bash

sudo visudo -f /etc/sudoers.d/opsuser1_sudo
This safely opens a new file named opsuser1_sudo for editing.

Add the sudo rule to the file:
For example, to grant opsuser1 full sudo access without needing to be in sudo group:

Code snippet

# /etc/sudoers.d/opsuser1_sudo
opsuser1 ALL=(ALL) ALL
Or, to allow only specific commands (more secure):

Code snippet

# /etc/sudoers.d/opsuser1_sudo
opsuser1 ALL=/usr/bin/systemctl restart nginx, /usr/bin/apt update
Or, to allow full sudo access without a password (use with extreme caution!):

Code snippet

# /etc/sudoers.d/opsuser1_sudo
opsuser1 ALL=(ALL) NOPASSWD: ALL
Save and close the file (Ctrl+X, Y, Enter in nano if visudo uses nano; :wq in vi/vim). visudo will set correct permissions (0440).

3.4 Verify sudo Privileges on Ubuntu
Test sudo from the new user's account:

Open a new terminal or SSH session.

Log in as opsuser1 using the password you set.

Try a sudo command:

Bash

sudo apt update
You will be prompted for opsuser1's password. After entering it, the command should execute.

Check allowed commands (sudo -l):

As opsuser1, type:

Bash

sudo -l
This lists the commands opsuser1 is allowed to run via sudo. You'll be prompted for the password.

If opsuser1 is in sudo group (Method 1) or has ALL=(ALL) ALL (Method 2 example), you'll see:
User opsuser1 may run the following commands on this host: (ALL) ALL

If specific commands were allowed, you'll see a list of those commands.

4. General Best Practices for sudo
4.1 Security Warning about sudoers File!
The /etc/sudoers file and any files in /etc/sudoers.d/ are EXTREMELY SENSITIVE.

A single syntax error can render sudo unusable, potentially locking you out of administrative access (meaning you can't run sudo commands anymore).

ALWAYS use sudo visudo (or sudo visudo -f <file_path>) to edit sudoers files. visudo performs a syntax check before saving and prevents accidental write failures.

4.2 Principle of Least Privilege
Grant only what's necessary: Instead of giving ALL=(ALL) ALL (full root access), whenever possible, grant users/groups permission only for the specific commands they need to run with sudo.

Use full paths: Always specify the full, absolute path to commands in sudoers (e.g., /usr/bin/systemctl) to prevent a malicious user from creating a fake command in their PATH.

4.3 Always Use Passphrases for SSH Keys
If users are accessing instances via SSH keys, ensure their private keys are protected with strong passphrases. This provides an additional layer of security.