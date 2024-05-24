
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


# Disable randomize_va_space
echo "Disable randomize_va_space"
sudo echo 0 > sudo  /proc/sys/kernel/randomize_va_space

# Ensure '.' appears in root's $PATH
echo "Ensure '.' appears in root's $PATH"
sudo echo "export PATH=$PATH:." >> /root/.bashrc

