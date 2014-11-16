#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

DIR_PWD="$(pwd)"
DIR_SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $DIR_SOURCE/env.sh

cd $DIR_LOCAL

tam=$(CountElementConfig "['MACHINE_SLAVES']")

if [ $# = 1 ] ; then	
	echo "Iniciando la maquina $1"
	vagrant reload --no-provision $1
	echo "maquina $1 iniciada"
else
	echo "Iniciando las maquinas"
	#slaves
	for (( c=1; c<=$tam; c++ ))
	do
		name="slave$c"
		node_name=$(GetElementConfig "['MACHINE_SLAVES']['$name']['node_name']")
		vagrant reload --no-provision $name_name
	done
	#master
	master_name=$(GetElementConfig "['MACHINE_MASTER']['node_name']")
	vagrant reload --no-provision $master_name
	echo "maquinas iniciadas"
fi

cd $DIR_PWD

