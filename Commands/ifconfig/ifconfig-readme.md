Markdown

# Linux `ifconfig` Command Tutorial (Detailed)

The `ifconfig` (interface configuration) command is a legacy command-line utility used to configure, view, and manage network interfaces on Linux and other Unix-like operating systems. While it's still widely available, it has been largely superseded by the `ip` command (part of the `iproute2` suite) in modern Linux distributions. However, understanding `ifconfig` is still valuable due to its historical significance and presence in many older or embedded systems.

## Basic Syntax

```bash
ifconfig [INTERFACE] [OPTIONS | ADDRESS]
INTERFACE: The name of the network interface (e.g., eth0, wlan0, lo).

OPTIONS | ADDRESS: Commands or parameters to configure the interface, or an IP address to assign.

How ifconfig Works
ifconfig interacts with the kernel's network stack to get and set interface parameters. It can display current interface configurations, assign IP addresses, set netmasks, configure broadcast addresses, enable/disable interfaces, and more.

Examples and Use Cases
1. Display Information for All Active Network Interfaces
Running ifconfig without any arguments displays the configuration of all currently active (UP) network interfaces.

Bash

ifconfig
Output Explanation (simplified for eth0 and lo):

eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.100  netmask 255.255.255.0  broadcast 192.168.1.255
        inet6 fe80::a00:27ff:fe00:0  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:00:00:00  txqueuelen 1000  (Ethernet)
        RX packets 12345  bytes 1234567 (1.2 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 9876   bytes 987654 (987.6 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 100  bytes 8000 (8.0 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 100  bytes 8000 (8.0 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
eth0 / lo: Interface name (Ethernet 0, Loopback).

flags: Interface characteristics (e.g., UP=active, BROADCAST=supports broadcast, RUNNING=interface is up and running, MULTICAST=supports multicast).

mtu: Maximum Transmission Unit (maximum packet size).

inet: IPv4 address.

netmask: IPv4 subnet mask.

broadcast: IPv4 broadcast address.

inet6: IPv6 address.

ether: MAC address (Ethernet hardware address).

txqueuelen: Transmit queue length.

RX packets/bytes: Number of received packets and total bytes.

RX errors/dropped/overruns/frame: Statistics on receive errors.

TX packets/bytes: Number of transmitted packets and total bytes.

TX errors/dropped/overruns/carrier/collisions: Statistics on transmit errors.

2. Display Information for a Specific Interface
To see details for a particular interface, specify its name.

Bash

ifconfig eth0
ifconfig wlan0
3. Display All Interfaces (Including Inactive Ones)
The -a option shows all interfaces, whether they are active (UP) or inactive (DOWN).

Bash

ifconfig -a
4. Assign an IP Address and Netmask to an Interface
To configure an interface with a static IP address and netmask:

Bash

sudo ifconfig eth0 192.168.1.150 netmask 255.255.255.0
Note: This change is temporary and will be lost on reboot. For permanent changes, you need to edit network configuration files (e.g., /etc/network/interfaces on Debian/Ubuntu, or NetworkManager configurations on other distros).

5. Bring an Interface Up or Down
To activate an interface:

Bash

sudo ifconfig eth0 up
To deactivate an interface (disconnect from network):

Bash

sudo ifconfig eth0 down
This is useful for troubleshooting or applying network configuration changes.

6. Add a Second IP Address (IP Alias)
You can assign multiple IP addresses to a single interface using IP aliasing. This is often done by appending a colon and a number to the interface name.

Bash

sudo ifconfig eth0:0 192.168.1.200 netmask 255.255.255.0
This creates eth0:0 as an alias for eth0 with a new IP.

7. Remove an IP Address Alias
Bash

sudo ifconfig eth0:0 down
8. Set the MAC Address of an Interface
You can change the hardware (MAC) address of an interface. The interface must be brought down first.

Bash

sudo ifconfig eth0 down
sudo ifconfig eth0 hw ether 00:11:22:33:44:55
sudo ifconfig eth0 up
Caution: Changing MAC addresses can have network implications and should be done with care. It's often temporary.

9. Set the MTU (Maximum Transmission Unit)
The MTU defines the largest packet size (in bytes) that can be transmitted over an interface.

Bash

sudo ifconfig eth0 mtu 1400
10. Configure Loopback Interface (lo)
The loopback interface (lo) is a special interface that allows communication within the host itself. It's typically configured with 127.0.0.1.

Bash

sudo ifconfig lo up
sudo ifconfig lo 127.0.0.1 netmask 255.0.0.0
This is usually configured by default.

Legacy Status and Alternatives (ip command)
The ifconfig command is considered deprecated in favor of the more powerful and flexible ip command, which is part of the iproute2 utilities. Modern Linux distributions primarily use ip for network configuration.

Here's a comparison of common ifconfig commands and their ip equivalents:

ifconfig Command	ip Command Equivalent	Description
ifconfig	ip a or ip addr show	Show all interface addresses and details
ifconfig -a	ip a	Show all interfaces (including inactive)
ifconfig eth0	ip a show eth0	Show specific interface
sudo ifconfig eth0 up	sudo ip link set eth0 up	Bring interface up
sudo ifconfig eth0 down	sudo ip link set eth0 down	Bring interface down
sudo ifconfig eth0 1.2.3.4	sudo ip addr add 1.2.3.4/24 dev eth0	Add IP address
sudo ifconfig eth0:0 1.2.3.4	sudo ip addr add 1.2.3.4/24 dev eth0 label eth0:0	Add IP alias
sudo ifconfig eth0 del 1.2.3.4	sudo ip addr del 1.2.3.4/24 dev eth0	Delete IP address
sudo ifconfig eth0 hw ether ...	sudo ip link set dev eth0 address ...	Change MAC address
sudo ifconfig eth0 mtu 1500	sudo ip link set dev eth0 mtu 1500	Set MTU
route -n (routing table)	ip r or ip route show	Show routing table

Export to Sheets
When to use ifconfig?
Quick Checks: For basic viewing of IP addresses and interface status on systems where ip might not be immediately familiar or if you're working on an older system.

Legacy Systems: When administering older Linux distributions or embedded systems that might not have iproute2 installed or where ifconfig is the primary tool.

Specific Troubleshooting: Sometimes, a particular error message or troubleshooting guide might refer to ifconfig.

Recommendation: For modern Linux systems and for more advanced network management, learn and use the ip command. It is more powerful, consistent, and provides more detailed information. However, ifconfig remains a valuable tool to be aware of in your Linux skillset.
```