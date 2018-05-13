#!/bin/bash
# config file per tftp server
#---------------------------------------------------
mkdir -p /var/lib/tftpboot/pxelinux.cfg
cp /usr/share/syslinux/{pxelinux.0,vesamenu.c32,ldlinux.c32,libcom32.c32,libutil.c32} /var/lib/tftpboot/

