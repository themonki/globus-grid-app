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

PATH_PROFILE=$DIR_LOCAL/cookbooks/confighost/attributes
#PATH_SCRIPT=$(dirname $(readlink -f $0))
PATH_FILES=$DIR_LOCAL/cookbooks/confighost/files/default
export PATH_CONFIGHOST=$PATH_FILES
IP="172.18.0.1"
VARUSER="$(whoami)"

file_exists() {
	FILE=$1
	if [ -e $FILE ]; then
		return 0; 
	else
		return 1;
	fi
}

function print_help {
	printf '%s\n' "";
	printf '%s\n' "manage-user-profile: permite administrar el archivo";
	printf '%s\n' "$PATH_PROFILE/default.rb ";
	printf '%s\n' "y crear otros perfiles." ;
	printf '%s\n' "" ;
	printf '\t%s\n' "Uso:" ;
	printf '\t%s\n' "manage-user-profile.sh [-h] [-l] [-c [OpcionesCrear [<args>]] ] [Opciones [<args>]] " ;
	printf '%s\n' "" ;
	printf '\t\t%s\n' "-c	indica que se crea un nuevo perfil. Ver Opciones para Crear.";
	printf '\t\t%s\n' "-l	muestra la lista de perfiles.";
	printf '\t\t%s\n' "-h	imprime esta ayuda.";
	printf '%s\n' "" ;
	printf '\t%s\n' "Opciones:" ;
	printf '%s\n' "" ;
	printf '\t\t%s\n' "-d	NAME indica que se borrara un perfil.";
	printf '\t\t%s\n' "-e	NAME indica que se usara dicho perfil.";
	printf '\t\t%s\n' "-s	NAME muestra el contenido del perfil.";
	printf '%s\n' "" ;
	printf '\t%s\n' "Opciones para Crear:" ;
	printf '%s\n' "";
	printf '\t\t%s\n' "-n	NAME indica el nombre del perfil.";
	printf '\t\t%s\n' "-i	IP indica el la ip del equipo actual del perfil. Por defecto 172.18.0.1.";
	printf '\t\t%s\n' "-p	PASS indica el PASS del USER";
	printf '\t\t%s\n' "-u	USER indica el USER de la máquina actual. Por defecto el usuario actual.";
	printf '%s\n' "" ;
	printf '\t\t%s\n' "Ejemplo:" ;
	printf '\t\t\t%s\n' "manage-user-profile -c -u USER -p PASS -i IP -n NAME" ;
	printf '%s\n' "" ;
}

function print_error {
	printf '%s\n' "";
	printf '%s\n' "Error: Parámetros incorrectos.";
	print_help;
}

function print_list {
	printf '%s\n' "";
	printf '%s\n' "Los perfiles que se encuentran en $PATH_PROFILE,"; 
	printf '%s\n' "son:";
	printf '%s\n' "";
	for f in `ls $PATH_PROFILE/*.rb`; do 
		filename=$(basename "$f");
		filename="${filename%.*}";
		if [ $filename != "default" ] && [ $filename != "default-release" ] && [ $filename != "share-folder" ]; then
			echo $filename;
		fi
	done
	printf '%s\n' "";
	printf '%s\n' "Utilice:"; 
	printf '\t%s\n' "manage-user-profile -s NAME";
	printf '%s\n' "Para ver el contenido del perfil.";
	printf '%s\n' "";
	exit 0;
}

function print_show {
	cat $PATH_PROFILE/$NAME.rb;
	exit 0;
}

function delete_profile {
	if [ $NAME = "default" ] || [ $NAME = "default-release" ] || [ $NAME = "share-folder" ]; then
		printf '%s\n' "";
		printf '%s\n' "No se puede borrar el perfil \"$NAME\".";
		printf '%s\n' "";
		exit 0;
	fi
	if file_exists "$PATH_PROFILE/$NAME.rb" ; then
		rm -rf $PATH_PROFILE/$NAME.rb;
		printf '%s\n' "";
		printf '%s\n' "Se borro el perfil \"$NAME\".";
		printf '%s\n' "";
	else
		printf '%s\n' "";
		printf '%s\n' "El perfil \"$NAME\" no existe.";
		printf '%s\n' "";
	fi
	exit 0;
}

