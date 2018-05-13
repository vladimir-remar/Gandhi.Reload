# Gandhi Reload by Vladimir Remar
## NFS server Dockerfile
## ASIX M14-2018

Creación Imagen para el servidor de NFS

Porst to open:

111/tcp  open  rpcbind
111/udp  open  rpcbind
2049/tcp open  nfs
2049/udp open  nfs


- Creamos Una imagen con un [Dockerfile](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerNfs/Dockerfile) con servicios minimos
	- [Fiecheros para la imagen ](https://gitlab.com/vladimir-remar/Gandhi.Reload/tree/master/Documentacion/ModoBasico/ServerNfs).
				
			docker build -t gandhireload_nfs .
    
- Se creará un docker que sólo gestione el servicio NFS y un docker volume
donde estarán los *home* de los usuarios.

    - Para crear el contendor con un volumen

            docker run --name nfs.gandhi.reload -h nfs.gandhi.reload --privileged=True -v /mnt/dades --net gandhireload__net -d gandhireload_nfs
         
    - Podemos identificar el volumen creado con la orden docker inspect

            docker inspect -f "{{json .Mounts}}" nfsserver |jq

    - Con su nombre podemos tambien hacer un inspec al volumen

            docker volume inspect $namedockervolume
        
    - incluso podemos listar el contenido desde fuera o gestionarlo

            sudo ls /var/lib/docker/volumes/$namedockervolume/_data

- Ficheros de configuraciónn:

    - Fichero configuracion del servicio [config](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerNfs/install.sh)
    - Fichero de inicio de servicios  [start](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerNfs/startup.sh)

- El servidor se ejecutara en modo ***deattach***

## Extra

Analisis de trafico de red

        tcpdump -nn -T rpc