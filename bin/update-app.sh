#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

DIR_PWD2="$(pwd)"
DIR_SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "$DIR_SOURCE"/env.sh
cd "$DIR_PWD2"

SAVE_FILE=/tmp
NAME="app"

"$DIR_BIN"/package-app.sh -n "$NAME" -l "$SAVE_FILE"

DIR_APP="$DIR_LOCAL/cookbooks/app/files/default"

if [ -e "$DIR_APP" ];then

	rm -rf "$DIR_APP/app.tar.gz"
	echo "Borrada"

else
	mkdir -p "$DIR_APP"
fi

mv "$SAVE_FILE/$NAME.tar.gz" "$DIR_APP/"

echo "Aplicación actualizada"
