#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

DIR_PWD="$(pwd)"
DIR_SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $DIR_SOURCE/env.sh

SAVE_FILE=/tmp
NAME="app"
function print_help { 
	printf '%s\n' "";
	printf '%s\n' "package-app: empaqueta el contenido necesario para la ejecución de las ";
	printf '%s\n' "recetas, para ignorar ciertos archivos agregarlos al archivo .package.ignore"  ;
	printf '%s\n' "" ;
	printf '\t%s\n' "Opciones:" ;
	printf '%s\n' "" ;
	printf '\t\t%s\n' "-n	NAME indica el nombre del archvio .tar.gz resultante, " ;
	printf '\t\t%s\n' "		por defecto app." ;
	printf '\t\t%s\n' "-l	SAVE_FILE indica el directorio donde guardar el archivo resultante, " ;
	printf '\t\t%s\n' "		por defecto /tmp." ;
	printf '\t\t%s\n' "-h	imprime esta ayuda."   ; 
	printf '%s\n' "" ;
} 

function print_error {
	printf '%s\n' "";
	printf '%s\n' "Error: Parámetros incorrectos.";
	print_help;
}

while getopts ':l:n:h' option;
do
	case "$option"
		in
			n) NAME=${OPTARG};;
			l) SAVE_FILE=${OPTARG};;
			h) print_help; exit 0;;
			*) print_error; exit 2;;
	esac
done
	
	cd $DIR_LOCAL;
	rm -rf $SAVE_FILE/$NAME.tar.gz ;
	tar czvf $SAVE_FILE/$NAME.tar.gz -X $DIR_ETC/package-app.ignore  app;
	cd $DIR_PWD;
	
	printf '\n%s\n' "Release salvado en $SAVE_FILE/$NAME.tar.gz"
	printf '%s\n' "";

exit 0
