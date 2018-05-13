# Gandhi Reload by Vladimir Remar
## krbserver Dockerfile
## ASIX M14-2018

Creación Imagen para el servidor de Kerberos


- Creamos la imagen del servidor. Files:

	- [Ficheros para la imagen](https://gitlab.com/vladimir-remar/Gandhi.Reload/tree/master/Documentacion/ModoBasico/ServerKerberos).
	- [Dockerfile](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerGandhi/Dockerfile)

		docker build -t gandhireload_krb .

- Creamos el docker con la imagen:

		docker run --name krb.gandhi.reload -h krb.gandhi.reload --privileged=True --net gandhireload__net -d gandhireload_krb

- El docker ya viene configurado por la imagen y se queda en modo *deattach*.

	- Configuración del realm GANDHI.RELOAD

		- [krb5.conf](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerKerberos/krb5.conf).
		- [kdc.conf](https://gitlab.com/vladimir-remar/Gandhi.Reload/blob/master/Documentacion/ModoBasico/ServerKerberos/kdc.conf).

- Los datos se injectarán de manera remota.