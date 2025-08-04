firewalld is the default firewall management tool in RHEL 7, 8, and 9. It uses the concept of zones to manage network connections, making it easier to apply different rules based on the trust level of the network an interface is connected to.

Here's how to open a port using firewalld in RHEL, with clear explanations for each step:

Key Concepts in firewalld:

Zones: 
	firewalld groups network interfaces into zones. Each zone has its own set of rules. Common zones include public, internal, home, trusted, drop, etc. You can find out which zone your interface is in (e.g., eth0 or enp0s3) using sudo firewall-cmd --get-zone-of-interface=<interface_name>.

Services: 
	firewalld comes with pre-defined services (like http, https, ssh, dhcp). Using these services is often easier than remembering port numbers. You can list them with firewall-cmd --get-services.

Ports: You can open specific port numbers directly (e.g., 80/tcp, 443/udp).

Runtime vs. Permanent:

Runtime: 
	Changes applied without the --permanent flag are active immediately but will be lost after a reboot or firewalld service restart/reload.

Permanent: Changes applied with the --permanent flag are saved to configuration files and will persist across reboots. They are not active immediately unless you also reload the firewall.

Reload: After making permanent changes, you need to reload firewalld for them to take effect on the running system.

Steps to Open a Port using firewalld
1. Check firewalld Status (Optional but Recommended)

Before you start, make sure firewalld is running:



sudo systemctl status firewalld or 
	service  firewalld status 

	If it's not running, start and enable it:



sudo systemctl start firewalld
sudo systemctl enable firewalld
2. Identify the Zone (Crucial)

You need to know which zone your network interface is associated with. Usually, public-facing interfaces are in the public zone.


	sudo firewall-cmd --get-active-zones
This command will show you which interfaces are active in which zones. For example:

public
  interfaces: eth0
This means eth0 is in the public zone. If you have multiple interfaces, you might see more.

Alternatively, to find the zone for a specific interface:



sudo firewall-cmd --get-zone-of-interface=eth0
3. Choose Your Method: Service or Port Number

Method A: Opening a Pre-defined Service (Recommended for common services)

firewalld includes definitions for many common services (e.g., HTTP, HTTPS, SSH). This is generally preferred as it's more readable and often includes all necessary ports for that service.

List available services:



	sudo firewall-cmd --get-services
Add the service to the desired zone (e.g., public zone for http):

For runtime (temporary) only:



	sudo firewall-cmd --zone=public --add-service=http --permanent
	sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
	firewall-cmd reload 
For permanent changes (persists after reboot):



sudo firewall-cmd --zone=public --add-service=http --permanent
Reload firewalld if you used --permanent:



sudo firewall-cmd --reload
Method B: Opening a Specific Port Number

If your application uses a non-standard port or there's no pre-defined service, you can open the port directly. You must specify the protocol (tcp or udp).

Add the port to the desired zone (e.g., public zone for port 8080/tcp):

For runtime (temporary) only:



sudo firewall-cmd --zone=public --add-port=8080/tcp
For permanent changes (persists after reboot):



sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
To open a range of ports (e.g., 60000-61000 for TCP):



sudo firewall-cmd --zone=public --add-port=60000-61000/tcp --permanent
Reload firewalld if you used --permanent:



sudo firewall-cmd --reload
4. Verify the Changes

After adding the rule, always verify that the port or service is open in the correct zone.

List all active rules for a specific zone:



sudo firewall-cmd --zone=public --list-all
Look for ports: or services: in the output. For example:

public (active)
  target: default
  icmp-block-inversion: no
  interfaces: eth0
  sources:
  services: cockpit dhcpv6-client http ssh
  ports: 8080/tcp
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:
Query a specific port or service:



sudo firewall-cmd --zone=public --query-port=8080/tcp
# Output: yes or no

sudo firewall-cmd --zone=public --query-service=http
# Output: yes or no
Examples:
Example 1: Open HTTP (port 80 TCP) permanently in the public zone



sudo firewall-cmd --zone=public --add-service=http --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --zone=public --list-services
Example 2: Open a custom port 9000 TCP permanently in the default zone
(If you don't specify --zone, it applies to the default zone, which is often public.)



sudo firewall-cmd --add-port=9000/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-ports # Lists ports in the default zone
Important Considerations:
Security Groups (AWS): Remember that firewalld operates inside your EC2 instance. In AWS, you also have Security Groups acting as a virtual firewall at the instance level. Even if you open a port with firewalld, if the Security Group doesn't allow traffic on that port, it will still be blocked. Ensure your EC2 instance's Security Group allows inbound traffic on the port you're trying to open.

SELinux: While less common for simple port opening, SELinux can also restrict services from binding to ports. If you open a port with firewalld and it still doesn't work, check SELinux logs (sudo ausearch -c <service_name> -m AVC -ts recent) or temporarily set SELinux to permissive mode for testing (sudo setenforce 0).

Application Listening: Ensure the application itself is configured to listen on the port you're opening. An open firewall port is useless if no service is listening on it. Use sudo ss -tulpn | grep <port_number> to check.