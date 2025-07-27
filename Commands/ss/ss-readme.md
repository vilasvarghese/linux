Markdown

# Linux `ss` Command Tutorial (Detailed)

The `ss` (socket statistics) command is a powerful, modern utility in Linux used to display information about network sockets. It's designed to be a faster and more comprehensive replacement for the older `netstat` command, especially on systems with a large number of active connections. `ss` can show statistics for TCP, UDP, raw, and Unix domain sockets, providing detailed information about network connections, routing tables, and interface statistics.

## Basic Syntax

```bash
ss [OPTIONS] [FILTER]
OPTIONS: Control the type and format of information displayed.

FILTER: Optional expressions to filter the output based on states, addresses, ports, etc.

How ss Works
ss retrieves its information directly from the kernel's network stack via Netlink sockets, which is a more efficient mechanism than netstat's reliance on parsing /proc filesystem entries. This efficiency makes ss particularly well-suited for high-load servers.

Common Options
-t (or --tcp): Display TCP sockets.

-u (or --udp): Display UDP sockets.

-x (or --unix): Display Unix domain sockets.

-l (or --listening): Display only listening sockets.

-a (or --all): Display all sockets (both listening and non-listening).

-n (or --numeric): Do not try to resolve service names or hostnames. Display numeric addresses and port numbers. This speeds up output.

-p (or --processes): Show the process ID (PID) and name of the process that owns the socket. Requires root privileges for full details.

-e (or --extended): Show extended information, such as user, inode, and security context.

-m (or --memory): Show socket memory usage.

-i (or --info): Show internal TCP information (e.g., recv-q, send-q, wscale, rtt, rto). This is incredibly useful for debugging performance.

-o (or --options): Show socket timer information.

-s (or --summary): Display summary statistics for each socket type.

-r (or --resolve): Resolve numeric addresses/ports to hostnames/service names (opposite of -n).

Socket States
You'll often see various TCP states in ss output:

LISTEN: The socket is listening for incoming connections.

ESTAB: The socket has an established connection.

SYN-SENT: A connection request has been sent.

SYN-RECV: A connection request has been received.

FIN-WAIT1: The socket is closed, and the connection is half-closed.

FIN-WAIT2: The connection is closed, and the socket is waiting for the remote end to terminate the connection.

TIME-WAIT: The socket is waiting for enough time to pass to ensure that the remote host received the acknowledgment of its connection termination request.

CLOSE: The socket is not being used.

CLOSE-WAIT: The remote end has shut down, waiting for the socket to close.

LAST-ACK: The remote end has shut down, and the socket is closed, waiting for an acknowledgment.

UNCONN: Unconnected (for UDP).

Examples and Use Cases
1. Display All TCP Sockets (Listening and Established)
Bash

ss -t
This is equivalent to ss -ta if you want to be explicit about all TCP sockets.

2. Display All Listening TCP Sockets
Bash

ss -lt
Example Output:

State      Recv-Q Send-Q      Local Address:Port      Peer Address:Port
LISTEN     0      128         0.0.0.0:ssh             0.0.0.0:*
LISTEN     0      5           127.0.0.1:ipp           0.0.0.0:*
LISTEN     0      128             [::]:ssh                [::]:*
You can see ssh listening on both IPv4 (0.0.0.0) and IPv6 (::) on standard SSH port (22), and ipp (CUPS printing service) on localhost.

3. Display All UDP Sockets
Bash

ss -u
# or for listening UDP sockets:
ss -lu
4. Display All Established Connections (TCP)
Bash

ss -t state established
Example Output:

State      Recv-Q Send-Q       Local Address:Port         Peer Address:Port
ESTAB      0      0            192.168.1.100:ssh          192.168.1.1:60123
ESTAB      0      0            192.168.1.100:443          172.217.160.10:https
5. Display All Sockets with Process Information (-p)
This is one of the most useful features. Requires sudo for full process details.

Bash

sudo ss -lptn
# Display all listening TCP sockets, with process info, numeric ports/addresses
Example Output:

State      Recv-Q Send-Q      Local Address:Port      Peer Address:Port
LISTEN     0      128         0.0.0.0:22              0.0.0.0:* users:(("sshd",pid=789,fd=3))
LISTEN     0      5           127.0.0.1:631           0.0.0.0:* users:(("cupsd",pid=543,fd=7))
You can see sshd (PID 789) listening on port 22 and cupsd (PID 543) listening on port 631.

6. Display Socket Memory Usage (-m)
Bash

ss -m
This can help identify applications consuming a lot of socket buffer memory.

7. Display TCP Info (-i) - Excellent for Debugging
This option provides detailed internal information about TCP connections, which is invaluable for network troubleshooting and performance analysis.

Bash

ss -ti
Example Output (for an established connection):

State      Recv-Q Send-Q Local Address:Port   Peer Address:Port
ESTAB      0      0      192.168.1.100:54321  1.2.3.4:443
     skmem:(r0,rb87380,t0,tb87380,f0,w0,p0,d0)
     timer:(keepalive,42min,0)
     rto:204 rtt:147.25/1.125 ato:40 mss:1448 pmtu:1500 rcvmss:536 rcvwnd:65535
     wscale:7,7 unacked:1 retrans:0/0
     cwnd:10 bytes_acked:38379 bytes_received:38507 segs_out:16 segs_in:17
     data_recv:38507 data_sent:38379 send_timeout:3
Key fields from -i:

Recv-Q: Receive queue (bytes) - data received but not yet read by the application.

Send-Q: Send queue (bytes) - data sent by the application but not yet acknowledged by the peer.

rto: Retransmission Timeout (ms).

rtt: Round Trip Time (ms) - average/deviation.

cwnd: Congestion Window size.

bytes_acked: Total bytes acknowledged by peer.

bytes_received: Total bytes received.

8. Display Socket Summary (-s)
Get a quick overview of socket usage.

Bash

ss -s
Example Output:

Total: 345 (kernel 372)
TCP:   9 (estab 4, closed 0, orphaned 0, synrecv 0, timewait 0/0), ports 0

Transport Total     IP        IPv6
* UDP     10        7         3
* TCP     9         6         3
* RAW     0         0         0
* IP FRAG 0         0         0
9. Filtering Output
You can filter ss output using various criteria.

a) Filter by Port Number
Bash

ss -ltn 'sport = :80'        # Listening TCP sockets on source port 80
ss -ltn 'dport = :443'       # Listening TCP sockets on destination port 443 (less common for listening)
ss -tn '( sport = :80 or dport = :80 )' # All TCP sockets (both ends) involving port 80
b) Filter by Address and Port
Bash

ss -tn 'src 192.168.1.100:ssh'     # Connections originating from local IP 192.168.1.100 on SSH port
ss -tn 'dst 1.2.3.4:https'         # Connections destined for 1.2.3.4 on HTTPS port
c) Filter by State
Bash

ss -nt 'state time-wait'         # Show all TCP sockets in TIME-WAIT state
ss -nt 'state ( established or syn-sent )' # Show established or SYN-SENT states
d) Filter by Process User
Bash

sudo ss -p user root              # Show sockets owned by root (requires root for -p)
sudo ss -p user apache            # Show sockets owned by user 'apache'
e) Combine Filters
Bash

sudo ss -atn '( sport = :80 or sport = :443 ) or ( dport = :80 or dport = :443 )'
This shows all active (listening and non-listening) TCP sockets, numerically, where either the source or destination port is 80 or 443.

10. Unix Domain Sockets (-x)
Unix domain sockets are used for inter-process communication (IPC) on the same host.

Bash

ss -x
ss -lx # Listing listening Unix domain sockets
ss -xp # With process info
Example Output for ss -lx:

State      Recv-Q Send-Q     Local Address:Port    Peer Address:Port
LISTEN     0      4096      /run/user/1000/systemd/private 0
LISTEN     0      128       /run/dbus/system_bus_socket 0
ss vs. netstat
Feature	netstat (Older)	ss (Newer)
Performance	Slower, especially on busy systems	Faster, more efficient (uses Netlink)
Information	Good, but less detailed TCP info	More comprehensive, especially with -i
Default Usage	Still widely taught and used, but deprecated	Recommended for modern Linux systems
Syntax	Often slightly different options for similar tasks	More consistent and intuitive options
Availability	Usually installed by default (net-tools package)	Usually installed by default (iproute2 package)

Export to Sheets
While netstat is still prevalent, ss is the technically superior and recommended tool for network socket introspection on contemporary Linux systems.

Conclusion
The ss command is an indispensable tool for network administrators, developers, and anyone troubleshooting network connectivity or performance issues on Linux. Its speed, detailed output, and powerful filtering capabilities make it a clear winner over its predecessor netstat for in-depth socket analysis.
```