#!/bin/bash
#DHCP server
#-----------------------------------------------------------------------
/usr/sbin/dhcpd -4 -f -d --no-pid -cf /etc/dhcp/dhcpd.conf