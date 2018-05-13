#!/bin/bash
#DHCP server
# Este donfig se ejecutara
#-----------------------------------------------------------------------
#Añadimos la ip sobre la interfaz donde vamos a trabajar
useradd dhcp
chown -R dhcp.dhcp /etc/dhcp/
rm -rf /etc/dhcp/dhcp.conf
cp dhcp.conf /etc/dhcp/dhcp.conf
