#!/bin/bash

# Update the package lists
sudo apt update

# Install the necessary packages
sudo apt install -y software-properties-common

# Add the NVIDIA CUDA repository
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb
sudo dpkg -i cuda-keyring_1.0-1_all.deb
sudo apt-get update
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update

# Install the NVIDIA driver
sudo ubuntu-drivers autoinstall

# Install CUDA
sudo apt-get -y install cuda

# Reboot the system
sudo reboot
