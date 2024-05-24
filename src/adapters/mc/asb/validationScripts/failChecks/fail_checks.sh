wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/enable_old_packages.sh 
wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/fail_file_permission_checks.sh
wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/fail_network_config_checks.sh
wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/install_old_packages.sh
wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/fail_log_checks.sh
wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/fail_partition_checks.sh
wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/fail_user_group_checks.sh
wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/fail_sshd_config_checks.sh
wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/fail_password_checks.sh
wget https://raw.githubusercontent.com/saicharithc/azure-osconfig/user/saicharithc/asmv2_validation_scripts/src/adapters/mc/asb/validationScripts/failChecks/fail_misc.sh

chmod 777 enable_old_packages.sh fail_file_permission_checks.sh fail_network_config_checks.sh install_old_packages.sh fail_log_checks.sh ./fail_partition_checks.sh ./fail_user_group_checks.sh ./fail_sshd_config_checks.sh ./fail_password_checks.sh fail_misc.sh


sudo ./fail_file_permission_checks.sh
sudo ./fail_network_config_checks.sh
sudo ./fail_log_checks.sh
sudo ./fail_partition_checks.sh
sudo ./fail_sshd_config_checks.sh
sudo ./fail_password_checks.sh

sudo ./install_old_packages.sh
sudo ./enable_old_packages.sh
sudo ./fail_misc.sh

# sudo ./fail_user_group_checks.sh