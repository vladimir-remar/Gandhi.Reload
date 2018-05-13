 Gandhi Reload

Para el desarrollo de los servidores y la postgestion de servicios se 
emplearan dockers.

En un primer momento no haremos la gestion de resolucion de nombres(DNS) 
ni la obtencion de IP (DHCP), dejaremos esto a la gestion interna de docker.

## Modo Básico

En este modo se crearán los servidores ldap, nfs, kerberos, gadmin
que sera un admin-server y un client interno que servirá de pruebas.

### Paso 1: Creación de subnet.

Para este modo se hará uso de una subnet de docker, para que los diferentes
dockers sepan quienes son entre ellos, mediante el comando docker 
network create.

    docker network create --subnet=172.31.0.0/16 --gateway=172.31.0.1 gandhireload__net
    
    docker network ls
    
    NETWORK ID          NAME                DRIVER
    b729896272ca        host                host                
    285299f13ec3        gandhireload__net       bridge              
    1ec02bc9b9ea        bridge              bridge              
    ee57eca9037a        mynet               bridge              
    bc56345ac0f7        none                null
    
    docker network inspect gandhireload__net 
    [
        {
            "Name": "gandhireload__net",
            "Id": "285299f13ec38cdae31700ad2e4e1da8a60216edec0b9778ae80ff946c92b1d9",
            "Scope": "local",
            "Driver": "bridge",
            "IPAM": {
                "Driver": "default",
                "Options": {},
                "Config": [
                    {
                        "Subnet": "172.31.0.0/16",
                        "Gateway": "172.31.0.1"
                    }
                ]
            },
            "Containers": {},
            "Options": {}
        }
    ]

### Paso 2: Creación del servidor Ldap

- Este servidor pertencerá a la red creada anteriormente

- Para una posible y futura automatización crearemos la imagen del servidor
*ldap* mediante un [Dockerfile](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerLdap/Dockerfile).

- Los archivos de configuracion, contenido de la base datos y scripst post
instalación.
	
	- [Configuración](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerLdap/slapd.conf).
	- [Contenido](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerLdap/all-uid-gandhi-reload.ldif).
	- [Instalación](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerLdap/install.sh).
	- [Run del servidor](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerLdap/startup.sh).
	
- El contenido de la base datos ldap hará referencia al proyecto.
	
	- Ejemplo de las entradas:

			Base: 'dc=gandhi,dc=reload'
			Ou  : 'dn: ou=usuaris,dc=gandhi,dc=reload'
			o   : 'dn: o=europa,ou=clients,dc=gandhi,dc=reload'
	
	- Ejemplo de un usuario
		
	        dn: uid=vladimir,o=noneu,o=europa,ou=clients,dc=gandhi,dc=reload
	        objectClass: posixAccount
	        objectClass: inetOrgPerson
	        cn: vladimir putin
	        sn: vladimir
	        homePhone: 779-222-0011
	        mail: vladimir@noneu.europa.gandhi.reload
	        description: client de rusia
	        ou: 2wiaw
	        uid: vladimir
	        uidNumber: 11011
	        gidNumber: 651
	        homeDirectory: /tmp/home/2wiaw/vladimir
	        userPassword:: e1NIQX0zSkdHb0dCNGN6a1Zwdnk2czA1WkVndml0SVE9

#### Creación de la imagen, docker y test de una consulta.
		
		docker build -t gandhireload_ldap .
		
- Creación del contenedor

		docker run --name ldap.gandhi.reload -h ldap.gandhi.reload --net gandhireload__net  -d gandhireload_ldap

- Consulta de la base al contendor

		ldapsearch -x -LLL -h 172.31.0.2:389 -b 'dc=gandhi,dc=reload' -s base
		
		dn: dc=gandhi,dc=reload
		dc: gandhi
		description: Escola del treball de Barcelona
		objectClass: dcObject
		objectClass: organization
		o: gandhi.reload

- El servidor se ejecutara en modo ***deattach***

### Paso 3: Creación del servidor NFS

