#!/bin/bash
# Start dockers
#Para ejecutar este scipt situarse en el directorio raiz donde se ecuentra
# el "docker-compose.yml"
#--------------------------------------------
docker-compose start
docker start dhcp.gandhi.reload
docker exec -d dhcp.gandhi.reload /usr/sbin/in.tftpd --foreground --address 192.168.2.57:69 -s /var/lib/tftpboot &disown
docker exec -d dhcp.gandhi.reload /usr/sbin/dhcpd -4 -f -d --no-pid -cf /etc/dhcp/dhcpd.conf enp0s20f0u14
