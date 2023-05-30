#!/bin/bash

echo "Starting installation of the script, sit back and relax"
echo "By Subhashis Barad"

# Make the script executable
sudo chmod +x $0

# Uninstall packages
sudo dnf remove -y cheese* libreoffice* firefox || true
 
# Update the system
sudo dnf update -y

# Set maximum parallel downloads to 10
sudo dnf config-manager --setopt=max_parallel_downloads=10 --save

# Set primary mirror
sudo dnf config-manager --setopt=baseurl=https://admin.fedoraproject.org/mirrormanager/mirrors/Fedora/38/x86_64 --save

# Enable fastest mirror
sudo dnf config-manager --setopt=fastestmirror=true --save

# Add Brave Browser repository
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

# Import Brave Browser GPG key
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

# Enable RPM Fusion repository
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Install common packages
sudo dnf install -y brave-browser fastfetch kdenlive gimp gedit gparted timeshift gnome-tweaks vlc android-tools okular || true

# Get the current username
username=$(whoami)

# Set the Android product output directory
export ANDROID_PRODUCT_OUT="/home/$username/AOSP/out/target/product/device"

#start and kill server 
sudo adb kill-server
sudo adb start-server

# Install Flatpak and add Flathub repository
sudo dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Flatpak applications
flatpak install -y flathub io.github.aandrew_me.ytdn flathub com.mattjakeman.ExtensionManager || true

# Clone Layan GTK theme repository
cd ~
git clone https://github.com/vinceliuice/Layan-gtk-theme

# Execute Layan theme installation script
cd Layan-gtk-theme
sudo ./install.sh -l -c dark

# Clone WhiteSur icon theme repository
cd ~
git clone https://github.com/vinceliuice/WhiteSur-icon-theme

# Execute WhiteSur icon theme installation script
cd WhiteSur-icon-theme
sudo ./install.sh

# Clone Layan cursors installation script
cd~
git clone https://github.com/vinceliuice/Layan-cursors

# Exectue cursors installation
cd Layan-cursors
sudo ./install.sh 

# Add fastfetch and systemd-analyze to .bashrc
echo -e "\n# Add fastfetch and systemd-analyze\necho\nfastfetch\nsystemd-analyze\n" >> ~/.bashrc

# Print completion message
echo "Post-installation script completed."

# Reboot the system
sudo reboot

