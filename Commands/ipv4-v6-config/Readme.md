https://pro.tecmint.com/setup-network-services-rhel/
https://www.tecmint.com/linux-ip-address/
--------------------------------------------------------------------------------



Red Hat Enterprise Linux 9 (RHEL 9) primarily uses NetworkManager for network configuration. While ifcfg files in /etc/sysconfig/network-scripts/ are still supported for backward compatibility, new configurations are preferably stored as key files in /etc/NetworkManager/system-connections/.

The most common and recommended way to configure network settings on RHEL 9 is using the nmcli (NetworkManager Command Line Interface) utility. It's powerful, flexible, and allows for both interactive and scriptable configuration. You can also use nmtui for a text-based user interface, or cockpit for a web-based interface.

This guide will focus on nmcli.

1. Understanding NetworkManager and nmcli
NetworkManager: The daemon that manages network connections. It creates and activates "connection profiles" which define how an interface connects to a network.

nmcli: The command-line tool to interact with NetworkManager. It allows you to create, modify, activate, and deactivate network connections.

Connection Profiles: These are configuration sets that tell NetworkManager how to connect to a specific network. A single physical interface can have multiple connection profiles (e.g., one for DHCP, one for static IP).

2. Finding Your Network Interface Name
First, identify the name of your network interface. Common names on RHEL 9 include enpXsY (e.g., enp0s3, enp1s0) or eth0.

Bash

nmcli device status
# OR
ip a
Example nmcli device status output:

DEVICE     TYPE      STATE      CONNECTION
enp0s3     ethernet  connected  Wired connection 1
lo         loopback  unmanaged  --
In this example, enp0s3 is the network interface name, and Wired connection 1 is the default connection profile associated with it. You'll often modify the existing connection profile rather than creating a new one, especially for the primary interface.

3. Configuration Scenarios with nmcli
Remember to run all nmcli commands with sudo.

Scenario A: DHCP for IPv4 and IPv6 (Default)
Most RHEL 9 installations default to DHCP. If your interface is already configured for DHCP, you don't need to do anything. If you want to explicitly ensure it's set to DHCP, or switch it from static to DHCP:

Identify the connection name:

Bash

To check what connection method
-------------------------------
nmcli connection show --active
	find out the name - e.g. "cloud-init ens5"
nmcli connection show "<name> e.g.cloud-init ens5" | grep -i ipv4.method
	if method is auto - then it is dhcp 

nmcli connection show
# Let's assume it's "Wired connection 1" for enp0s3
Set IPv4 and IPv6 methods to auto (DHCP/SLAAC):

Bash

sudo nmcli connection modify "Wired connection 1" ipv4.method auto ipv6.method auto
Bring the connection down and up to apply changes:

Bash

sudo nmcli connection down "Wired connection 1"
sudo nmcli connection up "Wired connection 1"
Scenario B: Static IPv4 Address
This is common for servers where you need a consistent, fixed IP address.

Identify the connection name (e.g., "Wired connection 1").

Configure the static IPv4 address, gateway, and DNS servers:
Replace enp0s3, 192.168.1.150/24, 192.168.1.1, 8.8.8.8, 8.8.4.4 with your actual values.

Bash

sudo nmcli connection modify "Wired connection 1" \
    ipv4.method manual \
    ipv4.addresses 192.168.1.150/24 \
    ipv4.gateway 192.168.1.1 \
    ipv4.dns "8.8.8.8 8.8.4.4" \
    connection.autoconnect yes # Ensure it connects on boot
Bring the connection down and up to apply changes:

Bash

sudo nmcli connection down "Wired connection 1"
sudo nmcli connection up "Wired connection 1"
Scenario C: Static IPv6 Address
This can be combined with static IPv4 or DHCPv4.

Identify the connection name.

Configure the static IPv6 address, gateway, and DNS servers:
Replace enp0s3, 2001:db8::10/64, 2001:db8::1, 2001:4860:4860::8888, 2001:4860:4860::8844 with your actual values.

