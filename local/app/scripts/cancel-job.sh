#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :
##Script que cancela un job dado su contact

USER_PASS=""
STRING_CONTACT=""
export PATH_PROXY_VALIDACION=$PWD_APP_SCRIPTS/proxyValidacion.sh

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


function cancel_job {	
	if [[ $STRING_CONTACT != "" ]] ; then
		$PATH_PROXY_VALIDACION -q -p $USER_PASS
		VALUE=$(globusrun -k $STRING_CONTACT);
		printf '%s\n' "$VALUE";
	fi
}

while getopts 'p: s:' option;
do
	case "$option"
		in
			p) USER_PASS="$OPTARG";;
			s) STRING_CONTACT="$OPTARG";;
			*) print_error; exit 2;;
	esac
done

cancel_job
