#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

##Script que comprueba la sintaxys del rsl y que se pueda ejecutar

USER_PASS=""
RSL_FILE=""
SUCESS_MSG=""
PORT="2119"
GLOBUS_HOST="172.18.0.21"
JOB_MANAGER="jobmanager"
export PATH_PROXY_VALIDACION=$PWD_PROTOTIPEGTK_SCRIPTS/proxyValidacion.sh

file_exists() {
  FILE=$1  
  if [ -e $FILE ]; then
    return 0; 
  else
    return 1;
  fi
}

function print_error	{
	printf '%s\n' "";
	printf '%s\n' "Error: Parámetros incorrectos.";
}

#solo comprueba sintaxys
#obsoleto
function parse_job {
	if file_exists "$RSL_FILE" ; then
		$PATH_PROXY_VALIDACION -q -p $USER_PASS
		VALUE=$(globusrun -p -f $RSL_FILE);
		if [[ $VALUE -eq $SUCESS_MSG ]] ; then 
			printf '%s\n' "true";
		else
			printf '%s\n' "false";
		fi
	fi
}

#comprueba que se pueda ejecutar
function dry_run {
	if file_exists "$RSL_FILE" ; then
		$PATH_PROXY_VALIDACION -q -p $USER_PASS
		VALUE=$(globusrun -q -d -r $GLOBUS_HOST:$PORT/$JOB_MANAGER -f $RSL_FILE 2>&1 );
		local status=$?
		if [[ $status -ne 0 ]] ; then
			#printf '%s\n' "false"
			printf '%s\n' "$VALUE"
		#else
			#printf '%s\n' "true"
		fi
	fi
}

while getopts 'p: f: j:' option;
do
	case "$option"
		in
			p) USER_PASS="$OPTARG";;
			f) RSL_FILE="$OPTARG";;
			j) JOB_MANAGER="$OPTARG";;
			*) print_error; exit 2;;
	esac
done

dry_run
