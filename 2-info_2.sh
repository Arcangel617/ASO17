#
#DOCUMENTACIÓN
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
#Escribir un script 2-info.sh que genere un archivo INFO.sistema (ubicado en directorio doc antes
#generado) que reuna información del sistema que utilizan. El archivo debe incluir la siguiente
#información, delimitada por títulos descriptivos.-
#
#Fecha del reporte. (date,uptime)
#Versión del equipo y kernel (uname,hostname)
#Versión del S.O.(lsb-release)
#Hardware: Procesador, memoria y periféricos. (proc/cpuinfo,memory,free,lscpu,lsusb,lspci,lsblk)
#Espacio de disco y particiones montadas (fdisk,du,etc/fstab,blkid)
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

DIRECTORIO="$PWD/../doc"

#
#Obliga que exista el directorio doc/
#en las ubicaciones donde se llame al script
#
#

function existeDirectorio(){   

if [ -e $DIRECTORIO ]; then     
  echo -e "--> ${GREEN}Existe el directorio.${NC}"
else
  echo -e "--> ${RED}¡Error de PATH! Estás dentro de \"doc/\" 
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

if [ -f $DIRECTORIO/INFO.sistema ]; then          
   echo -e "--> ${RED}¡Error! El archivo \"INFO.sistema\" ha sido creado antes.${NC}"
   exit 3             
else
   echo -e "--> ${YELLOW}Creando el archivo para el informe.${NC}"
   touch $DIRECTORIO/INFO.sistema
fi

}


function llenarArchivoInformacion(){

#
#Cargar la información al archivo INFO.sistema
#
#

echo "** DETALLANDO EL HARDWARE DEL SISTEMA **" > $DIRECTORIO/INFO.sistema

( echo -e "\n** FECHA REPORTE:" && date +%d/%m/%Y ) >> $DIRECTORIO/INFO.sistema       

( echo -e "\n** VERSIÓN DEL EQUIPO:" && uname -m ) >>  $DIRECTORIO/INFO.sistema     

( echo -e "\n** VERSIÓN DEL KERNEL:" && uname -srv ) >> $DIRECTORIO/INFO.sistema   

( echo -e "\n** VERSION DEL SO:" && lsb_release -a ) >> $DIRECTORIO/INFO.sistema     

( echo -e "\n** HARDWARE: a) INFORMACIÓN SOBRE EL PROCESADOR:" && lscpu |  grep -e "Arquitectura" -e "CPU" -e "ID" -e "Virtualizacion" -e "Caché" ) >> $DIRECTORIO/INFO.sistema

( echo -e "\n             b) INFORMACIÓN SOBRE LA MEMORIA:" && free -h -l -t ) >> $DIRECTORIO/INFO.sistema

( echo -e "\n             c) INFORMACIÓN SOBRE LOS PERIFÉRICOS:" && lsusb ) >> $DIRECTORIO/INFO.sistema   

( echo -e "\n             d) OTROS DISPOSITIVOS DEL SISTEMA:" && lspci -nn ) >> $DIRECTORIO/INFO.sistema    

( echo -e "\n** ESPACIO EN DISCO:" && fdisk -l ) >> $DIRECTORIO/INFO.sistema  

( echo -e "\n** INFORMACIÓN AMPLIADA SOBRE EL DISCO:" && lsblk -a -f -l -m -p -S -t && blkid ) >> $DIRECTORIO/INFO.sistema

( echo -e "\n** PARTICIONES MONTADAS:" && cat /etc/fstab | grep -e "noatime" ) >> $DIRECTORIO/INFO.sistema

}

#
#Llamado a las funciones
#
#

existeDirectorio
crearArchivoInforme
llenarArchivoInformacion 

exit 0
