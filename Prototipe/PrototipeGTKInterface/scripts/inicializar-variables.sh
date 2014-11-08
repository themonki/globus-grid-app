#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

#function variable_clear {
#	USER_CERT=""
#	USER_KEY=""
#	USER_PROXY=""
#	unset X509_USER_CERT
#	unset X509_USER_KEY
#	unset X509_USER_PROXY
#}

#function variable_cert {
#	export X509_USER_CERT=$USER_CERT
#	echo export X509_USER_CERT
#	echo $X509_USER_CERT
#}

#function variable_key {
#	export X509_USER_KEY=$USER_KEY
#	echo export X509_USER_KEY
#	echo $X509_USER_KEY
#}

#function variable_proxy {
#	export X509_USER_PROXY=$USER_PROXY
#	echo export X509_USER_PROXY
#	echo $X509_USER_PROXY
#}

#while getopts 'c: k: o:' option;
#do
#	case "$option"
#		in
#			c) USER_CERT="$OPTARG";variable_cert;;
#			k) USER_KEY="$OPTARG";variable_key;;
#			o) USER_PROXY="$OPTARG";variable_proxy;;
#	esac
#done


################################################################################
##Para llamar este archivo se utiliza el comando source o .
##De esta manera se inicializan las variables desde afuera
##Se debe de utilizar las opciones c para certificado k para la llave y o para 
##indicar el proxy
##Solo se usa una vez durante la sesion


export PWD_PROTOTIPEGTK_SCRIPTS=/var/www/html/PrototipeGTKInterface/scripts

while getopts 'c: k: o:' option;
do
	case "$option"
		in
			c) export X509_USER_CERT="$OPTARG";;
			k) export X509_USER_KEY="$OPTARG";;
			o) export X509_USER_PROXY="$OPTARG";
	esac
done
