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

CONFIG_FILE=$DIR_ETC/config.json
export CONFIG_FILE

ENV_FILE=$DIR_ETC/env.rb
export ENV_FILE

#Obtiene un elemento del JSON
GetElementConfig() {
    element=$1
    param="j = JSON.parse(File.read(\"$CONFIG_FILE\")); puts j$element"
	exe=$(ruby -rjson -e "$param")
	echo $exe
}
#Cuenta cuantos elementos tiene el JSON
CountElementConfig() {
    element=$1
    param="j = JSON.parse(File.read(\"$CONFIG_FILE\"));  puts j$element.count"
	exe=$(ruby -rjson -e "$param")
	echo $exe
}


#var="['MACHINE_SLAVES']['slave1']['node_name']"

#GetElementConfig "['MACHINE_SLAVES']['slave1']['node_name']" 

#CountElementConfig "['MACHINE_SLAVES']['slave1']"
