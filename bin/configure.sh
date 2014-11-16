#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

DIR_PWD="$(pwd)"
DIR_SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $DIR_SOURCE/env.sh

CONF_RB=$DIR_BIN/configure.rb

PATH_NODES=$DIR_LOCAL/nodes

rm -rf $PATH_NODES/master*.json $PATH_NODES/slave*.json

mkdir -p $PATH_NODES

comand=$(ruby -r $CONF_RB -e "slavei_json '$PATH_NODES'")

$comand

comand=$(ruby -r $CONF_RB -e "master_json '$PATH_NODES'")

$comand

comand=$(ruby -r $CONF_RB -e "master_initsimpleca_json '$PATH_NODES'")

$comand

comand=$(ruby -r $CONF_RB -e "slavei_initsimplecasecondmachine_json '$PATH_NODES'")

$comand

comand=$(ruby -r $CONF_RB -e "master_signsimpleca_json '$PATH_NODES'")

$comand

comand=$(ruby -r $CONF_RB -e "slavei_configcertnodes_json '$PATH_NODES'")

$comand

comand=$(ruby -r $CONF_RB -e "master_app_json '$PATH_NODES'")

$comand

echo "Archivos nodes generados y reconfigurados, deben ejecutarse en el orden:"

ls -tr $PATH_NODES/master*.json $PATH_NODES/slave*.json
