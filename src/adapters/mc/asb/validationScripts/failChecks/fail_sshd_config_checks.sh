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

#remove protocol 2 from '/etc/ssh/sshd_config Protocol = 2' (106.1)
echo "remove protocol 2 from '/etc/ssh/sshd_config Protocol = 2'"
sudo sed -i 's/Protocol 2/Protocol 1/g' /etc/ssh/sshd_config
sudo sed -i 's/Protocol 2/Protocol 1/g' /etc/ssh/sshd_config.d/osconfig_remediation.conf

#set '/etc/ssh/sshd_config IgnoreRhosts = no' (106.3)
echo "set '/etc/ssh/sshd_config IgnoreRhosts = no'"
sudo sed -i 's/IgnoreRhosts no/IgnoreRhosts yes/g' /etc/ssh/sshd_config
sudo sed -i 's/IgnoreRhosts no/IgnoreRhosts yes/g' /etc/ssh/sshd_config.d/osconfig_remediation.conf

#Set SSH LogLevel is set to ERROR (106.5)
echo "Set SSH LogLevel is set to ERROR"
sudo sed -i 's/LogLevel INFO/LogLevel ERROR/g' /etc/ssh/sshd_config
sudo sed -i 's/LogLevel INFO/LogLevel ERROR/g' /etc/ssh/sshd_config.d/osconfig_remediation.conf
sudo echo "LogLevel ERROR" >> /etc/ssh/sshd_config

#Set SSH MaxAuthTries is set to 7 or more (106.7)
echo "Set SSH MaxAuthTries is set to 7 or more"
sudo sed -i 's/MaxAuthTries 6/MaxAuthTries 7/g' /etc/ssh/sshd_config
sudo sed -i 's/MaxAuthTries 6/MaxAuthTries 7/g' /etc/ssh/sshd_config.d/osconfig_remediation.conf
sudo echo "MaxAuthTries 7" >> /etc/ssh/sshd_config

#set SSH access to unlimited (106.11)
echo "set SSH access to unlimited"


#Enable Emulation of the rsh command through the ssh server  - '/etc/ssh/sshd_config RhostsRSAAuthentication = yes' (107)
echo "Enable Emulation of the rsh command through the ssh server"
sudo sed -i 's/RhostsRSAAuthentication no/RhostsRSAAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i 's/RhostsRSAAuthentication no/RhostsRSAAuthentication yes/g' /etc/ssh/sshd_config.d/osconfig_remediation.conf
sudo echo "RhostsRSAAuthentication yes" >> /etc/ssh/sshd_config


#Enable SSH host-based authentication  - '/etc/ssh/sshd_config HostbasedAuthentication = no' (108)
echo "Enable SSH host-based authentication"
sudo sed -i 's/HostbasedAuthentication no/HostbasedAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i 's/HostbasedAuthentication no/HostbasedAuthentication yes/g' /etc/ssh/sshd_config.d/osconfig_remediation.conf
sudo echo "HostbasedAuthentication yes" >> /etc/ssh/sshd_config

#Enable root login via SSH. - '/etc/ssh/sshd_config PermitRootLogin = no' (109)
echo "Enable root login via SSH"
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config.d/osconfig_remediation.conf
sudo echo "PermitRootLogin no" >> /etc/ssh/sshd_config

# Allow remote connections from accounts with empty passwords. - '/etc/ssh/sshd_config PermitEmptyPasswords = no' (110)
echo "Allow remote connections from accounts with empty passwords"
sudo sed -i 's/PermitEmptyPasswords yes/PermitEmptyPasswords no/g' /etc/ssh/sshd_config
sudo sed -i 's/PermitEmptyPasswords yes/PermitEmptyPasswords no/g' /etc/ssh/sshd_config.d/osconfig_remediation.conf
sudo echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config

#Ensure SSH Idle Timeout Interval is not configured. (110.1)
echo "Ensure SSH Idle Timeout Interval is not configured"
sudo sed -i '/ClientAliveInterval 0/d' /etc/ssh/sshd_config
sudo sed -i '/ClientAliveInterval 0/d' /etc/ssh/sshd_config.d/osconfig_remediation.conf

#Ensure SSH LoginGraceTime is set to 2 minutes or more. (110.2)
echo "Ensure SSH LoginGraceTime is set to 2 minutes or more"
sudo sed -i '/LoginGraceTime/d' /etc/ssh/sshd_config
sudo sed -i '/LoginGraceTime/d' /etc/ssh/sshd_config.d/osconfig_remediation.conf
sudo echo "LoginGraceTime 120" >> /etc/ssh/sshd_config

#Enable non approved MAC algorithms(110.3)
echo "Enable non approved MAC algorithms"
sudo sed -i '/MAC/d' /etc/ssh/sshd_config
sudo sed -i '/MAC/d' /etc/ssh/sshd_config.d/osconfig_remediation.conf
sudo echo "MACs umac-64@openssh.com,hmac-sha2-256" >> /etc/ssh/sshd_config

#Configure remote/local login warning banner im-properly. (111)
echo "Configure remote/local login warning banner im-properly"
chmod 777 /etc/azsec/banner.txt


#Disable SSH warning banner (111.2)
echo "Disable SSH warning banner"
sudo sed -i '/Banner/d' /etc/ssh/sshd_config
sudo sed -i '/Banner/d' /etc/ssh/sshd_config.d/osconfig_remediation.conf

#Users are allowed to set environment options for SSH. (112)
echo "Users are allowed to set environment options for SSH"
sudo sed -i 's/PermitUserEnvironment no/PermitUserEnvironment yes/g' /etc/ssh/sshd_config
sudo sed -i 's/PermitUserEnvironment no/PermitUserEnvironment yes/g' /etc/ssh/sshd_config.d/osconfig_remediation.conf


#Non-appropriate ciphers are set for SSH. (Ciphers aes128-ctr,aes192-ctr,aes256-ctr) (113)
echo "Non-appropriate ciphers are set for SSH"
sudo sed -i '/Ciphers/d' /etc/ssh/sshd_config
sudo sed -i '/Ciphers/d' /etc/ssh/sshd_config.d/osconfig_remediation.conf


sudo systemctl restart sshd
