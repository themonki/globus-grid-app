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

echo "Destruir las maquinas"

cd $DIR_LOCAL

vagrant destroy -f mg

vagrant destroy -f mgwn1

DEFAULT_VM=$HOME/VirtualBox\ VMs

VM_FOLDER=$(cat /home/monki/.VirtualBox/VirtualBox.xml | grep defaultMachineFolder | cut -d' ' -f6 | cut -d'"' -f2)

if [ -z "$VM_FOLDER" ]; then
	VM_FOLDER=$DEFAULT_VM
fi

rm -rf $VM_FOLDER/globus-master/
rm -rf $VM_FOLDER/globus-client1/

cd $DIR_PWD

$DIR_BIN/clean.sh

echo "maquinas Destruidas"

cd ..
