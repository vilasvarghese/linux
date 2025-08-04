Markdown

# nmcli: A Detailed Tutorial for Linux Network Management

`nmcli` is a command-line client for NetworkManager, a powerful system service that manages network connections on Linux. `nmcli` allows users to create, modify, enable, and disable network connections, monitor network status, and control NetworkManager from the terminal. It's an essential tool for headless servers, scripting network configurations, and for users who prefer the command line.

This tutorial will cover `nmcli`'s basic concepts, common commands for managing connections, devices, and general NetworkManager status, and provide practical examples for various networking tasks.

---

## 1. Basic Concepts

Before diving into commands, let's understand some key `nmcli` concepts:

* **Connections (Profiles):** These are configurations that define how to connect to a specific network. A connection profile includes settings like SSID, password, IP address, DNS servers, etc. You can have multiple connection profiles (e.g., "Home Wi-Fi," "Office Ethernet," "VPN").
* **Devices:** These are your physical or virtual network interfaces (e.g., `eth0`, `wlan0`, `ens33`, `virbr0`). A device can be "connected" to a connection profile.
* **NetworkManager:** The background service that manages all network operations. `nmcli` is just a client that talks to this service.

---

## 2. General Status and Information

### 2.1. Check NetworkManager Status

To see if NetworkManager is running and enabled:

