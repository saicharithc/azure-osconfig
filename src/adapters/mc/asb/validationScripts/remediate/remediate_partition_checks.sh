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



#Add ""/var/home.partition /home ext2 loop,noexec,nosuid,nodev,rw 0 0"" into /etc/fstab"
echo "Add ""/var/home.partition /home ext2 loop,noexec,nosuid,nodev,rw 0 0"" into /etc/fstab"
echo "/var/home.partition /home ext2 loop,noexec,nosuid,nodev,rw 0 0" >> /etc/fstab

#Add ""/var/home.partition /tmp ext2 loop,noexec,nosuid,nodev,rw 0 0"" into /etc/fstab"
echo "Add ""/var/home.partition /tmp ext2 loop,noexec,nosuid,nodev,rw 0 0"" into /etc/fstab"
echo "/var/home.partition /tmp ext2 loop,noexec,nosuid,nodev,rw 0 0" >> /etc/fstab

#Add ""/var/home.partition /var/tmp ext2 loop,noexec,nosuid,nodev,rw 0 0"" into /etc/fstab"
echo "Add ""/var/home.partition /var/tmp ext2 loop,noexec,nosuid,nodev,rw 0 0"" into /etc/fstab"
echo "/var/home.partition /var/tmp ext2 loop,noexec,nosuid,nodev,rw 0 0" >> /etc/fstab

#Add ""/var/home.partition /tmp ext2 loop,noexec,nosuid,nodev,rw 0 0"" into /etc/fstab"
echo "Add ""/var/home.partition /tmp ext2 loop,noexec,nosuid,nodev,rw 0 0"" into /etc/fstab"
echo "/var/home.partition /tmp ext2 loop,noexec,nosuid,nodev,rw 0 0" >> /etc/fstab

#Add ""/var/home.partition /var/tmp ext2 loop,noexec,nosuid,nodev,rw 0 0"" into /etc/fstab"
echo "Add ""/var/home.partition /var/tmp ext2 loop,noexec,nosuid,nodev,rw 0 0"" into /etc/fstab"
echo "/var/home.partition /var/tmp ext2 loop,noexec,nosuid,nodev,rw 0 0" >> /etc/fstab

#Add ""/var/home.partition /var/tmp ext2 loop,noexec,nosuid,nodev,rw 0 0"" into /etc/fstab"
echo "Add ""/var/home.partition /var/tmp ext2 loop,noexec,nosuid,nodev,rw 0 0"" into /etc/fstab"
echo "/var/home.partition /var/tmp ext2 loop,noexec,nosuid,nodev,rw 0 0" >> /etc/fstab

#Add ""/var/home.partition /dev/shm ext2 loop,noexec,nosuid,nodev,rw 0 0"" into /etc/fstab"
echo "Add ""/var/home.partition /dev/shm ext2 loop,noexec,nosuid,nodev,rw 0 0"" into /etc/fstab"
echo "/var/home.partition /dev/shm ext2 loop,noexec,nosuid,nodev,rw 0 0" >> /etc/fstab

#Add ""/var/home.partition /media/extdev ext2 loop,noexec,nosuid,nodev,rw 0 0"" into /etc/fstab"
echo "Add ""/var/home.partition /media/extdev ext2 loop,noexec,nosuid,nodev,rw 0 0"" into /etc/fstab"
echo "/var/home.partition /media/extdev ext2 loop,noexec,nosuid,nodev,rw 0 0" >> /etc/fstab

#Add ""/var/home.partition /media/extdev ext2 loop,noexec,nosuid,nodev,rw 0 0"" into /etc/fstab"
echo "Add ""/var/home.partition /media/extdev ext2 loop,noexec,nosuid,nodev,rw 0 0"" into /etc/fstab"
echo "/var/home.partition /media/extdev ext2 loop,noexec,nosuid,nodev,rw 0 0" >> /etc/fstab

#Add ""/var/home.partition /media/extdev ext2 loop,noexec,nosuid,nodev,rw 0 0"" into /etc/fstab"
echo "Add ""/var/home.partition /media/extdev ext2 loop,noexec,nosuid,nodev,rw 0 0"" into /etc/fstab"
echo "/var/home.partition /media/extdev ext2 loop,noexec,nosuid,nodev,rw 0 0" >> /etc/fstab

#Add ""192.168.0.216:/mnt/HDD1    /media/freenas/    nfs    defaults,noexec,nosuid,proto=tcp,port=2049    0 0"" into /etc/fstab"
echo "Add ""192.168.0.216:/mnt/HDD1    /media/freenas/    nfs    defaults,noexec,nosuid,proto=tcp,port=2049    0 0"" into /etc/fstab"
echo "192.168.0.216:/mnt/HDD1    /media/freenas/    nfs    defaults,noexec,nosuid,proto=tcp,port=2049    0 0" >> /etc/fstab
