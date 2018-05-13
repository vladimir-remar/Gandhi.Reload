# Gandhi Reload by Vladimir Remar
## CLiente Interno Dockerfile
## ASIX M14-2018

Creación Imagen para el cliente interno, cliente que pertenece a la
misma red que los otros servidores.

		docker build -t gandhireload_clientintern .

		docker run --name clientintern.gandhi.reload -h clientintern.gandhi.reload --privileged=True --net gandhireload__net -it gandhireload_clientintern /bin/bash