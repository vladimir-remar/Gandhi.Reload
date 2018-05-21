# Gandhi Reload by Vladimir Remar
## Server GADMIN
## Herramientas de administración

Aquí se encuentran algunas de las herramientas  que se emplearán en la
administracíon de los servidores de ldap, nfs y kerberos, tales como

- La creación de homes de los usuarios.
- La creación de los principales en en el servidor de kerberos.
- La creación de nuevos usuarios en nuestra base de datos de ldap.

## Funcionamiento de los ***scripts***

### Script "creacionhomes.sh"

Este script es el encargado de crear los homes de los usuarios ya existentes
en nuestra base de datos de ldap, el funcionamiento es simple:

- Hace una consulta a nuestra base ldap preguntando por los grupos y sus 
usuarios este los filtra opteniendo una lista de grupo-usuario/s y crea
según estos los directorios para cada uno de los usuarios añadienlos un
skel basico.

### Script "creacioprincipalskrb.sh"

Este script se encarga de dar de alta a los usuarios de ldap en forma
de "pincipals" en nuestro servidor de kerberos.

- Funciona de la misma manera que el script anterior pero en este caso
optione una lista solo con los usuarios y crea la entrada de "principals"
en el servidor de kerberos.

### Script "add_users.py"

Este script nos ayudará a hacer un "poplute" de usuarios nuevos a nuestra
base de datos de ldap.

Los datos de los usurios son almacenados mediante una applet web en un
fichero "json", este fichero es procesado mediante plantillas para obtener 
entradas ldiff normalizadas, luego estas entradas serán injectadas en el 
servidor ldap, una vez añadida la entrada de un usuario en el servidor 
se le crea tanto el *home* como el *principal*.

- Funcionamiento:

	- Entrada fichero json

			[
			{"cn": "ho chi minh",
			"homephone": "777-222-0002",
			"mail": "ho@asia.gandhi.reload",
			"description" : "client de vietnam",
			"ou" : "1wiaw"
			}
			]

	- Postproceso de entrada mediante una plantilla:

			def plantilla_ldap_users():
			
			ldap_users='''dn: uid=%s,ou=usuaris,dc=gandhi,dc=reload
			objectclass: posixAccount
			objectclass: inetOrgPerson
			cn: %s
			sn: %s
			homephone: %s 
			mail: %s
			description: %s
			ou: %s
			uid: %s
			uidNumber: %d
			gidNumber: %d
			homeDirectory: /home/users/inf/%/%s 
			loginShell: /bin/bash
			userPassword: %s
			'''

	- Salida fichero users.ldif :

			dn: uid=renzo,ou=usuaris,dc=gandhi,dc=reload
			changetype: add
			objectclass: posixAccount
			objectclass: inetOrgPerson
			cn: renzo alberto remar
			sn: renzo
			homephone: 777-223-0002 
			mail: renzo@asia.gandhi.reload
			description: client de casa
			ou: 1wiaw
			uid: renzo
			uidNumber: 11017
			gidNumber: 650
			homeDirectory: /home/users/inf/1wiaw/renzo 
			loginShell: /bin/bash
			userPassword: {SHA}NxQ4C9JEfz4HvD6qira9CMPbBsQ=

	- Salida fichero grups.ldif

			dn: cn=1wiaw,ou=grups,dc=gandhi,dc=reload
			changetype:modify
			add:memberUid
			memberUid:uid=renzo,ou=usuaris,dc=gandhi,dc=reload

			dn: cn=1asix,ou=grups,dc=gandhi,dc=reload
			changetype:modify
			add:memberUid
			memberUid:uid=martina,ou=usuaris,dc=gandhi,dc=reload

