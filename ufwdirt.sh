#!/bin/bash

# A script to manage ufw in Linux

# Check if the script is being run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Please run the script as root using sudo."
    exit 1
fi

# Function to add a ufw rule
add_rule() {
    echo "Enter the ufw rule you want to add:"
    read rule
    sudo ufw allow $rule
}

# Function to delete a ufw rule
delete_rule() {
    echo "Enter the ufw rule you want to delete:"
    read rule
    sudo ufw delete allow $rule
}

# Function to restart ufw
restart_ufw() {
    sudo ufw disable
    sudo ufw enable
}

# Function to apply a common set of rules for https, http, dns and ssh
apply_common_rules() {
    sudo ufw allow ssh
    sudo ufw allow http
    sudo ufw allow https
    sudo ufw allow dns
}

# Function to display ufw status
display_status() {
    sudo ufw status
}

# Function to show all currently applied rules within ufw
show_rules() {
    sudo ufw status numbered
}

# Function to restrict incoming connections on any of the allowed services to a specific IP
restrict_incoming() {
    echo "Enter the IP address to restrict incoming connections to:"
    read ip_address
    echo "Enter the port number to restrict incoming connections on:"
    read port_number
    sudo ufw allow from $ip_address to any port $port_number
}

# Function to only allow outgoing connections
allow_outgoing() {
    sudo ufw default allow outgoing
}

# Function to set default policy to deny
set_policy_deny() {
    sudo ufw default deny incoming
    sudo ufw default deny outgoing
}

# Main program loop
while true; do
    echo "Please select an option:"
    echo "1. Add a ufw rule"
    echo "2. Delete a ufw rule"
    echo "3. Restart ufw"
    echo "4. Apply common set of rules"
    echo "5. Display ufw status"
    echo "6. Show all currently applied rules within ufw"
    echo "7. Restrict incoming connections on a service to a specific IP"
    echo "8. Allow outgoing connections only"
    echo "9. Set default policy to deny"
    echo "10. Exit"
    read choice
    case $choice in
        1) add_rule;;
        2) delete_rule;;
        3) restart_ufw;;
        4) apply_common_rules;;
        5) display_status;;
        6) show_rules;;
        7) restrict_incoming;;
        8) allow_outgoing;;
        9) set_policy_deny;;
        10) exit;;
        *) echo "Invalid choice";;
    esac
done
