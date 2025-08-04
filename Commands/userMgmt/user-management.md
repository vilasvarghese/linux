RHEL 9: User Management, Permissions, and Network Configuration
This tutorial covers three fundamental areas of RHEL 9 administration: setting up consistent user home directory structures, managing file and directory permissions, and configuring network interfaces.

Table of Contents
User Folder Structure Management

1.1 Default User Creation Behavior

1.2 Method 1: Customizing /etc/skel (For New Users)

1.3 Method 2: Scripting for Existing Users

File and Directory Permissions & Ownership

2.1 Understanding Permissions (rwx)

2.2 Changing Permissions with chmod

2.3 Changing Ownership with chown and chgrp

2.4 Sticky Bit (Special Permission)

Network Configuration with nmcli

3.1 Finding Your Network Interface Name

3.2 Scenario A: DHCP Configuration (IPv4 and IPv6)

3.3 Scenario B: Static IPv4 Address Configuration

3.4 Scenario C: Static IPv6 Address Configuration

3.5 Scenario D: Combined Static IPv4 and DHCP/SLAAC IPv6

3.6 Verifying Your Network Configuration

3.7 Troubleshooting Network Issues

1. User Folder Structure Management
On RHEL 9, when you create a new user, a home directory is automatically generated (e.g., /home/username). This serves as their personal workspace. You can standardize subdirectories within it for better organization.

1.1 Default User Creation Behavior
The useradd (low-level) or adduser (user-friendly wrapper for useradd) commands automatically create the user's home directory and populate it with files from /etc/skel.

Example:



sudo adduser devuser1
sudo passwd devuser1 # Set password
This creates /home/devuser1/ with default dotfiles (e.g., .rc) and sets ownership.

1.2 Method 1: Customizing /etc/skel (For New Users)
This is the recommended way to enforce a standard folder structure for all newly created users. Any files or subdirectories placed in /etc/skel are copied to a new user's home directory.

Create desired directories and files within /etc/skel:



sudo mkdir -p /etc/skel/Documents
sudo mkdir -p /etc/skel/Projects
sudo mkdir -p /etc/skel/Downloads
sudo mkdir -p /etc/skel/Public
echo "# Custom welcome message" | sudo tee /etc/skel/welcome.txt
Verify contents of /etc/skel:



ls -a /etc/skel/
Create a new test user:



sudo adduser newuser_test
sudo passwd newuser_test
Verify the new user's home directory:



ls -a /home/newuser_test/
You should see the Documents, Projects, Downloads, Public directories, and welcome.txt file.

1.3 Method 2: Scripting for Existing Users
If you need to apply a standard structure to users who already exist (or a specific subset), a  script can automate this.



#!/bin/

# Define the base directory for user homes
USER_HOME_BASE="/home"

# Define the standard subdirectories
SUBDIRS=("Documents" "Projects" "Downloads" "Public")

# --- Function to create subdirectories for a single user ---
create_user_structure() {
    local username="$1"
    local user_home="$USER_HOME_BASE/$username"

    # Check if user's home directory exists
    if [ ! -d "$user_home" ]; then
        echo "Warning: Home directory '$user_home' for user '$username' does not exist. Skipping."
        return 1
    fi

    echo "Processing user: $username"
    for dir in "${SUBDIRS[@]}"; do
        if [ ! -d "$user_home/$dir" ]; then
            sudo mkdir -p "$user_home/$dir"
            # Set ownership and basic permissions
            sudo chown "$username:$username" "$user_home/$dir"
            sudo chmod 755 "$user_home/$dir" # rwx r-x r-x
            echo "  - Created '$dir' in '$user_home'"
        else
            echo "  - Directory '$dir' already exists in '$user_home', skipping."
        fi
    done
}

# --- Main script logic ---

if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <username_1> [username_2 ...]"
    echo "       $0 --all"
    echo "       $0 --group <groupname>"
    exit 1
fi

if [ "$1" == "--all" ]; then
    echo "Creating structure for all regular users (UID >= 1000)..."
    # Iterate through users with UID >= 1000 (standard for regular users)
    getent passwd | awk -F: '$3 >= 1000 && $1 != "nobody" && $1 != "nfsnobody" {print $1}' | while read -r user; do
        create_user_structure "$user"
    done
elif [ "$1" == "--group" ]; then
    if [ -z "$2" ]; then
        echo "Error: Please provide a group name after --group."
        exit 1
    fi
    groupname="$2"
    echo "Creating structure for users in group: $groupname..."
    getent group "$groupname" | awk -F: '{print $4}' | tr ',' '\n' | while read -r user; do
        if [ -n "$user" ]; then # Ensure user variable is not empty
            create_user_structure "$user"
        fi
    done
else
    # Process specific users provided as arguments
    for user_to_process in "$@"; do
        create_user_structure "$user_to_process"
    done
fi

echo "User folder structure script finished."
How to Use the Script:

Save the script as create_user_folders.sh.

Make it executable: chmod +x create_user_folders.sh.

Run it:

For a single user: ./create_user_folders.sh john

For multiple users: ./create_user_folders.sh mary alice

For all regular users: ./create_user_folders.sh --all

For users in a specific group (e.g., developers): ./create_user_folders.sh --group developers

2. File and Directory Permissions & Ownership
Linux uses a robust permission system to control who can read, write, or execute files and directories.

2.1 Understanding Permissions (rwx)
Permissions are defined for three categories of entities:

u (user): The owner of the file/directory.

g (group): The group associated with the file/directory.

o (others): Everyone else on the system.

The types of permissions are:

r (read): 4 - View content (files), list directory contents (directories).

w (write): 2 - Modify content (files), create/delete files in a directory (directories).

