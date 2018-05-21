# Gandhi Reload.

- Tecnologías: Kerberos, LDAP, PAM, Docker, GIT.
- by: Vladimir Remar.
- id: isx48262276.
- gp: hisx2.
- Escola del treball - Barcelona.


## Proposito general

El objetivo de este proyecto es generar un modelo de acceso a servicios 
similar a los que brinda el servidor de  ***Gandhi*** en la escuela pero 
con cada uno de los estos separados en contenedores Docker.
 

## Implementaciones:

- Hots Client de la escuela:
	- Configurar un cliente para que haga la autenticación como la hace
cualquier host de la escuela (autentica con gandhi y monta su home).

- Docker:
	- Implementar por separado en un docker cada uno de los componentes.

- Servidor Kerberos:
	- Implementar un servidor kerberos que permite autenticar usuarios:
login / Kinit con Kerberos. Usar de base de datos LDAP. PAM.

- Clients Kerberizados:

	- Realizar la autenticación de usuarios en servicios Kerberizados, como por
ejemplo ssh, http y ftp y un servidor tftp.

- Servidor de la escuela:

	Implementar en Dockers los servicios individuales del servidor de
	la escuela gandhi.

	- LDAP.
	- Kerberos.
	- NFS.
	- SSH.
	- DHCP.
	- DNS.

## Planteamiento y desarrollo

El planteamiento y desarrollo contenido en el [planing](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/Planing_proyecto.md) del proyecto.

## Calendario de trabajo (aún pendiente)

Dias y horas gastadas en el proyecto en el [calendario](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/calendari.md)
