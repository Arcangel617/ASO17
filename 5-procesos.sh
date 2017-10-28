#!/bin/bash
#
#DOCUMENTACIÓN:
#
#Autores: Sabadini, Pablo; Hernandez, Maximiliano; Aquino, Pablo; Hipper, Brenda; Artigue, Arcangel; Moglia, Franco
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

DIRECTORIO=./doc/
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

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
   echo -e "--> ${RED}No se encontró un proceso activo con ese nombre${NC}"
   echo -e "--> ${GREEN}Terminado!${NC}"
   exit
else
   
   PID=$(pidof $nombre_proceso)
   echo "========================================================" > ./doc/$ARCHIVOSOPORTE
   echo "--> Información del proceso $PID" >> ./doc/$ARCHIVOSOPORTE
   echo "========================================================" >> ./doc/$ARCHIVOSOPORTE
   echo "--> /proc/$PID/status" >> ./doc/$ARCHIVOSOPORTE
   echo "========================================================" >> ./doc/$ARCHIVOSOPORTE
   cat /proc/$PID/status >> ./doc/$ARCHIVOSOPORTE
   echo "========================================================" >> ./doc/$ARCHIVOSOPORTE
   echo "--> /proc/$PID/stat" >> ./doc/$ARCHIVOSOPORTE
   echo "========================================================" >> ./doc/$ARCHIVOSOPORTE
   cat /proc/$PID/stat >> ./doc/$ARCHIVOSOPORTE
   echo "========================================================" >> ./doc/$ARCHIVOSOPORTE
   echo "--> /proc/$PID/statm" >> ./doc/$ARCHIVOSOPORTE
   echo "========================================================" >> ./doc/$ARCHIVOSOPORTE
   cat /proc/$PID/statm >> ./doc/$ARCHIVOSOPORTE
fi

}

function crearArchivoInforme(){
   if [ -f ./doc/$ARCHIVOSOPORTE ]; then
      rm  ./doc/$ARCHIVOSOPORTE # si el archivo ya existe lo borra y crea uno nuevo
      echo -e "--> ${YELLOW}Creando el archivo para el informe...${NC}"
      # exit
      touch ./doc/$ARCHIVOSOPORTE
   else
      echo -e "--> ${YELLOW}Creando el archivo para el informe...${NC}"
      touch ./doc/$ARCHIVOSOPORTE
   fi
}

existeDirectorio
crearArchivoInforme
validaProcesos
echo "========================================================"
echo -e "--> ${YELLOW}Leyendo informe${NC}"
cat ./doc/$ARCHIVOSOPORTE
echo -e "--> ${GREEN}Terminado!${NC}"

exit 0
