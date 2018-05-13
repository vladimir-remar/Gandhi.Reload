# Gandhi Reload by Vladimir Remar
## HTTP Kerberizado
## ASIX M14-2018

Configurar Apache para tener autenticación Kerberos

### Procedimiento

- En el servidor de kerberos creamos la entrada para este servicio

		kadmin.local -q "addprinc -randkey HTTP/httpserver.gandhi.reload"

- En el servidor de la aplicación.
		
	Añadimos la entrada de nuestra aplicacion al fichero */etc/httpd/conf.d/krb5.keytab*

		echo "HTTP/fd3s.srv.world@SRV.WORLD" > /etc/httpd/conf.d/krb5.keytab
    
	Le cambiamos los permisos para que apache pueda acceder a el. 
	 		
		chown apache /etc/httpd/http.keytab

	Creamos una entrada de configuración para nuestra web "privada"

		vi /etc/httpd/conf.d/auth_kerberos.conf
		# create new
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

	Por último creamos una pagina de prueba

		mkdir /var/www/html/auth-kerberos 
		vi /var/www/html/auth-kerberos/index.html
		<html>
		<body>
		<div style="width: 100%; font-size: 40px; font-weight: bold; text-align: center;">
		Test Page for Kerberos Auth
		</div>
		</body>
		</html>