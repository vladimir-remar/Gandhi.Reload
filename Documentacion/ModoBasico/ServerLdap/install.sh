#! /bin/bash
rm -rf /etc/openldap/slapd.d/*
rm -rf /var/lib/ldap/*
cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
slaptest -f /opt/docker/slapd.conf -F /etc/openldap/slapd.d
slapadd -F /etc/openldap/slapd.d -l /opt/docker/all-uid-gandhi-reload.ldif
rm -rf /etc/openldap/ldap.conf
cp /opt/docker/ldap.conf /etc/openldap/ldap.conf
chown -R ldap.ldap /etc/openldap/slapd.d/
chown -R ldap.ldap /var/lib/ldap/
