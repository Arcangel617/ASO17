#!/bin/bash

#
#DOCUMENTACIÓN:
#
#Autores: Sabadini, Pablo; Hernandez, Maximiliano; Aquino, Pablo; Hipper, Brenda; Artigue, Arcangel; Moglia, Franco
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

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

#
#Si no nos pasa ningun parámetro el programa se cierra
#

if [ $# -eq 0 ]; then
   echo -e "--> ${RED}Necesito parámetros para ejecutarme.${NC}"
   exit 1
elif [ $# -lt 2 ]; then
   echo -e "--> ${RED}Solo requiero dos parámetros.${NC}"
   exit 2
else
   echo -e "--> ${YELLOW}Cantidad de parámetros correcta.${NC}"
fi


#
#Vamos a preguntar si existe la carpeta doc/
#y si está vacía para agregar archivos
#

function existeDirectorio(){

echo -e "--> ${YELLOW}Creando directorio...${NC}"
if [ -e $DIRECTORIO ]; then
   echo -e "--> ${GREEN}El directorio ya existe!${NC}"
else
   mkdir ./doc
fi
}

#
#Vamos a crear el archivo que guardará el informe
#

function crearArchivoInforme(){
   if [ -f $ARCHIVOSOPORTE ]; then
      rm ./doc/$ARCHIVOSOPORTE # si el archivo ya existe lo borra y crea uno nuevo
      echo -e "--> ${YELLOW}Creando el archivo para el informe...${NC}"
      touch ./doc/$ARCHIVOSOPORTE
   else
      echo -e "--> ${YELLOW}Creando el archivo para el informe...${NC}"
      touch ./doc/$ARCHIVOSOPORTE
   fi
}

#
#Validamos la existencia del directorio y buscamos los archivos.
#

function encuentraExtensionDirectorio(){
   if [ -d $DIRECTORIOBUSQUEDA ]; then
      find "$DIRECTORIOBUSQUEDA" -type f -iname "*.$EXTENSION" >> ./doc/$ARCHIVOSOPORTE
      echo -e "--> ${GREEN}Terminado!.${NC}"
   else
      echo -e "--> ${RED}No existe el directorio.${NC}"
      echo "El directorio no existe" >> ./doc/$ARCHIVOSOPORTE
      echo -e "--> ${GREEN}Terminado!.${NC}"
      exit 3
   fi
}

existeDirectorio
crearArchivoInforme
encuentraExtensionDirectorio

exit 0
