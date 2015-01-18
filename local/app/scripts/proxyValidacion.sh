#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

##inicia el proxy con los valores por defecto o de las variables de entorono del
##certificado y del proxy si hace falta.

export PATH_PROXY_INIT=$PWD_APP_SCRIPTS/run-grid-proxy-init.exp
USER_PASS=""
QUIET_MODE=1

file_exists() {
  FILE=$1
  if [ -e "$FILE" ]; then
    return 0;
  else
    return 1;
  fi
}

function quiet_mode {
    [[ $QUIET_MODE -eq 1 ]] && return 0 || return 1
}

function print_error	{
	printf '%s\n' "";
	printf '%s\n' "Error: Parámetros incorrectos.";
}

function generar_proxy {
	if file_exists "$X509_USER_PROXY" ; then
		VALUE=$(grid-proxy-info -timeleft);
		if [[ $VALUE -gt 100 ]] ; then
			if quiet_mode ; then
				printf '%s\n' "No es necesario generar el proxy de nuevo.";
			fi
			exit 0;
		else
			if quiet_mode ; then
				printf '%s\n' "Proxy ya no es valido. Generando nuevo ...";
			fi
		fi
	fi
	if quiet_mode ; then
		$PATH_PROXY_INIT -p $USER_PASS
		printf '%s\n' "Proxy generado correctamente.";
	else
		$PATH_PROXY_INIT -p $USER_PASS 2>&1 >/dev/null
	fi
}

function info_proxy {
	if file_exists "$X509_USER_PROXY" ; then
		grid-proxy-info
	else
		if quiet_mode ; then
			printf '%s\n' "Proxy no existe.";
		fi
	fi
}

function destruir_proxy {
	if file_exists "$X509_USER_PROXY" ; then
		grid-proxy-destroy
		if quiet_mode ; then
			printf '%s\n' "Proxy destruido correctamente.";
		fi
	else
		if quiet_mode ; then
			printf '%s\n' "Proxy no existe.";
		fi
	fi
	exit 0
}

function info_proxy {
	if file_exists "$X509_USER_PROXY" ; then
		grid-proxy-info
	else
		if quiet_mode ; then
			printf '%s\n' "Proxy no existe.";
		fi
	fi
	exit 0
}

while getopts 'p: d i q' option;
do
	case "$option"
		in
			p) USER_PASS="$OPTARG";;
			d) destruir_proxy;;
			i) info_proxy;;
			q) QUIET_MODE=0;;
			*) print_error; exit 2;;
	esac
done

generar_proxy

exit 0;
