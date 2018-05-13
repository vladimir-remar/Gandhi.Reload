# Gandhi Reload by Vladimir Remar @EDT

- Proposito: Crear un entorno de trabajo para usuarios.
- Tecnologías: 
	
	- [LDAP](#Servidor-LDAP)
	- [NFS](#Servidor-NFS)
	- [Kerberos](#Servidor-Kerberos)
	- [DNS](#Servidor-DNS)
	- [DHCP](#Servidor-DHCP)
	- [SSH-Kerberized](#Servidor-SSH-Kerberized)
	- [FTP-Kerberized](#Servidor-FTP-Kerberized)
	- [HTTP-Kerberized](#Servidor-HTTP-Kerberized)
	- [TFTP](#Servidor-TFTP)
	- [Servidor PXE](#Servidor-PXE)
	- [Docker-Compose](#Docker-compose)

## Servicios

Para un entorno local dispondedremos de los servicios básicos para poder
trabajar y para un posible trabajo remoto dispondremos de los servicios
kerberizados.

¿Qué son los servicios básicos?

Son los servicios que permiten a un usuario de nuestra base de datos ldap
poder *trabajar* con normalidad.

¿Qué son los servicios Kerberizados?

Son aquellos servicios, tales como ftp, ssh o http entre otros puedan realizar
la autenticacíon via kerberos, es decir cuando un usuario necesita acceder
a un servicio de red, el cliente solicita un ticket y dependiendo de cada
servicio este lo valida contra la base de datos del servidor de Kerberos.

- [Servicios básicos de trabajo](#Servicios-básicos):
	- Datos de los usuarios almacenados en un servidor ***Ldap***.
	- El directorio de ficheros de cada usuario localizado en un servidor ***NFS***.
	- Autenticación via ***Kerberos***.
	- Implementación de un servidor de resolución de nombres(***DNS***) 
	propio de la  estructura propia de *Gandhi reload*.
	- Para el despliegue de toda nuestra red integraremos nuestro servidor de 
	***DHCP***.
- [Servicios ***Kerberizados***](#Servicios-Kerberizados):
	- FTP los usuarios podran disponer de sus propios ficheros como los 
	proporcionados por el mismo servidor.
	- SSH Se permitará el acceso a un sesión remota de los usuarios.
	- HTTP Acceso a determinda web de nuestro servidor solo para los usuarios
	validos del servidor LDAP.
- [Servicios extras](#Servicios-extras):
	- Servidor TFTP.
	- Servidor PXE.

Todos estos servicios se implementarán en contendores Docker, por ello
haremos uso de un fichero [***docker-compose***](#Docker-compose) para automatizar tanto la creación
como el arranque de nuestros servicios.

---
## Servicios básicos

### Servidor LDAP

- Entrada Principal

		dn: dc=gandhi,dc=reload
		dc: gandhi
		description: Escola del treball de Barcelona
		objectClass: dcObject
		objectClass: organization
		o: gandhi.reload

- Entrada de la organizacion

		dn: ou=usuaris,dc=gandhi,dc=reload
		ou: usuaris
		description: Container per usuaris del sistema linux
		objectclass: organizationalunit

- Entrada para un usuario

		dn: uid=pau,ou=usuaris,dc=gandhi,dc=reload
		objectclass: posixAccount
		objectclass: inetOrgPerson
		cn: Pau Pou
		cn: Pauet Pou
		sn: Pou
		homephone: 555-222-2220
		mail: pau@gandhi.reload
		description: Watch out for this guy
		ou: Profes
		uid: pau
		uidNumber: 5000
		gidNumber: 100
		homeDirectory: /home/users/inf/pau
		userPassword: {SSHA}NDkipesNQqTFDgGJfyraLz/csZAIlk2/

### Servidor NFS

Dispondremos de un ***Volumne Docker*** ubicado en */mnt/dades* donde se 
creará la estructura de directorios para nuestros usuarios, en este caso 
su ***home***.

	/mnt/dades/
	|-- 1asix
	|   |-- user01
	|   |-- user02
	|   |-- user03
	|   |-- user04
	|   `-- user05
	|-- 1wiaw
	|   |-- ali
	|   |-- hiro
	|   |   |-- 2.txt
	|   |   `-- text.txt
	|   |-- ho
	|   |   |-- Descargas
	|   |   |-- Documentos
	|   |   |-- Escritorio
	|   |   |-- Im\303\241genes
	|   |   |-- M\303\272sica
	|   |   |-- Plantillas
	|   |   |-- P\303\272blico
	|   |   `-- V\303\255deos
	|   |-- mao
	|   |-- nelson
	|   `-- robert
	|-- 2asix
	|   |-- user06
	|   |-- user07
	|   |-- user08
	|   |-- user09
	|   `-- user10
	|-- 2wiaw
	|   |-- carles
	|   |-- francisco
	|   |-- humphrey
	|   |-- jorge
	|   |   `-- text.txt
	|   |-- konrad
	|   `-- vladimir
	|-- admin
	|   `-- admin
	|-- alumnes
	|   |-- anna
	|   |-- jordi
	|   `-- marta
	|-- cup
	`-- profes
	    |-- jordi
	    |-- pau
	    `-- pere

### Servidor Kerberos

GANDHI.RELOAD así se llamará nuestro reino.

	[logging]
	 default = FILE:/var/log/krb5libs.log
	 kdc = FILE:/var/log/krb5kdc.log
	 admin_server = FILE:/var/log/kadmind.log

	[libdefaults]
	 dns_lookup_realm = false
	 ticket_lifetime = 24h
	 renew_lifetime = 7d
	 forwardable = true
	 rdns = false
	 default_realm = GANDHI.RELOAD
	 allow_weak_crypto = yes
	 
	[realms]
	 GANDHI.RELOAD = {
	  kdc = krb.gandhi.reload
	  admin_server = krb.gandhi.reload
	 }
	[domain_realm]
	 .gandhi.reload = GANDHI.RELOAD
	 gandhi.reload = GANDHI.RELOAD


### Servidor DNS

Se creara una zona ***gandhi.reload*** y se configura para que resuelva 
las ips de los servidores(ldap,nfs,kerberos, etc)	

Fichero ***named.conf***

	view "internal" {
	    match-clients {
	      localhost;
	      172.31.0.0/16;
	      172.17.0.0/16;
	      192.168.1.0/24;
	      192.168.2.0/24;
	    };
	    zone "." IN {
	      type hint;
	      file "named.ca";
	    };
	    zone "gandhi.reload" IN {
	      type master;
	      file "gandhi.reload";
	      allow-update { none; };
	    };
	    zone "2.168.192.in-addr.arpa" IN {
	      type master;
	      file "1.168.192.db";
	      allow-update { none; };
	    };
		};
	view "external" {
	    match-clients { any; };
	    allow-query { any; };
	    recursion no;
	    zone "gandhi.reload" IN {
	      type master;
	      file "gandhi.reload";
	      allow-update { none; };
	    };
	    zone "57.2.168.192.in-addr.arpa" IN {
	      type master;
	      file "38.1.168.192.db";
	      allow-update { none; };
    	};
	};

Zona ***GANDHI.RELOAD***

	$TTL 86400
	@   IN  SOA   gandhi.reload. root.gandhi.reload. (
	        2017121701  ;Serial
	        3600        ;Refresh
	        1800        ;Retry
	        604800      ;Expire
	        86400       ;Minimum TTL
	)
	        IN  NS     gandhi.reload.
	        IN  A       192.168.2.57
	ldap    IN  A       192.168.2.57
	krb     IN  A       192.168.2.57
	nfs     IN  A       192.168.2.57
	sshserver  IN  A       192.168.2.57
	ftpserver  IN  A       192.168.2.57
	tftpserver  IN  A       192.168.2.57
	httpserver  IN  A       192.168.2.57

### Servidor DHCP

Para este docker indagaremos en como trabaja las tecnologias de dockers con 
nuestras interficies de red para ello utilizaremos la ***network:host*** 
que es aquella que nos permite la utilización de todas las interficies 
de red del *host* anfitrión que gobierna los contenedores dockers.

Quizas el único fuera de nuestra estructura *interna*.

Fichero *etc/dhcp/dhcp.conf*

	default-lease-time 600;
	max-lease-time 7200;

	authoritative;

	# specify network address and subnet mask

	subnet 10.10.0.0 netmask 255.255.255.0 {
	  option routers 10.10.0.1;
	  option subnet-mask 255.255.255.0;
	  range 10.10.0.3 10.10.0.254;
	  option broadcast-address 10.10.0.255;
	  option domain-name-servers 192.168.2.57, 8.8.8.8;
	  option domain-name "gandhi.reload";
	  option domain-search "gandhi.reload";
	  next-server 192.168.2.57; 
	  filename "pxelinux.0";
	}

	subnet 192.168.2.0 netmask 255.255.255.0{

	}

---
## Servicios Kerberizados

Cada uno de estos servicios se configurarán como si de un cliente se tratase,
es decir obtendran las configuraciones de nuestros servicios básicos para
luego ellos brindar acceso a los mismos de manera remota valiendose de la
autenticación via kerberos.

### Servidor SSH-Kerberized

### Servidor FTP-Kerberized

### Servidor HTTP-Kerberized

---
## Servicios extras

### Servidor TFTP
	
### Servidor PXE

### Servidor de Administración: *Gadmin*

### Docker-compose