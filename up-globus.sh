#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

cd machineglobus

if [ $# = 1 ] ; then
  if [ $1 = "mg2" ] || [ $1 = "mgwn2" ]; then
    
    echo "Iniciando la maquina $1"

    vagrant reload --no-provision $1

    echo "maquinas $1 iniciada"
    
  fi
else
  echo "Iniciando las maquinas"

  vagrant reload --no-provision mg2

  vagrant reload --no-provision mgwn2

  echo "maquinas iniciadas"

fi

cd ..