x (execute): 1 - Run a file (files), enter/traverse a directory (directories).

Permissions are often shown in ls -l output (e.g., -rw-r--r--) or represented numerically (e.g., 644).

2.2 Changing Permissions with chmod
The chmod (change mode) command modifies file and directory permissions.

Syntax (Symbolic Mode): chmod [ugoa][+-=][rwx] FILE...

+: Add permission.

-: Remove permission.

=: Set permission exactly.

Syntax (Octal Mode): chmod [OCTAL_MODE] FILE... (e.g., 755, 644).

Examples:

Grant execute to owner: chmod u+x myscript.sh

Remove write from group and others: chmod go-w sensitive.txt

Set exact permissions (owner rwx, group rx, others r): chmod 755 mydirectory/

Set exact permissions (owner rw, group r, others r): chmod 644 myfile.txt

Recursively set permissions for directories (755) and files (644):



find /path/to/data -type d -exec chmod 755 {} +
find /path/to/data -type f -exec chmod 644 {} +
2.3 Changing Ownership with chown and chgrp
chown (change owner): Changes the user and/or group ownership. Requires sudo.

Change user owner: sudo chown newuser file.txt

Change group owner (only group, keeping user): sudo chown :newgroup file.txt

Change both user and group: sudo chown newuser:newgroup file.txt

Recursively change ownership: sudo chown -R newuser:newgroup /path/to/data

chgrp (change group): Specifically changes only the group ownership. Requires sudo (or ownership of file).

Change group: sudo chgrp newgroup file.txt

Recursively change group: sudo chgrp -R newgroup /path/to/data

Example:
Set web_content directory and its contents to be owned by nginx user and nginx group:



sudo chown -R nginx:nginx /var/www/web_content/
2.4 Sticky Bit (Special Permission)
The sticky bit (+t or 1 in octal prefix) is mainly used on directories. It ensures that only the owner of a file (or the directory owner or root) can delete or rename files within that directory, even if others have write permissions. Common for /tmp.

Example:



sudo chmod +t /tmp/shared_uploads
# Or:
# sudo chmod 1777 /tmp/shared_uploads # Sets rwxrwxrwt permissions
3. Network Configuration with nmcli
RHEL 9 predominantly uses NetworkManager for managing network connections. nmcli is the command-line interface for NetworkManager, and it handles persistent configurations.

3.1 Finding Your Network Interface Name


nmcli device status
# Example: enp0s3, eth0, ens160
Note down your interface name (e.g., enp0s3) and its CONNECTION name (e.g., System enp0s3).

3.2 Scenario A: DHCP Configuration (IPv4 and IPv6 - Common Default)
This is typically the default. If you need to revert to DHCP or confirm it:



# Replace "System enp0s3" with your actual connection name
sudo nmcli connection modify "System enp0s3" ipv4.method auto ipv6.method auto
sudo nmcli connection up "System enp0s3" # Bring connection up/down to apply
3.3 Scenario B: Static IPv4 Address Configuration
Modify the existing connection profile:



sudo nmcli connection modify "System enp0s3" \
    ipv4.method manual \
    ipv4.addresses 192.168.1.150/24 \
    ipv4.gateway 192.168.1.1 \
    ipv4.dns "8.8.8.8 8.8.4.4" \
    connection.autoconnect yes # Ensure it connects on boot
Bring connection up/down to apply:



sudo nmcli connection down "System enp0s3"
sudo nmcli connection up "System enp0s3"
3.4 Scenario C: Static IPv6 Address Configuration
This can be combined with static IPv4 or DHCPv4.

Modify the existing connection profile:



sudo nmcli connection modify "System enp0s3" \
    ipv6.method manual \
    ipv6.addresses 2001:db8::10/64 \
    ipv6.gateway fe80::1 \
    ipv6.dns "2001:4860:4860::8888 2001:4860:4860::8844" \
    connection.autoconnect yes
Bring connection up/down to apply:



sudo nmcli connection down "System enp0s3"
sudo nmcli connection up "System enp0s3"
3.5 Scenario D: Combined Static IPv4 and DHCP/SLAAC IPv6


sudo nmcli connection modify "System enp0s3" \
    ipv4.method manual \
    ipv4.addresses 192.168.1.150/24 \
    ipv4.gateway 192.168.1.1 \
    ipv4.dns "8.8.8.8 8.8.4.4" \
    ipv6.method auto \
    ipv6.dns "2001:4860:4860::8888 2001:4860:4860::8844" \
    connection.autoconnect yes
sudo nmcli connection down "System enp0s3"
sudo nmcli connection up "System enp0s3"
3.6 Verifying Your Network Configuration
Check IP Addresses:



ip a show enp0s3 # Replace enp0s3
Check Active Connections:



nmcli connection show --active
Check Routing Table:



ip r        # IPv4
ip -6 r     # IPv6
Test DNS Resolution:



ping google.com
ping -6 google.com
dig google.com # Requires `bind-utils`
Test Gateway Connectivity:



ping 192.168.1.1 # Your IPv4 gateway
ping fe80::1%enp0s3 # Your IPv6 link-local gateway
3.7 Troubleshooting Network Issues
Syntax Errors: nmcli usually provides clear error messages.

NetworkManager Service: sudo systemctl status NetworkManager. Restart if needed: sudo systemctl restart NetworkManager.

Firewall (firewalld): sudo firewall-cmd --list-all --zone=public. Ensure necessary ports are open.

Logs: journalctl -u NetworkManager.

EC2 Instances: If on AWS EC2, remember the primary ENI (eth0/enp0s3) is DHCP-managed by AWS. Do not change its ipv4.method to manual unless you absolutely know what you're doing. Use secondary ENIs for additional static IPs.