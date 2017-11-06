#
#DOCUMENTACIÓN
#
#Autores:   Sabadini, Pablo; 
#           Hernandez, Maximiliano
#           Aquino, Pablo 
#           Hipper, Brenda 
#           Artiguez, Arcangel 
#           Moglia, Franco
#Fecha de Entrega: 28/10/2017 Version 1.0
#Descripción:
#
#Escribir un script 1-directorio.sh que genere la siguiente estructura de directorios:
#
#bin/
#doc/
#script/
#
#etc enlace a /etc
#log enlace a /var/log
#
#Este script deberá controlar que los directorios no existan y deberá informar al usuario cada uno de 
#los directorios creados.-
#
#Luego deberá mover todos los scripts de esta actividad al directorio script, agregar permisos de
#ejecución a los archivos dentro de los directorios bin y script y agregar a la variable PATH
#estos directorios para luego finalizar.-
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

#
#Definimos algunas variables que nos serviran en el script
#
#

#DIRECTORIO1="/tmp/bin/"                  #Esta forma donde se ejecuten todos los script se van a 
crear los directorios
#DIRECTORIO2="/tmp/doc/"
#DIRECTORIO3="/tmp/script/"

DIRECTORIO="$PWD"

#COMANDO="/bin/mkdir $DIRECTORIO1 $DIRECTORIO2 $DIRECTORIO3"    #Esta variable es el comando para 
crear los directorios

COMANDO="/bin/mkdir $DIRECTORIO/bin $DIRECTORIO/doc $DIRECTORIO/script"

function estructuraDirectorio(){     #Inicio de la primera función

if $COMANDO                          #Mientras los directorios no existan serán creados, si existen de 
antemano se cierra script
   then
   echo -e "--> ${GREEN}Los directorios 
   \"bin/\";\"doc/\" y \"script/\" fueron creados.${NC}"
else
   echo -e "--> ${RED}Saliendo de la aplicacion.${NC}"
   exit 1   #Código de error para una futura documentación
fi

echo -e "--> ${GREEN}Creando los enlaces simbólicos.${NC}"     #Crea los enlaces a los directorios, en 
el directorio actual donde se están corriendo los scripts
ln -s /etc ./etc
ln -s /var/log ./log
            
}                                            #Fin de la primera función

function copiarArchivos(){                   #Inicio de la segunda función

#cp -r *.sh ./script/
#cp -r ./script/*.* ./bin/

mv *.sh ./script/                            #Mueve todos los archivos que están en el directorio 
actual a la carpeta script/
cp -r ./script/*.* ./bin/                    #Copia todos los archivos que están en el directorio 
script/ al directorio bin/ desde la ubicación actual


}                                            #Fin de la segunda función

#function darPermisos(){                      #Inicio de la tercera función

#if [ -x $DIRECTORIO3 ]; then                                #El condición pregunta si el directorio 
script/ tiene permisos de ejecución (cuando se lo creo)
#   echo -e "--> ${GREEN}Los archivos\
#   del directorio \"script/\" ya son ejecutables.${NC}"
#   chmod ugo+x $DIRECTORIO3/*.sh                            #Se le otorgan los permisos de ejecución 
a todos los archivos que son copias a la carpeta script
#else
#   echo -e "--> ${RED}Error! No tengo \
#   permiso de acceso a $DIRECTORIO3."  #Mensaje por stdout si ocurre un error
#   exit 2               #Código de error para una futura documentación
#fi

#if [ -x $DIRECTORIO1 ]; then                                  #La misma condición para el directorio 
bin/
#   chmod 644 $DIRECTORIO1/*.sh
#   echo -e "--> ${GREEN}Los archivos\
#   del directorio \"bin/\" ya son ejecutables.${NC}"
#   chmod ugo+x $DIRECTORIO1/*.sh
#else
#   echo -e "--> ${RED}Error! No tengo \
#   permiso de acceso a $DIRECTORIO1.${NC}"
#   exit 2
#fi

#}

function darPermisos(){                      #Inicio de la tercera función

if [ -x $DIRECTORIO/script ]; then                                #El condición pregunta si el 
directorio script/ tiene permisos de ejecución (cuando se lo creo)
   echo -e "--> ${GREEN}Los archivos 
   del directorio \"script/\" ya son ejecutables.${NC}"
   chmod ugo+x $DIRECTORIO/script/*.sh                            #Se le otorgan los permisos de 
ejecución a todos los archivos que son copias a la carpeta script
else
   echo -e "--> ${RED}Error! No tengo 
   permiso de acceso a $DIRECTORIO/script."  #Mensaje por stdout si ocurre un error
   exit 2               #Código de error para una futura documentación
fi

if [ -x $DIRECTORIO1 ]; then                                  #La misma condición para el directorio 
bin/
   chmod 644 $DIRECTORIO/bin/*.sh
   echo -e "--> ${GREEN}Los archivos 
   del directorio \"bin/\" ya son ejecutables.${NC}"
   chmod ugo+x $DIRECTORIO/bin/*.sh
else
   echo -e "--> ${RED}Error! No tengo 
   permiso de acceso a $DIRECTORIO/bin.${NC}"
   exit 2
fi

}

#
#Llamado a las funciones
#
#

echo -e "--> ${YELLOW}Creando los directorios.${NC}"       #Mensaje por stdout para el usuario 
avisando que los directorios se están creando si se tuvo existo anteriormente
estructuraDirectorio                    #Llamado a la primera función

echo -e "--> ${YELLOW}Moviendo los archivos \
a los directorios \"bin/\" y \"script/\".${NC}"  #Mensahe por stdout para el usuario avisando que los 
archivos se movieron
copiarArchivos                          #Llamado a la segunda función

echo -e "--> ${YELLOW}Otorgando permisos:${NC}"              #Mensaje por stdout para el usuario 
avisando que se están otorgando los permisos a los archivos si se tuvo exito
darPermisos                             #Llamado a la tercera función

echo -e "--> ${YELLOW}Agregando a la variable \
PATH los directorios \"bin/\" y \"script/\".${NC}"  #Mensaje por stdout para avisar sobre el último 
paso a realizar con el script

export PATH=$PATH:$DIRECTORIO/bin/:$DIRECTORIO/script/    #Se trata de agregar al PATH de Linux los 
directorios bin/ y script/
echo $PATH              #Mostramos como está el PATH, dentro del script se agregaron los directorios, 
fuera todo el ambiente no sufrio cambio alguno
exec /bin/bash          #Ejecutamos un nuevo ambiente de bash para que estos cambios en la variable 
permanezcan temporalmente y llamar a los demás scripts
sleep 300               #Este comando hará que se mantenga por un cierto tiempo los cambios y así 
poder ejecutar las demás rutinas


exit 0    #Código de existo del script