function election_profile {
	if [ $NAME = "default" ] || [ $NAME = "default-release" ] || [ $NAME = "share-folder" ]; then
			printf '%s\n' "";
			printf '%s\n' "No es posible elegir el perfil \"$NAME\" como el default.";
			printf '%s\n' "Utilice manage-user-profile.sh -l para listar los perfiles habilitados.";
			printf '%s\n' "O cree un nuevo perfil con manage-user-profile -c -u USER -p PASS -i IP -n NAME.";
			printf '%s\n' "";
			exit 0;
	else
		if file_exists "$PATH_PROFILE/$NAME.rb" ; then
			cat $PATH_PROFILE/$NAME.rb | sed 's/^#*//g' > $PATH_PROFILE/default.rb ;
			printf '%s\n' "";
			printf '%s\n' "Se elige el perfil \"$NAME\" como el perfil por defecto (default).";
			printf '%s\n' "";
			exit 0;
		else
			printf '%s\n' "";
			printf '%s\n' "El perfil \"$NAME\" no existe";
			printf '%s\n' "Utilice manage-user-profile.sh -l para listar los perfiles habilitados.";
			printf '%s\n' "O cree un nuevo perfil con manage-user-profile -c -u USER -p PASS -i IP -n NAME.";
			printf '%s\n' "";
			exit 0;
		fi
	fi
}


function create_profile {
	if [ $NAME = "default" ] || [ $NAME = "default-release" ] || [ $NAME = "share-folder" ]; then
		printf '%s\n' "";
		printf '%s\n' "No se puede crear el perfil con el nombre \"$NAME\".";
		printf '%s\n' "Este nombre esta reservado.";
		printf '%s\n' "";
		exit 0;
	fi
	if [ ! -z "$NAME" ] && [ ! -z "$PASS" ]; then
		if file_exists "$PATH_PROFILE/$NAME.rb" ; then
			printf '%s\n' "Actualizando perfil \"$NAME\" ...";
			rm -rf $PATH_PROFILE/$NAME.rb;
		else
			printf '%s\n' "Creando perfil \"$NAME\" ...";
		fi
		touch $PATH_PROFILE/$NAME.rb;
		echo "#default[:slavedata][:ip_maquina_local] = \"$IP\"" >> $PATH_PROFILE/$NAME.rb;
		echo "#default[:slavedata][:pass_maquina_local] = \"$PASS\"" >> $PATH_PROFILE/$NAME.rb;
		echo "#default[:slavedata][:user_maquina_local] = \"$VARUSER\"" >> $PATH_PROFILE/$NAME.rb;
		echo "#default[:slavedata][:path_project_vagrant] = \"$PATH_CONFIGHOST\"" >> $PATH_PROFILE/$NAME.rb;
		printf '%s\n' "";
		printf '%s\n' "--------------------------------------------------------------";
		cat $PATH_PROFILE/$NAME.rb;
		printf '%s\n' "--------------------------------------------------------------";
		printf '%s\n' "";
		if file_exists "$PATH_PROFILE/$NAME.rb" ; then
			printf '%s\n' "Se actualiza el perfil \"$NAME\" en $PATH_PROFILE/$NAME.rb";
		else
			printf '%s\n' "Se crea el perfil \"$NAME\" en $PATH_PROFILE/$NAME.rb";
		fi
		printf '%s\n' "Ejecute:";
		printf '\t%s\n' "manage-user-profile.sh -e $NAME";
		printf '%s\n' "Para elegir el perfil \"$NAME\" como el perfil por defecto (default).";
		printf '%s\n' "";
		exit 0;
	fi
	print_error;
	exit 2;
}


while getopts 'n: i: p: u: d: e: s: hlc' option;
do
	case "$option"
		in
			c) CREATE=true;;
			n ) NAME="$OPTARG";;
			i ) IP="$OPTARG";;
			p ) PASS="$OPTARG";;
			u ) VARUSER="$OPTARG";;
			e ) NAME="$OPTARG";election_profile;;
			s ) NAME="$OPTARG";print_show;;
			l) print_list;;
			d ) NAME="$OPTARG";delete_profile;;
			h) print_help; exit 0;;
			*) print_error; exit 2;;
	esac
done

if [ $CREATE ]; then
	create_profile;
fi

print_help;
exit 0;
