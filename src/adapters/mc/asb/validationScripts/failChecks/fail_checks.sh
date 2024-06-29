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




wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/enable_old_packages.sh -O enable_old_packages.sh
wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/fail_file_permission_checks.sh -O fail_file_permission_checks.sh
wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/fail_network_config_checks.sh -O fail_network_config_checks.sh
wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/install_old_packages.sh -O install_old_packages.sh
wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/fail_log_checks.sh -O fail_log_checks.sh
wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/fail_partition_checks.sh -O fail_partition_checks.sh
wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/fail_user_group_checks.sh -O fail_user_group_checks.sh
wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/fail_sshd_config_checks.sh -O fail_sshd_config_checks.sh
wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/fail_password_checks.sh -O fail_password_checks.sh
wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/fail_misc.sh -O fail_misc.sh

chmod 777 ./*.sh 


sudo $package_manager update
sudo ./fail_file_permission_checks.sh

sudo ./fail_log_checks.sh
sudo ./fail_partition_checks.sh
sudo ./fail_sshd_config_checks.sh
sudo ./fail_password_checks.sh

sudo ./install_old_packages.sh
sudo ./enable_old_packages.sh

sudo ./fail_user_group_checks.sh

sudo ./fail_misc.sh
sudo ./fail_network_config_checks.sh


# wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/fail_checks.sh -O fail_checks.sh
# chmod 777 fail_checks.sh
# sudo ./fail_checks.sh


