# Gandhi Reload by Vladimir Remar
## Servidor Gadmin
## ASIX  M14-2018

Creación Imagen para el servidor de Gadmin

- Creamos la imagen del servidor. Files:

	[Ficheros para la imagen](https://gitlab.com/vladimir-remar/Gandhi.Reload/tree/master/Documentacion/ModoBasico/ServerGandhi).

		docker build -t gandhireload_gadmin .

- Para este modo el servidor Gadmin sera interactivo

		docker run --name gadmin.gandhi.reload -h gadmin.gandhi.reload --privileged=True --volumes-from  nfsserver --net gandhireload__net -v /etc/dhcp/ -it gandhireload_gadmin /bin/bash

- A este docker se le asocia el volumen de datos del servidor nfsserver 
para una rapida gestion de los datos.

Este servidor se encargará de la administración de los servidores de
ldap, nfs, kerberos.

- Ficheros: 

	- Script de configuracion ***config.sh***
	- Script de creacion de homes ***creacionhomes.sh***
	- Script de creacion de homes ***creacioprincipalskrb.sh***

- Configurar */etc/krb5.conf* añadir el default realm

- Con el servidor ldap en marcha, el servidor nfs también en marcha y 
nuestra [bd](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerLdap/all-uid-edt.ldif)
injectada en el servidor ldap, creamos los *homes* de los usuarios de la bd, 
para esto ejecutamos el siguiente scrip.

	- [homes](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerGadmin/Herramientas_de_administracion/creacionhomes.sh)

- Con los 2 servidores ldap,nfs,kerberos y Gadmin corriendo creamos los principals
en el servidor de kerberos, para esto también ejecutamos el siguiente 
scrit.

	- [principals](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerGadmin/Herramientas_de_administracion/creacioprincipalskrb.sh)

- Creación de nuevos usuarios mediante [script](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerGadmin/Herramientas_de_administracion/add_users.py)