#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

DIR_PWD2="$(pwd)"
DIR_SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "$DIR_SOURCE"/env.sh
cd "$DIR_PWD2"

"$DIR_BIN"/shutdown-globus.sh "$1"

"$DIR_BIN"/up-globus.sh "$1"

echo "reinicio completado"
