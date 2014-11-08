#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

NAME="globus"
function print_help { 
	printf '%s\n' "";
	printf '%s\n' "package-realease: empaqueta el contenido necesario para la ejecución de las ";
	printf '%s\n' "recetas, para ignorar ciertos archivos agregarlos al archivo .package.ignore"  ;
	printf '%s\n' "" ;
	printf '\t%s\n' "Opciones:" ;
	printf '%s\n' "" ;
	printf '\t\t%s\n' "-n	NAME indica el nombre del archvio .tar.gz resultante, " ;
	printf '\t\t%s\n' "		por defecto globus." ; 
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

	mv  ./machineglobus/cookbooks/confighost/attributes/default.rb ./machineglobus/cookbooks/confighost/attributes/default.rb.tmp ;
	cat ./machineglobus/cookbooks/confighost/attributes/default-release.rb | sed 's/^#*//g' > ./machineglobus/cookbooks/confighost/attributes/default.rb ;
	
	rm -rf $NAME.tar.gz ;
	tar czvf $NAME.tar.gz -X .package.ignore  ./* ;
	
	rm ./machineglobus/cookbooks/confighost/attributes/default.rb ;
	mv ./machineglobus/cookbooks/confighost/attributes/default.rb.tmp ./machineglobus/cookbooks/confighost/attributes/default.rb ;
	
	printf '\n%s\n' "Release salvado en $NAME.tar.gz"
	printf '%s\n' "";

exit 0


