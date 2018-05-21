#!/bin/bash
# Start service
#-----------------------------------------------------------------------
#/usr/sbin/in.tftpd --foreground --address 0.0.0.0:69 -s /var/lib/tftpboot
#/usr/sbin/in.tftpd --foreground --address 192.168.2.57:69 -s /var/lib/tftpboot &disown
/usr/sbin/in.tftpd -L -s /var/lib/tftpboot 