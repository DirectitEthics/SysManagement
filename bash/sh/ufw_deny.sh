#!/bin/bash

# Gemini Advanced AI Assistance
# https://gemini.google.com/app/

# Check if UFW is installed.

#   - `command -v ufw`: Checks if the 'ufw' command exists.

#   - `&> /dev/null`: Redirects both standard output and standard error to /dev/null, silencing any output.

#   - `!`: Negates the result of the command. If 'ufw' is NOT found, the condition is true.

if ! command -v ufw &> /dev/null; then  
  echo "UFW not found. Installing..."
  sudo apt update  # Update package lists.
  sudo apt install -y ufw  # Install UFW (non-interactive with '-y').
fi


# Check if fail2ban is installed (similar logic as above).

# if ! command -v fail2ban &> /dev/null; then  
 # echo "fail2ban not found. Installing..."
 # sudo apt update
 # sudo apt install -y fail2ban
# fi

# before using fail2ban, configure and connect to your own SSH. Then, watch a video on how to setup fail2ban, as it secures SSH.


# Reset UFW.

sudo ufw reset  


# Deny all incoming connections on all ports for TCP and UDP.

sudo ufw deny proto tcp from any to any port 1:65535  

sudo ufw deny proto udp from any to any port 1:65535  


# Allow SSH connections.

sudo ufw allow 22/tcp  


# Enable UFW.

sudo ufw enable  


echo "UFW firewall is now active."
