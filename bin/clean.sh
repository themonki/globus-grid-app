#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

DIR_PWD="$(pwd)"
DIR_SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $DIR_SOURCE/env.sh

path=$DIR_LOCAL/cookbooks/confighost/files/default

rm -rf ${path}/hosts
rm -rf ${path}/tmp

touch ${path}/hosts

echo "clean"
