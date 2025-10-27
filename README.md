# Ubuntu Enhancement Scripts

A collection of bash scripts designed to enhance and simplify Ubuntu server administration. These scripts focus on security, configuration, and system management tasks.
```
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
```

## 📋 Table of Contents

- [Available Scripts](#available-scripts)
- [Quick Start](#quick-start)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## 🚀 Available Scripts

### SSH Port Configuration Tool

Change your SSH port on Ubuntu 24.04+ systems with systemd socket activation support.

**Features:**
- ✅ Automatic systemd socket configuration
- ✅ UFW firewall rule management
- ✅ Automatic backup creation
- ✅ Configuration validation
- ✅ Comprehensive error handling
- ✅ OS compatibility checks

**One-liner installation and execution:**
```bash
wget -O ssh_port.sh https://raw.githubusercontent.com/reaperofpower/ubuntu-enhancement-scripts/main/ssh_port.sh && sed -i 's/\r$//' ssh_port.sh && chmod +x ssh_port.sh && sudo ./ssh_port.sh -p 7822
```

**Or download and run separately:**
```bash
# Download and prepare
wget -O ssh_port.sh https://raw.githubusercontent.com/reaperofpower/ubuntu-enhancement-scripts/main/ssh_port.sh && sed -i 's/\r$//' ssh_port.sh && chmod +x ssh_port.sh

# Run with your desired port
sudo ./ssh_port.sh -p 7822
```

**Manual usage:**
```bash
sudo ./ssh_port.sh -p <port_number>
```

**Options:**
- `-p` : Specify the port number (required)
- `-h` : Display help message

**Example:**
```bash
sudo ./ssh_port.sh -p 2222
```

---

## ⚡ Quick Start

### Prerequisites

- Ubuntu 24.04 or later (recommended)
- systemd-based system
- Root/sudo access
- Active internet connection for downloading scripts

### Installation Methods

**Method 1: Clone the Repository**
```bash
git clone https://github.com/reaperofpower/ubuntu-enhancement-scripts.git
cd ubuntu-enhancement-scripts
chmod +x *.sh
```

**Method 2: Direct Download**
```bash
# Download a specific script
wget https://raw.githubusercontent.com/reaperofpower/ubuntu-enhancement-scripts/main/ssh_port.sh
chmod +x ssh_port.sh
```

**Method 3: One-liner (Download + Fix + Execute)**
```bash
wget -O ssh_port.sh https://raw.githubusercontent.com/reaperofpower/ubuntu-enhancement-scripts/main/ssh_port.sh && sed -i 's/\r$//' ssh_port.sh && chmod +x ssh_port.sh && sudo ./ssh_port.sh -p YOUR_PORT
```

---

## 🔧 Requirements

- **Operating System:** Ubuntu 24.04+ (other systemd-based distros may work with warnings)
- **Privileges:** Root or sudo access
- **Dependencies:** 
  - systemd
  - bash
  - Standard GNU utilities (sed, grep, etc.)

---

## 📖 Detailed Usage

### SSH Port Configuration

This script safely changes your SSH port while handling all the necessary systemd socket activation configurations.

**Important Safety Notes:**
1. ⚠️ **DO NOT close your current SSH session** until you verify the new port works
2. 🔄 Always test the new configuration in a **separate terminal window**
3. 💾 The script automatically creates backups of your configuration
4. 🔒 Remember to update your firewall rules accordingly

**Step-by-Step Process:**

1. **Download and prepare the script:**
```bash
   wget -O ssh_port.sh https://raw.githubusercontent.com/reaperofpower/ubuntu-enhancement-scripts/main/ssh_port.sh
   sed -i 's/\r$//' ssh_port.sh
   chmod +x ssh_port.sh
```

2. **Run the script with your desired port:**
```bash
   sudo ./ssh_port.sh -p 7822
```

3. **Test the new connection** (in a new terminal):
```bash
   ssh -p 7822 user@your_server_ip
```

4. **If successful**, you can safely close the old session

5. **If unsuccessful**, restore from backup:
```bash
   sudo cp /etc/ssh/sshd_config.backup.TIMESTAMP /etc/ssh/sshd_config
   sudo rm -f /etc/systemd/system/ssh.socket.d/override.conf
   sudo systemctl daemon-reload
   sudo systemctl restart ssh.socket ssh.service
```

**What the script does:**
- ✓ Creates timestamped backup of SSH configuration
- ✓ Updates `/etc/ssh/sshd_config`
- ✓ Creates systemd socket override at `/etc/systemd/system/ssh.socket.d/override.conf`
- ✓ Updates UFW firewall rules (if active)
- ✓ Validates configuration before applying
- ✓ Restarts SSH services
- ✓ Verifies the new port is listening

---

## 🎯 Port Selection Guidelines

**Recommended Ports:**
- `1024-49151` : Registered ports (good choice)
- `49152-65535` : Dynamic/private ports (also good)

**Avoid:**
- `1-1023` : Privileged ports (require special permissions)
- `22` : Default SSH port (defeats the purpose)
- Common service ports: `80`, `443`, `3306`, `5432`, etc.

**Popular custom SSH ports:**
- `2222` : Common alternative
- `7822` : Random high port
- `22222` : Easy to remember

---

## 🛡️ Security Best Practices

When changing your SSH port:

1. **Use SSH key authentication** instead of passwords
2. **Disable root login** in `/etc/ssh/sshd_config`
3. **Keep your current session open** until verified
4. **Document your new port** securely
5. **Update your client SSH configs** (`~/.ssh/config`)
6. **Inform your team** if it's a shared server
7. **Update monitoring tools** that check SSH connectivity

---

## 🐛 Troubleshooting

### Issue: Line ending errors (`\r': command not found`)
**Solution:**
```bash
sed -i 's/\r$//' ssh_port.sh
```

### Issue: Permission denied
**Solution:**
```bash
chmod +x ssh_port.sh
sudo ./ssh_port.sh -p YOUR_PORT
```

### Issue: Port already in use
**Solution:**
```bash
# Check what's using the port
sudo ss -tlnp | grep :PORT_NUMBER

# Choose a different port
sudo ./ssh_port.sh -p DIFFERENT_PORT
```

### Issue: Can't connect after changing port
**Solution:**
```bash
# From another terminal on the same machine (not via SSH)
sudo cp /etc/ssh/sshd_config.backup.* /etc/ssh/sshd_config
sudo rm -f /etc/systemd/system/ssh.socket.d/override.conf
sudo systemctl daemon-reload
sudo systemctl restart ssh.socket ssh.service
```

---

## 🔮 Coming Soon

More enhancement scripts are in development:

- 🔐 Automated security hardening
- 🚀 Performance optimization tools
- 📊 System monitoring setup
- 🔄 Automated backup solutions
- 🌐 Network configuration helpers
- 🐳 Docker management utilities

**Stay tuned!** ⭐ Star this repo to get notified about new scripts.

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/amazing-script`)
3. **Commit your changes** (`git commit -m 'Add amazing script'`)
4. **Push to the branch** (`git push origin feature/amazing-script`)
5. **Open a Pull Request**

### Contribution Guidelines

- All scripts should include error handling
- Add comprehensive comments
- Include usage examples
- Test on Ubuntu 24.04+
- Follow bash best practices
- Update README with new scripts

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## ⚠️ Disclaimer

These scripts modify system configurations. While they include safety measures:

- ⚠️ Always backup your data before running system scripts
- ⚠️ Test in a non-production environment first
- ⚠️ Review the code before executing
- ⚠️ Use at your own risk

The authors are not responsible for any damage or data loss caused by these scripts.

---

## 📞 Support

- 🐛 **Issues:** [GitHub Issues](https://github.com/reaperofpower/ubuntu-enhancement-scripts/issues)
- 💬 **Discussions:** [GitHub Discussions](https://github.com/reaperofpower/ubuntu-enhancement-scripts/discussions)
- ⭐ **Star this repo** if you find it helpful!

---

## 📊 Statistics

![GitHub stars](https://img.shields.io/github/stars/reaperofpower/ubuntu-enhancement-scripts?style=social)
![GitHub forks](https://img.shields.io/github/forks/reaperofpower/ubuntu-enhancement-scripts?style=social)
![GitHub issues](https://img.shields.io/github/issues/reaperofpower/ubuntu-enhancement-scripts)
![GitHub license](https://img.shields.io/github/license/reaperofpower/ubuntu-enhancement-scripts)

---

<div align="center">

**Made with ❤️ for the Ubuntu community**

[⬆ Back to Top](#ubuntu-enhancement-scripts)

</div>