Bash

sudo nmcli connection modify "Wired connection 1" \
    ipv6.method manual \
    ipv6.addresses 2001:db8::10/64 \
    ipv6.gateway 2001:db8::1 \
    ipv6.dns "2001:4860:4860::8888 2001:4860:4860::8844" \
    connection.autoconnect yes # Ensure it connects on boot
Bring the connection down and up to apply changes:

Bash

sudo nmcli connection down "Wired connection 1"
sudo nmcli connection up "Wired connection 1"
Scenario D: Combined Static IPv4 and DHCP/SLAAC IPv6
This is a common setup for dual-stack environments.

Identify the connection name.

Configure static IPv4 and DHCP/SLAAC IPv6:

Bash

sudo nmcli connection modify "Wired connection 1" \
    ipv4.method manual \
    ipv4.addresses 192.168.1.150/24 \
    ipv4.gateway 192.168.1.1 \
    ipv6.method auto \
    ipv4.dns "8.8.8.8 8.8.4.4" \
    ipv6.dns "2001:4860:4860::8888 2001:4860:4860::8844" \
    connection.autoconnect yes
Bring the connection down and up to apply changes:

Bash

sudo nmcli connection down "Wired connection 1"
sudo nmcli connection up "Wired connection 1"
Note: You can specify both IPv4 and IPv6 DNS servers in the same ipv4.dns or ipv6.dns property, or you can separate them as shown above. NetworkManager will merge them into /etc/resolv.conf.

4. Creating a New Connection Profile (Optional, but good practice)
Instead of modifying the default "Wired connection 1", you might want to create a new profile for a specific purpose (e.g., my-static-eth0). This is useful if you want to easily switch between configurations.

Add a new connection profile:

Bash

sudo nmcli connection add type ethernet con-name my-static-eth0 ifname enp0s3 \
    ipv4.method manual \
    ipv4.addresses 192.168.1.150/24 \
    ipv4.gateway 192.168.1.1 \
    ipv4.dns "8.8.8.8 8.8.4.4" \
    ipv6.method auto \
    ipv6.dns "2001:4860:4860::8888" \
    connection.autoconnect yes
Activate the new connection profile:

Bash

sudo nmcli connection up my-static-eth0
This will automatically deactivate any other connection profile on enp0s3.

5. Verifying Your Network Configuration
After applying changes, always verify them.

Check IP Addresses:

Bash

ip a
# Look for your interface (e.g., enp0s3) and confirm assigned IPv4/IPv6 addresses.
Check Active Connections:

Bash

nmcli connection show --active
Check Routing Table:

Bash

ip r        # For IPv4 routes
ip -6 r     # For IPv6 routes
Ensure your default gateway(s) are correctly listed.

Test DNS Resolution:

Bash

ping google.com       # Test IPv4 DNS and connectivity
ping -6 google.com    # Test IPv6 DNS and connectivity
	will not work if ipv6 is not enabled 
dig google.com        # Detailed DNS lookup (requires 'bind-utils' package: `sudo dnf install bind-utils`)
Test Gateway Connectivity:

Bash

ping 192.168.1.1      # Ping your IPv4 gateway
ping fe80::1%enp0s3   # Ping your IPv6 link-local gateway (replace with actual)
6. Troubleshooting Tips
Typo in connection name: Ensure the connection name used in nmcli commands exactly matches the one shown in nmcli connection show.

Syntax Errors: nmcli usually provides helpful error messages if there's a syntax issue.

NetworkManager Service: Ensure NetworkManager is running:

Bash

sudo systemctl status NetworkManager
If it's not running or enabled, start/enable it:

Bash

sudo systemctl enable --now NetworkManager
Firewall (firewalld): If you can't access services, check firewalld settings.

Bash

