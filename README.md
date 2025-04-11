🧩 MODULE 1: Automating Programs + Login Options
🔧 Automating Programs
📁 Run Levels
bash
Copy
Edit
# Check current runlevel (SysV)
runlevel

# For systemd (modern distros)
systemctl get-default

# Change runlevel/target
sudo systemctl set-default multi-user.target   # No GUI
sudo systemctl set-default graphical.target    # GUI
📁 /etc/rc.d Files (SysV style)
bash
Copy
Edit
# Custom script example
sudo vi /etc/rc.d/init.d/myscript
bash
Copy
Edit
#!/bin/bash
# chkconfig: 2345 99 10
# description: My Sample Service

case "$1" in
  start)
    echo "Starting my service"
    ;;
  stop)
    echo "Stopping my service"
    ;;
  restart)
    echo "Restarting..."
    ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
esac
bash
Copy
Edit
sudo chmod +x /etc/rc.d/init.d/myscript
sudo chkconfig --add myscript
📅 cron and anacron
bash
Copy
Edit
# Edit crontab for current user
crontab -e

# Run every day at 2 AM
0 2 * * * /home/user/backup.sh

# List cron jobs
crontab -l
Anacron example:

bash
Copy
Edit
sudo vi /etc/anacrontab
ini
Copy
Edit
1   5   cron.daily   run-parts /etc/cron.daily
⏰ at and batch
bash
Copy
Edit
# Schedule task once at 10:00 AM
echo "echo 'Backup done'" | at 10:00

# List scheduled jobs
atq

# Remove a job
atrm <job_number>
🔐 Login Options
🖥️ Console Logon
Simply press Ctrl + Alt + F1 to F6 to switch to console login.

Use loginctl to manage sessions.

🔒 Controlling Console Login
bash
Copy
Edit
# Restrict console login via /etc/security/access.conf
sudo vi /etc/security/access.conf
text
Copy
Edit
-:ALL EXCEPT root:tty[1-6]
⌨️ Virtual Consoles
bash
Copy
Edit
# List active virtual consoles
fgconsole

# Switch between consoles
Ctrl+Alt+F1 → F6
🔌 Serial Login
bash
Copy
Edit
sudo systemctl enable serial-getty@ttyS0.service
sudo systemctl start serial-getty@ttyS0.service
🌐 Remote Login
bash
Copy
Edit
# Enable SSH
sudo systemctl enable sshd
sudo systemctl start sshd

# From remote system
ssh user@<hostname_or_IP>

🧩 MODULE 2: Kernel Building + GNU/Linux Filesystem
🧬 Building a Custom Linux Kernel
🔢 Kernel Versions
bash
Copy
Edit
uname -r                  # Current running kernel
ls /boot                  # Lists available kernel images
📂 Kernel Source Files
bash
Copy
Edit
# Install build dependencies (Debian/Ubuntu)
sudo apt install build-essential libncurses-dev bison flex libssl-dev libelf-dev

# Download kernel source
wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.7.4.tar.xz
tar -xvf linux-6.7.4.tar.xz
cd linux-6.7.4
📄 Kernel Patch Files
bash
Copy
Edit
# Apply a patch (example patch)
patch -p1 < ../my-patch-file.patch
⚙️ Kernel Configuration
bash
Copy
Edit
make menuconfig       # TUI menu for kernel config
make defconfig        # Default config
cp /boot/config-$(uname -r) .config  # Use current config
🛠️ Kernel Building
bash
Copy
Edit
make -j$(nproc)           # Compile kernel
sudo make modules_install
sudo make install
🧪 Testing a New Kernel
bash
Copy
Edit
# Update GRUB
sudo update-grub
reboot

# On boot screen, select new kernel
uname -r                  # Verify the new version
🧱 The GNU/Linux Filesystem
💽 Partition Types
bash
Copy
Edit
lsblk
fdisk -l
Primary, Extended, Logical

📁 Filesystem Types
bash
Copy
Edit
# View current filesystem types
df -T

# Format a new partition
sudo mkfs.ext4 /dev/sdb1
📌 Mounting
bash
Copy
Edit
sudo mount /dev/sdb1 /mnt
df -h
🌀 Automount (via /etc/fstab)
bash
Copy
Edit
sudo vi /etc/fstab
bash
Copy
Edit
/dev/sdb1   /mnt/data   ext4   defaults   0  2
bash
Copy
Edit
sudo mount -a
🧾 File Types
bash
Copy
Edit
# Common types
ls -l
file somefile
Regular -, Directory d, Symlink l, Socket s, Block b, Char c, Pipe p

