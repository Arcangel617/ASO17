#!/bin/bash
#
#DOCUMENTACIÓN:
#
#Autores: Sabadini, Pablo
#         Hernandez, Maximiliano
#         Aquino, Pablo 
#         Hipper, Brenda 
#         Artigue, Arcangel
#         Moglia, Franco
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
#
#Paleta de colores
#
#

RED='\033[1;31m'
GREEN='\033[1;32m'
BROWN='\033[0;33m'
YELLOW='\033[1;33m'
CIAN='\033[1;36m'
NC='\033[0m' # No Color

DIRECTORIO="$PWD/../doc"

#
#Primero armamos los parámetros de la búsqueda y se los pasará por consola
#
#

DIRECTORIOBUSQUEDA=$1
EXTENSION=$2
ARCHIVOSOPORTE="archivo-<$EXTENSION>en<$(echo $DIRECTORIOBUSQUEDA | tr / -)>"

#
#Si no nos pasa ningun parámetro el programa se cierra
#
#

if [ $# -eq 0 ]; then
   echo -e "--> ${RED}ERROR: Se necesitan dos parámentros.${NC}"
   echo -e "--> ${YELLOW}Usage: 4-buscaArchivos.sh <DIRECTORIO> <EXTENSION>${NC}"
   exit 4
elif [ $# -gt 2 ]; then
   echo -e "--> ${RED}ERROR: Se necesitan dos parámentros.${NC}"
   echo -e "--> ${YELLOW}Usage: 4-buscaArchivos.sh <DIRECTORIO> <EXTENSION>${NC}"
else
   echo -e "--> ${BROWN}Comprobando directorios...${NC}"
fi

#
#Obliga que exista el directorio doc/
#en las ubicaciones donde se llame al script
#
#

function existeDirectorio(){   

if [ -e $DIRECTORIO ]; then     
  echo -e "--> ${GREEN}OK.${NC}"
else
  echo -e "--> ${RED}¡Error de PATH! Estás dentro del \"doc/\" 
  o bien no exite el directorio en este camino. 
  Mostrando PATH:$PWD.${NC}"
  exit 1
fi

}

#
#Se crea el archivo que guardará el informe
#
#

function crearArchivoInforme(){

  if [ -f $DIRECTORIO/$ARCHIVOSOPORTE ]; then
     echo -e "--> ${RED}¡Error! El archivo \"$ARCHIVOSOPORTE\" ha sido creado antes.${NC}"
     exit 3
  else
    echo -e "--> ${BROWN}Creando el archivo para el informe.${NC}"
    touch $DIRECTORIO/$ARCHIVOSOPORTE
    echo -e "--> ${GREEN}Hecho.${NC}"
  fi
}

#
#Validamos la existencia del directorio 
#y buscamos los archivos.
#
#

function encuentraExtensionDirectorio(){  

echo -e "--> ${BROWN}Buscando archivos \"$EXTENSION\" en \"$DIRECTORIOBUSQUEDA\".${NC}"
if [ -d $DIRECTORIOBUSQUEDA ]; then 
  echo -e "--> ${GREEN}El directorio existe y es válido.${NC}"
  ( find $DIRECTORIOBUSQUEDA -type f -iname "*.$EXTENSION" -print 2>&1 | fgrep -v "Permiso denegado" ) && 
  ( find $DIRECTORIOBUSQUEDA -type f -iname "*.$EXTENSION" -print 2>&1 | fgrep -v "Permiso denegado" ) >> $DIRECTORIO/$ARCHIVOSOPORTE 
else
   echo -e "--> ${RED}No existe el directorio.${NC}"
   exit 1 
fi

}

#
#Llamados a las funciones
#
#

existeDirectorio
crearArchivoInforme
encuentraExtensionDirectorio

exit 0

