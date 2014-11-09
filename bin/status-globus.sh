#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

DIR_PWD="$(pwd)"
DIR_SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR_PWD
DIR_BIN=$DIR_SOURCE
DIR_LOCAL=$DIR_SOURCE/../local
cd $DIR_LOCAL
DIR_LOCAL="$(pwd)"
DIR_ETC=$DIR_SOURCE/../etc
cd $DIR_ETC
DIR_ETC="$(pwd)"
cd $DIR_PWD

cd $DIR_LOCAL

vagrant status

cd $DIR_PWD


