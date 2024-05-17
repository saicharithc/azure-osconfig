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


disablecramfs() {
    # disabling cramfs package
    echo "disabling cramfs package"
    echo "install cramfs /bin/false" > /etc/modprobe.d/blacklistcramfs.conf
}
disablefreevxfs(){
    # disabling freevxfs package
    echo "disabling freevxfs package"
    echo "install freevxfs /bin/false" > /etc/modprobe.d/blacklistfreevxfs.conf
}
disablehfs(){
    # disabling hfs package
    echo "disabling hfs package"
    echo "install hfs /bin/false" > /etc/modprobe.d/blacklisthfs.conf
}
disablehfsplus(){
    # disabling hfsplus package
    echo "disabling hfsplus package"
    echo "install hfsplus /bin/false" > /etc/modprobe.d/blacklisthfsplus.conf
}
disablejffs2(){
    # disabling jffs2 package
    echo "disabling jffs2 package"
    echo "install jffs2 /bin/false" > /etc/modprobe.d/blacklistjffs2.conf
}
disablerpcsvc(){
    # removing the entry to disbale rpcsvc package
    echo "removing the entry to disbale rpcsvc package"
    sed -i 's/NEED_SVCGSSD = yes/ /g' /etc/inetd.conf
}
disabledccp(){
    # disabling dccp package
    echo "disabling dccp package"
    echo "install dccp /bin/false" > /etc/modprobe.d/blacklistdccp.conf
    sudo modprobe -r dccp 
}
disbalesctp(){
    # disabling sctp package
    echo "disabling sctp package"
    echo "install sctp /bin/false" > /etc/modprobe.d/blacklistsctp.conf
    sudo modprobe -r sctp 
}
disabletipc(){
    # disabling tipc package
    echo "disabling tipc package"
    echo "install tipc /bin/false" > /etc/modprobe.d/blacklisttipc.conf
    sudo modprobe -r tipc 
}
disableusbmounting(){
    # disabling usbmounting package
    echo "disabling usbmounting package"
    echo "install usb-storage /bin/false" > /etc/modprobe.d/blacklistusbmounting.conf
    sudo modprobe -r usb-storage 
}
disableautofs(){
    # disabling autofs package
    echo "disabling autofs package"
    sudo $package_manager remove -y autofs
}

disablecramfs
disablefreevxfs
disablehfs
disablehfsplus
disablejffs2
disablerpcsvc
disabledccp
disbalesctp
disabletipc
disableusbmounting
disableautofs
