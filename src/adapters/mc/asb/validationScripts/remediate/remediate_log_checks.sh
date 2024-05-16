#!/bin/bash

os_name=$(grep ^ID= /etc/os-release | tr -d "ID=\"")
os_version=$(grep ^VERSION_ID /etc/os-release | tr -d "VERSION_ID=\"")
package_manager=""

#Using yum for CentOS, Fedora, AlmaLinux, and other RHEL-based distros
if [ -n "$(command -v yum)" ]; then
        package_manager=yum
fi
#Using apt-get for Ubuntu, Debian, and other Debian-based distros
if [ -n "$(command -v apt-get)" ]; then
    package_manager=apt-get
fi
#Using zypper for SLES
if [ "$os_name" = "sles" ]; then
    package_manager=zypher
fi


removeinetd() {
    # remove inetd package
    echo "removing inetd package"
    if [ "$package_manager" = "yum" ]; then
        sudo yum remove -y inetd 
    elif [ "$package_manager" = "apt-get" ]; then
        sudo apt-get remove -y inetutils-inetd 
    elif [ "$package_manager" = "zypher" ]; then
        sudo zypper remove -y inetd 
    fi
}

#Ensure logging is configured
echo "installing syslog,ryslog,syslog-ng,systemd-journald packages"
sudo package_manager install -y rsyslog syslog-ng systemd-journald

#Add the line '$FileCreateMode 0640' to the file '/etc/rsyslog.conf' and restart
echo "Setting permissions on /etc/rsyslog.conf and restarting"
echo '$FileCreateMode 0640' >> /etc/rsyslog.conf
sudo systemctl restart rsyslog


#Set your logger's configuration(/etc/rsyslog.conf & /etc/syslog-ng/syslog-ng.conf when present) files to 0640
echo "Setting permissions on /etc/rsyslog.conf & /etc/syslog-ng/syslog-ng.conf"
sudo chmod 0640 /etc/rsyslog.conf
sudo chmod 0640 /etc/syslog-ng/syslog-ng.conf

#Add the line '$FileGroup adm' to the file '/etc/rsyslog.conf'
echo "Adding the line "\$FileGroup adm" to /etc/rsyslog.conf"
echo '$FileGroup adm' >> /etc/rsyslog.conf

#Add the line '$FileOwner syslog' to the file '/etc/rsyslog.conf' 
echo "Adding the line "\$FileOwner syslog" to /etc/rsyslog.conf"
echo '$FileOwner syslog' >> /etc/rsyslog.conf

#Remove the lines '$ModLoad imudp' and '$ModLoad imtcp' from the file '/etc/rsyslog.conf'
echo "Removing the lines "\$ModLoad imudp" and "\$ModLoad imtcp" from /etc/rsyslog.conf"
sed -i '/$ModLoad imudp/d' /etc/rsyslog.conf
sed -i '/$ModLoad imtcp/d' /etc/rsyslog.conf

#Install the logrotate package and confirm the logrotate cron entry is active (chmod 755 /etc/cron.daily/logrotate; chown root:root /etc/cron.daily/logrotate)
echo "installing logrotate package"
sudo package_manager install -y logrotate
sudo chmod 755 /etc/cron.daily/logrotate
sudo chown root:root /etc/cron.daily/logrotate

#Remove the inetd service
echo "removing inetd service"
removeinetd

#Install the cron package (apt-get install -y cron) and confirm the file '/etc/init/cron.conf' contains the line 'start on runlevel [2345]'
echo "installing cron package"
sudo package_manager install -y cron
echo "start on runlevel [2345]" >> /etc/init/cron.conf

#Run AuditD service (systemctl start auditd)
echo "installing & starting AuditD service"
sudo package_manager install -y auditd
sudo systemctl start auditd
