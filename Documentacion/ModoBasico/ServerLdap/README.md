# Gandhi Reload by Vladimir Remar
## Ldapserver Dockerfile
## ASIX M14-2018

Creación Imagen para el servidor de ldap

Ficheros: 

- Fichero de configuracion ***slapd.conf***
- Fichero de contenido ***all-uid-edt.ldif***
- Script de instalación ***install.sh***
- Script de inicio del servicio ***startup.sh***

### Paso 2: Creacion del servidor Ldap

- Este servidor pertencerá a la red creada anteriormente

- Para una posible y futura automatización crearemos la imagen del servidor
ldap mediante un [Dockerfile](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerLdap/Dockerfile).

- Los archivos de configuracion, contenido de la base datos y scripst post
instalación.
	
	- [Configuración](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerLdap/slapd.conf).
	- [Contenido](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerLdap/all-uid-edt.ldif).
	- [Instalación](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerLdap/install.sh).
	- [Run del servidor](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerLdap/startup.sh).
	
- El contenido de la base datos ldap será la trabajada en clase
	
	- Ejemplo de las entradas:

			Base: 'dc=edt,dc=org'
			Ou  : 'dn: ou=usuaris,dc=edt,dc=org'
			o   : 'dn: o=europa,ou=clients,dc=edt,dc=org'
	
	- Ejemplo de un usuario
		
	        dn: uid=vladimir,o=noneu,o=europa,ou=clients,dc=edt,dc=org
	        objectClass: posixAccount
	        objectClass: inetOrgPerson
	        cn: vladimir putin
	        sn: vladimir
	        homePhone: 779-222-0011
	        mail: vladimir@noneu.europa.edt.org
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

- Consulda de la base al contendor

		ldapsearch -x -LLL -h ldap.gandhi.reload -b 'dc=edt,dc=org' -s base
		
		dn: dc=edt,dc=org
		dc: edt
		description: Escola del treball de Barcelona
		objectClass: dcObject
		objectClass: organization
		o: edt.org

- El servidor se ejecutara en modo ***deattach***