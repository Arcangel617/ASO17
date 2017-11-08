#!/bin/bash
#
#DOCUMENTACIÓN
#
#Autores:   Sabadini, Pablo; 
#           Hernandez, Maximiliano
#           Aquino, Pablo 
#           Hipper, Brenda 
#           Artigue, Arcangel 
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

#
#Paleta de colores
#
#

RED='\033[1;31m'
GREEN='\033[1;32m'
BROWN='\033[0;33m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

#
#Definimos algunas variables que nos serviran en el script
#
#

DIRECTORIO="$PWD"

COMANDO="/bin/mkdir $DIRECTORIO/bin $DIRECTORIO/doc $DIRECTORIO/script"

function estructuraDirectorio(){     

   if $COMANDO                          
      then
      echo -e "--> ${GREEN}Hecho.${NC}"
   else
      echo -e "--> ${RED}No se crearon los directorios.${NC}"
      echo -e "--> ${BROWN}Se sale de la aplicación.${NC}"
      exit 1
   fi

   echo -e "--> ${BROWN}Creando los enlaces simbólicos...${NC}"  
   ln -s /etc ./etc
   ln -s /var/log ./log
   echo -e "--> ${GREEN}Hecho.${NC}"            
}                                            

function copiarArchivos(){
   mv *.sh ./script/
   cp -r ./script/*.* ./bin/
   echo -e "--> ${GREEN}Hecho.${NC}"
}                                     

function darPermisos(){                     

if [ -x $DIRECTORIO/script ]; then                                
   chmod ugo+x $DIRECTORIO/script/*.sh                          
else
   echo -e "--> ${RED}Error! No se tienen permisos de acceso a $DIRECTORIO/script."  
   exit 2               
fi

if [ -x $DIRECTORIO1 ]; then
   chmod 644 $DIRECTORIO/bin/*.sh
   chmod ugo+x $DIRECTORIO/bin/*.sh
else
   echo -e "--> ${RED}Error! No se tienen permisos de acceso a $DIRECTORIO/bin.${NC}"
   exit 2
fi

}

#
#Llamado a las funciones
#
#

echo -e "--> ${BROWN}Creando los directorios \"bin\", \"doc\" y \"script\"...${NC}"       
estructuraDirectorio                    

echo -e "--> ${BROWN}Moviendo los archivos a los directorios \"bin\" y \"script\"...${NC}"
copiarArchivos                          

echo -e "--> ${BROWN}Otorgando permisos de ejecución a los scripts...${NC}"              
darPermisos
echo -e "--> ${GREEN}Hecho.${NC}"

echo -e "--> ${BROWN}Agregando a la variable PATH los directorios \"bin/\" y \"script/\"...${NC}"  

export PATH=$PATH:$DIRECTORIO/bin/:$DIRECTORIO/script/   
echo -e "--> ${YELLOW}${PATH}${NC}"
echo -e "--> ${GREEN}Hecho.${NC}"                    
exec /bin/bash
sleep 300               

exit 0
