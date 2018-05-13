# Gandhi Reload by Vladimir Remar
## SSH Kerberizado
## ASIX M14-2018

- Creamos la imagen para el servidor de ssh-kerb

		docker build -t gandhireload_ssh_krb .

- Creamos el docker 

		docker run --name sshserver.gandhi.reload -h sshserver.gandhi.reload --net gandhireload__net --ip 172.31.0.7 --privileged=True -p 3022:22  -d gandhireload_ssh_krb

### Procedimiento

- En el servidor de kerberos creamos la entrada para este servicio

		kadmin.local -q "addprinc -randkey ssh/sshserver.gandhi.reload"

- En nuestro servidor de ssh:

		# kadmin
		kadmin: ktadd -k /etc/krb5.keytab ssh/sshserver.gandhi.reload

- Este servidor brindara acceso remoto a los usuarios de nuestra base de 
datos ldap por ello se configurará los siguientes ficheros:

	- /etc/krb5.conf
	- /etc/nslcd.conf
	- /etc/nsswitch.conf
	- /etc/openldap/ldap.conf
	- /etc/pam.d/sshd 
	- /etc/pam.d/system-auth 
	- /etc/security/pam_mount.xml
