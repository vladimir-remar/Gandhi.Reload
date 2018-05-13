#! /bin/bash
# Vladimir
# Script de proposito unico
# Modificacio de fitxers per la validacio via ldap
#-----------------------------------------------------------------------


authconfig --enableldapauth  --enableldap --enablemkhomedir --enableshadow --enablekrb5 --enablelocauthorize --ldapserver=ldap://ldap.gandhi.reload/ --ldapbasedn=dc=gandhi,dc=reload --krb5adminserver=krb.gandhi.reload --krb5realm=GANDHI.RELOAD  --krb5kdc=krb.gandhi.reload --updateall
rm -rf /etc/pam.d/system-auth
cp system-auth.new /etc/pam.d/system-auth
sed -i -r 's/(<.*.Volume definitions.*.)/\1\n\t\t<volume fstype="nfs" server="nfs.gandhi.reload" mountpoint="~" path="\/mnt\/dades\/%(GROUP)\/%(USER)" \/>/' /etc/security/pam_mount.conf.xml