🔐 File Security
bash
Copy
Edit
ls -l file.txt
chmod 755 file.txt
chown user:group file.txt

:

🧩 MODULE 3: Key Filesystem Locations + /proc Filesystem
🗂️ Key Filesystem Locations
📂 Boot Files
bash
Copy
Edit
cd /boot
ls -l

# Files of interest:
# vmlinuz — compressed kernel image
# initrd.img — initial RAM disk
# grub/ — bootloader files
👤 User Files
bash
Copy
Edit
cd /home
ls -lh

# Default user home directories
# Each user has a /home/username with personal files
👑 Administrator Files
bash
Copy
Edit
cd /root
ls -lh

# Root user's home directory
# Only accessible by root
⚙️ Configuration Files
bash
Copy
Edit
cd /etc
ls -l

# Contains system-wide configuration:
# /etc/passwd, /etc/ssh/sshd_config, /etc/fstab
📜 Log Files
bash
Copy
Edit
cd /var/log
ls -lh

# Common logs
# syslog, auth.log, dmesg, journal, etc.
🧠 The /proc Pseudo Filesystem
📊 Process Info
bash
Copy
Edit
ps aux
cat /proc/<PID>/status
cat /proc/<PID>/cmdline
🛠️ Kernel Config Info
bash
Copy
Edit
cat /proc/version
cat /proc/cmdline
🧰 Hardware Info
bash
Copy
Edit
cat /proc/cpuinfo
cat /proc/meminfo
cat /proc/partitions
📝 Changing /proc Info (sysctl)
bash
Copy
Edit
# Read kernel parameter
cat /proc/sys/net/ipv4/ip_forward

# Change temporarily
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward

# Use sysctl for permanent or batch
sudo sysctl -w net.ipv4.ip_forward=1

# Persist across reboots
sudo vi /etc/sysctl.conf
ini
Copy
Edit
net.ipv4.ip_forward = 1
bash
Copy
Edit
sudo sysctl -p

🧩 MODULE 4: BASH + User Management
🐚 BASH – Bourne Again Shell
📂 Key /bin Commands
bash
Copy
Edit
ls     cp     mv     rm     mkdir     echo     cat     touch     pwd     cd
🛠️ Key /sbin Commands
bash
Copy
Edit
ifconfig     shutdown     reboot     ip     fdisk     mkfs     mount     fsck
📜 History
bash
Copy
Edit
history             # View command history
!25                 # Run command number 25
!!                  # Run last command again
history -c          # Clear history
📚 man and info
bash
Copy
Edit
man ls              # Manual page
info ls             # Info documentation
📝 vi Editor
bash
Copy
Edit
vi filename.txt

# Basic Commands:
# i – insert
# esc + :w – save
# esc + :q – quit
# esc + :wq – save & quit
# esc + :q! – force quit
🧪 Using Shell Scripts
Example: greet.sh

bash
Copy
Edit
#!/bin/bash
echo "Hello, $(whoami)! Today is $(date)."
bash
Copy
Edit
chmod +x greet.sh
./greet.sh
👥 User Management
👤 Users and Groups
bash
Copy
Edit
sudo useradd john
sudo passwd john
sudo groupadd developers
sudo usermod -aG developers john
🏠 Home Directories
bash
Copy
Edit
sudo useradd -m raj
ls -ld /home/raj
🔑 Password Files
bash
Copy
Edit
cat /etc/passwd       # user account info
cat /etc/shadow       # encrypted passwords (only root)
🛡️ PAM (Pluggable Auth Modules)
bash
Copy
Edit
# PAM configuration files
ls /etc/pam.d/
cat /etc/pam.d/common-auth
Example: Enforce strong passwords

bash
Copy
Edit
sudo apt install libpam-pwquality
sudo vi /etc/pam.d/common-password
ruby
Copy
Edit
password requisite pam_pwquality.so retry=3 minlen=10
💾 Quotas (enable and configure)
Edit fstab

bash
Copy
Edit
sudo vi /etc/fstab
bash
Copy
Edit
/dev/sda1  /home  ext4  defaults,usrquota,grpquota  0  2
Remount & Create Quota Files

bash
Copy
Edit
sudo mount -o remount /home
sudo quotacheck -cum /home
sudo quotaon /home
Assign Quotas