- Creamos Una imagen con un [Dockerfile](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerNfs/Dockerfile) con servicios minimos
	- [Fiecheros para la imagen ](https://gitlab.com/vladimir-remar/Gandhi.Reload/tree/master/Documentacion/ModoBasico/ServerNfs).
				
			docker build -t gandhireload/nfsserver .
    
- Se creará un docker que sólo gestione el servicio NFS y un docker volume
donde estarán los *home* de los usuarios.

    - Para crear el contendor con un volumen

            docker run --name nfs.gandhi.reload -h nfs.gandhi.reload --privileged=True -v /mnt/dades --net gandhireload__net -d gandhireload_nfs
         
    - Podemos identificar el volumen creado con la orden docker inspect

            docker inspect -f "{{json .Mounts}}" nfsserver |jq

    - Con su nombre podemos tambien hacer un inspec al volumen

            docker volume inspect $namedockervolume
        
    - incluso podemos listar el contenido desde fuera o gestionarlo

            sudo ls /var/lib/docker/volumes/$namedockervolume/_data

- Ficheros de configuraciónn:

      - Fichero configuracion del servicio [config](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerNfs/install.sh)
      - Fichero de inicio de servicios  [start](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerNfs/startup.sh)

- El servidor se ejecutara en modo ***deattach***
 
### Paso 4: Creación servidor Kerberos

- Creamos la imagen del servidor. Files:

	- [Ficheros para la imagen](https://gitlab.com/vladimir-remar/Gandhi.Reload/tree/master/Documentacion/ModoBasico/ServerKerberos).
	- [Dockerfile](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerGandhi/Dockerfile)

		docker build -t gandhireload_krb .

- Creamos el docker con la imagen:

		docker run --name krb.gandhi.reload -h krb.gandhi.reload --privileged=True --net gandhireload__net -d gandhireload_krb

- El docker ya viene configurado por la imagen y se queda en modo *deattach*.

	- Configuración del realm gandhi.reload

		- [krb5.conf](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerKerberos/krb5.conf).
		- [kdc.conf](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerKerberos/kdc.conf).

- Los datos se injectarán de manera remota.

### Paso 5: Gadamin - Admin server

- Creamos la imagen del servidor. Files:

	[Ficheros para la images](https://gitlab.com/vladimir-remar/Gandhi.Reload/tree/master/Documentacion/ModoBasico/ServerGandhi).

		docker build -t gandhireload_gadmin .

- Para este modo el servidor Gadmin sera interactivo

		docker run --name gadmin.gandhi.reload -h gadmin.gandhi.reload --privileged=True --volumes-from  nfsserver --net gandhireload__net -v /etc/dhcp/ -it gandhireload_gadmin /bin/bash

- A este docker se le asocia el volumen de datos del servidor nfs.gandhi.reload.

- Este Docker hará las funciones de administración de los servidores de 
ldap, nfs y kerberos

- Con el servidor ldap en marcha, el servidor nfs también en marcha y 
nuestra [bd](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerLdap/all-uid-gandhi-reload.ldif)
injectada en el servidor ldap, creamos los *homes* de los usuarios de la bd, 
para esto ejecutamos el siguiente script.

	- [homes](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerGandhi/creacionhomes.sh)

- Con los 2 servidores ldap,nfs y Gadmin corriendo creamos los principals
en el servidor de kerberos, para esto también ejecutamos el siguiente 
script.

	- [principals](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerGandhi/creacioprincipalskrb.sh)

### Paso 6 : Cliente interno

- Este docker será interactivo

		docker run --name clientintern.gandhi.reload -h clientintern.gandhi.reload --privileged=True --net gandhireload__net -it fedora:24 /bin/bash
	
- Le daremos la configuración via script
	
	- [config](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ClientIntern/config.sh)
	

- Docker cliente, que funciona a modo de prueba, 

		- login ldap : check
		- mount home : check
		- krb5 authentication : check

## Test Login, mount, tiket krb en el cliente interno.
		
		[root@clientintern pam.d]# su - vladimir
		reenter password for pam_mount:
		-sh-4.3$ su - mao
		Password: 
		Creating directory '/tmp/home/1wiaw/mao'.
		-sh-4.3$ pwd
		/tmp/home/1wiaw/mao
		-sh-4.3$ klist
		Ticket cache: DIR::/run/user/11001/krb5cc_I1mOZo/tktRgWE9a
		Default principal: mao@gandhi.reload

		Valid starting     Expires            Service principal
		04/27/18 10:10:55  04/28/18 10:10:55  krbtgt/gandhi.reload@gandhi.reload

Se hace primero un login con un usuario cualquiera, y luego un login "real"
con cualquier otro usuario, asi podemos ver que pide el password.

Con la orden *mount* podemos ver de donde proviene el *home* del usuario
mao:

	-sh-4.3$ mount|grep mao
	nfsserver:/mnt/dades/1wiaw/mao on /tmp/home/1wiaw/mao type nfs 
	(rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=172.31.0.3,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=172.31.0.3)

Y con *finger* podemos ver info adicional del usuario proveniente de ldap

	-sh-4.3$ finger mao
	Login: mao            			Name: mao tse tung
	Directory: /tmp/home/1wiaw/mao      	Shell: /bin/sh
	Last login Fri Apr 27 10:10 (UTC) on console
	No mail.
	No Plan.

---
Y hasta aquí el desarrollo del modo básico, para darle una escala mayor
sigue con el modo advanced.

Ir al modo [ADVANCED](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoAdvanced/desarrollo_modo_advanced.md)

Volver al [planteamiento](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/Planing_proyecto.md)