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


disablePromisc(){
    sudo sed -i 's/PROMISC/ /g' /etc/network/interfaces
    sudo sed -i 's/PROMISC/ /g' /etc/rc.local
    interfaces=$(ip link show | awk -F': ' '{print $2}')
    for interface in $interfaces; do
        echo "Turning off promiscuous mode for $interface"
        sudo ip link set $interface promisc off
    done
}

enableipv6(){
    sudo sysctl -w net.ipv6.conf.all.disable_ipv6=0
    sudo sysctl -w net.ipv6.conf.default.disable_ipv6=0
    sudo sed -i 's/net.ipv6.conf.all.disable_ipv6/net.ipv6.conf.all.disable_ipv6=0/g' /etc/sysctl.conf 
    sudo sed -i 's/net.ipv6.conf.default.disable_ipv6/net.ipv6.conf.default.disable_ipv6=0/g' /etc/sysctl.conf 
        if [ -ne "/proc/net/if_inet6" ]; then
        suod echo " " >> /proc/net/if_inet6
    fi
}


echo "Disabling ICMP Redirect Acceptance"
sudo sysctl -w net.ipv4.conf.default.accept_redirects=0

echo "Disabling Secure ICMP Redirects"
sudo sysctl -w net.ipv4.conf.default.secure_redirects=0

echo "Enabling source routed packets"
sudo net.ipv4.conf.all.accept_source_route=0

echo "Enabling source routed packets(ipv6)"
sudo net.ipv6.conf.all.accept_source_route=0

echo "Disabling ICMP Redirect Acceptance"
sudo net.ipv4.conf.default.accept_source_route=0

echo "Disabling default setting for accepting source routed packets"
sudo net.ipv6.conf.default.accept_source_route=0

echo "Enabling to ignore bogus icmp responses"
sudo net.ipv4.icmp_ignore_bogus_error_responses=1

echo "Enabling to ignore ICMP broadcast pings"
sudo net.ipv4.icmp_echo_ignore_broadcasts=1

echo "Enabling log martians"
sudo net.ipv4.conf.all.log_martians=1

echo "Enabling to perform source validation by reversed path"
sudo net.ipv4.conf.all.rp_filter=1

echo "Enabling to perform source validation by reversed path by default"
sudo net.ipv4.conf.default.rp_filter=1

echo "Enabling TCP SYN cookies"
sudo net.ipv4.tcp_syncookies=1

echo "disabling promisc"
disablePromisc

echo "Enabling ipv6"
enableipv6

echo "Disabling packect redirect sending"
sudo net.ipv4.conf.all.send_redirects=0
sudo net.ipv4.conf.default.send_redirects=0