bash
Copy
Edit
sudo edquota raj
🧭 NIS Intro (client-side example)
bash
Copy
Edit
sudo apt install nis
sudo vi /etc/yp.conf
nginx
Copy
Edit
domain mydomain.com server 192.168.1.100
bash
Copy
Edit
sudo systemctl restart nis

:

🧩 MODULE 5: Software Management + Hardware Management + Network Management
📦 Software Management
📁 tar Files
bash
Copy
Edit
# Create a tar archive
tar -cvf myfiles.tar file1 file2 dir/

# Extract a tar archive
tar -xvf myfiles.tar

# With gzip
tar -czvf myfiles.tar.gz myfolder/
tar -xzvf myfiles.tar.gz
🧩 Patch Files
bash
Copy
Edit
# Create patch
diff -u original.c updated.c > file.patch

# Apply patch
patch < file.patch
📦 RPM (RedHat, CentOS, Fedora)
bash
Copy
Edit
rpm -ivh package.rpm        # Install
rpm -Uvh package.rpm        # Upgrade
rpm -e package               # Remove
rpm -qa                     # List installed
rpm -ql httpd               # List files in a package
🧰 Hardware Management
💡 Types of Devices
Character Devices: /dev/tty, /dev/random

Block Devices: /dev/sda, /dev/sdb

Network Devices: eth0, lo

🗂️ /dev Namespace
bash
Copy
Edit
ls -l /dev | more
🧠 Modules
bash
Copy
Edit
lsmod                          # List loaded modules
modprobe <module>              # Load module
rmmod <module>                 # Remove module
modinfo <module>               # Show info
Example:

bash
Copy
Edit
sudo modprobe snd_hda_intel
🌐 Network Management
🔌 Types of Network Devices
bash
Copy
Edit
ip a                # Show interfaces
ifconfig            # (older distros)
📊 Monitoring Network Devices
bash
Copy
Edit
ping google.com
traceroute google.com
netstat -tulnp
ss -tulnp
🧭 Controlling Network Services
bash
Copy
Edit
sudo systemctl status ssh
sudo systemctl start ssh
sudo systemctl stop ssh
⚙️ xinetd (old-style super-server)
bash
Copy
Edit
sudo apt install xinetd
sudo vi /etc/xinetd.d/echo

# Sample echo config
service echo
{
    disable     = no
    type        = INTERNAL
    id          = echo-stream
    socket_type = stream
    protocol    = tcp
    user        = root
    wait        = no
}
bash
Copy
Edit
sudo systemctl restart xinetd
🔥 iptables
bash
Copy
Edit
# Basic rules
sudo iptables -L                     # List rules
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -j DROP       # Drop everything else
sudo iptables-save > /etc/iptables.rules


🧩 MODULE 6: Network Services – Part I, II, III
🌐 Network Services – Part I
🧭 DHCP (Dynamic Host Configuration Protocol)
Server Installation (Debian/Ubuntu)

bash
Copy
Edit
sudo apt install isc-dhcp-server
sudo vi /etc/dhcp/dhcpd.conf
Basic Configuration:

conf
Copy
Edit
subnet 192.168.1.0 netmask 255.255.255.0 {
  range 192.168.1.100 192.168.1.200;
  option routers 192.168.1.1;
  option domain-name-servers 8.8.8.8;
}
bash
Copy
Edit
sudo systemctl restart isc-dhcp-server
🌍 DNS (Domain Name System)
Install BIND DNS Server

bash
Copy
Edit
sudo apt install bind9 bind9utils
sudo vi /etc/bind/named.conf.local
Add Zone:

conf
Copy
Edit
zone "linuxclass.local" {
  type master;
  file "/etc/bind/db.linuxclass";
};
Create Zone File:

bash
Copy
Edit
sudo cp /etc/bind/db.local /etc/bind/db.linuxclass
sudo vi /etc/bind/db.linuxclass
conf
Copy
Edit
@   IN  A   192.168.1.10
www IN  A   192.168.1.10
bash
Copy
Edit
sudo systemctl restart bind9
dig @localhost www.linuxclass.local
🔐 SSH (Secure Shell)
bash
Copy
Edit
# Server installation
sudo apt install openssh-server

# Start/Enable
sudo systemctl start ssh
sudo systemctl enable ssh