sudo firewall-cmd --list-all
# Example to allow http:
# sudo firewall-cmd --permanent --add-service=http
# sudo firewall-cmd --reload
Persistent Configuration: nmcli changes are saved persistently in /etc/NetworkManager/system-connections/*.nmconnection files.

Rollback: If you get locked out, you might need console access (e.g., via cloud provider console, KVM/hypervisor console) to correct the configuration. Using nmtui or direct file editing in /etc/NetworkManager/system-connections/ might be easier in a lockout scenario.

Check logs:

Bash

journalctl -u NetworkManager


------------------------------
Create a network manager connection on "machine" name "eth0" that manages ens3 interface 
Configure the following static ip 
	ipv4 172.138.1.1/20
		this should be from m/c range 
	ipv6 ddd
	
	
ip a
nmcli connection show 
	find name ens3 (or equivalent in your m/c)
nmcli connection add type ethernet con-name eth0 ifname ens3 
ip a 
	find the ip range you should try 
nmcli connection modify eth0 ipv4.address 172.31.32.7/20 ipv4.method manual connection.autoconnect yes 
	similar comman can modify ipv6 also
nmcli connection show 
nmcli connection up eth0
nmcli connection show 
ip a 
	check the ip address configured

---------------------------------------------------------------------
On ec2 instance 
---------------
Scenario: You want to add an additional static IPv4 and IPv6 address to your RHEL 9 EC2 instance using nmcli.

Steps:

Launch an RHEL 9 EC2 Instance (Primary ENI via DHCP):

Go to the AWS EC2 Dashboard and click "Launch instance".

Name and tags: Give it a meaningful name (e.g., rhel-network-test).

Application and OS Images (Amazon Machine Image - AMI): Select "Red Hat Enterprise Linux" and choose an RHEL 9 AMI (e.g., "Red Hat Enterprise Linux 9 (HVM) - Kernel 5.14").

Instance type: A t2.micro or t3.micro is usually sufficient for testing.

Key pair (login): Select an existing key pair or create a new one to SSH into the instance.

Network settings:

VPC: Choose an existing VPC or create a new one.

Subnet: Select a subnet that has both IPv4 and IPv6 CIDR blocks associated with it. This is crucial for IPv6 testing. If your subnet doesn't have IPv6, you'll need to add an IPv6 CIDR block to your VPC and then associate it with your subnet.

Auto-assign public IP: Enable it if you want direct internet access via public IP.

Firewall (security groups): Ensure you have a security group that allows SSH (port 22) from your IP address. For testing later, you might want to add ICMP (ping) rules for IPv4 and IPv6.

Review and Launch: Launch the instance.

Create a New Elastic Network Interface (ENI) in the AWS Console:
This ENI will host your static IPv4 and IPv6 addresses.

Go to the EC2 Dashboard -> Network & Security -> Network Interfaces.

Click Create network interface.

Description: Give it a meaningful name (e.g., rhel-secondary-eni).

Subnet: Crucially, select the SAME subnet where your EC2 instance is running.

Security Groups: Attach the same security group (or one with equivalent rules) as your EC2 instance. This is important so traffic on the secondary interface is allowed.

IPv4 Private IP: Under "IPv4 private IP addresses", click "Auto-assign" or "Custom" to pick an available IP from the subnet's IPv4 range. Let's assume AWS assigns 172.31.32.100.

IPv6 IP: Click "Add new IPv6 address". AWS will typically assign one automatically from the subnet's IPv6 CIDR block (e.g., 2600:1f18:222a:3f01::/64). Note this address down. Example: 2600:1f18:222a:3f01:b3d2:ac78:c9f0:1234.

Click Create network interface.

Attach the New ENI to Your RHEL EC2 Instance:

In the Network Interfaces list, select your newly created ENI.

Go to Actions -> Attach.

Select your running RHEL EC2 instance from the dropdown.

Device index: Choose 1 (for eth1). This will usually make it eth1 or enp0sX (where X is incremented) in the OS.

Click Attach network interface.

Configure the New ENI within the RHEL 9 Instance (using nmcli):

SSH into your RHEL 9 EC2 instance using its primary public IP.

Verify the new interface is detected:

Bash

nmcli device status
# Look for a new device that is 'unmanaged'. It might be named eth1, enp0s4, etc.
# Example output:
# DEVICE     TYPE      STATE      CONNECTION
# enp0s3     ethernet  connected  System enp0s3
# eth1       ethernet  unmanaged  --
From this point, let's assume the secondary interface name is eth1.

Create a new NetworkManager connection profile for eth1 with static IPv4 and IPv6:

Important: Replace 172.31.32.100/20 and 2600:1f18:222a:3f01:b3d2:ac78:c9f0:1234/64 with the actual IP addresses that AWS assigned to your secondary ENI in step 2.

Gateways (ipv4.gateway and ipv6.gateway) should be left empty (or set to "") for secondary ENIs. The default route for your instance goes through the primary ENI (enp0s3 in this example).

DNS: Use your VPC's DNS resolver for IPv4 (e.g., 172.31.0.2 for a 172.31.0.0/16 VPC). For IPv6, you can use public DNS like Google's.

Bash

sudo nmcli connection add type ethernet con-name static-eth1 ifname eth1 \
    ipv4.method manual \
    ipv4.addresses 172.31.32.100/20 \
    ipv4.gateway "" \
    ipv4.dns "172.31.0.2" \
    ipv6.method manual \
    ipv6.addresses 2600:1f18:222a:3f01:b3d2:ac78:c9f0:1234/64 \
    ipv6.gateway "" \
    ipv6.dns "2001:4860:4860::8888 2001:4860:4860::8844" \
    connection.autoconnect yes
Activate the new connection:

Bash

sudo nmcli connection up static-eth1
This command will bring up the static-eth1 connection profile on the eth1 interface.

Verify Configuration:

Check IP addresses:

Bash

ip a
# Look for 'eth1' and confirm it has both your static IPv4 and IPv6 addresses.
Check active connections:

Bash

nmcli connection show --active
# Confirm 'static-eth1' is listed as active.
Test connectivity (IPv4 and IPv6):

Bash

ping -I eth1 google.com       # Tests IPv4 using the new interface
ping -6 -I eth1 google.com    # Tests IPv6 using the new interface
# You might need to install `iputils` for ping, or `bind-utils` for dig.
# sudo dnf install iputils bind-utils -y
dig google.com @172.31.0.2    # Test IPv4 DNS
dig -6 google.com @2001:4860:4860::8888 # Test IPv6 DNS
Check routing table (optional, but good for understanding):

Bash

ip r             # Check IPv4 routes (default should still be via primary ENI)
ip -6 r          # Check IPv6 routes (default should still be via primary ENI)
You'll typically only see local routes for eth1 because its purpose is to provide additional IPs, not a separate default route.

Why this approach works and is safe:

Primary ENI Intact: Your main enp0s3 (or eth0) interface remains on DHCP, allowing the instance to communicate with AWS services and maintaining your SSH connection.

AWS-Allocated IPs: You are configuring static IPs that AWS has actually allocated to that specific secondary ENI, avoiding conflicts.

Correct Routing Model: Secondary ENIs are for additional IP addresses, not for establishing a separate default route. The primary ENI handles the instance's default route
---------------------------------------------------------------------
In ubuntu
---------
Configure IPv4/IPv6 on ubuntu



Show thinking
Configuring IPv4 and IPv6 on Ubuntu primarily relies on Netplan, a YAML-based network configuration abstraction introduced in Ubuntu 18.04 LTS. Netplan simplifies network setup by allowing you to define your network configuration in YAML files, which are then translated into configurations for either systemd-networkd or NetworkManager.

This tutorial will focus on Netplan, as it's the standard for modern Ubuntu server and desktop installations.

1. Understanding Netplan
What it is: Netplan is a utility for configuring networking on Linux using YAML configuration files.

How it works: You write a YAML description of your desired network interfaces, and Netplan generates the necessary configuration files for your chosen backend (systemd-networkd or NetworkManager).

Why Netplan: It provides a consistent, distribution-agnostic way to configure networks, simplifying automation and management across different setups (servers, desktops, cloud instances).

2. Finding Your Network Interface Name
Before you start, you need to identify the name of your network interface. Common names include eth0, enp0s3, ens33, eno1, wlan0, etc.

Bash

ip a
# Or (older command, may not be installed by default on newer Ubuntu):
# ifconfig
Example ip a output:

2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:1c:77:38 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.100/24 brd 192.168.1.255 scope global dynamic enp0s3
    inet6 fe80::a00:27ff:fe1c:7738/64 scope link
In this example, enp0s3 is the network interface name.

3. Netplan Configuration File Location
Netplan configuration files are located in the /etc/netplan/ directory. They typically have a .yaml extension (e.g., 00-installer-config.yaml, 50-cloud-init.yaml).

Important: YAML files are sensitive to indentation. Use spaces (not tabs) for indentation. It's best to use a text editor that supports YAML syntax highlighting and indentation (e.g., nano, vim, VS Code).

Always back up your existing Netplan configuration file before making changes:

Bash

sudo cp /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.bak
# Adjust the filename as per your system's existing Netplan file.
If you don't have an existing file, you can create a new one, e.g., /etc/netplan/01-netcfg.yaml.

4. Configuring Network Interfaces with Netplan
Below are common configuration scenarios using Netplan.

Scenario A: DHCP for IPv4 and IPv6 (Common Default for Desktops/Servers)
This is the simplest configuration and is often the default. If your network has a DHCP server (and optionally a DHCPv6 server or uses SLAAC), this is sufficient.

Edit the Netplan configuration file:

Bash

sudo nano /etc/netplan/00-installer-config.yaml
Add/Modify content:

YAML

# This is the network config written by 'subiquity' or 'cloud-init'
network:
  version: 2
  renderer: networkd # Use networkd for server, NetworkManager for desktop
  ethernets:
    enp0s3: # Replace with your actual interface name
      dhcp4: true
      dhcp6: true # Set to false if you don't want DHCPv6/SLAAC
renderer: networkd: Recommended for servers.

renderer: NetworkManager: Recommended for desktops, as it integrates with the graphical network manager.

Scenario B: Static IPv4 Address
Use this if you need a fixed IPv4 address for your server (e.g., for a web server, database server).

Edit the Netplan configuration file:

Bash

sudo nano /etc/netplan/00-installer-config.yaml
Add/Modify content:

YAML

network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3: # Replace with your actual interface name
      dhcp4: false # Disable DHCP for IPv4
      addresses:
        - 192.168.1.150/24 # Your static IP address and subnet mask (CIDR notation)
      routes:
        - to: default
          via: 192.168.1.1 # Your default gateway's IPv4 address
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4] # Your DNS server(s)
      # optional: uncomment for older kernels that don't support netlink route add/delete
      # link-local: []
addresses: A list of IP addresses to assign.

routes: Define routing rules. to: default means the default gateway.

nameservers: Define DNS resolvers.

Scenario C: Static IPv6 Address
Use this if you need a fixed IPv6 address. This can be combined with static IPv4 or DHCPv4.

Edit the Netplan configuration file:

Bash

sudo nano /etc/netplan/00-installer-config.yaml
Add/Modify content (example with static IPv6 only, no IPv4):

YAML

network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3: # Replace with your actual interface name
      dhcp4: false
      dhcp6: false # Disable DHCP for IPv6 (if using static)
      addresses:
        - 2001:db8::10/64 # Your static IPv6 address and prefix length
      routes:
        - to: default
          via: fe80::1 # Your default IPv6 gateway (often a link-local address)
      nameservers:
        addresses: [2001:4860:4860::8888, 2001:4860:4860::8844] # Your IPv6 DNS server(s)
Scenario D: Combined Static IPv4 and DHCP/SLAAC IPv6
A common scenario where you want a static IPv4 for server access but prefer IPv6 to be automatically configured.

Edit the Netplan configuration file:

Bash

sudo nano /etc/netplan/00-installer-config.yaml
Add/Modify content:

YAML

network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3: # Replace with your actual interface name
      dhcp4: false
      addresses:
        - 192.168.1.150/24
      routes:
        - to: default
          via: 192.168.1.1
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4, 2001:4860:4860::8888, 2001:4860:4860::8844] # Both IPv4 and IPv6 DNS
      dhcp6: true # Enable DHCPv6 (for stateful) or SLAAC (for stateless)
5. Applying Netplan Configuration Changes
After editing the YAML file, you need to apply the changes.

Test the configuration (Highly Recommended!):
This command will apply the changes and automatically roll them back if connectivity is lost.

Bash

sudo netplan try
If prompted, press Enter to keep the changes, or wait for the timeout to revert.

Apply the configuration permanently:
If netplan try was successful (or if you're confident), apply the changes.

Bash

sudo netplan apply
No sudo systemctl restart networking or sudo service network-manager restart is typically needed if using netplan apply, as netplan handles restarting the correct backend service.

6. Verifying Your Network Configuration
After applying changes, always verify them.

Check IP Addresses:

Bash

ip a
Look for your interface (enp0s3 in our examples) and confirm the assigned IPv4 and IPv6 addresses.

Check Routing Table:

Bash

ip r        # For IPv4 routes
ip -6 r     # For IPv6 routes
Ensure your default gateway(s) are correctly listed.

Test DNS Resolution:

Bash

ping google.com       # Test IPv4 DNS and connectivity
ping -6 google.com    # Test IPv6 DNS and connectivity
dig google.com        # Detailed DNS lookup (requires 'dnsutils' package: `sudo apt install dnsutils`)
Test Gateway Connectivity:

Bash

ping 192.168.1.1      # Ping your IPv4 gateway
ping fe80::1%enp0s3   # Ping your IPv6 link-local gateway (replace fe80::1 and enp0s3 with actual)
7. Troubleshooting Common Netplan Issues
YAML Indentation: This is the most common error. Use a YAML linter if you're unsure. Errors will often show up when running netplan apply.

Syntax Errors: Double-check commas, colons, and valid keywords.

Interface Name: Ensure enp0s3 (or whatever you used) correctly matches your system's interface name.

Renderer Conflict: If you're on a desktop system and use renderer: networkd, you might lose GUI control over networking. It's usually NetworkManager for desktops.

"No default gateway found": Check your routes entry in the YAML file.

DNS Issues: If you can ping IPs but not hostnames, check nameservers in the YAML and confirm the DNS servers are reachable.

Check Netplan Logs:

Bash

journalctl -u systemd-networkd # If you use renderer: networkd
journalctl -u NetworkManager   # If you use renderer: NetworkManager
If you get locked out: Access the server via console (e.g., EC2 console, local VM console) or physical access if on bare metal to revert the changes. You can also boot into a recovery mode.

8. Legacy Method: /etc/network/interfaces (for very old Ubuntu versions or specific needs)
For Ubuntu versions prior to 18.04 LTS (e.g., 16.04 LTS), network configuration was primarily handled by the ifupdown package via the /etc/network/interfaces file. While Netplan is now preferred, you might encounter this on older systems.

Example ifupdown configuration for static IPv4:

Ini, TOML

# /etc/network/interfaces
auto enp0s3
iface enp0s3 inet static
    address 192.168.1.150
    netmask 255.255.255.0
    gateway 192.168.1.1
    dns-nameservers 8.8.8.8 8.8.4.4

# For static IPv6:
iface enp0s3 inet6 static
    address 2001:db8::10
    netmask 64
    gateway fe80::1
Apply changes:

Bash

sudo systemctl restart networking
# Or:
# sudo ifdown enp0s3
# sudo ifup enp0s3
Recommendation: Stick with Netplan for modern Ubuntu installations as it's the official and supported method.