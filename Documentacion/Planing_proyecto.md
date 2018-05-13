# Gandhi Reload 

Ante el plantamiento de crear un servidor que imite el funcionamiento de 
Gandhi, decidi abordar el tema dividiendo la tarea en modos de trabajo, uno 
básico para tener un referente con el que trabajar, uno más amplio que
se comporte de una manera más fiel a lo que es Gandhi en la escuela y por
último implementar servicios kerberizados.

- Modos a seguir.

	- Modo básico: Funcionamiento elemental, login + montaje del home.
	- Modo Advanced : Resolucion de nombres(DNS), obtencion de ip(DHCP).

- Servicios extras: Servicios kerberizados (SSH,HTTP,FTP) y un servevidor 
TFTP.

- Extra:

	Servidor PXE.

## Modo básico

- Estructuración de los servicios (ldap,kerberos,nfs).
- Implementación *Servidor básico* + *servicios básicos(ldap,kerberos,nfs)*.

### Plan para el modo básico:

- Estructuración de los servicios.

	¿Cuáles son los servicios que el servidor utilizará para la gestión del
	login, montaje de los *home's* de los usuarios, etc?

- Implementación *Servidor básico* + *servicios básicos*.

	Implementación de los servicios de LDAP, kerberos y NFS que serán 
	gestionados de manera individual y haran posible el acceso a una sesion
	cualquier usuario que pertenezca a nuestra base de datos de ldap.

- Test *Servidor básico*.

	Correspondiente test del servidor mas la optención de los primeros errores

- Correción de erratas + test del servidor.

	Proceso en bucle que finalizará cuando se de por correcto el 
	funcionamiento del servidor más los servicios que gestiona.

- Ultimación del *Servidor básico*.

	Tarea que ya no se encarga de la gestion de errores si no que ultima
	pequeños detalles.

Todas las respuestas en el desarrollo del modo [básico](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/Desarrollo_modo_basico.md).

## Modo Advanced

- Implementación de servidores de DHCP y DNS.
- Creación de un cliente externo sea docker o un cliente real.
- Desarrollo del *docker-compose*.

### Plan para el modo advanced:

- Estructuración de los servidores de DHCP y DNS
	- ¿Que interficies de red utiliza docker?
	- ¿Es posible añadir determina interficie de red a un docker?
	- ¿Cómo gestionaremos la resolución de nombres fuera de la red interna
	de nuestros dockers?
- Configurar el cliente externo para poder trabajar con normalidad.
- ¿Es posible automatizar la arranca de nuestra estructura de servicios?

Todas las respuestas en el desarrollo del modo [advanced](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoAdvanced/desarrollo_modo_advanced.md)

## Servicios Extras

Como extra crearemos algunos servicios kerberizados, tales como:

- SSH kerberized server
- FTP kerberized server
- HTTP kerberized server

Y para acabar también montaremos un servidor de TFTP

Todo el seguimiento  en el desarrollo de los [servicios](https://gitlab.com/vladimir-remar/Gandhi.Reload/tree/master/Documentacion/ServiciosKerberizados)

## Servidor PXE 

Un servidor PXE elemental. 

[Página de inicio](https://gitlab.com/vladimir-remar/Gandhi.Reload/tree/master)