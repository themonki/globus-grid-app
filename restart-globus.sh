#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

./shutdown-globus.sh $1


./up-globus.sh $1

echo "reinicio completado"
