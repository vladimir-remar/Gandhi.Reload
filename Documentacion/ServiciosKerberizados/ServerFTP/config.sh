#!/bin/bash
# Server Gadmin
# Administrador
#-----------------------------------------------------------------------
rm -rf /etc/krb5.conf
cp krb5.conf /etc/krb5.conf
rm -rf /etc/pam.d/vsftpd
cp vsftpd-ldap /etc/pam.d/vsftpd


#sed -i 's/listen=NO/listen=YES/; s/listen_ipv6=YES/listen_ipv6=NO/' /etc/vsftpd/vsftpd.conf
echo "background=NO">>/etc/vsftpd/vsftpd.conf 
echo "pasv_enable=NO"  >>/etc/vsftpd/vsftpd.conf
# Descomenta si quieres hacer funcionar la opcion pasiva del servidor
# y Cambia el pasv_enable=NO por pasv_enable=YES
#echo "pasv_min_port=50000" >>/etc/vsftpd/vsftpd.conf
#echo "pasv_max_port=50050" >>/etc/vsftpd/vsftpd.conf
echo "port_enable=YES" >>/etc/vsftpd/vsftpd.conf

# Users "locals" sense password
useradd ho
useradd hiro
#User local amb password
useradd lvladimir
echo "1234" | passwd lvladimir --stdin &>/dev/null 

sed -i -e 's/^uid.*/uid nslcd/; 
         s/^gid.*/gid ldap/;
         s/^uri.*/uri ldap:\/\/ldap.gandhi.reload\//;
         s/^base.*/base dc=gandhi,dc=reload/' /etc/nslcd.conf
sed -i -e 's/^passwd:.*/passwd:    files ldap/; 
        s/^shadow:.*/shadow:    files ldap/; 
        s/^group:.*/group:     files ldap/' /etc/nsswitch.conf

echo -e "BASE dc=gandhi,dc=reload  \nURI ldap://ldap.gandhi.reload/" >>/etc/openldap/ldap.conf

cp /etc/pam.d/system-auth /etc/pam.d/system-auth.bk
rm -rf /etc/pam.d/system-auth
cp system-auth.new /etc/pam.d/system-auth

sed -i -r 's/(<.*.Volume definitions.*.)/\1\n\t\t<volume fstype="nfs" server="nfs.gandhi.reload" mountpoint="~" path="\/mnt\/dades\/%(GROUP)\/%(USER)" \/>/' /etc/security/pam_mount.conf.xml
mkdir -p /home/users/inf
chmod 777 /home/users/inf
cp config.tar.gz /var/ftp/pub/config.tar.gz && echo "okcp"
chmod -R 777 /var/ftp/