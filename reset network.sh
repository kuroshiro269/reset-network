#!/bin/bash

# Check network connection
ping -c 1 8.8.8.8 > /dev/null
if [ $? -eq 0 ]; then
    echo "Network connection is active."
else
    echo "Network connection is not active."
fi

# Reset and renew network
sudo dhclient -r
sudo dhclient

# Flush DNS
sudo systemctl restart systemd-resolved

echo "Network reset and DNS flushed."

# Other important commands to fix connection errors
# Add your commands below this line

# Release and renew IP address using dhclient (if dhclient is not available, you can use dhcpcd or ip commands)
sudo dhclient -r
sudo dhclient

# Restart network manager (replace 'network-manager' with the appropriate service name for your distribution)
sudo systemctl restart network-manager

# Restart networking service (replace 'networking' with the appropriate service name for your distribution)
sudo systemctl restart networking

# Restart the network interface (replace 'eth0' with your network interface name)
sudo ifdown eth0
sudo ifup eth0

# Restart the Wi-Fi interface (replace 'wlan0' with your Wi-Fi interface name)
sudo ifdown wlan0
sudo ifup wlan0

# Restart the router or modem (replace '192.168.1.1' with your router or modem IP address)
sudo ping -c 1 192.168.1.1 > /dev/null
if [ $? -eq 0 ]; then
    echo "Router or modem restarted successfully."
else
    echo "Failed to restart router or modem."
fi

# Flush ARP cache
sudo ip -s -s neigh flush all

# Disable and re-enable network interface (replace 'eth0' with your network interface name)
sudo ifconfig eth0 down
sudo ifconfig eth0 up