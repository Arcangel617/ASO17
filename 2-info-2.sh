#!/bin/bash

#
#Vamos a preguntar si existe la carpeta doc/
#y si está vacía para agregar archivos
#

DIRECTORIO=./doc

function existeDirectorio(){

if [ -e $DIRECTORIO ]; then
  echo "Existe el directorio "
else
  echo "Falló al no crearse $DIRECTORIO"  # Tal vez convenga mejor que lo cree al directorio en vez de terminar el script
  exit 1
fi
}

#
#Vamos a preguntar si nosotros nos podemos ejecutar
#dentro del directorio
#

function permisoArchivo(){
cd ./bin    # En teoria este archivo existe dentro del directorio y pregunto si tiene los permisos dados con el script 1
if [ -x info.sh ]; then
   echo "Tengo permisos"
else
   echo "Error! No se otorgaron los permisos de ejecución."
   exit 2
fi
}

#
#Crear el archivo que guardará el informe
#

function crearArchivoInforme(){ 2> informeERROR1.txt

cd ./../$DIRECTORIO         #desde el directorio estoy actualmente voy al directorio doc/ para crear el archivo

if [ -f INFO.sistema ]; then
   echo "¡Error! No debería existir el archivo \"INFO.sistema\" sin haberse creado antes."
   exit 3
else
   echo "Creando el archivo para el informe."
   touch INFO.sistema
fi

#
#Cargar la información al archivo INFO.sistema
#

(echo -e "FECHA REPORTE:" && date +%D) > INFO.sistema
(echo -e "VERSIÓN DEL EQUIPO:" && uname -m) >> INFO.sistema
(echo -e "VERSIÓN DEL KERNEL:" && uname -v) >> INFO.sistema
(echo -e "VERSION DEL SO:" && lsb_release -a) >> INFO.sistema
(echo -e "HARDWARE: a) INFORMACIÓN SOBRE EL PROCESADOR:" && lscpu |  grep -e "Arquitectura" -e "CPU" -e "ID" -e "Virtualizacion" -e "Caché") >> INFO.sistema
(echo -e "          b) INFORMACIÓN SOBRE LA MEMORIA:" && free -h -l -t) >> INFO.sistema
(echo -e "          c) INFORMACIÓN SOBRE LOS PERIFÉRICOS:" && lsusb ) >> INFO.sistema
(echo -e "          d) OTROS DISPOSITIVOS DEL SISTEMA:" && lspci -nn) >> INFO.sistema
(echo -e "ESPACIO EN DISCO:" && sudo fdisk -l) >> INFO.sistema
(echo -e "INFORMACIÓN AMPLIADA SOBRE EL DISCO:" && lsblk -a -f -l -m -p -S -t && blkid) >> INFO.sistema
(echo -e "PARTICIONES MONTADAS:" && cat /etc/fstab | grep -e "noatime" ) >> INFO.sistema

}

existeDirectorio
permisoArchivo
crearArchivoInforme

exit 0

