#!/bin/bash

# --- Functions ---

# Function to check if the script is running as root
check_root() {
  if [[ $EUID -ne 0 ]]; then
    echo "This script requires root privileges. Please run with sudo."
    exit 1
  fi
}

# Function to update package lists
update_packages() {
  echo "Updating package lists..."
  apt update 2>&1 | tee -a apt_update.log
  if [[ $? -ne 0 ]]; then
    echo "Error updating package lists. See apt_update.log for details. Exiting."
    exit 1
  fi
}

# Function to upgrade packages
upgrade_packages() {
  echo "Upgrading packages..."
  apt full-upgrade -y 2>&1 | tee -a apt_upgrade.log
  if [[ $? -ne 0 ]]; then
    echo "Error upgrading packages. See apt_upgrade.log for details. Exiting."
    exit 1
  fi
}

# Function to install a package
install_package() {
  local package_name=$1
  echo "Installing $package_name..."
  apt install -y "$package_name" 2>&1 | tee -a apt_install.log
  if [[ $? -ne 0 ]]; then
    echo "Error installing $package_name. See apt_install.log for details. Exiting."
    exit 1
  fi
}

# Function to remove a package
remove_package() {
  local package_name=$1
  echo "Removing $package_name..."
  apt remove -y "$package_name" 2>&1 | tee -a apt_remove.log
  if [[ $? -ne 0 ]]; then
    echo "Error removing $package_name. See apt_remove.log for details. Exiting."
    exit 1
  fi
}

# Function to clean up old logs and cache
clean_up() {
  echo "Cleaning up old logs and cache..."
  apt autoremove -y 2>&1 | tee -a apt_cleanup.log
  apt clean 2>&1 | tee -a apt_cleanup.log
  if [[ $? -ne 0 ]]; then
    echo "Error cleaning up. See apt_cleanup.log for details. Exiting."
    exit 1
  fi
}

# --- Main script ---

# Check for root privileges
check_root

# Update package lists
update_packages

# Upgrade packages
upgrade_packages

# Install essential packages
install_package "sudo"
install_package "locales"
install_package "gnome-text-editor" # Or your preferred text editor
install_package "curl"
install_package "wget"
install_package "git"
install_package "build-essential" # For compiling software

# Install recommended packages (customize based on your needs)
install_package "htop" # System monitor
install_package "zsh" # Shell upgrade
install_package "tree" # Directory tree viewer

# Debian Compatibility: Install 'lsb-release'
# install_package "lsb-release"

# Remove unnecessary packages (replace with your actual packages)
# (Be very careful with removing packages on a fresh install)

# Clean up old logs and cache
# clean_up

# Display OS information
# echo "OS information:"
# lsb_release -a

echo "Script completed successfully!"
