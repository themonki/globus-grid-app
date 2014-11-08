#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

echo "Destruir las maquinas"

cd machineglobus

vagrant destroy -f mg2

vagrant destroy -f mgwn2

rm -rf ~/VirtualBox\ VMs/globus-master2/
rm -rf ~/VirtualBox\ VMs/globus-client2/

./clean.sh

echo "maquinas Destruidas"

cd ..