# Test
ssh user@localhost
📁 Network Services – Part II
📂 FTP (vsftpd)
bash
Copy
Edit
sudo apt install vsftpd
sudo systemctl start vsftpd
sudo systemctl enable vsftpd
Anonymous or local access is configurable via:

bash
Copy
Edit
sudo vi /etc/vsftpd.conf
Test via:

bash
Copy
Edit
ftp localhost
📤 NFS (Network File System)
Server Setup:

bash
Copy
Edit
sudo apt install nfs-kernel-server
sudo mkdir -p /srv/nfs/shared
sudo chown nobody:nogroup /srv/nfs/shared
sudo vi /etc/exports
conf
Copy
Edit
/srv/nfs/shared 192.168.1.0/24(rw,sync,no_subtree_check)
bash
Copy
Edit
sudo exportfs -a
sudo systemctl restart nfs-kernel-server
Client Mount:

bash
Copy
Edit
sudo mount 192.168.1.10:/srv/nfs/shared /mnt
🪟 Samba (Windows Sharing)
Install Samba:

bash
Copy
Edit
sudo apt install samba
sudo mkdir -p /srv/samba/shared
sudo chown nobody:nogroup /srv/samba/shared
Edit Config:

bash
Copy
Edit
sudo vi /etc/samba/smb.conf
conf
Copy
Edit
[shared]
   path = /srv/samba/shared
   browsable = yes
   guest ok = yes
   read only = no
bash
Copy
Edit
sudo systemctl restart smbd
Access from Windows:

php-template
Copy
Edit
\\<linux-ip>\shared
📬 Network Services – Part III
📧 Sendmail
Install & Configure:

bash
Copy
Edit
sudo apt install sendmail mailutils
sudo sendmailconfig
echo "Test Mail" | mail -s "Subject" user@example.com
🌐 Apache Web Server
bash
Copy
Edit
sudo apt install apache2
sudo systemctl start apache2
sudo systemctl enable apache2

# Place content in:
cd /var/www/html
echo "Welcome to Linux Class!" > index.html
Access:

cpp
Copy
Edit
http://<your_ip>
🕵️‍♂️ Squid Proxy Server
bash
Copy
Edit
sudo apt install squid
sudo vi /etc/squid/squid.conf

# Change default port (optional):
http_port 3128
bash
Copy
Edit
sudo systemctl restart squid
Configure client browser or terminal proxy:

bash
Copy
Edit
export http_proxy=http://192.168.1.10:3128


🧩 MODULE 7: The X Window System
🪟 X Servers and X Clients
X Server = provides the graphical display and handles input devices (keyboard, mouse).

X Clients = applications that use the X server to display GUI (e.g., xclock, xterm).

bash
Copy
Edit
# Start an X client app
xclock &
xeyes &
💻 XFree86 (Historical)
XFree86 was the first open-source X Server used in Linux.

It has now been replaced by X.Org Server.

bash
Copy
Edit
X -version
🔠 X Fonts
Fonts for X are managed by fontconfig and xfont packages.

bash
Copy
Edit
fc-list          # List all available fonts
xfontsel         # GUI font selector
xset fp+ /usr/share/fonts/misc/   # Add font path
🖼️ GTK and KDE
GTK (GIMP Toolkit): Used by GNOME.

KDE (K Desktop Environment): Built on Qt.

Install basic environments:

bash
Copy
Edit
sudo apt install gnome-core    # GNOME
sudo apt install kde-plasma-desktop  # KDE
🧪 Installation Challenges
Simulate:

bash
Copy
Edit
sudo apt install xorg xinit xterm
startx
Common Issue:

Misconfigured drivers or missing dependencies.

⚙️ Configuration Challenges
X Config File:

bash
Copy
Edit
sudo X -configure
sudo cp /root/xorg.conf.new /etc/X11/xorg.conf
Manually define monitor, mouse, keyboard options in xorg.conf.

🧯 Troubleshooting Challenges
Check logs:

bash
Copy
Edit
cat /var/log/Xorg.0.log | less
Useful Fixes:

Try different desktop environment: startxfce4

Permissions issues: xhost +local:

🧪 Example Script: Minimal X Test with xinit
bash
Copy
Edit
sudo apt install xinit xterm x11-xserver-utils

# Run minimal X session
xinit /usr/bin/xterm
You’ll get a plain X session with just a terminal. You can launch apps from here like:

bash
Copy
Edit
xclock &
xeyes &





























