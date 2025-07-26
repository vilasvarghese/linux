Markdown

# Linux `whois` and `finger` Command Tutorial (Detailed)

This tutorial covers two commands, `whois` and `finger`, which are used to query information about users and network resources. While `whois` is widely used for domain and IP information, `finger` is an older command for user information, less common on modern, security-conscious systems.

---

## 1. `whois` Command Tutorial

The `whois` command is a client for the Whois directory service protocol. It's primarily used to query databases that store information about registered domain names, IP addresses, and autonomous system numbers (ASNs). This information typically includes details about the registrant, administrative and technical contacts, registration dates, and nameservers.

### Basic Syntax

```bash
whois [OPTIONS] OBJECT
OBJECT: The domain name, IP address, or ASN you want to query.

How whois Works
When you run whois, your system connects to a Whois server (a database server) responsible for the queried OBJECT. For example, if you query example.com, whois first looks up the Whois server for .com domains (e.g., whois.verisign-grs.com), then queries that server. If the information is delegated to another registrar, it might follow a chain of queries. The server then returns the public information associated with that OBJECT.

Examples and Use Cases
a) Query a Domain Name
Bash

whois google.com
Output (excerpt - highly verbose, will vary):

Domain Name: GOOGLE.COM
Registry Domain ID: 2138514_DOMAIN_COM-VRSN
Registrar WHOIS Server: whois.markmonitor.com
Registrar URL: [http://www.markmonitor.com](http://www.markmonitor.com)
Updated Date: 2024-05-13T16:00:23Z
Creation Date: 1997-09-15T04:00:00Z
Registry Expiry Date: 2028-09-14T04:00:00Z
Registrar: MarkMonitor Inc.
Registrar IANA ID: 292
Registrar Abuse Contact Email: abusecomplaints@markmonitor.com
Registrar Abuse Contact Phone: +1.2083895740
Domain Status: clientDeleteProhibited [https://icann.org/epp#clientDeleteProhibited](https://icann.org/epp#clientDeleteProhibited)
Domain Status: clientTransferProhibited [https://icann.org/epp#clientTransferProhibited](https://icann.org/epp#clientTransferProhibited)
Domain Status: clientUpdateProhibited [https://icann.org/epp#clientUpdateProhibited](https://icann.org/epp#clientUpdateProhibited)
Name Server: NS1.GOOGLE.COM
Name Server: NS2.GOOGLE.COM
Name Server: NS3.GOOGLE.COM
Name Server: NS4.GOOGLE.COM
DNSSEC: unsigned
URL of the ICANN Whois Inaccuracy Complaint Form: [https://www.icann.org/wicf/](https://www.icann.org/wicf/)
>>> Last update of WHOIS database: 2025-07-26T03:00:00Z <<<

For more information on Whois status codes, please visit [https://icann.org/epp](https://icann.org/epp)
Common fields you'll see:

Domain Name: The queried domain.

Registrar: The company through which the domain was registered.

Creation Date: When the domain was first registered.

Updated Date: Last time the registration information was updated.

Registry Expiry Date: When the domain registration expires.

Name Server: DNS servers responsible for resolving the domain.

Registrant/Admin/Tech Contact: (May be redacted due to privacy regulations like GDPR, showing "Redacted for Privacy" or a proxy service). If available, this would show contact names, organizations, addresses, emails, and phone numbers.

Domain Status: Status codes indicating the domain's current state (e.g., clientTransferProhibited).

b) Query an IP Address
Bash

whois 8.8.8.8
Output (excerpt):

NetRange:       8.8.8.0 - 8.8.8.255
CIDR:           8.8.8.0/24
NetName:        LVLT-GOGL-8-8-8
Organization:   Google LLC (GOGL)
OrgId:          GOGL
Address:        1600 Amphitheatre Parkway
City:           Mountain View
StateProv:      CA
PostalCode:     94043
Country:        US
RegDate:        2009-02-24
Updated:        2012-02-24
Ref:            [https://rdap.arin.net/registry/entity/GOGL](https://rdap.arin.net/registry/entity/GOGL)

OrgName:        Google LLC
OrgId:          GOGL
Address:        1600 Amphitheatre Parkway
City:           Mountain View
StateProv:      CA
PostalCode:     94043
Country:        US
TechHandle:     GOOG-ARIN
TechName:       Google LLC
TechPhone:      +1-650-253-0000
TechEmail:      arin-contact@google.com
...
For IP addresses, whois queries regional internet registries (RIRs) like ARIN (North America), RIPE (Europe), APNIC (Asia-Pacific), AFRINIC (Africa), LACNIC (Latin America). The output shows the allocated IP range, the organization it belongs to, contact information, and registration dates.

c) Query an Autonomous System Number (ASN)
ASNs are unique numbers assigned to autonomous systems (networks of IP prefixes operated by one or more network operators with a single, clearly defined external routing policy).

Bash

whois AS15169 # Google's ASN
Output (excerpt):

aut-num:        AS15169
as-name:        GOOGLE
descr:          Google LLC
org:            ORG-GOL2-ARIN
import:         from AS39414 action pref=100; accept ANY
export:         to AS39414 announce AS15169
...
d) Specifying a Whois Server (-h)
Sometimes you might need to query a specific Whois server directly, especially for certain TLDs or if the automatic lookup fails.

Bash

whois -h whois.nic.in example.in # Query the .in Whois server
e) Limiting Output (-H or -r)
Some Whois servers return very verbose output, including disclaimer texts.

-H (or --no-recurse): Prevents recursive lookups and prints raw output from the first server.

-r (or --raw): Equivalent to -H.

Bash

whois -H example.com
When to use whois?
Domain Ownership: To find out who owns a domain, their contact information (if public), and when it expires.

IP Address Allocation: To identify the organization or ISP that owns a specific IP address block.

Network Troubleshooting: Useful for identifying the responsible parties for a given IP range or domain when investigating network issues or abuse.

Security Research: Understanding network infrastructure and ownership.

2. finger Command Tutorial
The finger command is an older utility used to look up information about users on a specific system. It fetches information like login name, real name, terminal name, idle time, login time, and sometimes even the user's home directory and shell.

Important Note: finger relies on a finger daemon (fingerd) running on the target system (port 79). Due to security and privacy concerns, fingerd is rarely enabled on modern public-facing systems. Therefore, finger is largely obsolete for querying remote users over the internet, but can still be useful on private, internal networks or local systems (if enabled).

Basic Syntax
Bash

finger [OPTIONS] [USER@HOST]
USER: The username to query.

HOST: The hostname or IP address of the system to query.

How finger Works
When finger is used, it attempts to connect to the fingerd service on the specified host (or localhost if no host is given). If fingerd is running and configured to provide information, it returns details about the requested user(s).

Examples and Use Cases
Let's assume fingerd is running on a hypothetical local network server or your own Linux machine (for USER queries).

a) Finger your own user on the local system
Bash

finger $(whoami)
Output (example - varies based on system and configuration):

Login: user         Name: Linux User
Directory: /home/user           Shell: /bin/bash
On since Fri Jul 25 10:30 (IST) on :0 (messages off)
1 hour 25 minutes idle
No Plan.
Login: Username

Name: Real name (from /etc/passwd or similar).

Directory: Home directory.

Shell: Default shell.

On since: Login time and terminal.

Idle: How long the user has been inactive.

No Plan/Plan: Some systems allowed users to put a .plan file in their home directory, which finger would display.

b) Finger another user on the local system
Bash

finger root
Output (example):

Login: root          Name: root
Directory: /root                Shell: /bin/bash
Never logged in.
No Plan.
c) Finger all logged-in users on the local system
Bash

finger
Output (example):

Login     Name       Tty      Idle  Login Time   Office     Office Phone
user      Linux User :0       1h 25m Jul 25 10:30
otheruser Other User pts/0      5m  Jul 25 12:00
This output is similar to what you might get from w or who.

d) Finger a user on a remote host (rarely works on public internet)
Bash

finger user@example.com
finger sysadmin@192.168.1.10
Most public internet servers will either not have fingerd running or will block port 79 for security reasons. If it works, the output would be similar to local queries but for the remote user.

e) Suppress .plan and .project files (-p)
If a user has .plan or .project files in their home directory, finger displays them. The -p option suppresses this.

Bash

finger -p user
When to use finger?
Local Network/Internal Systems: Primarily useful on controlled internal networks where fingerd might be intentionally enabled for internal user lookup or system administration.

Legacy Systems: When working with older Unix systems where finger was more prevalent.

Curiosity/Obsolete: For historical context or to understand how older systems worked.

Due to privacy concerns and security risks (information leakage, potential for DoS attacks), fingerd is almost always disabled on modern internet-facing systems. For general user information, tools like w, who, last, id, and system-specific directory services are used instead.
```