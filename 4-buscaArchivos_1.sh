#!/bin/bash

#
#DOCUMENTACIÓN:
#
#Autores: Sabadini, Pablo; Hernandez, Maximiliano; Aquino, Pablo; Hipper, Brenda; Artiguez, Arcangel; Moglia, Franco
#Fecha de Entrega: 28/10/2017 Version 1.0
#Descripción:
#
#Escribir un script 4-buscaArchivos.sh que busque de manera recursiva en un directorio recibido como parametro 
#todos los archivos con una determinada extensión, tambien recibido como parámetro. El script debera verificar 
#que sea un directorio válido, exista y mostrar por salida estandar los archivos encontrados con su 
#ruta completa o absoluta.
#Ademas deberá generar dentro del directorio doc un archivo conteniendo la misma información.
#El archivo generado debera llamarse de la siguiente manera:
#
#archivos-<extension>en<directorioBusqueda>
#

#
#Primero armamos los parámetros de la búsqueda y se los pasará por consola
#


DIRECTORIOBUSQUEDA=$1
EXTENSION=$2
ARCHIVOSOPORTE="archivo-<$EXTENSION>en<"$(echo $DIRECTORIOBUSQUEDA | tr / -)">"
DIRECTORIO=./doc/

#
#Si no nos pasa ningun parámetro el programa se cierra
#

if [ $# -eq 0 ]; then
   echo "Necesito parámetros para ejecutarme."
   exit 1
elif [ $# -gt 2 ]; then
   echo "Solo requiero dos parámetros."
   exit 2
else
   echo "Cantidad de parámetros correcta."
fi


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

if [ -x 4-buscaArchivos.sh ]; then  # Para realizar las pruebas cambiar 4-buscaArchivos.sh por rutinaS4.sh
   echo "Tengo permisos de ejecución."
else
   echo "¡Error! No se otorgaron los permisos de ejecución."
   exit 2
fi

}


#
#Vamos a crear el archivo que guardará el informe
#

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
#Validamos la existencia del directorio y buscamos los archivos.
#

function encuentraExtensionDirectorio(){

if [ -d $DIRECTORIOBUSQUEDA ]; then
   echo "El directorio existe y es válidos."
   ( find "$DIRECTORIOBUSQUEDA" -type f -iname "$EXTENSION" ) && 
   ( find "$DIRECTORIOBUSQUEDA" -type f -iname "$EXTENSION" ) >> $ARCHIVOSOPORTE
else
   echo "No existe el directorio."
   exit 3
fi
}

existeDirectorio
permisoArchivo
crearArchivoInforme
encuentraExtensionDirectorio


exit 0
