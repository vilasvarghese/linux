Markdown

# Linux `netstat` Command Tutorial

The `netstat` (network statistics) command is a command-line utility for displaying network connections (both incoming and outgoing), routing tables, interface statistics, masquerade connections, and multicast memberships. While `netstat` is considered a legacy tool and has been superseded by the `ss` command in modern Linux distributions (especially with `iproute2` suite), it is still widely available and understood, making it useful for troubleshooting network issues.

## Basic Syntax

```
netstat [OPTION]...
Key Information Displayed by netstat
netstat can show various types of network information:

Active TCP connections: Established, listening, TIME_WAIT, etc.

Active UDP connections: Open UDP ports.

Listening sockets: Ports on which the system is waiting for incoming connections.

Routing tables: The kernel's IP routing information.

Network interface statistics: Data packets sent/received, errors, etc.

Unix domain sockets: Sockets used for inter-process communication on the same host.

Common Options and Examples
1. Display All Active Connections and Listening Ports (Numeric Output)
This is one of the most common uses.

-a (or --all): Displays all active TCP connections and all listening TCP and UDP ports.

-n (or --numeric): Displays numerical addresses and port numbers instead of trying to determine hostnames and service names. This speeds up the output and avoids DNS lookups.



netstat -an
Output Explanation (simplified):

Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 0.0.0.0:22              0.0.0.0:* LISTEN     # SSH server listening on all interfaces
tcp        0      0 127.0.0.1:25            0.0.0.0:* LISTEN     # Mail server listening on localhost
tcp        0      0 192.168.1.100:22        192.168.1.1:54321       ESTABLISHED # Active SSH connection
tcp6       0      0 :::80                   :::* LISTEN     # IPv6 web server listening
udp        0      0 0.0.0.0:68              0.0.0.0:* # DHCP client port
Proto: Protocol (tcp, udp, tcp6, udp6).

Recv-Q: The count of bytes not copied by the user program connected to this socket.

Send-Q: The count of bytes not acknowledged by the remote host.

Local Address: The local IP address and port number.

Foreign Address: The remote IP address and port number.

State: The state of the TCP connection (e.g., LISTEN, ESTABLISHED, TIME_WAIT, CLOSE_WAIT). UDP has no state.

2. Display Listening Ports Only
-l (or --listening): Displays only listening sockets.



netstat -lntu
l: Listening sockets.

n: Numeric addresses/ports.

t: TCP connections.

u: UDP connections.

Output:

Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 0.0.0.0:22              0.0.0.0:* LISTEN
tcp        0      0 127.0.0.1:631           0.0.0.0:* LISTEN
udp        0      0 0.0.0.0:68              0.0.0.0:*
3. Display Process ID (PID) and Program Name
-p (or --programs): Shows the PID and program name for each socket. You usually need root privileges (sudo) for this, especially for processes owned by other users.



sudo netstat -anp | less
This is extremely useful for identifying which process is using a specific port.

Output (excerpt):

Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:22              0.0.0.0:* LISTEN      1000/sshd
tcp        0      0 127.0.0.1:3306          0.0.0.0:* LISTEN      1500/mysqld
tcp        0      0 127.0.0.1:9000          0.0.0.0:* LISTEN      2000/php-fpm
4. Display TCP Connections Only


netstat -at
Displays only TCP connections (active and listening).

5. Display UDP Connections Only


netstat -au
Displays only UDP connections (active and listening).

6. Display Routing Table
-r (or --route): Displays the kernel IP routing table.



netstat -r
Output:

Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         _gateway        0.0.0.0         UG    100    0        0 ens33  # Default route
192.168.1.0     0.0.0.0         255.255.255.0   U     100    0        0 ens33  # Local network
7. Display Network Interface Statistics
-i (or --interfaces): Displays a table of all network interfaces, showing details like MTU, packets sent/received, errors, etc.

-e (or --extend): Displays more extensive information.



netstat -ie
Output (excerpt):

Iface      MTU    RX-OK RX-ERR RX-DRP RX-OVR    TX-OK TX-ERR TX-DRP TX-OVR Flg
ens33     1500    92345      0      0      0    67890      0      0      0 BMRU
lo        65536   12345      0      0      0    12345      0      0      0 LRU
8. Display Unix Domain Sockets
-x (or --unix): Displays Unix domain sockets.



netstat -ax
9. Filtering Output with grep
You can combine netstat with grep to filter for specific ports, protocols, or states.

Find out who is listening on port 80 (HTTP):



sudo netstat -anp | grep ":80"
Check for specific connection states (e.g., TIME_WAIT):



netstat -an | grep "TIME_WAIT"
A high number of TIME_WAIT connections can sometimes indicate a problem with client/server closing connections or a high volume of short-lived connections.

Find connections to a specific remote IP:



netstat -an | grep "192.168.1.50"
Legacy Status and Alternatives (ss)
While netstat is still prevalent, the ss command (Socket Statistics) from the iproute2 suite is the modern, more efficient, and feature-rich replacement. It's faster for large tables and provides more detailed information.

Basic ss equivalents:

netstat -an 
rightarrow ss -an

netstat -lntu 
rightarrow ss -lntu

netstat -anp 
rightarrow sudo ss -anp

netstat -r 
rightarrow ip route or ss -r

netstat -i 
rightarrow ip -s link or ss -i

Example of ss for port 80:



sudo ss -lntp | grep ":80"
Why ss is preferred:

Performance: ss is generally faster, especially on systems with many connections, because it retrieves information directly from kernel data structures rather than parsing /proc files.

More Features: ss offers more advanced filtering and information display (e.g., TCP congestion control information).

Conclusion
netstat is a powerful tool for network troubleshooting and monitoring on Linux systems. While modern systems recommend ss, understanding netstat remains valuable due to its widespread usage. When in doubt, start with netstat -anp (with sudo for PID/program names) to get a comprehensive overview of your system's network activity.
```