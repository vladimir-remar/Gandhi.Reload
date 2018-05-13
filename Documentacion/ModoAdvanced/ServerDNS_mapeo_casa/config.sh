#!/bin/bash
# DNS - server Config
#-----------------------------------------------------------------------
rm -rf /etc/named.conf
cp /opt/docker/named.conf /etc/named.conf
cp /opt/docker/1.168.192.db /var/named/.
cp /opt/docker/38.1.168.192.db /var/named/.
cp /opt/docker/gandhi.reload /var/named/.
chown -R .named /var/named/