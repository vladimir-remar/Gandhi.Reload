# Gandhi Reload by Vladimir Remar
## Servidor PXE
## ASIX M14-2018

The last but not the least.

Servidor de imágenes PXE que permitirá el arranque de
sistemas vía red.

Se dará uso a los servidores de dhcp, tftp ya creados previamente
[aquí](https://gitlab.com/vladimir-remar/Gandhi.Reload/tree/master/Documentacion/ServiciosKerberizados)

### Configuración

- Servidor TFTP

	Instalaremos el paquete syslinux

		dnf install syslinux