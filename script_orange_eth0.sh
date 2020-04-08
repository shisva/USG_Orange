#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

configure

set interfaces ethernet eth0 vif 832 dhcp-options client-option "send vendor-class-identifier &quot;sagem&quot;;"
set interfaces ethernet eth0 vif 832 dhcp-options client-option "send user-class &quot;\053FSVDSL_livebox.Internet.softathome.Livebox4&quot;;"
set interfaces ethernet eth0 vif 832 dhcp-options client-option "send rfc3118-auth xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx;"
set interfaces ethernet eth0 vif 832 dhcp-options client-option "send dhcp-client-identifier 1:YY:YY:YY:YY:YY:YY;"
set interfaces ethernet eth0 vif 832 dhcp-options client-option "request subnet-mask, routers, domain-name-servers, domain-name, broadcast-address, dhcp-lease-time, dhcp-renewal-time, dhcp-rebinding-time, rfc3118-auth;"
set interfaces ethernet eth0 vif 832 egress-qos "0:0 1:0 2:0 3:0 4:0 5:0 6:6 7:0"

commit

save