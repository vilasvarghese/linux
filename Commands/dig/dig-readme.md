Markdown

# Linux `dig` Command Tutorial (Detailed)

The `dig` (Domain Information Groper) command is a powerful and flexible command-line tool for querying DNS (Domain Name System) name servers. 
It's an essential utility for system administrators, network engineers, and developers to troubleshoot DNS issues, 
	verify DNS records, and understand how domain names are resolved.

`dig` is part of the `bind-utils` (on Red Hat/CentOS/Fedora) or `dnsutils` (on Debian/Ubuntu) package.

## Basic Syntax

```bash
dig [@server] [name] [type] [options]
@server: (Optional) Specifies the IP address or hostname of the DNS server you want to query. If omitted, dig uses the DNS servers configured in /etc/resolv.conf.

name: The domain name, hostname, or IP address you want to look up.

type: (Optional) 
	The type of DNS record you want to query 
		(e.g., A, MX, NS, SOA, PTR, ANY). 
	If omitted, dig defaults to A (IPv4 address) records.

options: Control the output and behavior of the dig command.

How dig Works
dig sends DNS queries to specified (or default) DNS servers and displays the responses received. It provides a detailed output, including the query sent, the answer section, authority section, and additional section, along with query statistics. This level of detail is often more comprehensive than simpler tools like host or nslookup.

Common DNS Record Types
Understanding these types will help you utilize dig effectively:

A (Address): Maps a domain name to an IPv4 address.

AAAA (IPv6 Address): Maps a domain name to an IPv6 address.

MX (Mail Exchange): Specifies the mail servers responsible for accepting email messages on behalf of a domain.

NS (Name Server): Specifies the authoritative name servers for a domain.

SOA (Start of Authority): Provides authoritative information about a DNS zone, including the primary name server, administrator's email, serial number, and various timers.

PTR (Pointer): Used for reverse DNS lookups (mapping an IP address to a domain name).

CNAME (Canonical Name): Creates an alias from one domain name to another.

TXT (Text): Stores arbitrary text data, often used for SPF, DKIM, DMARC records (for email authentication) or for domain verification.

SRV (Service): Specifies the location (hostname and port number) of servers for specific services (e.g., SIP, XMPP).

ANY: Requests all available record types for a domain.

Common Options
+short: Displays a concise output, showing only the answer(s). Ideal for scripting.

+noall +answer: Shows only the answer section. Useful for specific details without all the extra info.

+trace: Traces the delegation path from the root name servers, showing the resolution process.

+noshort: (Default) Shows the full, verbose output.

+norecurse: Disables recursive queries. dig will only query the specified server directly and not ask it to query other servers.

+vc: Force dig to use TCP instead of UDP for the query. Useful for large responses (like zone transfers) or if UDP is unreliable.

+domain=NAME: Appends NAME to name if name doesn't contain a dot.

+search: Use the domain search list (from /etc/resolv.conf). (Default)

+nosearch: Do not use the domain search list.

+time=SECONDS: Set the query timeout (default is 5 seconds).

Examples and Use Cases
1. Basic A Record Lookup
Find the IPv4 address for google.com.

Bash

dig google.com
Output Breakdown (Key Sections):

HEADER: Shows query ID, flags (e.g., qr for query response, rd for recursion desired, ra for recursion available).

QUESTION SECTION: Shows the query made (google.com. IN A).

ANSWER SECTION: This is where the actual DNS records are found.

google.com. 299 IN A 142.250.193.174 (Domain, TTL, Record Type, IPv4 Address)

AUTHORITY SECTION: Lists the authoritative name servers for the queried domain.

ADDITIONAL SECTION: Provides IP addresses for the name servers listed in the authority section.

Query time: How long the query took.

SERVER: The DNS server that answered the query.

WHEN: Timestamp of the query.

MSG SIZE: Size of the DNS response message.

2. Querying a Specific DNS Server
Query google.com using Google's public DNS server (8.8.8.8).

Bash

dig @8.8.8.8 google.com
3. AAAA Record Lookup (IPv6)
Find the IPv6 address for google.com.

Bash

dig google.com AAAA
4. MX Record Lookup (Mail Servers)
Find the mail exchange servers for google.com.

Bash

dig google.com MX
Example Output (Answer Section):

;; ANSWER SECTION:
google.com.        300     IN      MX      50 alt4.aspmx.l.google.com.
google.com.        300     IN      MX      10 aspmx.l.google.com.
google.com.        300     IN      MX      20 alt1.aspmx.l.google.com.
google.com.        300     IN      MX      30 alt2.aspmx.l.google.com.
google.com.        300     IN      MX      40 alt3.aspmx.l.google.com.
The numbers (10, 20, 30, etc.) are preference values; lower numbers are preferred.

5. NS Record Lookup (Name Servers)
Find the authoritative name servers for google.com.

Bash

dig google.com NS
6. SOA Record Lookup (Start of Authority)
Get authoritative information about the google.com zone.

Bash

dig google.com SOA
This shows important details like the primary nameserver, responsible person's email, serial number, refresh, retry, expire, and minimum TTL values.

7. PTR Record Lookup (Reverse DNS)
Map an IP address back to a hostname. You need to reverse the IP address and append .in-addr.arpa for IPv4 or .ip6.arpa for IPv6.

Bash

dig -x 142.250.193.174
Example Output (Answer Section):

;; ANSWER SECTION:
174.193.250.142.in-addr.arpa. 1775 IN PTR  ord38s06-in-f14.1e100.net.
8. ANY Record Lookup (All Types)
Request all available DNS record types for a domain.

Bash

dig google.com ANY
This can return a lot of information, including A, AAAA, MX, NS, SOA, TXT, etc.

9. Short Output (+short)
Get a concise answer, useful for scripting or quick checks.

Bash

dig +short google.com
# Output: 142.250.193.174

dig +short google.com MX
# Output:
# 50 alt4.aspmx.l.google.com.
# 10 aspmx.l.google.com.
# 20 alt1.aspmx.l.google.com.
# 30 alt2.aspmx.l.google.com.
# 40 alt3.aspmx.l.google.com.
10. Tracing DNS Resolution (+trace)
See the delegation path from the root servers down to the authoritative name servers for a domain. This is excellent for debugging delegation issues.

Bash

dig +trace example.com
This will show the query to a root server, then the top-level domain (TLD) server, and finally the authoritative name server for example.com.

11. Customizing Output (+noall +answer)
Show only the answer section without headers, statistics, or other sections.

Bash

dig +noall +answer google.com MX
12. Querying a Specific Port (+vc and -p)
By default, dig uses UDP port 53.

+vc forces dig to use TCP (port 53 by default).

-p allows you to specify a different port.

Bash

dig +vc example.com       # Use TCP for query
dig @ns1.example.com -p 5353 example.com # Query server on non-standard port
13. Querying Localhost DNS Server (if you have one)
If you're running a local caching DNS server (like bind or dnsmasq), you can query it directly.

Bash

dig @127.0.0.1 google.com
14. Querying a TXT Record (e.g., SPF)
Bash

dig google.com TXT
This often reveals SPF (Sender Policy Framework) records or domain verification strings.

Troubleshooting with dig
"SERVER: 127.0.0.53#53(127.0.0.53)": On Ubuntu/Debian, this indicates systemd-resolved is being used as a local caching DNS server.

connection timed out; no servers could be reached: This indicates that dig could not reach the specified DNS server or the default ones in /etc/resolv.conf. Check network connectivity or firewall rules.

NXDOMAIN in status field: "Non-existent domain". The domain name does not exist.

SERVFAIL in status field: "Server failure". The DNS server encountered an error while processing the query. This could indicate a problem with the DNS server itself or its upstream resolvers.

REFUSED in status field: The DNS server refused to answer the query, often due to security policies (e.g., it's not configured to resolve for your IP).

Incorrect IP/No A Record: If dig returns no A record, check the hostname for typos, or verify that an A record is indeed configured for that domain.

Propagation Delays: After changing DNS records, it can take time for changes to propagate across the internet (TTL values). dig can help confirm if your authoritative server has the new records, even if public DNS hasn't updated yet. Use dig @your_authoritative_nameserver yourdomain.com.

dig is an indispensable tool for anyone working with network services and DNS, providing deep insights into how domain names are resolved across the internet.
```