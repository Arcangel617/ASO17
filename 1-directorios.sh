# 1) Escribir un script 1-directorios.sh que genere la siguiente estructura de directorios:

# bin
# doc
# script
# etc enlace a /etc
# log  enlace a /var/log

# El script deberá controlar que los directorios no existan y deberá informar al usuario cada 
# uno de los directorios creados.-

# Luego deberá mover todos los scripts de esta actividad al directorio script, agregar permisos 
# de ejecucion a los archivos dentro de los directorios bin y script y agregar a la variable PATH 
# estos directorios para luego finalizar.-

#!/bin/bash
echo "Hola mundo"