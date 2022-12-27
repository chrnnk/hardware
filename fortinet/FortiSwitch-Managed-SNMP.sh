# https://community.fortinet.com/t5/FortiGate/Troubleshooting-Tip-Configure-SNMP-for-Managed-FortiSwitch-using/ta-p/196381
# https://fortinetweb.s3.amazonaws.com/docs.fortinet.com/v2/attachments/d25d773a-37d0-11ea-9384-00505692583a/FortiSwitch-6.2.3-Managed_by_FortiOS_6.2.pdf
config switch-controller security-policy local-access
show
edit default
set mgmt-allowaccess https ping ssh snmp
set internal-allowaccess https ping ssh snmp
end

config switch-controller custom-command

edit snmp1
set command "config system interface %0a edit internal %0a set allowaccess http https ping snmp ssh telnet %0a end %0a"
next

edit snmp2
set command "config system snmp community %0a edit 2 %0a config hosts %0a edit 1 %0a set interface internal %0a set ip 192.168.1.10 255.255.255.255 %0a next %0a end %0a set name SNMPCOMMUNITY %0a next %0a end %0a"
next

edit snmp3
set command "config system snmp sysinfo %0a set contact-info test2 %0a set description test %0a set location test1 %0a set status enable %0a end %0a"
end

config switch-controller managed-switch
edit "SWITCHSERIALNUMBER"
config custom-command
edit "1"
set command-name "snmp1"
next
edit "2"
set command-name "snmp2"
next
edit "3"
set command-name "snmp3"
next

config firewall policy
edit 1
set srcintf <fortilink interface name>
set dstintf <interface name where SNMP server is located>
set srcaddr "all"
set dstaddr "all"
set action accept
set schedule "always"
set service "SNMP" "ALL_ICMP" "PING"
set nat enable
end
