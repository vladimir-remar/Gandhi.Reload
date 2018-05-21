# Gandhi Reload by Vladimir Remar
## FTP Kerberizado
## ASIX M14-2018

- Creamos la imagen para el servidor de ssh-kerb

		docker build -t gandhireload_ftp_krb .

- Creamos el docker 

		docker run --name ftpserver.gandhi.reload -h ftpserver.gandhi.reload --net gandhireload__net --ip 172.31.0.8 --privileged=True  -p 21:21 -p 21:21/udp -p 20:20 -p 20:20/udp -it gandhireload_ftp_krb

### Procedimiento

- En el servidor de kerberos creamos la entrada para este servicio

		kadmin.local -q "addprinc -randkey ftp/ftpserver.gandhi.reload"

- En el servidor de la aplicación.
		
		# kadmin
			kadmin: ktadd -k /etc/krb5.keytab ftp/ftpserver.gandhi.reload


#### Declaración de intenciones

- Este servidor se configurará para que tenga acceso a nuestros servicios 
 	
	- ldap
	- nfs
	- kerberos


Se le da la configuración para estos servicios como si fuera un cliente, 
es decir, cuando un usurio de manera remota realice una petición ftp a 
este servidor este se encargará de validarlo contra el ldap, autenticarlo 
con kerberos y montar su home del servidor de nfs.

#### Resultado

Con la modificación de su archivo de pam *vsftpd*, conseguimos la validación
y la autenticación.

		#%PAM-1.0
		auth    required    pam_listfile.so item=user sense=deny file=/etc/ftpusers onerr=succeed
		auth    required    pam_env.so
		auth    sufficient  pam_unix.so nullok_secure
		auth    sufficient  pam_krb5.so use_first_pass
		auth    sufficient  pam_ldap.so use_first_pass
		auth    required    pam_shells.so

		account required    pam_unix.so
		account sufficient  pam_ldap.so

		session required    pam_limits.so
		session required    pam_unix.so
		session optional    pam_ldap.so
		session optional    pam_mount.so
		
		session required        pam_mkhomedir.so        skel=/etc/skel umask=0002

El problema está en que no he sabido resolver el por qué el archivo de 
configuración vsftpd no es capaz de resolver el stack "session" que 
incluye el pam_mount.so para poder montar el home del usuario.

Posibles respuestas al problema:

- Que el archivo vsftpd no interprete o utilice el stack de session
- Que el modulo "pam_mount.so" no sea interpreado por el archivo vsftpd

Posible solución

La solución que planteo no es ni de lejos la adecuada pero nos soluciona
el problema.

En el servidor de FTP hacemos que monte los homes de nuestros usuarios

		mount -t nfs nfs.gandhi.reload:/mnt/dades /home/users/inf

Con esto logramos que el inicio de sesiones remotas puedan acceder a su
home y trabajar con ftp.