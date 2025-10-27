#!/bin/bash

cat << "EOF"
                    ⣀⣀⣤⣤⣶⣶⣿⣿⣿⣿⣿⣿⣶⣦⣄⡀
                ⣠⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀
              ⣠⣾⣿⣿⣿⣿⣿⠿⠟⠛⠉⠉⠉⠛⠻⢿⣿⣿⣿⣿⣷⡄
            ⢀⣾⣿⣿⡿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⢿⣿⣿⣷⡀
           ⣰⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣧
          ⣼⣿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣷
         ⣸⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡇
        ⢠⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⡄
        ⣾⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣧
        ⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿
        ⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿
        ⢿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⡿
         ⢻⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⠏
          ⠹⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⡟⠁
           ⠈⢻⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⠟⠁
             ⠙⢿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⡿⠋
               ⠉⠻⣿⣦⣄⠀⠀⠀⠀⠀⠀⠀⢀⣠⣾⡿⠋
                  ⠉⠛⢿⣷⣦⣤⣤⣤⣴⣾⡿⠛⠁
                      ⠈⠉⠛⠛⠋⠉⠁

═══════════════════════════════════════════════════════════════════
           SSH Port Configuration Tool for Ubuntu 24.04+
    https://github.com/reaperofpower/ubuntu-enhancement-scripts
═══════════════════════════════════════════════════════════════════

EOF

set -e

SSH_CONFIG="/etc/ssh/sshd_config"
SOCKET_OVERRIDE_DIR="/etc/systemd/system/ssh.socket.d"
SOCKET_OVERRIDE_FILE="$SOCKET_OVERRIDE_DIR/override.conf"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

usage() {
    echo "Usage: $0 -p <port_number>"
    echo ""
    echo "Options:"
    echo "  -p    Port number (1024-65535 recommended)"
    echo "  -h    Display this help message"
    echo ""
    echo "Example:"
    echo "  sudo $0 -p 7822"
    echo ""
    echo "Requirements:"
    echo "  - Ubuntu 24.04 or later (with systemd socket activation)"
    echo "  - systemd-based system"
    echo ""
    echo "GitHub: https://github.com/reaperofpower/ubuntu-enhancement-scripts"
    exit 1
}

check_os_compatibility() {
    echo -e "${YELLOW}Checking system compatibility...${NC}"
    
    if [[ "$OSTYPE" != "linux-gnu"* ]]; then
        echo -e "${RED}Error: This script is designed for Linux systems${NC}"
        echo "Detected OS type: $OSTYPE"
        exit 1
    fi
    
    if ! command -v systemctl &> /dev/null; then
        echo -e "${RED}Error: systemd is not available on this system${NC}"
        echo "This script requires systemd for socket activation"
        exit 1
    fi
    
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        
        if [[ "$ID" != "ubuntu" ]]; then
            echo -e "${YELLOW}Warning: This script is designed for Ubuntu${NC}"
            echo "Detected OS: $NAME"
            echo ""
            read -p "Continue anyway? (y/n): " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                exit 1
            fi
        else
            echo -e "${GREEN}✓ Running on Ubuntu${NC}"
            
            VERSION_NUM=$(echo "$VERSION_ID" | cut -d. -f1)
            if [ "$VERSION_NUM" -lt 24 ]; then
                echo -e "${YELLOW}Warning: Detected Ubuntu $VERSION_ID${NC}"
                echo "This script is optimized for Ubuntu 24.04+"
                echo "Older versions may not use systemd socket activation for SSH"
                echo ""
                read -p "Continue anyway? (y/n): " -n 1 -r
                echo
                if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                    exit 1
                fi
            else
                echo -e "${GREEN}✓ Ubuntu version $VERSION_ID compatible${NC}"
            fi
        fi
    else
        echo -e "${YELLOW}Warning: Cannot determine OS version${NC}"
        echo "/etc/os-release not found"
        echo ""
        read -p "Continue anyway? (y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
    
    if ! systemctl list-unit-files | grep -q "ssh.socket"; then
        echo -e "${YELLOW}Warning: ssh.socket not found${NC}"
        echo "Your system may not be using systemd socket activation for SSH"
        echo "This script may not work correctly"
        echo ""
        read -p "Continue anyway? (y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    else
        echo -e "${GREEN}✓ SSH socket activation detected${NC}"
    fi
    
    if [ ! -f "$SSH_CONFIG" ]; then
        echo -e "${RED}Error: SSH configuration file not found: $SSH_CONFIG${NC}"
        exit 1
    fi
    echo -e "${GREEN}✓ SSH configuration file found${NC}"
    
    echo ""
}

validate_port() {
    local port=$1
    
    if ! [[ "$port" =~ ^[0-9]+$ ]]; then
        echo -e "${RED}Error: Port must be a number${NC}"
        exit 1
    fi
    
    if [ "$port" -lt 1 ] || [ "$port" -gt 65535 ]; then
        echo -e "${RED}Error: Port must be between 1 and 65535${NC}"
        exit 1
    fi
    
    if [ "$port" -lt 1024 ]; then
        echo -e "${YELLOW}Warning: Port $port is in the privileged range (< 1024)${NC}"
        read -p "Continue anyway? (y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
    
    if [ "$port" -eq 22 ]; then
        echo -e "${YELLOW}Warning: Port 22 is the default SSH port${NC}"
        read -p "Are you sure you want to use this? (y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
    
    if ss -tlnp | grep -q ":$port "; then
        echo -e "${YELLOW}Warning: Port $port appears to be in use${NC}"
        ss -tlnp | grep ":$port "
        echo ""
        read -p "Continue anyway? (y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
}

