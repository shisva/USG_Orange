#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

configure

set firewall ipv6-name WAN_IN-6 default-action drop
set firewall ipv6-name WAN_IN-6 description "packets from internet to intranet"

set firewall ipv6-name WAN_IN-6 rule 3001 action accept
set firewall ipv6-name WAN_IN-6 rule 3001 state established enable
set firewall ipv6-name WAN_IN-6 rule 3001 state related enable
set firewall ipv6-name WAN_IN-6 rule 3001 description "allow established/related sessions"

set firewall ipv6-name WAN_IN-6 rule 3002 action drop
set firewall ipv6-name WAN_IN-6 rule 3002 state invalid enable
set firewall ipv6-name WAN_IN-6 rule 3002 description "drop Invalid state"

set firewall ipv6-name WAN_IN-6 rule 3003 action accept
set firewall ipv6-name WAN_IN-6 rule 3003 protocol icmpv6
set firewall ipv6-name WAN_IN-6 rule 3003 description "allow ICMPv6"

set firewall ipv6-name WAN_LOCAL-6 default-action drop
set firewall ipv6-name WAN_LOCAL-6 description "packets from internet to gateway"

set firewall ipv6-name WAN_LOCAL-6 rule 3001 action accept
set firewall ipv6-name WAN_LOCAL-6 rule 3001 state established enable
set firewall ipv6-name WAN_LOCAL-6 rule 3001 state related enable
set firewall ipv6-name WAN_LOCAL-6 rule 3001 description "allow established/related sessions"

set firewall ipv6-name WAN_LOCAL-6 rule 3002 action drop
set firewall ipv6-name WAN_LOCAL-6 rule 3002 state invalid enable
set firewall ipv6-name WAN_LOCAL-6 rule 3002 description "drop Invalid state"

set firewall ipv6-name WAN_LOCAL-6 rule 3003 action accept
set firewall ipv6-name WAN_LOCAL-6 rule 3003 protocol icmpv6
set firewall ipv6-name WAN_LOCAL-6 rule 3003 description "allow ICMPv6"

set firewall ipv6-name WAN_LOCAL-6 rule 3004 description "allow DHCPv6 client/server"
set firewall ipv6-name WAN_LOCAL-6 rule 3004 action accept
set firewall ipv6-name WAN_LOCAL-6 rule 3004 destination port 546
set firewall ipv6-name WAN_LOCAL-6 rule 3004 protocol udp
set firewall ipv6-name WAN_LOCAL-6 rule 3004 source port 547  

set firewall ipv6-name WAN_OUT-6 default-action accept
set firewall ipv6-name WAN_OUT-6 description "packets to internet"

set interfaces ethernet eth0 vif 832 firewall in ipv6-name WAN_IN-6
set interfaces ethernet eth0 vif 832 firewall local ipv6-name WAN_LOCAL-6
set interfaces ethernet eth0 vif 832 firewall out ipv6-name WAN_OUT-6
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