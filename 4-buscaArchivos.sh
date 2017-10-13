#!/bin/bash
# Escribir un script **"4-buscaArchivos. sh"** que busque de manera recursiva en un directorio recibido 
# como parametro todos los archivos con una determinada extensión, tambien recibido como parámetro. 
# El script debera verificar que sea un directorio válido, exista y mostrar por salida estandar los 
# archivos encontrados con su ruta completa o absoluta.
# Ademas deberá generar dentro del directorio doc un archivo conteniendo la misma información.
# El archivo generado debera llamarse de la siguiente manera:

# archivos-<extension>en<directorioBusqueda>

if [[ $# -eq 0 ]]; then
	echo "Error: No arguments found"
	echo "Usage: 4-buscaArchivos.sh <FOLDER> <\"FILE\">"
	exit
fi

if [[ $# -lt 2 ]]; then
	echo "Error: Missing arguments"
	echo "Usage: 4-buscaArchivos.sh <FOLDER> <\"FILE\">"
	exit
fi

FOLDER=$1
FILE=$2

if [ -d $1 ]; then
	find $FOLDER -name $FILE > ./doc/archivos
	cat ./doc/archivos
else
	echo "No existe el directorio"
	exit
fi