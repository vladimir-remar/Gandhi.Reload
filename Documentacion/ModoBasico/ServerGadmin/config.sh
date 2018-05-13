#!/bin/bash
# Server Gadmin
# Administrador
#-----------------------------------------------------------------------
rm -rf /etc/krb5.conf
cp /opt/docker/krb5.conf /etc/krb5.conf
useradd dhcp
mkdir /etc/dhcp
chown -R dhcp.dhcp /etc/dhcp/
echo "gadminproot" |passwd root --stdin &>/dev/null 
ssh-keygen -A &>/dev/null
echo -e "BASE dc=gandhi,dc=reload  \nURI ldap://ldap.gandhi.reload/" >>/etc/openldap/ldap.conf