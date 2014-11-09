#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

DIR_PWD="$(pwd)"
DIR_SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR_PWD
DIR_BIN=$DIR_SOURCE
DIR_LOCAL=$DIR_SOURCE/../local
cd $DIR_LOCAL
DIR_LOCAL="$(pwd)"
DIR_ETC=$DIR_SOURCE/../etc
cd $DIR_ETC
DIR_ETC="$(pwd)"
cd $DIR_PWD

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
	printf '\t\t%s\n' "		por defecto globus-grid-app." ;
	printf '\t\t%s\n' "-L	SAVE_FILE indica el lugar donde se guardara el archvio .tar.gz resultante, " ;
	printf '\t\t%s\n' "		por defecto $DIR_PWD." ;
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

	mkdir -p $DIR_LOCAL/cookbooks/confighost/attributes/tmp-release
	mv $DIR_LOCAL/cookbooks/confighost/attributes/* $DIR_LOCAL/cookbooks/confighost/attributes/tmp-release/
	cat $DIR_LOCAL/cookbooks/confighost/attributes/tmp-release/default-release.rb | sed 's/^#*//g' > $DIR_LOCAL/cookbooks/confighost/attributes/default.rb ;
	
	rm -rf $SAVE_FILE/$NAME.tar.gz ;
	tar czvf $SAVE_FILE/$NAME.tar.gz -X $DIR_ETC/package-release.ignore  ./* ;
	
	rm $DIR_LOCAL/cookbooks/confighost/attributes/default.rb ;
	mv $DIR_LOCAL/cookbooks/confighost/attributes/tmp-release/* $DIR_LOCAL/cookbooks/confighost/attributes/
	rm -rf $DIR_LOCAL/cookbooks/confighost/attributes/tmp-release
	
	printf '\n%s\n' "Release salvado en $SAVE_FILE/$NAME.tar.gz"
	printf '%s\n' "";

exit 0


