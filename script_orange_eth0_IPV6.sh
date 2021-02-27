#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

configure

set interfaces ethernet eth0 vif 832 ipv6 address autoconf
set interfaces ethernet eth0 vif 832 ipv6 dup-addr-detect-transmits 1

set interfaces ethernet eth1 ipv6 dup-addr-detect-transmits 1
set interfaces ethernet eth1 ipv6 router-advert cur-hop-limit 64
set interfaces ethernet eth1 ipv6 router-advert link-mtu 0
set interfaces ethernet eth1 ipv6 router-advert managed-flag false
set interfaces ethernet eth1 ipv6 router-advert max-interval 600
set interfaces ethernet eth1 ipv6 router-advert other-config-flag false
set interfaces ethernet eth1 ipv6 router-advert prefix ::/64 autonomous-flag true
set interfaces ethernet eth1 ipv6 router-advert prefix ::/64 on-link-flag true
set interfaces ethernet eth1 ipv6 router-advert prefix ::/64 valid-lifetime 2592000
set interfaces ethernet eth1 ipv6 router-advert reachable-time 0
set interfaces ethernet eth1 ipv6 router-advert retrans-timer 0
set interfaces ethernet eth1 ipv6 router-advert send-advert true

commit

save