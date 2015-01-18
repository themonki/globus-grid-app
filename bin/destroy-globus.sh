#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

DIR_PWD2="$(pwd)"
DIR_SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "$DIR_SOURCE"/env.sh
cd "$DIR_PWD2"

echo "Destruir las maquinas"

cd "$DIR_LOCAL"

tam=$(CountElementConfig "['MACHINE_SLAVES']")

#slaves
for (( c=1; c <= tam; c++ ))
do
	name="slave$c"
	node_name=$(GetElementConfig "['MACHINE_SLAVES']['$name']['node_name']")
	vagrant destroy -f "$node_name"
done

#master
master_name=$(GetElementConfig "['MACHINE_MASTER']['node_name']")
vagrant destroy -f "$master_name"


DEFAULT_VM="$HOME/VirtualBox VMs"
VM_FIND="$HOME/.VirtualBox/VirtualBox.xml"

if [ -e "$VM_FIND" ]; then
	VM_FOLDER=$(grep defaultMachineFolder < "$VM_FIND" | cut -d' ' -f6 | cut -d'"' -f2)
fi

if [ -z "$VM_FOLDER" ]; then
	VM_FOLDER="$DEFAULT_VM"
fi

if [ -e "$VM_FOLDER" ];then
	echo "La carpeta VM es: $VM_FOLDER"
	#slaves
	for (( c=1; c <= tam; c++ ))
	do
		name="slave$c"
		node_vm_name=$(GetElementConfig "['MACHINE_SLAVES']['$name']['vm_name']")
		if [ -e "$VM_FOLDER/$node_vm_name/" ]; then
			echo "Borrando: $VM_FOLDER/$node_vm_name/"
			rm -rf "$VM_FOLDER/$node_vm_name/"
		fi
	done

	#master
	master_vm_name=$(GetElementConfig "['MACHINE_MASTER']['vm_name']")

	if [ -e "$VM_FOLDER/$master_vm_name/" ]; then
		echo "Borrando: $VM_FOLDER/$master_vm_name/"
		rm -rf "$VM_FOLDER/$master_vm_name/"
	fi
else
	echo "No se encontro la carpeta de las VM"
fi

cd "$DIR_PWD"

"$DIR_BIN"/clean.sh

echo "maquinas Destruidas"

cd ..
