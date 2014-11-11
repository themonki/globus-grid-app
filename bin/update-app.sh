#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

DIR_PWD="$(pwd)"
DIR_SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $DIR_SOURCE/env.sh

SAVE_FILE=/tmp
NAME="app"

$DIR_BIN/package-app.sh -n $NAME -l $SAVE_FILE

mkdir -p $DIR_LOCAL/cookbooks/app/files/default

rm -rf $DIR_LOCAL/cookbooks/app/files/default/app.tar.gz

mv $SAVE_FILE/$NAME.tar.gz $DIR_LOCAL/cookbooks/app/files/default/

echo "Aplicación actualizada"
