# Gandhi Reload by Vladimir Remar
## Servidor DHCP
## ASIX M14-2018

## Desarrollo

Para este docker utilizaremos la *network* del host  que hace de router
ya que nuestro servidor de DHCP necesita asignar la ip del servidor a la 
interfaz donde va a estar la red externa.

- Creación de la imagen:

  	docker build -t gandhireload_dhcp .

- Creación del docker:

		docker run --name dhcp.gandhi.reload -h dhcp.gandhi.reload --network=host --privileged=True --volumes-from gadmin.gandhi.reload -v tftp:/var/lib/tftpboot -it gandhireload_dhcp

Debido a la configuracion interna de docker los docker creados con la 
***network: host*** no pueden ser lanzados en modo deattach por ello
este docker se iniciara interactivo:

Recordar cambiar la interficie de red segun por donde queremos trabajar.

Ejecutamos:

		/usr/sbin/ip a a 10.10.0.1/24 dev enp0s20f0u14
		/usr/sbin/dhcpd -4 -f -d --no-pid -cf /etc/dhcp/dhcpd.conf enp0s20f0u14


## Request client
dhclient -v -s 10.10.0.1

---
## Como añadir una interficie de red a nuestro docker

En el caso de que hayamos creado un docker perteneciente a la red interna
gandhi.reload podemos intentar darle una interficie de red.

La solución o una de ellas seria poder asginar una interficie física/virtual de red que tenga el host anfitrión que hace de router a un docker que  pertenezca a la red interna de gandhi.reload, se puede mapear una  interificie a un docker pero lo hace a partir de una vlan, no  significaria un problema si no fuese por el eccesivo tiempo que toma en resolver una ip.

### Aquí la manera:

- Crear la vlan asociandola a la interficie *enp0s20f0u14*

		docker network create -d macvlan \
		  -o parent=enp0s20f0u14 \
		  dhcp_red

- Assignarla a l docker

		docker network connect dhcp_red dhcp.gandhi.reload

Y de esta manera nuestro docker interno es *"conocedor"* de dicha interficie
pudiendo asi asigarle un ip y brindar por este dipositivo nuestro servicio
de dhcp.