NEW_PORT=""
while getopts "p:h" opt; do
    case $opt in
        p)
            NEW_PORT=$OPTARG
            ;;
        h)
            usage
            ;;
        \?)
            echo -e "${RED}Invalid option: -$OPTARG${NC}" >&2
            usage
            ;;
        :)
            echo -e "${RED}Option -$OPTARG requires an argument${NC}" >&2
            usage
            ;;
    esac
done

if [ -z "$NEW_PORT" ]; then
    echo -e "${RED}Error: Port number is required${NC}"
    usage
fi

validate_port "$NEW_PORT"

if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}Error: This script must be run as root (use sudo)${NC}" 
   exit 1
fi

check_os_compatibility

BACKUP_FILE="/etc/ssh/sshd_config.backup.$(date +%Y%m%d_%H%M%S)"

echo -e "${GREEN}=== SSH Port Change Script ===${NC}"
echo "This script will change your SSH port to $NEW_PORT"
echo ""

echo -e "${YELLOW}Creating backup of SSH config...${NC}"
cp "$SSH_CONFIG" "$BACKUP_FILE"
echo "Backup created: $BACKUP_FILE"

echo -e "${YELLOW}Modifying SSH configuration...${NC}"
if grep -q "^Port " "$SSH_CONFIG"; then
    sed -i "s/^Port .*/Port $NEW_PORT/" "$SSH_CONFIG"
elif grep -q "^#Port " "$SSH_CONFIG"; then
    sed -i "s/^#Port .*/Port $NEW_PORT/" "$SSH_CONFIG"
else
    echo "Port $NEW_PORT" >> "$SSH_CONFIG"
fi

echo -e "${YELLOW}Configuring systemd socket activation...${NC}"
mkdir -p "$SOCKET_OVERRIDE_DIR"

cat > "$SOCKET_OVERRIDE_FILE" << EOF
[Socket]
ListenStream=
ListenStream=$NEW_PORT
EOF

echo -e "${GREEN}✓ Systemd socket override created${NC}"

if command -v ufw &> /dev/null; then
    if ufw status | grep -q "Status: active"; then
        echo -e "${YELLOW}Updating UFW firewall rules...${NC}"
        ufw allow "$NEW_PORT/tcp" comment 'SSH on custom port'
        echo -e "${GREEN}✓ Firewall rule added for port $NEW_PORT${NC}"
        echo -e "${YELLOW}Note: Don't forget to remove the old SSH rule after testing:${NC}"
        echo "  sudo ufw status numbered"
        echo "  sudo ufw delete <rule_number>"
    fi
fi

echo -e "${YELLOW}Testing SSH configuration...${NC}"
if sshd -t; then
    echo -e "${GREEN}✓ SSH configuration is valid${NC}"
else
    echo -e "${RED}✗ SSH configuration has errors. Restoring backup...${NC}"
    cp "$BACKUP_FILE" "$SSH_CONFIG"
    rm -f "$SOCKET_OVERRIDE_FILE"
    exit 1
fi

echo -e "${YELLOW}Reloading systemd and restarting SSH...${NC}"
systemctl daemon-reload
systemctl restart ssh.socket
systemctl restart ssh.service

sleep 2
if systemctl is-active --quiet ssh.socket && systemctl is-active --quiet ssh.service; then
    echo -e "${GREEN}✓ SSH services restarted successfully${NC}"
else
    echo -e "${RED}✗ SSH service failed to restart. Restoring backup...${NC}"
    cp "$BACKUP_FILE" "$SSH_CONFIG"
    rm -f "$SOCKET_OVERRIDE_FILE"
    systemctl daemon-reload
    systemctl restart ssh.socket
    systemctl restart ssh.service
    exit 1
fi

echo -e "${YELLOW}Verifying port is listening...${NC}"
sleep 1
if ss -tlnp | grep -q ":$NEW_PORT"; then
    echo -e "${GREEN}✓ SSH is now listening on port $NEW_PORT${NC}"
else
    echo -e "${RED}⚠ Warning: Port $NEW_PORT may not be listening yet${NC}"
fi

echo ""
echo -e "${GREEN}=== SSH Port Change Complete ===${NC}"
echo ""
echo -e "${YELLOW}IMPORTANT INSTRUCTIONS:${NC}"
echo "1. DO NOT close this terminal session yet!"
echo "2. Open a NEW terminal and test the connection:"
echo "   ssh -p $NEW_PORT user@your_server_ip"
echo "3. If the connection works, you can safely close this session"
echo "4. If it doesn't work, restore the backup with:"
echo "   sudo cp $BACKUP_FILE $SSH_CONFIG"
echo "   sudo rm -f $SOCKET_OVERRIDE_FILE"
echo "   sudo systemctl daemon-reload"
echo "   sudo systemctl restart ssh.socket ssh.service"
echo ""
echo "New SSH Port: $NEW_PORT"
echo "Backup file: $BACKUP_FILE"
echo "Socket override: $SOCKET_OVERRIDE_FILE"
echo ""
echo "To view current SSH status:"
echo "  sudo systemctl status ssh.socket"
echo "  sudo ss -tlnp | grep ssh"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  GitHub: https://github.com/reaperofpower/ubuntu-enhancement-scripts"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
