#!/bin/bash
#DHCP server
# Este donfig se ejecutara
#-----------------------------------------------------------------------
#Añadimos la ip sobre la interfaz donde vamos a trabajar
useradd dhcp
chown -R dhcp.dhcp /etc/dhcp/
rm -rf /etc/dhcp/dhcp.conf
cp dhcp.conf /etc/dhcp/dhcpd.conf
# mkdir -p /var/lib/tftpboot/pxelinux.cfg
# cp /usr/share/syslinux/{pxelinux.0,vesamenu.c32,ldlinux.c32,libcom32.c32,libutil.c32} /var/lib/tftpboot/
#CONFIG server TFTP

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