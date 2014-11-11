#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

DIR_PWD="$(pwd)"
DIR_SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $DIR_SOURCE/env.sh

cd $DIR_LOCAL

if [ $# = 1 ] ; then
  if [ $1 = "mg" ] || [ $1 = "mgwn1" ]; then
    
    echo "Apagando la maquina $1"

    vagrant halt $1

    echo "maquinas $1 apagada"
    
  fi
else
  echo "Apagando las maquinas"

  vagrant halt mg

  vagrant halt mgwn1

  echo "maquinas apagadas"

fi

cd $DIR_PWD

