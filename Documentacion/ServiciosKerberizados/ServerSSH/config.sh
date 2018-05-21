#!/bin/bash
# Server ssh kerberizedd
# Administrador
#-----------------------------------------------------------------------
echo "sshroot" |passwd root --stdin &>/dev/null 
ssh-keygen -A &>/dev/null
rm -rf /etc/krb5.conf
cp krb5.conf /etc/krb5.conf
#-----------------------------------------------------------------------
# descomentar esta linea y ejecutar "usernologinsshserver.sh" si se quiere
#un servidor ssh kerberizado puro
sed -i  's/#KerberosAuthentication no/KerberosAuthentication yes/; s/#KerberosTicketCleanup yes/KerberosTicketCleanup yes/' /etc/ssh/sshd_config

#Part com client

sed -i -e 's/^uid.*/uid nslcd/; 
         s/^gid.*/gid ldap/;
         s/^uri.*/uri ldap:\/\/ldap.gandhi.reload\//;
         s/^base.*/base dc=gandhi,dc=reload/' /etc/nslcd.conf
sed -i -e 's/^passwd:.*/passwd:    files ldap/; 
        s/^shadow:.*/shadow:    files ldap/; 
        s/^group:.*/group:     files ldap/' /etc/nsswitch.conf
echo -e "BASE dc=gandhi,dc=reload  \nURI ldap://ldap.gandhi.reload/" >>/etc/openldap/ldap.conf


#Comentar estas lineas si solo se quieres un ssh kerberizado puro
sed -i -r 's/(<.*.Volume definitions.*.)/\1\n\t\t<volume fstype="nfs" server="nfs.gandhi.reload" mountpoint="~" path="\/mnt\/dades\/%(GROUP)\/%(USER)" \/>/' /etc/security/pam_mount.conf.xml
rm -rf /etc/pam.d/system-auth
cp system-auth.new /etc/pam.d/system-auth
cp /etc/pam.d/sshd /etc/pam.d/sshd.bk
rm -rf /etc/pam.d/sshd
cp sshd.new /etc/pam.d/sshd