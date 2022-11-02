https://community.fortinet.com/t5/FortiGate/Technical-Tip-ISDB-common-admin-operations/ta-p/192971?externalID=FD46115
1) How to check the current version of ISDB.
# diag autoupdate version | grep 'Internet-service' -A6
2) How to list the ALL the ISDB services and their corresponding IDs.
# diagnose internet-service id
3) How to check to which service an IP belongs to. For example, this IP belongs to multiple services. This is valid for FortiOS 6.2 and newer (not before).
# diagnose internet-service match root 40.77.226.249 255.255.255.255
4) How to check the list of IP addresses and ports included in a ISDB service
WARNING! For smaller units, or units running close to max capacity, this may trigger conserve mode when a service with a lot of IPs is displayed (ie. Google, Microsoft, etc)!
# diagnose internet-service id 11796487
5) How to check all the ports included in a ISDB service (FortiOS 6.0 only).
# diagnose internet-service id-summary 327786
