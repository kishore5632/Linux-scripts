# Create custom script
sudo nano /etc/init.d/myapache

# Add the following:
#!/bin/bash
case "$1" in
  start) /usr/sbin/httpd ;;
  stop)  killall httpd ;;
esac

# Make it executable
chmod +x /etc/init.d/myapache

# Add to boot
chkconfig --add myapache
chkconfig myapache on
