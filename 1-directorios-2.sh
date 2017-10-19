#!/bin/bash

# Generar la estructura de los directorio

function estrucDirectorio(){
cd $HOME 								#Si estamos en cualquier directorio, leerá que estamos en el home									#Muestra sola la ruta para verifcar
echo "Creando directorio /bin /doc /script, mientras no existan:"	#Crea estructura de directorio
if [ -d ./bin./doc./script ]; then
	exit 1
else
	mkdir ./bin ./doc ./script
fi

ln -s /etc ./etc		#Enlace simbólico

ln -s /var/log ./log            #Enlace simbólico
}

function darPermisosArchivos(){
#ls -l $HOME/script/
cp -r $HOME/*.sh $HOME/script/ ; chmod a+x *.sh		#copia los archivos, y le otorga permisos de ejecución, mientras ya estén creados en el directorio

#ls -l $HOME/bin/
cp -r $HOME/*.bin $HOME/bin ; chmod a+x *.bin           #copia los archivos, y le otorga permisos de ejecución, mientras ya estén creados en el directorio

}

estrucDirectorio
darPermisosArchivos


export PATH=$PATH:$HOME/script/:$HOME/bin/		#agregar al path; de esta forma porque graficamente no lo permite linux
echo $PATH

# Agregar todas las acciones que realizan los demas directorios

#HolaMundo.sh #crear el archivo en el directorio y probar

exit 0
