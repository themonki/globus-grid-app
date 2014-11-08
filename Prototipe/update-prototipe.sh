#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

./package-prototipe.sh

mkdir -p ../globus/cookbooks/prototipe/files/default

rm -rf ../globus/cookbooks/prototipe/files/default/prototipe.tar.gz

mv prototipe.tar.gz ../globus/cookbooks/prototipe/files/default/

echo "Prototipo actualizado"