```bash
sudo systemctl status NetworkManager
2.2. Get General NetworkManager Status
This command provides a quick overview of NetworkManager's state, connectivity, and active connections.

Bash

nmcli general status
# Or simply
nmcli g s
Example Output:

STATE         CONNECTIVITY  WIFI-HW  WIFI     WWAN-HW  WWAN
connected     full          enabled  enabled  enabled  enabled
2.3. Show All NetworkManager Information
This command provides a verbose output of NetworkManager's capabilities and current state.

Bash

nmcli general show
# Or
nmcli g sh
2.4. Monitor Network Changes (Event Stream)
To see real-time events as NetworkManager detects changes (e.g., Wi-Fi networks appearing/disappearing, connections being activated/deactivated):

Bash

nmcli monitor
Press Ctrl+C to stop monitoring.

3. Managing Devices
3.1. List Network Devices
View all recognized network devices and their status.

Bash

nmcli device status
# Or simply
nmcli d s
Example Output:

DEVICE   TYPE      STATE         CONNECTION
enp0s3   ethernet  connected     Wired connection 1
wlp2s0   wifi      disconnected  --
lo       loopback  unmanaged     --
3.2. Show Detailed Device Information
Get detailed information about a specific network device.

Bash

nmcli device show [device_name]
# Example:
nmcli device show enp0s3
3.3. Bring a Device Up/Down
Enable or disable a network device. Note that this doesn't disconnect existing connections; it makes the device unusable.

Bash

nmcli device set [device_name] up
nmcli device set [device_name] down
# Example:
nmcli device set wlp2s0 down

3.4. Disconnect a Device
To disconnect a device from its active connection without bringing the device down:

Bash

nmcli device disconnect [device_name]
# Example:
nmcli device disconnect enp0s3

3.5. Rescan Wi-Fi Networks
Force NetworkManager to rescan for available Wi-Fi networks.

Bash

nmcli device wifi rescan


3.6. List Available Wi-Fi Networks
Show detected Wi-Fi networks and their properties.

Bash

nmcli device wifi list

4. Managing Connections (Profiles)

4.1. List All Connections
View all defined connection profiles, active or inactive.

Bash

nmcli connection show
# Or simply
nmcli c s
Example Output:

NAME                UUID                                  TYPE      DEVICE
Wired connection 1  a1b2c3d4-e5f6-7890-1234-567890abcdef  ethernet  enp0s3
Home_WiFi           fedcba98-7654-3210-fedc-ba9876543210  wifi      --

4.2. Show Active Connections
Display only the currently active connections.

Bash

nmcli connection show --active

4.3. Show Detailed Connection Information
Get detailed configuration for a specific connection profile.

Bash

nmcli connection show [connection_name_or_uuid]
# Example:
nmcli connection show "Wired connection 1"
# Or using UUID:
nmcli connection show a1b2c3d4-e5f6-7890-1234-567890abcdef

4.4. Activate/Deactivate a Connection
Bring a connection profile up (activate) or take it down (deactivate). This will associate/disassociate the connection with its device.

Bash

nmcli connection up [connection_name]
nmcli connection down [connection_name]
# Example:
nmcli connection up Home_WiFi
nmcli connection down "Wired connection 1"
4.5. Delete a Connection
Remove a connection profile from NetworkManager.

Bash

nmcli connection delete [connection_name]
# Example:
nmcli connection delete Old_Network

4.6. Reload All Connections
Reload all connection profiles from disk. Useful if you manually edited configuration files.

Bash

nmcli connection reload
5. Creating and Modifying Connections
5.1. Create a Wired (Ethernet) Connection
DHCP (Automatic IP):

Bash

nmcli connection add type ethernet con-name "My Wired Connection" ifname enp0s3
add: Adds a new connection.

type ethernet: Specifies the connection type.

con-name "My Wired Connection": Sets the name of the connection profile.

ifname enp0s3: Binds the connection to the enp0s3 device.

Static IP:

Bash

nmcli connection add type ethernet con-name "Static Ethernet" ifname enp0s3 \
    ip4 192.168.1.100/24 gw4 192.168.1.1 \
    ipv4.dns "8.8.8.8 8.8.4.4" \
    ipv4.method manual
ip4: Sets the IPv4 address and subnet mask (CIDR notation).

gw4: Sets the IPv4 gateway.

ipv4.dns: Sets the IPv4 DNS servers (space-separated).

ipv4.method manual: Specifies a static IP configuration. Use auto for DHCP.

5.2. Create a Wi-Fi Connection
Open Wi-Fi:

Bash

nmcli device wifi connect "Open_SSID_Name"
WPA/WPA2 Personal (PSK) Wi-Fi:

Bash

nmcli device wifi connect "Secure_SSID_Name" password "Your_Wi-Fi_Password"
When you use nmcli device wifi connect, it automatically creates a new connection profile with the SSID as its name.

Creating a Wi-Fi connection with a custom profile name:

Bash

nmcli connection add type wifi con-name "My Home WiFi" ifname wlp2s0 ssid "My_Home_SSID" password "My_Super_Secret_Password"
ssid: The Wi-Fi network's SSID.

password: The Wi-Fi password.

5.3. Modify an Existing Connection
Use nmcli connection modify to change parameters of an existing connection.

Change DNS servers for "My Wired Connection":

Bash

nmcli connection modify "My Wired Connection" ipv4.dns "1.1.1.1 9.9.9.9"
Set IPv4 method to DHCP for "Static Ethernet":

Bash

nmcli connection modify "Static Ethernet" ipv4.method auto
Change Wi-Fi password for "My Home WiFi":

Bash

nmcli connection modify "My Home WiFi" wifi.ssid "My_New_SSID" wifi-sec.psk "New_Password"
Set a connection to automatically connect:

Bash

nmcli connection modify "My Home WiFi" autoconnect yes
To prevent a connection from automatically connecting:

Bash

nmcli connection modify "My Home WiFi" autoconnect no
Change the device a connection is bound to:

Bash

nmcli connection modify "My Wired Connection" interface-name eth1
Remove a specific IP address:

Bash

nmcli connection modify "Static Ethernet" -ipv4.addresses "192.168.1.100/24"
Add a secondary IP address:

Bash

nmcli connection modify "Static Ethernet" +ipv4.addresses "192.168.1.101/24"
Change connection priority (higher value means higher priority):

Bash

nmcli connection modify "My Home WiFi" connection.autoconnect-priority 10
5.4. Save Changes
Changes made with nmcli connection modify are automatically saved to the connection profile files (usually in /etc/NetworkManager/system-connections/). For changes to take effect on an active connection, you might need to deactivate and reactivate it:

Bash

nmcli connection down "My Wired Connection" && nmcli connection up "My Wired Connection"
6. Advanced Topics
6.1. Bond/Bridge/VLAN
nmcli can also create more complex network setups.

Create a Bridge:

Bash

nmcli connection add type bridge con-name br0 ifname br0
nmcli connection add type bridge-slave con-name eth0-slave ifname eth0 master br0
nmcli connection up br0
nmcli connection up eth0-slave
Create a Bond:

Bash

nmcli connection add type bond con-name bond0 ifname bond0 mode active-backup
nmcli connection add type bond-slave con-name eth0-bond ifname eth0 master bond0
nmcli connection add type bond-slave con-name eth1-bond ifname eth1 master bond0
nmcli connection up bond0
nmcli connection up eth0-bond
nmcli connection up eth1-bond
Create a VLAN:

Bash

nmcli connection add type vlan con-name vlan100 ifname eth0.100 dev eth0 id 100
nmcli connection up vlan100
6.2. Using UUIDs
While connection names are convenient, using UUIDs ensures you're always referencing the correct profile, especially if names are similar or change.

Bash

nmcli connection up a1b2c3d4-e5f6-7890-1234-567890abcdef
6.3. Tab Completion
nmcli has excellent tab completion. Type nmcli and press Tab twice to see available commands, or type a command and press Tab twice to see its options. This is extremely helpful for discovering commands and parameters.

Bash

nmcli c <TAB><TAB>
nmcli connection add type <TAB><TAB>
6.4. Troubleshooting with nmcli
"No network connectivity":

nmcli general status: Is NetworkManager connected?

nmcli device status: Is your device connected to a profile?

nmcli connection show --active: Is the intended connection profile active?

nmcli connection show "Connection Name": Check IP settings, DNS, gateway.

ping 8.8.8.8: Can you reach the internet by IP?

ping google.com: Is DNS working?

"Cannot connect to Wi-Fi":

nmcli device wifi list: Is the SSID visible? Is it secured?

Verify the password in your connection profile: nmcli connection show "My Home WiFi" | grep psk (Be careful with sensitive info in shell history).

Ensure wlan0 is up: nmcli device show wlan0.
```