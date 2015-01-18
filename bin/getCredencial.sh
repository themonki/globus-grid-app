#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

DIR_PWD2="$(pwd)"
DIR_SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "$DIR_SOURCE"/env.sh
cd "$DIR_PWD2"

rm -rf usercred.p12

#master
musr=$(GetElementConfig "['MACHINE_MASTER']['user_name']")
mip=$(GetElementConfig "['MACHINE_MASTER']['ip']")
scp "$musr@$mip:~/.globus/usercred.p12" .

echo "certificado usercred.p12 de vagrant obtenido, importar al navegador para acceder"
