# Gandhi Reload by Vladimir Remar
## Servidor DNS
## Edt config
## ASIXM M14-2018


Se creara una zona *gandhi.reload* y se configura para que resuelva 
las ips de los servidores(ldap,nfs y kerberos)	

- Creación de la imagen 

		docker build -t gandhireload_dns .

- Ficheros de configuración:

	- [Named.conf](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoAdvanced/ServerDNS_mapeo_edt/named.conf)
	- [gandhi.reload](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoAdvanced/ServerDNS_mapeo_edt/gandhi.reload)
	- [2.168.192.db](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoAdvanced/ServerDNS_mapeo_edt/2.168.192.db)
	- [57.2.168.192.db](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoAdvanced/ServerDNS_mapeo_edt/57.2.168.192.db)

- Creación del docker
		
		docker run --name dns.gandhi.reload -h dns.gandhi.reload --net gandhireload__net --ip 172.31.0.3 -p 53:53 --privileged=True -d gandhireload_dns


Enlaces externos:

- [Draft fedora](https://fedoraproject.org/wiki/Administration_Guide_Draft/DNS)
- [Config server](https://www.server-world.info/en/note?os=Fedora_27&p=dns&f=1)
