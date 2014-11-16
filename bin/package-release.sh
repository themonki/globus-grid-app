#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

DIR_PWD="$(pwd)"
DIR_SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $DIR_SOURCE/env.sh

SAVE_FILE=$DIR_PWD
NAME="globus-grid-app"
function print_help { 
	printf '%s\n' "";
	printf '%s\n' "package-realease: empaqueta el contenido necesario para la ejecución de las ";
	printf '%s\n' "recetas, para ignorar ciertos archivos agregarlos al archivo .package.ignore"  ;
	printf '%s\n' "" ;
	printf '\t%s\n' "Opciones:" ;
	printf '%s\n' "" ;
	printf '\t\t%s\n' "-n	NAME indica el nombre del archvio .tar.gz resultante, " ;
	printf '\t\t%s\n' "	por defecto globus-grid-app." ;
	printf '\t\t%s\n' "-L	SAVE_FILE indica el lugar donde se guardara el archivo" ;
	printf '\t\t%s\n' "	.tar.gz resultante, por defecto la carpeta actual." ;
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

DIR_ATT="$DIR_LOCAL/cookbooks/confighost/attributes"


mkdir -p "$DIR_ATT/tmp-release"
mv "$DIR_ATT/"*.rb "$DIR_ATT/tmp-release/"
cat "$DIR_ATT/tmp-release/default-release.rb" | sed 's/^#*//g' > "$DIR_ATT/default.rb" ;

rm -rf "$SAVE_FILE/$NAME.tar.gz" ;
tar czvf "$SAVE_FILE/$NAME.tar.gz" -X "$DIR_ETC/package-release.ignore"  ./*

rm "$DIR_ATT/default.rb"
mv "$DIR_ATT/tmp-release/"*.rb "$DIR_ATT/"
rm -rf "$DIR_ATT/tmp-release"

printf '\n%s\n' "Release salvado en $SAVE_FILE/$NAME.tar.gz"
printf '%s\n' ""

exit 0


