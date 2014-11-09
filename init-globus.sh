#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

#Si se emplea el share folder no se necesesita confirgurar
SHARE_FOLDER_ACTIVE="$(grep -lir 'USE_SHARE_FOLDER = true' machineglobus/Vagrantfile)"

if [ -z "$SHARE_FOLDER_ACTIVE" ]; then
  FILE=./machineglobus/cookbooks/confighost/attributes/default.rb
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
#echo $pathSSH

rm -rf log.txt
touch log.txt

cd machineglobus

vagrant up mgwn1 --color >> ../log.txt

vagrant up mg --color >> ../log.txt

./clean.sh

echo "maquinas levantadas"

cd ..

##Se actualiza el prototipo
prototipePath=./Prototipe
if [ -e $prototipePath ]; then
	
	echo "Preparando el prototipo"
	
	cd Prototipe
	
	./update-prototipe.sh >> ../log.txt
	
	cd ..

	echo "Prototipo actualizado"
	
fi

cd globus

expect configssh.exp -u vagrant -p vagrant -h 172.18.0.21 -l ${pathSSH} >> ../log.txt
expect configssh.exp -u vagrant -p vagrant -h 172.18.0.22 -l ${pathSSH} >> ../log.txt

echo "garantizado acceso ssh a las maquinas virtuales"

knife solo cook vagrant@172.18.0.21 >> ../log.txt
knife solo cook vagrant@172.18.0.22 >> ../log.txt

echo "setup simpleca, hostcert y usercert for vagrant"

knife solo cook vagrant@172.18.0.21 nodes/initsimpleca.json >> ../log.txt
knife solo cook vagrant@172.18.0.22 nodes/initsimplecasecondmachine.json >> ../log.txt
knife solo cook vagrant@172.18.0.21 nodes/signsimpleca.json >> ../log.txt
knife solo cook vagrant@172.18.0.22 nodes/configcertnodes.json >> ../log.txt

echo "globus instalado"

echo "Preparando configuracion de aplicacion"

knife solo cook vagrant@172.18.0.21 nodes/configSSL.json >> ../log.txt
knife solo cook vagrant@172.18.0.21 nodes/database.json >> ../log.txt

knife solo cook vagrant@172.18.0.21 nodes/prototipe.json >> ../log.txt

echo "Aplicación generada"

cd ..

./getCredencial.sh >> log.txt

./restart-globus.sh >>  log.txt

echo "Importe al navegador el archivo usercred.p12 (no tiene contraseña)."
echo "Ingrese al Grid: https://172.18.0.21/PrototipeGTKInterface/"
echo "email: vagrant@gmail.com"
echo "Contraseña: Vagrant123"
echo ""

