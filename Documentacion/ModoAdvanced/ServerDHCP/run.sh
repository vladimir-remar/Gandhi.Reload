#!/bin/bash
#start dhcp
#-------------------------------------------
/usr/sbin/dhcpd -4 -f -d --no-pid -cf /etc/dhcp/dhcpd.conf enp0s20f0u14