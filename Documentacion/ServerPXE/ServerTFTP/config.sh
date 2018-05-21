#!/bin/bash
# config file per tftp server
#---------------------------------------------------
mkdir -p /var/lib/tftpboot/pxelinux.cfg
cp /usr/share/syslinux/{pxelinux.0,vesamenu.c32,ldlinux.c32,libcom32.c32,libutil.c32} /var/lib/tftpboot/

cat << EOF > /var/lib/tftpboot/pxelinux.cfg/default
default vesamenu.c32
prompt 1
timeout 600

label linux
menu label ^Install Fedora 26 64-bit
menu default
kernel f26/vmlinuz
append initrd=f26/initrd.img inst.stage2=http://download.fedoraproject.org/pub/fedora/linux/releases/26/Server/x86_64/os/ ip=dhcp

label local
menu label Boot from ^local drive
localboot 0xffff
EOF

mkdir -p /var/lib/tftpboot/f26
cd /tmp
wget --timeout=3s --tries=1 http://download.fedoraproject.org/pub/fedora/linux/releases/26/Server/x86_64/os/images/pxeboot/vmlinuz 
wget --timeout=3s --tries=1 http://download.fedoraproject.org/pub/fedora/linux/releases/26/Server/x86_64/os/images/pxeboot/vmlinuz 

wget --timeout=3s --tries=1 http://download.fedoraproject.org/pub/fedora/linux/releases/26/Server/x86_64/os/images/pxeboot/initrd.img
wget  --timeout=3s --tries=1 http://download.fedoraproject.org/pub/fedora/linux/releases/26/Server/x86_64/os/images/pxeboot/initrd.img
wget --timeout=3s --tries=1 http://download.fedoraproject.org/pub/fedora/linux/releases/26/Server/x86_64/os/images/pxeboot/vmlinuz 
cp vmlinuz /var/lib/tftpboot/f26/.
cp initrd.img /var/lib/tftpboot/f26/.