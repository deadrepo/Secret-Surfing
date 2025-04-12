#!/bin/bash

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No color

# Function to install Anonsurf
install_anonsurf() {
    echo -e "${GREEN}[+] Installing Anonsurf...${NC}"
    git clone https://github.com/Und3rf10w/kali-anonsurf.git ~/kali-anonsurf
    cd ~/kali-anonsurf || exit
    sudo ./installer.sh
    cd ~
    rm -rf ~/kali-anonsurf
}

# Check if Anonsurf is installed
if which anonsurf &> /dev/null; then
    echo -e "${GREEN}[+] Anonsurf is installed.${NC}"
else
    echo -e "${RED}[-] Anonsurf not found.${NC}"
    read -p "Do you want to install it now? (y/n): " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        install_anonsurf
    else
        echo "Exiting."
        exit 1
    fi
fi

# Check if xterm is installed
if ! command -v xterm &> /dev/null; then
    echo -e "${RED}[-] xterm is not installed.${NC}"
    read -p "Do you want to install it now? (y/n): " install_xterm
    if [[ "$install_xterm" == "y" || "$install_xterm" == "Y" ]]; then
        sudo apt update && sudo apt install -y xterm
    else
        echo "xterm is required for option 5. Exiting."
        exit 1
    fi
else
    echo -e "${GREEN}[+] xterm is installed.${NC}"
fi

# Anonsurf Menu
while true; do
  clear
echo "┌──────────────────────────────────────────────────────────┐"
echo "│                   Welcome 秘密のサーフィン               │"
echo "├──────────────────────────────────────────────────────────┤"
echo "│ 1) Start Secret Surfing (開始)                           │"
echo "│                                                          │"
echo "│ 2) Stop Secret Surfing (停止)                            │"
echo "│                                                          │"
echo "│ 3) Restart Secret Surfing (再起動)                       │"
echo "│                                                          │"
echo "│ 4) Change Identity (アイデンティティ変更)                │"
echo "│                                                          │"
echo "│ 5) Change Identity Every 5s (アイデンティティ変更)       │"
echo "│                                                          │"
echo "│ 6) Show Status (ステータス表示)                          │"
echo "│                                                          │"
echo "│ 0) Exit (終了)                                           │"
echo "└──────────────────────────────────────────────────────────┘"


  echo
  read -p "Choose an option: " option

  case $option in
    1) echo "Starting Secret Surfing (開始) ..."; sudo anonsurf start ;;
    2) echo "Stopping Secret Surfing (開始) ..."; sudo anonsurf stop ;;
    3) echo "Restarting Secret Surfing (開始) ..."; sudo anonsurf restart ;;
    4) echo "Changing Identity (再起動) ..."; sudo anonsurf change ;;
    5) echo "Change Identity Every 5s (アイデンティティ変更) ..."; xterm -hold -e "sudo watch -n 5 'anonsurf change'" & ;;
    6) echo "Show Status (ステータス表示) ..."; xterm -hold -e "sudo anonsurf status"; read -p "Press enter to continue..." &  ;;
    0) echo "失せろ"; exit 0 ;;
    *) echo "Invalid option. Try again."; sleep 1 ;;
  esac
done
