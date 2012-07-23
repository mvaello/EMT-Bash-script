#!/bin/bash

USO="Uso: $0 [linea] [cod. parada]"

# Si no se pasa ningún parámetro, se muestra el uso del comando
# Si el número de parámetro es cero (zero -z)
if [ -z $# ]; then 
	echo $USO
	exit 1
fi
# Si el número de parámetros introducidos es superior a 2, se muestra el error
# diciendo que hay demasiados parámetros, se muestra el uso y se sale (exit)
if [ $# -gt 2 ]; then
	echo "Demasiados parámetros"
	echo $USO
	exit 1
fi
# Si el número de parámetros es igual a 1, se asigna el código de la parada de bus a la variable PARADA 
# La variable LINEA queda vacía, no es necesaria en este caso
if [ $# -eq 1 ]; then
	PARADA=$1
	LINEA=""
fi

# Si el número de parámetros es igual a 2, se asigna el código de la parada de bus a la variable PARADA 
# A la variable LINEA se le asigna el número de linea que le corresponde
if [ $# -eq 2 ]; then
	PARADA=$1
	LINEA=$2
fi
 
# Para poder hacer una "query" al sevidor, se ha empleado el programa cURL. Mediante el mandato curl, al que 
# se le pasan como parámetros la url del servidor y la cadena correspondiente a la petición de tipo POST (-d) con 
# la línea y la parada de bus así como la plataforma que recibe los datos, en este caso Java. 
salida=$(curl -s http://195.76.144.242:80/services/tespera2.asp -d linea=$LINEA -d parada=$PARADA -d movil=JAVA)

# Para hacerlo compatible con el comando sey de Mac, se ha modificado el stream original
salida=$(echo $salida | sed 's .\{1\}  ')
echo $salida
