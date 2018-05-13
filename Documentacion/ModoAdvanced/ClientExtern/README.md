# Gandhi Reload by Vladimir Remar
## Cliente Externo
## ASIX M14-2018

Cliente externo se configura un cliente con servicios minimos para poder 
acceder a los servicios de gandhi.reload esta imagen representará lo que 
un cliente *real* ha de tener para poder trabajar.

Imagen

		docker build -t gandhireload/clientextern .

Podemos utilizar esta imagen para crear un docker interactivo, para luego 
configurarle los servicios con la ayuda de nuestro pequeño script de configuración.

O podemos hacer el mismo deploy en una maquina real y configurar los servicios
de la misma manera.