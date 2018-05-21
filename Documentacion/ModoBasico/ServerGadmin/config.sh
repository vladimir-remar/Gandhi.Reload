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
sed -i -e 's/^uid.*/uid nslcd/; 
         s/^gid.*/gid ldap/;
         s/^uri.*/uri ldap:\/\/ldap.gandhi.reload\//;
         s/^base.*/base dc=gandhi,dc=reload/' /etc/nslcd.conf
sed -i -e 's/^passwd:.*/passwd:    files ldap/; 
        s/^shadow:.*/shadow:    files ldap/; 
        s/^group:.*/group:     files ldap/' /etc/nsswitch.conf
echo -e "BASE dc=gandhi,dc=reload  \nURI ldap://ldap.gandhi.reload/" >>/etc/openldap/ldap.conf
#ldapmodify -x -h ldap.gandhi.reload -D 'cn=Sysadmin,cn=config' -w syskey -f mod_acl.ldif
mkdir -p /opt/log_users/users_ok
mkdir -p /opt/log_users/users_bad
mkdir -p /opt/log_groups/grups_ok
mkdir -p /opt/log_groups/grups_bad