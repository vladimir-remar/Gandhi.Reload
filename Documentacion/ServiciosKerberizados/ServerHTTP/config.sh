#!/bin/bash
# Config servidor
#-----------------------------------------------------------------------
rm -rf /etc/krb5.conf
cp krb5.conf /etc/krb5.conf


echo "HTTP/httpserver.gandhi.reload" > /etc/httpd/conf.d/krb5.keytab 
chown apache  /etc/httpd/conf.d/krb5.keytab
cat << EOF > /etc/httpd/conf.d/auth_kerberos.conf
<Directory /var/www/html/auth-kerberos>
    AuthType Kerberos
    AuthName "Kerberos Authentication"
    KrbAuthRealms GANDHI.RELOAD
    Krb5Keytab /etc/httpd/conf.d/krb5.keytab
    KrbMethodNegotiate Off
    KrbSaveCredentials Off
    KrbVerifyKDC Off
    Require valid-user
</Directory>
EOF

mkdir /var/www/html/auth-kerberos 

cat << EOF > /var/www/html/auth-kerberos/index.html
 <html>
<body>
<div style="width: 100%; font-size: 40px; font-weight: bold; text-align: center;">
Test Page for Kerberos Auth
</div>
</body>
</html>
EOF

cp index.html /var/www/html/.
chown apache /var/www/html/index.html