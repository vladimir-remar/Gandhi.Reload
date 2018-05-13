# Guia rápida nfs

a) Creamos un docker, la opción privilieged es importante, nos permite la ejecución de diversos servicios en el docker, cosa que de normal no nos dejaria

		docker run --privileged=True --name sharenfs -h nfsserver -it fedora:24 /bin/bash

b) Dentro del docker actualizamos e instalamos herramientas

		dnf update vi -y
		dnf install  mlocate iproute tree procps nfs-utils  vim -y

c) creamos los share y una carpeta para cada usuario (haste una lista con todos los usuarios del ldap)
	
		mkdir -p /mnt/users/data
		mkdir /mnt/users/data/pau
		mkdir /mnt/users/data/pere
		mkdir /mnt/users/data/anna
		...



d) cambiale los permisos a todas las carpetas 

		chmod 777 mkdir /mnt/users/data/*

e) editamos el fichero /etc/exports la ip variara según donde tengas el cliente, si has seguido el orden de creación de dockers, tu cliente debería tener la ip 172.17.0.3

		/mnt/users/data 192.168.1.42(rw,sync,no_subtree_check,no_root_squash,fsid=0)
		/mnt/users/data 172.17.0.1(rw,sync,no_subtree_check,no_root_squash,fsid=0)
		/mnt/users/data 172.17.0.3(rw,sync,no_subtree_check,no_root_squash,fsid=0)

f) edita el ficher /etc/hosts.allow y agrega esta linea

		rpcbind mountd nfsd statd lockd rquotad : 172.17.0.1 172.17.0.3


g) puesta en marcha del servicio

ejecuta las siguientes ordenes:

	 mkdir /run/rpcbind
	 touch /run/rpcbind/rpcbind.lock 

	 rpcbind
	 rpc.statd
	 rpc.nfsd
	 exportfs -ra

Una vez lo anterior "funciona" prueba hacer un ps -ax tienes que tener el rpcbind  y el rpc.statd corriendo, si no vuelve a intentar los pasos a partir de rpcbind

		exportfs # para ver si te lista los recursos

Si todo a ido bien ejecuta y deja la siguiente orden, te ira mostrando las peticiones de acceso :

rpc.mountd --foreground

h) Volvemos al docker pamclient y editamos el fichero ***/etc/security/pam_mount.conf.xml*** la directiva ***server="172.17.0.4"*** puede cambiar segun la ip de tu nfsserver.

i) Si todo a ido bien en el docker pamclient prueba hacer un login y verifica si se ha creado el home lo siguiente es crear un archivo salir de la sesion de jorge y verificar si el archivo esta en el servidor de NFS.

su jorge
cd

