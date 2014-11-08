#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

NAME="prototipe"
function print_help { 
	printf '%s\n' "";
	printf '%s\n' "package-prototipe: empaqueta el contenido necesario para la ejecución de las ";
	printf '%s\n' "recetas, para ignorar ciertos archivos agregarlos al archivo .package.ignore"  ;
	printf '%s\n' "" ;
	printf '\t%s\n' "Opciones:" ;
	printf '%s\n' "" ;
	printf '\t\t%s\n' "-n	NAME indica el nombre del archvio .tar.gz resultante, " ;
	printf '\t\t%s\n' "		por defecto prototipe." ; 
	printf '\t\t%s\n' "-h	imprime esta ayuda."   ; 
	printf '%s\n' "" ;
} 

function print_error {
	printf '%s\n' "";
	printf '%s\n' "Error: Parámetros incorrectos.";
	print_help;
}

while getopts ':n:h' option;
do
	case "$option"
		in
			n) NAME=${OPTARG};;
			h) print_help; exit 0;;
			*) print_error; exit 2;;
	esac
done
	
	rm -rf $NAME.tar.gz ;
	tar czvf $NAME.tar.gz -X .package.ignore  ./PrototipeGTKInterface ;
		
	printf '\n%s\n' "Release salvado en $NAME.tar.gz"
	printf '%s\n' "";

exit 0
