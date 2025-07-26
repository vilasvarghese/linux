Markdown

# Linux `ip` Command Tutorial (Detailed)

The `ip` command is a powerful, modern, and comprehensive command-line utility in Linux for managing and configuring network interfaces, routing, and tunnels. It is part of the `iproute2` suite and has largely replaced older, less powerful tools like `ifconfig`, `route`, and `netstat`. The `ip` command offers a more consistent syntax and provides more detailed and efficient control over the network stack.

## Basic Syntax

The `ip` command follows a consistent object-oriented syntax:

```bash
ip [OPTIONS] OBJECT COMMAND [ARGUMENTS]
OPTIONS: General ip command options (e.g., -V for version, -s for statistics).

OBJECT: The type of network object you want to manage. Common objects include:

addr (or address): IP addresses.

link: Network interfaces (physical or virtual).

route: Routing table entries.

neigh (or neighbour): ARP/NDP cache entries.

rule: Routing policy database rules.

monitor: Monitor changes in network state.

COMMAND: The action to perform on the object (e.g., show, add, del, set).

ARGUMENTS: Specific parameters for the command (e.g., interface name, IP address, device, metric).

Essential ip Objects and Commands
1. ip link (Network Interface Management)
Used to view and manipulate network devices (interfaces).

a) Display All Network Interfaces
Bash

ip link show
# or simply
ip link
This lists all network interfaces, their states (UP/DOWN), MAC addresses, MTU, and other link-layer details.

Output Explanation (simplified):

1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:00:00:00 brd ff:ff:ff:ff:ff:ff
1: lo: Interface index and name (loopback).

<LOOPBACK,UP,LOWER_UP>: Flags indicating interface capabilities and current state (UP means administratively up, LOWER_UP means link is physically up).

mtu 65536: Maximum Transmission Unit.

qdisc noqueue: Queuing discipline.

state UNKNOWN: Current operational state.

link/loopback / link/ether: Link layer type and MAC address.

b) Display Statistics for an Interface
Use the -s (statistics) option. Repeat -s for more details.

Bash

ip -s link show eth0
# or for more verbose stats
ip -s -s link show eth0
c) Bring an Interface Up or Down
Requires root privileges.

Bash

sudo ip link set eth0 up
sudo ip link set eth0 down
d) Change an Interface's MAC Address
Requires root privileges. The interface should usually be down first.

Bash

sudo ip link set eth0 down
sudo ip link set eth0 address 00:11:22:33:44:55
sudo ip link set eth0 up
e) Change an Interface's MTU
Requires root privileges.

Bash

sudo ip link set eth0 mtu 1400
2. ip addr (IP Address Management)
Used to view and manipulate IP addresses assigned to interfaces.

a) Display All IP Addresses
Bash

ip addr show
# or simply
ip a
This shows IP addresses (IPv4 and IPv6), netmasks, broadcast addresses, and scope for all interfaces.

Output Explanation (simplified for eth0):

2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:00:00:00 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.100/24 brd 192.168.1.255 scope global dynamic eth0
       valid_lft 86058sec preferred_lft 86058sec
    inet6 fe80::a00:27ff:fe00:0/64 scope link
       valid_lft forever preferred_lft forever
inet 192.168.1.100/24: IPv4 address with CIDR netmask (/24 means 255.255.255.0).

brd 192.168.1.255: Broadcast address.

scope global: Address is globally reachable.

dynamic: Address obtained via DHCP.

valid_lft / preferred_lft: Lifetime of the address (for DHCP/SLAAC).

b) Display IP Addresses for a Specific Interface
Bash

ip addr show eth0
# or
ip a show eth0
c) Add an IP Address to an Interface
Requires root privileges. Specify the address in CIDR notation.

Bash

sudo ip addr add 192.168.1.150/24 dev eth0
# For IPv6
sudo ip addr add 2001:db8::1/64 dev eth0
This adds the IP address. If the interface is down, it will still show as "down" but the address will be assigned.

d) Add a Secondary IP Address (IP Alias)
No special eth0:0 syntax is needed like with ifconfig. Simply add another IP.

Bash

sudo ip addr add 192.168.1.200/24 dev eth0
When using ip a show eth0, you will see multiple inet lines for eth0.

e) Delete an IP Address from an Interface
Requires root privileges.

Bash

sudo ip addr del 192.168.1.150/24 dev eth0
3. ip route (Routing Table Management)
Used to view and manipulate the kernel's IP routing table.

a) Display the Main Routing Table
Bash

ip route show
# or simply
ip r
This lists all known routes (destination networks, gateways, and interfaces).

Output Explanation (simplified):

default via 192.168.1.1 dev eth0 proto dhcp metric 100
192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.100 metric 100
default: The default route (traffic to destinations not explicitly listed in other routes).

via 192.168.1.1: Gateway IP address.

dev eth0: Outgoing interface.

proto dhcp: Protocol by which the route was installed (e.g., dhcp, kernel, static).

metric 100: Route metric (cost).

192.168.1.0/24: Destination network.

scope link: Route applies to directly connected network.

src 192.168.1.100: Source IP address used for this route.

b) Add a Default Gateway
Requires root privileges.

Bash

sudo ip route add default via 192.168.1.1
If you already have a default route (e.g., from DHCP), you might need to delete it first: sudo ip route del default.

c) Add a Static Route to a Specific Network
Requires root privileges.

Bash

sudo ip route add 10.0.0.0/8 via 192.168.1.254 dev eth0
This tells the system that to reach any address in the 10.0.0.0/8 network, send traffic to 192.168.1.254 via eth0.

d) Delete a Route
Requires root privileges.

Bash

sudo ip route del 10.0.0.0/8 via 192.168.1.254 dev eth0
sudo ip route del default via 192.168.1.1
4. ip neigh (ARP/NDP Cache Management)
Used to view and manipulate the ARP (IPv4) or NDP (IPv6) cache, which maps IP addresses to MAC addresses.

a) Display ARP/NDP Cache
Bash

ip neigh show
# or simply
ip n
Output:

192.168.1.1 dev eth0 lladdr 00:50:56:c0:00:08 REACHABLE
192.168.1.10 dev eth0 lladdr 08:00:27:ab:cd:ef STALE
192.168.1.1: IP address.

dev eth0: Interface.

lladdr 00:50:56:c0:00:08: Link Layer (MAC) address.

REACHABLE / STALE: State of the entry.

b) Add a Static ARP Entry
Requires root privileges.

Bash

sudo ip neigh add 192.168.1.200 lladdr 00:00:00:AA:BB:CC dev eth0
Useful for security or to ensure a specific MAC address is used for an IP.

c) Delete an ARP Entry
Requires root privileges.

Bash

sudo ip neigh del 192.168.1.200 dev eth0
5. ip rule (Routing Policy Database)
Used for advanced routing scenarios, allowing for policy-based routing where routing decisions are made based on more than just the destination IP (e.g., source IP, firewall marks).

a) Show Routing Rules
Bash

ip rule show
# or
ip rule
6. ip monitor (Real-time Monitoring)
Monitors changes in network configuration (links, addresses, routes, neighbours) in real-time.

Bash

ip monitor
Press Ctrl+C to stop. This is excellent for debugging network configuration changes as they happen.

Important ip Options
-s (or --stats): Display statistics. Use multiple -s for more details (-s -s).

-c (or --color): Use colorized output.

-json: Output in JSON format.

-details: Show more details in output.

-4 (or -6): Restrict output to IPv4 or IPv6 respectively.

-f FAMILY (or --family FAMILY): Restrict to specific address family (inet for IPv4, inet6 for IPv6, link for link layer).

Persistence of ip Commands
Important: Most ip commands executed directly on the command line are temporary and will be lost after a system reboot or network service restart.

For permanent network configurations, you must:

Edit Network Configuration Files: The exact location varies by Linux distribution.

Debian/Ubuntu: /etc/network/interfaces

Red Hat/CentOS/Fedora: /etc/sysconfig/network-scripts/ifcfg-ethX

Modern distributions often use systemd-networkd or NetworkManager.

systemd-networkd: Configuration files in /etc/systemd/network/

NetworkManager: CLI tool nmcli or GUI tools.

Use Network Management Tools:

nmcli (NetworkManager CLI)

nmtui (NetworkManager Text User Interface)

When to use ip?
Modern Linux Systems: The preferred tool for network configuration and troubleshooting.

Scripting: Its consistent syntax and rich output make it ideal for automation.

Detailed Network Information: Provides more granular detail than ifconfig.

Advanced Networking: Essential for configuring bonding, bridging, VLANs, policy routing, and more.

The ip command is a foundational tool for any Linux administrator or power user. Its consistent structure and comprehensive capabilities make it a clear choice over its older counterparts. While the initial learning curve might be slightly steeper than ifconfig, the benefits in functionality and efficiency are well worth the effort.

```