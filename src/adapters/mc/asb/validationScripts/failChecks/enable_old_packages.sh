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


enablecramfs() {
    # removing the entry to disbale cramfs package
    echo "removing the entry to disbale cramfs package"
    sed -i 's/install cramfs \/bin\/false/ /g' /etc/modprobe.d/blacklistcramfs.conf
}
enablefreevxfs(){
    # removing the entry to disbale freevxfs package
    echo "removing the entry to disbale cramfs package"
    sed -i 's/install freevxfs \/bin\/false/ /g' /etc/modprobe.d/blacklistfreevxfs.conf
}
enablehfs(){
    # removing the entry to disbale hfs package
    echo "removing the entry to disbale hfs package"
    sed -i 's/install hfs \/bin\/false/ /g' /etc/modprobe.d/blacklisthfs.conf
}
enablehfsplus(){
    # removing the entry to disbale hfsplus package
    echo "removing the entry to disbale hfsplus package"
    sed -i 's/install hfsplus \/bin\/false/ /g' /etc/modprobe.d/blacklisthfsplus.conf
}
enablejfs2(){
    # removing the entry to disbale jfs2 package
    echo "removing the entry to disbale jfs2 package"
    sed -i 's/install jfs2 \/bin\/false/ /g' /etc/modprobe.d/blacklistjfs2.conf
}
enablerpcsvc(){
    # removing the entry to disbale rpcsvc package
    echo "adding entry to enable rpcsvc package"
    echo "NEED_SVCGSSD = yes" >> "/etc/inetd.conf"
}

enablecramfs
enablefreevxfs
enablehfs
enablehfsplus
enablejfs2