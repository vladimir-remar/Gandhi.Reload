# Gandhi Reload by Vladimir Remar
## Servidor PXE
## ASIX M14-2018

The last but not the least.

Servidor de imágenes PXE que permitirá el arranque de
sistemas vía red.


### Configuración

En el servidor de DHCP que ya esta corriendo accedemos a el y configuramos:

		docker exec -it dhcp.gandhi.reload bash

-	Instalaremos el paquete syslinux

			dnf install syslinux

- Creamos un directorio de configuración y copiamos en el los ficheros
del paquete de syslinux recien instalados.

		mkdir -p /var/lib/tftpboot/pxelinux.cfg
		cp /usr/share/syslinux/{pxelinux.0,vesamenu.c32,ldlinux.c32,libcom32.c32,libutil.c32} /var/lib/tftpboot/

- Configuramos un bootloader para los clientes
	
		default vesamenu.c32
		prompt 1
		timeout 600

		label linux
		menu label ^Install Fedora 26 64-bit
		menu default
		kernel f26/vmlinuz
		append initrd=f26/initrd.img inst.stage2=http://download.fedoraproject.org/pub/fedora/linux/releases/26/Server/x86_64/os/ ip=dhcp

		label local
		menu label Boot from ^local drive
		localboot 0xffff

- Obetenmos el *kernel* y el initrd

		mkdir -p /var/lib/tftpboot/f26

		wget http://download.fedoraproject.org/pub/fedora/linux/releases/26/Server/x86_64/os/images/pxeboot/vmlinuz -O /var/lib/tftpboot/f26/vmlinuz

		wget http://download.fedoraproject.org/pub/fedora/linux/releases/26/Server/x86_64/os/images/pxeboot/initrd.img -O /var/lib/tftpboot/f26/initrd.img

- Iniciamos el servicio 

		/usr/sbin/in.tftpd --foreground --address 192.168.2.57:69 -s /var/lib/tftpboot &disown

---
### Purpose

¿Por qué se integró en el servidor de DHCP y no se creó otro docker?

Por como docker trabaja con el bind de los puertos entre host anfitrión 
y docker, especialmente con los binds a puertos UDP y en este caso no 
terminaba de "ligarlos" dando como resultado la perdida de paquetes.

De todas maneras si se quiere montar un servidor TFTP en un docker
dejo la documentación [aquí](https://gitlab.com/vladimir-remar/Gandhi.Reload/tree/master/Documentacion/ServerPXE/ServerTFTP)

Volver al [planteamiento](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/Planing_proyecto.md)