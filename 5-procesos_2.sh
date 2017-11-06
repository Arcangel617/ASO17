#
#DOCUMENTACIÓN:
#
#Autores: Sabadini, Pablo
#         Hernandez, Maximiliano
#         Aquino, Pablo
#         Hipper, Brenda
#         Artiguez, Arcangel
#         Moglia, Franco
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
#ACLARACIÓN SOBRE ESTE SCRIPT
#
#Antes de ejecutar este script se podría correr por consola el comando "$ps -A" para ver una lista de 
los procesos que están activos
#y conocer sus nombres, ya que este script está a la espera de un nombre de proceso y no un número, en 
su primera parte.
#Una vez identificado el proceso el script con el comando pidof y el nombre del proceso lanza otra 
lista con números
#que el usuario nuevamente podrá elegir para pasar a la parte del contenido
#Otra lista se desplegará, y esta se corresponde con los directorios numerados de la carpeta /proc/ y 
a su vez cada
#proceso contiene como información dentro de si mismo.
#Algunos posibles contenidos que se pueden ver con este script pueden ser "status", "stat", "statm". 
Otros pueden ser directorios
#que contienen más información o bien pueden ser archivos, directorios o enlaces simbolicos a otros 
directorios fuera de /proc
#que no pueden tener acceso permitido para el usuario o quien lo esté revisando en ese momento.
#
#

#!/bin/bash

#
#Paleta de colores
#
#

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

DIRECTORIO="$PWD/doc"

function validaProcesos(){

#
#Vamos a pedir por stdin el nombre de un proceso
#(para ver una lista de procesos ejecutar ps -A)
#
#

echo -e "--> ${YELLOW}Ingrese el nombre de un proceso:${NC}"
read nombre_proceso 

ARCHIVOSOPORTE="proceso-<$nombre_proceso>"

#
#Vamos a obtener el PID o ID del proceso que 
#ingresamos por stdin y ver si realmente este proceso existe
#
#

#ps -A | grep $nombre_proceso       
pidof $nombre_proceso

valor=$?             

#
#Vamos a preguntar si realmente el valor que arroja pertenece a un proceso 
#es decir =0(existe y esta en ejecucion) !=0(no es un proceso activo y si un archivo)
#
#

if [ $valor != 0 ]; then
   echo -e "--> ${YELLOW}Es un archivo virtual con\
   información sobre el sistema.${NC}" ; PROCESO=$nombre_proceso   
else
   echo -e "--> ${GREEN}Es un proceso en ejecución.${NC}" ; PROCESO=$nombre_proceso 
   echo -e "--> ${YELLOW}Elija el o uno de los PID-o-ID\
   del proceso para ver su contenido:${NC}"
   read PID         
fi

}

#
#Obliga que exista el directorio doc/
#en las ubicaciones donde se llame al script
#
#

function existeDirectorio(){   

if [ -e $DIRECTORIO ]; then     
  echo -e "--> ${GREEN}Existe el directorio.${NC}"
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
   echo -e "--> ${GREEN}Creando el archivo para el informe.${NC}"
   touch $DIRECTORIO/$ARCHIVOSOPORTE  
fi 

}

#
#Vamos a ver los contenidos de cada proceso ya sea en ejecución o no
#
#

function muestraContenido(){

if [ -e /proc/$PROCESO ]; then                          
   
   echo -e "--> ${YELLOW}La información se encuentra\
   en \"$ARCHIVOSOPORTE\" generado en el directorio \"$DIRECTORIO\"."
   
   cat /proc/$PROCESO > $DIRECTORIO/$ARCHIVOSOPORTE

else
	
   echo -e "--> ${YELLOW}Mostrando el contenido del $PID.${NC}"
   ls -F /proc/$PID
   
   echo -e "--> ${YELLOW}Elija un archivo (podrá ver su contenido\
   en \"$ARCHIVOSOPORTE\" del directorio \"$DIRECTORIO\".${NC})"
   read CONTENIDO
   
   cat /proc/$PID/$CONTENIDO > $DIRECTORIO/$ARCHIVOSOPORTE 
   
   if [ -d /proc/$PID/$CONTENIDO ]; then
      
      echo -e "--> ${RED}No se pueden acceder 
      a los directorios de los procesos o enlaces simbólicos.${NC}"
      exit 1
   fi
fi

echo "Listo."
} 

#
#Llamado a las funciones
#
#

validaProcesos
existeDirectorio
crearArchivoInforme
muestraContenido

exit 0

