#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

##Script que ejecuta un job

USER_PASS=""
RSL_FILE=""
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

function run_job {
	if file_exists "$RSL_FILE" ; then
		$PATH_PROXY_VALIDACION -q -p $USER_PASS
		VALUE=$(globusrun -q -b -r $GLOBUS_HOST:$PORT/$JOB_MANAGER -f $RSL_FILE);
		printf '%s\n' "$VALUE";
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

run_job

