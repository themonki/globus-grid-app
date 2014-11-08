#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

rm -rf usercred.p12
scp vagrant@172.18.0.21:~/.globus/usercred.p12 . >> log2.txt

echo "certificado usercred.p12 de vagrant obtenido, importar al navegador para acceder"

