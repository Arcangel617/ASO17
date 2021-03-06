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
#Escribir un script 3-ping.sh que verifique continuamente, cada cierto
#tiempo, la conectividad con un host determinado mediante el comando
#ping. Tanto el host como el tiempo entre verificación deberán ser
#pasados como argumentos del script según el siguiente formato:
#3-ping.sh <IP-o-FQDN> <tiempo>
#El script deberá mostrar por salida estandar un mensaje si hay o no
#conectividad y además generar un archivo dentro del directorio doc
#con la salida del comando ping.
#
#
#
#ACLARACIÓN: puede tardar un poco más de tiempo en realizar la búsqueda
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

#
#Variables que van a recibir los parámetros que le pasemos al script
#
#

DIRECTORIO="$PWD/../doc"

HOST=$1   #IP o FQDN
TIEMPO=$2

#
#Preguntamos si nos pasaron parámatros para poder ejecutar el script
#En caso de no pasar ninguno, finaliza el script
#Si nos pasan parámetros verifica si en realidad pasaron más de los necesarios
#
#

if [ $# -eq 0 ]; then
   echo -e "--> ${RED}ERROR: Se necesitan dos parámentros.${NC}"
   echo -e "--> ${YELLOW}Usage: 3-ping.sh <IP-o-FQDN> <tiempo>${NC}"
   exit 4
elif [ $# -gt 2 ]; then
   echo -e "--> ${RED}ERROR: Se necesitan dos parámentros.${NC}"
   echo -e "--> ${YELLOW}Usage: 3-ping.sh <IP-o-FQDN> <tiempo>${NC}"
   exit 5
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
#Analiza la conexión a Internet 
#y arroja el resultado de la conexión
#
#

function existeConexion(){  

COMANDO="ping -c 5 $HOST"    
CONT=1                       
echo -e "--> ${BROWN}Comprobando conectividad con $HOST${NC}"
echo -e "--> ${CIAN}Ctrl+C p/Finalizar${NC}"
echo -e "\n** CONEXION CON LA RED IP O FQDN $HOST **" >> $DIRECTORIO/INFO.sistema


while [ true ]; do    

   sleep $TIEMPO       
   
   echo "Prueba de conexión Nº $CONT" >> $DIRECTORIO/INFO.sistema
   
   ( echo -e "\n\nFecha:"  &&  date +%d/%m/%y )  >> $DIRECTORIO/INFO.sistema

   $COMANDO >> $DIRECTORIO/INFO.sistema
   
   RESULTADO=$( $COMANDO | grep -o 64 )
   
   if [[ "$RESULTADO" != "" ]]; then      
      echo -e "--> ${YELLOW}Hay conectividad.${NC}"
   else
      echo -e "--> ${RED}No hay conectividad.${NC}"  
   fi

   let CONT+=1   
done  

}  

#
#Llamados de las funciones
#
#

existeDirectorio
existeConexion

exit 0
