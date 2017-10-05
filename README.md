# ASO17

Actividad Practica : Programación de Script Shell
T.S.P Arquitectura y Sistemas Operativos 2017
Espacio para subir la actividad práctica sobre programación de scripts para shell Bash.

Documentación a Entregar

Se deberá subir a esta actividad un archivo comprimido (gz,zip) que contenga un archivo por cada script solicitado.
Además del código del script cada archivo deberá contener la siguiente documentación:

    Autores: Comentario con los datos de los autores del script.
    Fecha: Fecha de realización y versión.
    Descripcion: Enunciado de lo que realiza el script.
    Acciones: en cada acción que realice el scrit se deberá documentar que acción realiza con comentarios oportunamente agregados entre lineas del código.

Resolver los siguientes problemas utilizando programación de scripts para el shell Bash:

1) Escribir un script 1-directorios.sh que genere la siguiente estructura de directorios:

bin

doc

script

etc enlace a /etc

log  enlace a /var/log

El script deberá controlar que los directorios no existan y deberá informar al usuario cada uno de los directorios creados.-

Luego deberá mover todos los scripts de esta actividad al directorio script, agregar permisos de ejecucion a los archivos dentro de los directorios bin y script y agregar a la variable PATH estos directorios para luego finalizar.-

2) Escribir un script 2-info.sh que genere un archivo INFO.sistema (ubicado en directorio doc antes generado) que reuna informacion del sistema que utilizan. El archivo debe incluir la siguiente información, delimitada por titulos descriptivos.-

    Fecha del reporte. (date,uptime)
    Version del equipo y kernel (uname,hostname)
    version del S.O. ( lsb-release)
    Hardware: Procesador, memoria y perifericos. (proc/cpuinfo , memory,free , ls cpu, lsusb, lspci,lsblk)
    Espacio de disco y particiones montadas (fdisk,du, etc/f stab,blkid)

3) Escribir un script 3-ping.sh que verifique continuamente, cada cierto tiempo, la conectividad con un host determinado mediante el comando ping. Tanto el host como el tiempo entre verificación deberan ser pasados como argumentos del script segun el siguiente formato: 3-ping.sh <IP-o-FQDN> <tiempo>
El script debera mostrar por salida estandar un mensaje si hay o no conectividad y ademas generar un archivo dentro del directorio doc con la salida del comando ping.-

4) Escribir un script 4-buscaArchivos.sh que busque de manera recursiva en un directorio recibido como parametro todos los archivos con una determinada extensión, tambien recibido como parámetro. El script debera verificar que sea un directorio válido, exista y mostrar por salida estandar los archivos encontrados con su ruta completa o absoluta.
Ademas deberá generar dentro del directorio doc un archivo conteniendo la misma información.El archivo generado debera llamarse de la siguiente manera:

archivos-<extension>en<directorioBusqueda>


5) Escribir un script  5-procesos.sh que determine si un determinado proceso se encuentra en ejecución y muestra informacion detallada sobre el mismo a partir de informacion almacenada en el directorio proc.
El nombre del proceso es ingresado por entrada estandar (no argumento).
El script debera generar dentro del directorio doc un archivo conteniendo la información detallada.El archivo generado debera llamarse de la siguiente manera: proceso-<nombre_proceso>

https://www.howtoforge.com/kvm-and-openvz-virtualization-and-cloud-computing-with-proxmox-ve
