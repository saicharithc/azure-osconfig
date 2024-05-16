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

echo "restricting core dumps"
sudo echo "* hard core 0" >> /etc/security/limits.conf
sudo fs.suid_dumpable=0 

echo "restricting permissions on /etc/motd"
sudo chown root:root /etc/motd
sudo chmod 0644 /etc/motd

echo "restricting permissions on /etc/issue"
sudo chown root:root /etc/issue
sudo chmod 0644 /etc/issue

echo "restricting permissions on /etc/issue.net"
sudo chown root:root /etc/issue.net
sudo chmod 0644 /etc/issue.net

echo "restricting permissions on /etc/hosts.allow"
sudo chown root:root /etc/hosts.allow
sudo chmod 0644 /etc/hosts.allow

echo "restricting permissions on /etc/hosts.deny"
sudo chown root:root /etc/hosts.deny
sudo chmod 0644 /etc/hosts.deny

echo "restricting permissions on /etc/ssh/sshd_config"
sudo chown root:root /etc/ssh/sshd_config
sudo chmod 0600 /etc/ssh/sshd_config

echo "setting permissions on /etc/shadow"
sudo chmod 0400 /etc/shadow

echo "setting permissions on /etc/shadow-"
sudo chmod 0400 /etc/shadow-

echo "setting permissions on /etc/gshadow"
sudo chmod 0400 /etc/gshadow

echo "setting permissions on /etc/gshadow-"
sudo chmod 0400 /etc/gshadow-

echo "setting permissions on /etc/passwd"
sudo chown root:root /etc/passwd
sudo chmod 0644 /etc/passwd

echo "setting permissions on /etc/group"
sudo chown root:root /etc/group
sudo chmod 0644 /etc/group

echo "setting permissions on /etc/passwd-"
sudo chown root:root /etc/passwd-
sudo chmod 0600 /etc/passwd-

echo "setting permissions on /etc/group-"
sudo chown root:root /etc/group-
sudo chmod 0644 /etc/group-

echo "setting permissions on user home directories"
sudo chmod 750 /home/*

echo "setting permissions on bootloader config"
sudo chown root:root $BOOTLOADER_CONFIG_FILE_PATH
sudo chmod 0600 $BOOTLOADER_CONFIG_FILE_PATH

echo "setting permissions on /etc/anacrontab"
sudo chown root:root /etc/anacrontab
sudo chmod 0600 /etc/anacrontab

echo "setting permissions on /etc/cron.d"
sudo chown root:root /etc/cron.d
sudo chmod 0700 /etc/cron.d

echo "setting permissions on /etc/cron.daily"
sudo chown root:root /etc/cron.daily
sudo chmod 0700 /etc/cron.daily

echo "setting permissions on /etc/cron.hourly"
sudo chown root:root /etc/cron.hourly
sudo chmod 0700 /etc/cron.hourly

echo "setting permissions on /etc/cron.monthly"
sudo chown root:root /etc/cron.monthly
sudo chmod 0700 /etc/cron.monthly

echo "setting permissions on /etc/cron.weekly"
sudo chown root:root /etc/cron.weekly
sudo chmod 0700 /etc/cron.weekly

echo "restricting at/cron to authorized users"
sudo rm /etc/at.deny
sudo rm /etc/cron.deny
sudo touch /etc/at.allow
sudo chown root:root /etc/at.allow
sudo chmod 0600 /etc/at.allow
sudo touch /etc/cron.allow
sudo chown root:root /etc/cron.allow
sudo chmod 0600 /etc/cron.allow