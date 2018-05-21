#!/bin/bash
# Create all images and dockers
#--------------------------------------------
docker-compose up -d
#DHCP server
echo "server dhcp are building"
echo "after that must do:"
echo "/usr/sbin/in.tftpd --foreground --address 192.168.1.38:69 -s /var/lib/tftpboot &disown"
echo "/usr/sbin/dhcpd -4 -f -d --no-pid -cf /etc/dhcp/dhcpd.conf enp0s20u6"
cd Documentacion/ModoAdvanced/ServerDHCP/
docker build -t gandhireload_dhcp .
docker run --name dhcp.gandhi.reload -h dhcp.gandhi.reload --network=host --privileged=True --volumes-from gadmin.gandhi.reload -v tftp:/var/lib/tftpboot -it gandhireload_dhcp
#Una vez dentro del docker de dhcp ejecutamos
# Tener en cuenta cambiar la interficie de red según la que vayamos
# a utilizar
#------------------
# /usr/sbin/in.tftpd --foreground --address 192.168.2.57:69 -s /var/lib/tftpboot &disown
#/usr/sbin/ip a a 10.10.0.1/24 dev enp0s20f0u14
# /usr/sbin/dhcpd -4 -f -d --no-pid -cf /etc/dhcp/dhcpd.conf enp0s20f0u14
#
#------------------