#!/bin/bash
# Start service
#-----------------------------------------------------------------------
/usr/sbin/in.tftpd --foreground --address 0.0.0.0:69 -s /var/lib/tftpboot