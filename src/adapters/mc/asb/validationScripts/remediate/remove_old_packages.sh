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
removexinetd(){
    # remove xinetd package
    echo "removing xinetd package"
    sudo $package_manager remove -y xinetd
}
removetelnetd(){
    # remove telnetd package
    echo "removing telnetd package"
    if [ "$package_manager" = "yum" ]; then
        sudo yum remove -y telnet-server 
    elif [ "$package_manager" = "apt-get" ]; then
        sudo apt-get remove -y telnetd 
    elif [ "$package_manager" = "zypher" ]; then
        sudo zypper remove -y telnetd 
    fi
}
removercprsh(){
    # remove rsh-server package
    echo "removing rsh-server package"
    sudo $package_manager remove -y rsh-server
    sudo $package_manager remove -y rpcbind
}
removetftpd(){
    # remove tftpd package
    echo "removing tftpd package"
    if [ "$package_manager" = "yum" ]; then
        sudo yum remove -y tftp-server 
    elif [ "$package_manager" = "apt-get" ]; then
        sudo apt-get remove -y tftpd
    elif [ "$package_manager" = "zypher" ]; then
        sudo zypper remove -y tftp-server 
    fi
}
removereadaheadfedora(){
    # remove readahead-fedora package
    echo "removing readahead-fedora package"
    sudo $package_manager remove -y readahead-fedora
}
removebluetooth(){
    # remove bluetooth package
    echo "removing bluetooth package"
    sudo $package_manager remove -y bluetooth
}
removeisdnutils(){
    # remove isdnutils package
    sudo $package_manager remove -y isdnutils
}
removekdumputils(){
    # remove kdump package
    echo "removing kdump package"
    sudo $package_manager remove -y kexec-tools
}
removeavahidaemon(){
    # remove avahi-daemon package
    echo "removing avahi-daemon package"
    sudo $package_manager remove -y avahi-daemon
}
removecups(){
    # remove cups package
    echo "removing cups package"
    sudo $package_manager remove -y cups
}
removedhcpserver(){
    # remove dhcp server package
    echo "removing dhcp server package"
    sudo $package_manager remove -y dhcp dhcp-server
}
removesendmail(){
    # remove sendmail package
    echo "removing sendmail package"
    sudo $package_manager remove -y sendmail
}
removepostfix(){
    # remove postfix package
    echo "removing postfix package"
    sudo $package_manager remove -y postfix
}
removeldap(){
    # Remove ldap package
    echo "removing ldap package"
    sudo $package_manager remove -y slapd
}
removerpcgssd(){
    # Remove rpcgssd package
    echo "removing rpcgssd package"
    sudo $package_manager remove -y nfs-kernel-server
    sudo rm /etc/krb5.keytab
    sudo systemctl restart rpc-gssd
}
removerpcidmapd(){
    # Remove rpcidmapd package
    echo "removing rpcidmapd package"
    sudo $package_manager remove -y nfs-common
    sudo systemctl restart rpc-idmapd
}
removenfs(){
    # Remove nfs package
    echo "removing nfs server"
    sudo $package_manager remove -y nfs-kernal-server
}
removedovecotcore(){
    # Remove dovecot-core package
    echo "removing dovecot-core package"
    sudo $package_manager remove -y dovecot-core
}
removesnmpd(){
    # Remove snmpd package
    echo "removing snmpd package"
    sudo $package_manager remove -y snmpd
}


removeinetd
removexinetd
removetelnetd
removercprsh
removetftpd
removereadaheadfedora
removebluetooth
removeisdnutils
removekdumputils
removeavahidaemon
removecups
removesendmail
removepostfix
removeldap
removerpcgssd
removerpcidmapd
removenfs
removedovecotcore

removeprelink() {
    # remove prelink package
    echo "removing prelink package"
    sudo $package_manager remove -y prelink
}

removebind9() {
    # remove bind9 package
    echo "removing bind9 package"
    if [ "$package_manager" = "yum" ]; then
        sudo yum remove -y bind dnsutils 
    elif [ "$package_manager" = "apt-get" ]; then
        sudo apt-get remove -y bind9 
    elif [ "$package_manager" = "zypher" ]; then
        sudo zypper remove -y bind 
    fi
}

removersync() {
    # remove rsync package
    echo "removing rsync package"
    sudo $package_manager remove -y rsync
}
removenis(){
    # remove nis package
    echo "removing nis package"
    if [ "$package_manager" = "yum" ]; then
        sudo yum remove -y yp-tools ypbind ypserv 
    elif [ "$package_manager" = "apt-get" ]; then
        sudo apt-get remove -y nis 
    elif [ "$package_manager" = "zypper" ]; then
        sudo zypper remove -y nis
    fi
}
removershclient() {
    # remove rsh-client package
    echo "removing rsh-client package"
    if [ "$package_manager" = "yum" ]; then
        sudo yum remove -y epel-release
        sudo yum remove -y rsh 
    elif [ "$package_manager" = "apt-get" ]; then
        sudo apt-get remove -y rsh-client 
    elif [ "$package_manager" = "zypper" ]; then
        sudo zypper remove -y rsh-client
    fi
}
removesamba() {
    echo "removing samba package"
    sudo $package_manager remove -y samba
}


removeprelink
removebind9
removersync
removenis
removershclient
removesamba