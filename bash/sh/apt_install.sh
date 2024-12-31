
#!/bin/bash

# Update package lists
sudo apt update

# Install packages
sudo apt install -y \
    apt-mirror \
    mir-graphics-drivers-nvidia \
    mir-renderer-gl-dev \
    mir-platform-graphics-x20
    nvidia-common \
    nvidia-cuda-toolkit \
    htop \
    build-essential \
    git \
    tree \
    obs-studio \
    lmms \
    shotcut \
    virtualbox \
    
    fail2ban \
    ufw \
    gufw \
    clamav \
    nginx \
    wireguard \
    

    
  # gnome-tweaks \ # For Gnome Distributions
  # kubuntu-driver-manager \ # For Kubuntu / KDE Plasma
  
    shellcheck \
    jq \
    chkrootkit \
    rkhunter \
    ssh \
    openssh-server \
    openssh-sftp-server \
    ssh-tools \
    ssh-cron \

    gtkhash \
    xsel \
    gnupg \
    tor \
    torbrowser-launcher \
    torsocks \
    ptunnel \
    
  # remote-logon-service \
  # remote-logon-config-agent \
    

# Enable UFW firewall
sudo ufw enable

# Start and enable fail2ban
# sudo systemctl enable --now fail2ban

# Start and enable clamav daemon
sudo systemctl enable --now clamav-daemon


# wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.4_all.deb
# sudo dpkg -i ./protonvpn-stable-release_1.0.4_all.deb && sudo apt update

# for gnome desktop users
# sudo apt install proton-vpn-gnome-desktop

  sudo apt update 
  sudo apt upgrade

# sudo apt autoremove --show-progress --allow-remove-essential --fix-missing --fix-broken # IF NEEDED (use very rarely.)
