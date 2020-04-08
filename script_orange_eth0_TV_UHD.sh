#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

configure

set interfaces ethernet eth0 vif 840 address 192.168.255.254/24
set interfaces ethernet eth0 vif 840 egress-qos "0:5 1:5 2:5 3:5 4:5 5:5 6:5 7:5"

set protocols igmp-proxy disable-quickleave

set protocols igmp-proxy interface eth0 role disabled
set protocols igmp-proxy interface eth0 threshold 1

set protocols igmp-proxy interface eth0.832 role disabled
set protocols igmp-proxy interface eth0.832 threshold 1

set protocols igmp-proxy interface eth0.840 alt-subnet 0.0.0.0/0
set protocols igmp-proxy interface eth0.840 role upstream
set protocols igmp-proxy interface eth0.840 threshold 1

set protocols igmp-proxy interface eth1 role disabled
set protocols igmp-proxy interface eth1 threshold 1

set protocols igmp-proxy interface eth2 alt-subnet 0.0.0.0/0
set protocols igmp-proxy interface eth2 role downstream
set protocols igmp-proxy interface eth2 threshold 1

set service dhcp-server global-parameters "option Vendor-specific code 125 = string;"

set service dhcp-server shared-network-name net_LIVEBOX_TV_eth2_192.168.20.0-24 subnet 192.168.20.0/24 subnet-parameters "option vendor-specific 00:00:0d:e9:24:04:06:YY:YY:YY:YY:YY:YY:05:0f:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:06:09:4c:69:76:65:62:6f:78:20:VV;"

commit

save