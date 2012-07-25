# Copyright (c) <2012> <Miguel Vaello Martínez>
# 
# Permission is hereby granted, free of charge, to any
# person obtaining a copy of this software and associated
# documentation files (the "Software"), to deal in the
# Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the
# Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice
# shall be included in all copies or substantial portions of
# the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
# KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
# PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
# OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.#!/bin/bash

USE="Uso: $0 [linea] [cod. parada]"

# Si no se pasa ningún parámetro, se muestra el uso del comando
# Si el número de parámetro es cero (menos que uno)
if [ $# -lt 1 ]; then 
    echo "Error: No se ha introducido ningún parámetro"
	echo $USE
	exit 1
fi
# Si el número de parámetros introducidos es superior a 2, se muestra el error
# diciendo que hay demasiados parámetros, se muestra el uso y se sale (exit)
if [ $# -gt 2 ]; then
	echo "Error: Demasiados parámetros"
	echo $USE
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
exit=$(curl -s http://195.76.144.242:80/services/tespera2.asp -d linea=$LINEA -d parada=$PARADA -d movil=JAVA)

# Para hacerlo compatible con el comando 'say' de OS X, para ello se ha modificado el stream original
exit=$(echo $exit | sed 's .\{1\}  ')
echo $exit
