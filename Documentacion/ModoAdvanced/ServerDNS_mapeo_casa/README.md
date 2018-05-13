# Gandhi Reload by Vladimir Remar
## Servidor DNS
## Config Casa
## ASIX M14-2018


Se creara una zona *gandhi.reload* y se configura para que resuelva 
las ips de los servidores(ldap,nfs y kerberos)	

- Creación de la imagen 

		docker build -t gandhireload_dns .

- Ficheros de configuración:

	- [Named.conf](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoAdvanced/dns.gandhi.reload_mapeo_casa/named.conf)
	- [gandhi.reload](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoAdvanced/dns.gandhi.reload_mapeo_casa/gandhi.reload)
	- [1.168.192.db](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoAdvanced/dns.gandhi.reload_mapeo_casa/0.31.172.db)
	- [38.1.168.192.db](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoAdvanced/dns.gandhi.reload_mapeo_casa/3.0.31.172.db)

- Creación del docker
		
		docker run --name dns.gandhi.reload -h dns.gandhi.reload --net gandhireload__net --ip 172.31.0.3 -p 53:53 --privileged=True -d gandhireload_dns

