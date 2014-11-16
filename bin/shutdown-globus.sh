#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

DIR_PWD="$(pwd)"
DIR_SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $DIR_SOURCE/env.sh

cd $DIR_LOCAL

tam=$(CountElementConfig "['MACHINE_SLAVES']")

if [ $# = 1 ] ; then
	echo "Apagando la maquina $1"
	vagrant halt $1
	echo "maquina $1 apagada"
else
	echo "Apagando las maquinas"
	#slaves
	for (( c=1; c<=$tam; c++ ))
	do
		name="slave$c"
		node_name=$(GetElementConfig "['MACHINE_SLAVES']['$name']['node_name']")
		vagrant halt $name_name
	done
	#master
	master_name=$(GetElementConfig "['MACHINE_MASTER']['node_name']")
	vagrant halt $master_name
	echo "maquinas apagadas"
fi

cd $DIR_PWD

