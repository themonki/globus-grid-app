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

#Si se emplea el share folder no se necesesita confirgurar
SHARE_FOLDER_ACTIVE="$(grep -lir 'USE_SHARE_FOLDER.*=.*true' $DIR_LOCAL/Vagrantfile)"

if [ -z "$SHARE_FOLDER_ACTIVE" ]; then
  FILE=$DIR_LOCAL/cookbooks/confighost/attributes/default.rb
  profile=false;
  if [ -e $FILE ]; then
    while read line
    do
      if [[ "$line" == *"$HOME"* ]]
        then
          profile=true;       
      fi
    done < $FILE
    if [ $profile == false ]; then
      echo "El perfil por defecto no corresponde al usuario actual, actualice con manage-user-profile.sh";
      exit;
    fi
  else
    echo "Debe generar primero el perfil por defecto del usuario con manage-user-profile.sh";
    exit;
  fi
fi

pathSSH=$HOME/.ssh/id_rsa

LOG_FILE=$DIR_PWD/log.txt

rm -rf $LOG_FILE
touch $LOG_FILE

cd $DIR_LOCAL

vagrant up mgwn1 --color >> $LOG_FILE

vagrant up mg --color >> $LOG_FILE

cd $DIR_PWD

$DIR_BIN/clean.sh

echo "maquinas levantadas"

##Se actualiza la app
appPath=$DIR_LOCAL/app
if [ -e $appPath ]; then
	
	echo "Preparando la app"
	
	$DIR_BIN/update-app.sh >> $LOG_FILE

	echo "App actualizada"
	
fi

cd $DIR_LOCAL

expect $DIR_BIN/configssh.exp -u vagrant -p vagrant -h 172.18.0.21 -l ${pathSSH} >> $LOG_FILE
expect $DIR_BIN/configssh.exp -u vagrant -p vagrant -h 172.18.0.22 -l ${pathSSH} >> $LOG_FILE

echo "garantizado acceso ssh a las maquinas virtuales"

knife solo cook vagrant@172.18.0.21 >> $LOG_FILE
knife solo cook vagrant@172.18.0.22 >> $LOG_FILE

echo "setup simpleca, hostcert y usercert for vagrant"

knife solo cook vagrant@172.18.0.21 nodes/initsimpleca.json >> $LOG_FILE
knife solo cook vagrant@172.18.0.22 nodes/initsimplecasecondmachine.json >> $LOG_FILE
knife solo cook vagrant@172.18.0.21 nodes/signsimpleca.json >> $LOG_FILE
knife solo cook vagrant@172.18.0.22 nodes/configcertnodes.json >> $LOG_FILE

echo "globus instalado"

echo "Preparando configuracion de aplicacion"

knife solo cook vagrant@172.18.0.21 nodes/configSSL.json >> $LOG_FILE
knife solo cook vagrant@172.18.0.21 nodes/database.json >> $LOG_FILE

knife solo cook vagrant@172.18.0.21 nodes/app.json >> $LOG_FILE

echo "Aplicación generada"

cd $DIR_PWD

$DIR_BIN/getCredencial.sh >> $LOG_FILE

$DIR_BIN/restart-globus.sh >>  $LOG_FILE

echo "Importe al navegador el archivo usercred.p12 (no tiene contraseña)."
echo "Ingrese al Grid: https://172.18.0.21/app/"
echo "email: vagrant@gmail.com"
echo "Contraseña: Vagrant123"
echo ""

