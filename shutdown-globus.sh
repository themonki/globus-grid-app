#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

cd machineglobus

if [ $# = 1 ] ; then
  if [ $1 = "mg2" ] || [ $1 = "mgwn2" ]; then
    
    echo "Apagando la maquina $1"

    vagrant halt $1

    echo "maquinas $1 apagada"
    
  fi
else
  echo "Apagando las maquinas"

  vagrant halt mg2

  vagrant halt mgwn2

  echo "maquinas apagadas"

fi

cd ..

