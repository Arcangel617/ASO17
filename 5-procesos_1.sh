#
#DOCUMENTACIÓN:
#
#Autores: Sabadini, Pablo; Hernandez, Maximiliano; Aquino, Pablo; Hipper, Brenda; Artiguez, Arcangel; Moglia, Franco
#Fecha de Entrega: 28/10/2017 Version 1.0
#Descripción:
#
#Escribir un script 5-procesos.sh que determine si un determinado proceso
#se encuentra en ejecución y muestra información detallada sobre el mismo
#a partir de información almacenada en el directorio proc.
#El nombre del proceso es ingresado por entrada estandar (no argumento).
#El script debera generar dentro del directorio doc un archivo 
#conteniendo la información detallada. El archivo generado deberá
#llamarse de la siguiente manera: proceso-<nombre_proceso>
#
#

#!/bin/bash

DIRECTORIO=./doc/

#
#Vamos a preguntar si existe la carpeta doc/
#y si está vacía para agregar archivos
#

function existeDirectorio(){

if [ -e $DIRECTORIO ]; then
   echo "Existe el directorio."
else
   echo "1-directorios.sh falló al no crear el directorio $DIRECTORIO"
   exit 1
fi

}

#
#Vamos a preguntar si nosotros nos podemos ejecutar
#dentro del directorio
#

function permisoArchivo(){

cd ./bin

if [ -x 5-procesos.sh ]; then  # Para realizar las pruebas cambiar 5-procesos.sh por rutinaS5.sh
   echo "Tengo permisos de ejecución."
else
   echo "¡Error! No se otorgaron los permisos de ejecución."
   exit 2
fi

}

function validaProcesos(){

#
#Vamos a pedir por stdin el nombre de un proceso
#(para ver una lista de procesos ejecutar ps -A)
#
#

echo "Ingrese el nombre de un proceso:"
read nombre_proceso  # guardamos lo que nos introduce por teclado

ARCHIVOSOPORTE="proceso-<$nombre_proceso>"

#
#Vamos a obtener el PID o ID del proceso que 
#ingresamos por stdin y ver si realmente este proceso existe
#
#

#ps -A | grep $nombre_proceso
pidof $nombre_proceso

valor=$?

if [ $valor != 0 ]; then
   echo "Es un archivo virtual con información sobre el sistema." ; PROCESO=$nombre_proceso # si se da este caso guardar el proceso en la variable, tal como está aca
else
   echo "Es un proceso en ejecución." ; PROCESO=$nombre_proceso # si se da este caso guardar todos los PID en un arreglo
   echo "Elija el o uno de los PID-o-ID del proceso para ver su contenido:"
   read PID
fi

#echo "La información del proceso se encontrará en \"$ARCHIVOSOPORTE\" generado en la carpeta \"$DIRECTORIO\"."

}

function crearArchivoInforme(){

cd ./../$DIRECTORIO    #Desde el directorio donde estoy actualmente voy al directorio doc/ para crear el archivo

if [ -f $ARCHIVOSOPORTE ]; then
   echo "¡Error! El archivo \"$ARCHIVOSOPORTE\" ha sido creado antes."
   exit 3
else
   echo "Creando el archivo para el informe."
   touch $ARCHIVOSOPORTE
fi 

}

#
#Vamos a ver los contenidos de cada proceso ya ese en ejecución o no
#

function muestraContenido(){

if [ -e /proc/$PROCESO ]; then
   echo "La información se encuentra en \"$ARCHIVOSOPORTE\" generado en el directorio \"$DIRECTORIO\"."
   cat /proc/$PROCESO > $ARCHIVOSOPORTE
else
   echo "Mostrando el contenido del $PID."; 
   ls -F /proc/$PID
   echo "Elija un archivo (podrá ver su contenido en \"$ARCHIVOSOPORTE\" del directorio \"$DIRECTORIO\".)"
   read CONTENIDO
   cat /proc/$PID/$CONTENIDO > $ARCHIVOSOPORTE 
   if [ -d /proc/$PID/$CONTENIDO ]; then
      echo "No se pueden acceder a los directorios."
      exit 4
   fi
fi

}

existeDirectorio
permisoArchivo
validaProcesos
crearArchivoInforme
muestraContenido



exit 0
