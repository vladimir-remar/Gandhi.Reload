# Gandhi Reload by Vladimir Remar
## SSH Kerberizado
## ASIX M14-2018

- Creamos la imagen para el servidor de ssh-kerb

		docker build -t gandhireload_ssh_krb .

- Creamos el docker 

		docker run --name sshserver.gandhi.reload -h sshserver.gandhi.reload --net gandhireload__net --ip 172.31.0.7 --privileged=True -p 9022:22  -d gandhireload_ssh_krb

### Procedimiento

- En el servidor de kerberos creamos la entrada para este servicio

		kadmin.local -q "addprinc -randkey ssh/sshserver.gandhi.reload"

- En nuestro servidor de ssh:

		# kadmin
		kadmin: ktadd -k /etc/krb5.keytab ssh/sshserver.gandhi.reload

- En este caso este servidor brindara acceso remoto a los usuarios de nuestra base de 
datos ldap por ello se configurará los siguientes ficheros mediante un
[script](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ServiciosKerberizados/ServerSSH/config.sh):

	- /etc/krb5.conf
	- /etc/nslcd.conf
	- /etc/nsswitch.conf
	- /etc/openldap/ldap.conf
	- /etc/pam.d/sshd 
	- /etc/pam.d/system-auth 
	- /etc/security/pam_mount.xml

	

- Si únicamente se desea un servidor ssh kerberizado puro no haría falta
configurar la parte como cliente. Simplemente modificar la sgiguiente linea.

		sed -i  's/#KerberosAuthentication no/KerberosAuthentication yes/; s/#KerberosTicketCleanup yes/KerberosTicketCleanup yes/' /etc/ssh/sshd_config

- Si en la parte del cliente da problemas el "nologin" borrar en el 
servidor:

		rm -rf /var/run/nologin