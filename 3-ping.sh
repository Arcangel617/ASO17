#!/bin/bash

# Escribir un script **"3-ping. sh"** que verifique continuamente, cada cierto tiempo, la conectividad
# con un host determinado mediante el comando ping. Tanto el host como el tiempo entre verificación 
# deberan ser pasados como argumentos del script segun el siguiente formato: 3-ping.sh <IP-o-FQDN> <tiempo>
# El script debera mostrar por salida estandar un mensaje si hay o no conectividad y ademas generar 
# un archivo dentro del directorio doc con la salida del comando ping.-

if [[ $# -eq 0 ]]; then
	echo "Error: No arguments found"
	echo "Usage: 3-ping.sh <IP-o-FQDN> <TIEMPO>"
	exit
fi

if [[ $# -lt 2 ]]; then
	echo "Error: Missing arguments"
	echo "Usage: 3-ping.sh <IP-o-FQDN> <TIEMPO>"
	exit
fi

HOST=$1
TIEMPO=$2

ping $HOST -i $TIEMPO -c 3 >> 3-ping.log

# Se agrega un -c 10 para que después de tres intentos el script pare automaticamente

if [[ $? -gt 0 ]]; then
	echo "Oops! Parece que no hay conexión" 
fi