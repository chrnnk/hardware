config wireless-controller snmp
    set engine-id "fap-fortinet"
    set contact-info "support@sbtpartners.com"
    set trap-high-cpu-threshold 80
    set trap-high-mem-threshold 80
    config community
        edit 1
            set name "SNMP"
            config hosts
                edit 1
                    set ip SNMP-COLLECTOR-IP 255.255.255.255
                next
            end
        next
    end
    config user
        edit "SNMPname"
            set trap-status enable
        next
    end
end


