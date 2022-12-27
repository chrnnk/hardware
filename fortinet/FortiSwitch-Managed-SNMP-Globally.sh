# https://fortinetweb.s3.amazonaws.com/docs.fortinet.com/v2/attachments/d25d773a-37d0-11ea-9384-00505692583a/FortiSwitch-6.2.3-Managed_by_FortiOS_6.2.pdf
# Configuring SNMP globally
# To configure SNMP globally, configure the following settings:
# 1. Configure the SNMP system information.
# 2. Configure the SNMP community.
# 3. Configure the SNMP trap threshold values.
# 4. Configure the SNMP user.
# 
# To configure the SNMP system information globally:
config switch-controller snmp-sysinfo
set status enable
set engine-id <local_SNMP_engine_ID (the maximum is 24 characters)>
set description <system_description>
set contact-info <contact_information>
set location <FortiGate_location>
end
# To configure the SNMP community globally:
config switch-controller snmp-community
edit <SNMP_community_ID>
set status enable
set query-v1-status enable
set query-v1-port <0-65535; the default is 161>
set query-v2c-status enable
set query-v2c-port <0-65535; the default is 161>
set trap-v1-status enable
set trap-v1-lport <0-65535; the default is 162>
set trap-v1-rport <0-65535; the default is 162>
set trap-v2c-status enable
set trap-v2c-lport <0-65535; the default is 162>
set trap-v2c-rport <0-65535; the default is 162>
set events {cpu-high mem-low log-full intf-ip ent-conf-change}
config hosts
edit <host_entry_ID>
set ip <IPv4_address_of_the_SNMP_manager>
end
end
# To configure the SNMP trap threshold values globally:
config switch-controller snmp-trap-threshold
set trap-high-cpu-threshold <percentage_value; the default is 80>
set trap-low-memory-threshold <percentage_value; the default is 80>
set trap-log-full-threshold <percentage_value; the default is 90>
end
# To configure the SNMP user globally:
config switch-controller snmp-user
edit <SNMP_user_name>
set queries enable
set query-port <0-65535; the default is 161>
set security-level {auth-priv | auth-no-priv | no-auth-no-priv}
set auth-proto {md5 | sha}
set auth-pwd <password_for_authentication_protocol>
set priv-proto {aes | des}
set priv-pwd <password_for_encryption_protocol>
end
