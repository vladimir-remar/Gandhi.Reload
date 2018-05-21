#! /bin/bash
# Vladimir
# Script de proposito unico
# Modificacio de fitxers per la validacio via ldap
#-----------------------------------------------------------------------
#authconfig --enableldap --enableshadow  --enableldapauth --enablelocauthorize --ldapserver=ldap://ldap.gandhi.reload/ --ldapbasedn=dc=gandhi,dc=reload  --updateall
sed -i -e 's/^uid.*/uid nslcd/; 
         s/^gid.*/gid ldap/;
         s/^uri.*/uri ldap:\/\/ldap.gandhi.reload\//;
         s/^base.*/base dc=gandhi,dc=reload/' /etc/nslcd.conf
sed -i -e 's/^passwd:.*/passwd:    files ldap/; 
        s/^shadow:.*/shadow:    files ldap/; 
        s/^group:.*/group:     files ldap/' /etc/nsswitch.conf
echo -e "BASE dc=gandhi,dc=reload  \nURI ldap://ldap.gandhi.reload/" >>/etc/openldap/ldap.conf
rm -rf /etc/pam.d/system-auth
cp system-auth.new /etc/pam.d/system-auth
rm -rf /etc/krb5.conf
cp krb5.conf /etc/krb5.conf
##### MODIFICAR a partir de aqui

#authconfig --enableldap --enableshadow --enableldapauth --enablelocauthorize --ldapserver=ldap://serverldap/ --ldapbasedn=dc=gandhi,dc=reload --updateall &>/dev/null


sed -i -r 's/(<.*.Volume definitions.*.)/\1\n\t\t<volume fstype="nfs" server="nfs.gandhi.reload" mountpoint="~\/%(USER)\/" path="\/mnt\/dades\/%(GROUP)\/%(USER)" \/>/' /etc/security/pam_mount.conf.xml
