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

#DIRECTORIO1="/tmp/bin/"                  
#DIRECTORIO2="/tmp/doc/"
#DIRECTORIO3="/tmp/script/"

DIRECTORIO="$PWD"

#COMANDO="/bin/mkdir $DIRECTORIO1 $DIRECTORIO2 $DIRECTORIO3"   

COMANDO="/bin/mkdir $DIRECTORIO/bin $DIRECTORIO/doc $DIRECTORIO/script"

function estructuraDirectorio(){     

if $COMANDO                          
   then
   echo -e "--> ${GREEN}Los directorios 
   \"bin/\";\"doc/\" y \"script/\" fueron creados.${NC}"
else
   echo -e "--> ${RED}Saliendo de la aplicacion.${NC}"
   exit 1   #Código de error para una futura documentación
fi

echo -e "--> ${GREEN}Creando los enlaces simbólicos.${NC}"  
ln -s /etc ./etc
ln -s /var/log ./log
            
}                                            

function copiarArchivos(){                  

#cp -r *.sh ./script/
#cp -r ./script/*.* ./bin/

mv *.sh ./script/                            
actual a la carpeta script/
cp -r ./script/*.* ./bin/             


}                                     

#function darPermisos(){                      

#if [ -x $DIRECTORIO3 ]; then                               
#   echo -e "--> ${GREEN}Los archivos\
#   del directorio \"script/\" ya son ejecutables.${NC}"
#   chmod ugo+x $DIRECTORIO3/*.sh                           
#else
#   echo -e "--> ${RED}Error! No tengo \
#   permiso de acceso a $DIRECTORIO3."  
#   exit 2              
#fi

#if [ -x $DIRECTORIO1 ]; then                                
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

function darPermisos(){                     

if [ -x $DIRECTORIO/script ]; then                                
   echo -e "--> ${GREEN}Los archivos 
   del directorio \"script/\" ya son ejecutables.${NC}"
   chmod ugo+x $DIRECTORIO/script/*.sh                          
else
   echo -e "--> ${RED}Error! No tengo 
   permiso de acceso a $DIRECTORIO/script."  
   exit 2               
fi

if [ -x $DIRECTORIO1 ]; then                                 
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

echo -e "--> ${YELLOW}Creando los directorios.${NC}"       
estructuraDirectorio                    

echo -e "--> ${YELLOW}Moviendo los archivos \
a los directorios \"bin/\" y \"script/\".${NC}"
copiarArchivos                          

echo -e "--> ${YELLOW}Otorgando permisos:${NC}"              
darPermisos                             

echo -e "--> ${YELLOW}Agregando a la variable \
PATH los directorios \"bin/\" y \"script/\".${NC}"  

export PATH=$PATH:$DIRECTORIO/bin/:$DIRECTORIO/script/   
echo $PATH              
exec /bin/bash          
sleep 300               

exit 0    #Código de existo del script
