# Gandhi Reload by Vladimir Remar
## Servidor TFTP
## ASIX M14-2018


Se desarrolla este servidor conjuntamente con un volumen asociado

- Creamos la imagen para el servidor de ssh-kerb

		docker build -t gandhireload_tftp .

- Creamos el docker 

		docker run --name tftpserver.gandhi.reload -h tftpserver.gandhi.reload --net gandhireload__net --ip 172.31.0.9 --privileged=True -p 69:69  --volumes-from gadmin.gandhi.reload -d gandhireload_tftp


- Cuando se pone en marcha este servidor se queda esperando peticiones tftp.

Este servidor se empleará más adelante conjuntamente con un servidor PXE