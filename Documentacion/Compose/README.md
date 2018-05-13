# Gandhi Reload
## Docker compose

Ficheros para lanzar el docker-compose

- Generar tanto imagenes como dockers de nuevo

		docker stop $(docker ps -q)
		docker rm $(docker ps -qa)
		docker rmi $(docker images -q)
		#Borrar untagged images
		docker rmi $(docker images | grep "^<none>" | awk '{print $3}')

Para lanzar el *docker compose*.

- Situarse en el directorio raiz del proyecto.
- Ejecutar el comando
		
		docker-compose up -d

También utilizaremos el comando anterior si nos interesa reiniciar los 
servicios que tiene cada docker , por lo contrario si queremos volver
a iniciar los dockers ya creados utilizaremos el seguiente comando:

		docker-compose start