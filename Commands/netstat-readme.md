
---

Let me know if you'd like the newer `ip` command tutorial in `.md` format too!







You said:
linux netstat tutorial in .md format so that it can be  pasted


ChatGPT said:
Here is a complete Linux netstat command tutorial in .md (Markdown) format, ready to  and paste:

markdown


# Linux `netstat` Command Tutorial

The `netstat` (network statistics) command is used to **monitor network connections**, **routing tables**, **interface statistics**, **masquerade connections**, and **multicast memberships**.

> ⚠️ Note: `netstat` is considered deprecated and replaced by the `ss` and `ip` commands in modern Linux distributions, but it’s still widely used and available via the `net-tools` package.

---

## 📌 Syntax

```
netstat [OPTIONS]
📘 Commonly Used Options
Option	Description
-a	Show all connections and listening ports
-t	Show TCP connections
-u	Show UDP connections
-n	Show numerical addresses instead of resolving hostnames
-l	Show only listening ports
-p	Show PID and name of the program using the socket
-r	Display the kernel routing table
-i	Show network interface statistics
-s	Show summary statistics by protocol
-c	Continuously display the output (refreshes every second)

🔍 Examples
1. Show all listening ports



netstat -l
2. Show all TCP connections



netstat -at
3. Show all UDP connections



netstat -au
4. Show connections without hostname resolution



netstat -n
5. Show programs using each connection



sudo netstat -tulpn
6. Show the routing table



netstat -r
7. Show network interface statistics



netstat -i
8. Show protocol-specific statistics



netstat -s
 Output Columns (for netstat -tulpn)
Column	Description
Proto	Protocol (TCP or UDP)
Recv-Q	Received queue length
Send-Q	Send queue length
Local Address	IP address and port of the local socket
Foreign Address	IP and port of the remote socket
State	State of the connection (e.g., LISTEN, ESTABLISHED)
PID/Program name	Process ID and program name

 Deprecation Warning
netstat is part of the net-tools package which is deprecated.

Use the modern alternative ss:




ss -tuln
 Related Commands
ss – Display sockets (modern alternative to netstat)

lsof -i – List open files and associated Internet connections

ip a – Show IP addresses

ip r – Show routing table

nmap – Network port scanner

