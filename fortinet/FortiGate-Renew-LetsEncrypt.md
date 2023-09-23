If FortiGate is set-up in HA, run the following commands on all HA cluster members:  
1) Check ACME status :  
```
get system acme status
get system acme acc-details
```
2) To force config regeneration and certificate renewal:  
```
diagnose sys acme regenerate-client-config
diagnose sys acme restart
```
3) Wait 2-3 minutes, and check the certificate status:
```
get vpn certificate local details <Local certificate name>
diagnose sys acme status-full <Certificate’s CN domain>
```
Sample output when ACME certificate is renewed:
``
get vpn certificate local details acme-cert
diagnose sys acme status-full test.ftntlab.de
```
