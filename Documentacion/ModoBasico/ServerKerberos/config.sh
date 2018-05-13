#!/bin/bash
#Config kerveros server
#-----------------------------------------------------------------------
#COnfiguracion servicios

rm -rf /var/kerberos/krb5kdc/kdc.conf
rm -rf /etc/krb5.conf
cp /opt/docker/krb5.conf /etc/krb5.conf
cp /opt/docker/kdc.conf /var/kerberos/krb5kdc/kdc.conf

# BD
/usr/sbin/kdb5_util create -s -P masterkey &>/dev/null

rm -rf /var/kerberos/krb5kdc/kadm5.acl
echo "*/admin@GANDHI.RELOAD *">>/var/kerberos/krb5kdc/kadm5.acl

/usr/sbin/kadmin.local -q "addprinc -pw kadmin admin/admin " &>/dev/null
