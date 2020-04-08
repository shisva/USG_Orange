#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

configure

set interfaces ethernet eth0 vif 838 address dhcp
set interfaces ethernet eth0 vif 838 dhcp-options client-option "send vendor-class-identifier &quot;sagem&quot;;"
set interfaces ethernet eth0 vif 838 dhcp-options client-option "send user-class &quot;\047FSVDSL_livebox.MLTV.softathome.Livebox4&quot;;"
set interfaces ethernet eth0 vif 838 dhcp-options client-option "send dhcp-client-identifier 1:xx:xx:xx:xx:xx:xx;"
set interfaces ethernet eth0 vif 838 dhcp-options client-option "request subnet-mask, routers, rfc3442-classless-static-routes;"
set interfaces ethernet eth0 vif 838 dhcp-options default-route no-update
set interfaces ethernet eth0 vif 838 dhcp-options default-route-distance 210
set interfaces ethernet eth0 vif 838 dhcp-options name-server update
set interfaces ethernet eth0 vif 838 egress-qos "0:4 1:4 2:4 3:4 4:4 5:4 6:4 7:4"

set interfaces ethernet eth0 vif 840 address 192.168.255.254/24
set interfaces ethernet eth0 vif 840 egress-qos "0:5 1:5 2:5 3:5 4:5 5:5 6:5 7:5"

set protocols igmp-proxy disable-quickleave

set protocols igmp-proxy interface eth0 role disabled
set protocols igmp-proxy interface eth0 threshold 1

set protocols igmp-proxy interface eth0.832 role disabled
set protocols igmp-proxy interface eth0.832 threshold 1

set protocols igmp-proxy interface eth0.838 role disabled
set protocols igmp-proxy interface eth0.838 threshold 1

set protocols igmp-proxy interface eth0.840 alt-subnet 0.0.0.0/0
set protocols igmp-proxy interface eth0.840 role upstream
set protocols igmp-proxy interface eth0.840 threshold 1

set protocols igmp-proxy interface eth1 role disabled
set protocols igmp-proxy interface eth1 threshold 1

set protocols igmp-proxy interface eth2 alt-subnet 0.0.0.0/0
set protocols igmp-proxy interface eth2 role downstream
set protocols igmp-proxy interface eth2 threshold 1

set service nat rule 6020 description "MASQ LiveboxTV to WAN"
set service nat rule 6020 log disable
set service nat rule 6020 outbound-interface eth0.838
set service nat rule 6020 protocol all
set service nat rule 6020 source group network-group corporate_network
set service nat rule 6020 type masquerade

commit

save