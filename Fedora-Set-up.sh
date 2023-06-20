#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting installation of the script, sit back and relax${NC}"
echo -e "${BLUE}By Subhashis Barad${NC}"

echo -e "${CYAN}Make the script executable${NC}"
sudo chmod +x $0
sleep 2.5

echo -e "${CYAN}Uninstall packages${NC}"
sudo dnf remove -y cheese* libreoffice* firefox gnome-boxes gnome-contacts gnome-maps gnome-color-manager mediawriter || true
sleep 2.5

echo -e "${CYAN}Update the system${NC}"
sudo dnf update -y
sleep 2.5

echo -e "${CYAN}Set maximum parallel downloads to 10${NC}"
sudo dnf config-manager --setopt=max_parallel_downloads=10 --save
sleep 2.5

echo -e "${CYAN}Set primary mirror${NC}"
sudo dnf config-manager --setopt=<repository-id>.baseurl=https://admin.fedoraproject.org/mirrormanager/mirrors/Fedora/38/x86_64 --save
sleep 2.5

echo -e "${CYAN}Enable fastest mirror${NC}"
sudo dnf config-manager --setopt=fastestmirror=true --save
sleep 2.5

echo -e "${CYAN}Add Brave Browser repository${NC}"
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sleep 2.5

echo -e "${CYAN}Import Brave Browser GPG key${NC}"
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sleep 2.5

echo -e "${CYAN}Enable RPM Fusion repository${NC}"
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sleep 2.5

echo -e "${CYAN}Install common packages${NC}"
sudo dnf install -y brave-browser fastfetch kdenlive gimp gedit gparted timeshift gnome-tweaks vlc android-tools okular chrome-gnome-shell ddcutil || true
sleep 2.5

echo -e "${CYAN}Get the current username${NC}"
username=$(whoami)
sleep 2.5

echo -e "${CYAN}Set the Android product output directory${NC}"
export ANDROID_PRODUCT_OUT="/home/$username/AOSP/out/target/product/device"
sleep 2.5

echo -e "${CYAN}Start and kill server${NC}"
sudo adb kill-server
sudo adb start-server
sleep 2.5

echo -e "${CYAN}Install Flatpak and add Flathub repository${NC}"
sudo dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sleep 2.5

echo -e "${CYAN}Install Flatpak applications${NC}"
flatpak install -y flathub io.github.aandrew_me.ytdn flathub com.mattjakeman.ExtensionManager || true
sleep 2.5

echo -e "${CYAN}Clone Layan GTK theme repository${NC}"
cd ~
git clone https://github.com/vinceliuice/Layan-gtk-theme
sleep 2.5

echo -e "${CYAN}Execute Layan theme installation script${NC}"
cd Layan-gtk-theme
sudo ./install.sh -l -c dark
sleep 2.5

echo -e "${CYAN}Clone WhiteSur icon theme repository${NC}"
cd ~
git clone https://github.com/vinceliuice/WhiteSur-icon-theme
sleep 2.5

echo -e "${CYAN}Execute WhiteSur icon theme installation script${NC}"
cd WhiteSur-icon-theme
sudo ./install.sh
sleep 2.5

echo -e "${CYAN}Clone Layan cursors installation script${NC}"
cd ~
git clone https://github.com/vinceliuice/Layan-cursors
sleep 2.5

echo -e "${CYAN}Execute cursors installation${NC}"
cd Layan-cursors
sudo ./install.sh
sleep 2.5

echo -e "${CYAN}Add fastfetch and systemd-analyze to .bashrc${NC}"
echo -e "\n${YELLOW}# Add fastfetch and systemd-analyze${NC}\necho\nfastfetch\nsystemd-analyze\n" >> ~/.bashrc
sleep 2.5

echo -e "${CYAN}Print completion message${NC}"
echo -e "${GREEN}Script has successfully been completed now the system will reboot and you can enjoy it after that hehehehe${NC}"
sleep 2.5

echo -e "${CYAN}Reboot the system${NC}"
echo -e "${YELLOW}Rebooting the system in 10 seconds...Use ctrl+z to stop rebooting${NC}"
sleep 2.5

echo -e "${CYAN}Delay for 10 seconds${NC}"
sleep 10

echo -e "${CYAN}Reboot the system${NC}"
sudo reboot
