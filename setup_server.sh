#!/bin/bash

# ==========================================
# The Ultimate Ubuntu Server Setup Script
# Author: Khang (Dulkanggg)
# ==========================================

# 1. Check for Root Privileges
if [ "$EUID" -ne 0 ]; then 
  echo "Please run this script as root (use sudo)"
  exit
fi

echo "--- STARTING SYSTEM UPDATE ---"
apt update && apt upgrade -y

echo "--- 1. INSTALLING ESSENTIAL UTILITIES ---"
# Installing curl, wget, git, htop, vim, unzip, net-tools, etc.
apt install -y curl wget git htop vim nano unzip net-tools software-properties-common ca-certificates gnupg lsb-release

echo "--- 2. SETTING UP SECURITY (UFW & FAIL2BAN) ---"
apt install -y ufw fail2ban

# Configuring Basic Firewall Rules
# IMPORTANT: We must allow SSH first to prevent locking ourselves out!
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp

# Enable UFW (Auto-confirm 'yes')
echo "y" | ufw enable

echo "--- 3. INSTALLING NGINX (Web Server) ---"
apt install -y nginx
systemctl start nginx
systemctl enable nginx

echo "--- 4. INSTALLING DOCKER & DOCKER COMPOSE ---"
# Add Docker's official GPG key
mkdir -p /etc/apt/keyrings
curl -fsSL [https://download.docker.com/linux/ubuntu/gpg](https://download.docker.com/linux/ubuntu/gpg) | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] [https://download.docker.com/linux/ubuntu](https://download.docker.com/linux/ubuntu) \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Start Docker service
systemctl start docker
systemctl enable docker

# Add current user to Docker group (so you don't need 'sudo' for docker commands)
# Note: This checks for the user who ran the sudo command
if [ -n "$SUDO_USER" ]; then
    usermod -aG docker $SUDO_USER
    echo "User $SUDO_USER has been added to the docker group."
fi

echo "--- SYSTEM CLEANUP ---"
apt autoremove -y

echo "=========================================="
echo "   SETUP COMPLETE! READY TO ROCK."
echo "=========================================="
echo "Versions Installed:"
echo "- Nginx: $(nginx -v 2>&1 | cut -d '/' -f 2)"
echo "- Docker: $(docker --version)"
echo "- UFW Status: $(ufw status | grep 'Status')"
echo "NOTE: Please logout and login again to apply Docker group permissions."
