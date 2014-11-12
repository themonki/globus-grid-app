#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

DIR_PWD="$(pwd)"
DIR_SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $DIR_SOURCE/env.sh

#Si se emplea el share folder no se necesesita confirgurar
#SHARE_FOLDER_ACTIVE="$(grep -lir 'USE_SHARE_FOLDER.*=.*true' $DIR_LOCAL/Vagrantfile)"
SHARE_FOLDER_ACTIVE=$(GetElementConfig "['USE_SHARE_FOLDER']")

if [ $SHARE_FOLDER_ACTIVE != "true" ]; then
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

echo ""
echo "Generando configuración a partir de $CONFIG_FILE"
$DIR_BIN/configure.sh
echo ""

pathSSH=$HOME/.ssh/id_rsa

LOG_FILE=$DIR_PWD/log.txt

rm -rf $LOG_FILE
touch $LOG_FILE

cd $DIR_LOCAL

tam=$(CountElementConfig "['MACHINE_SLAVES']")

echo "Iniciando maquinas virtuales con Vagrant"

#slaves
for (( c=1; c<=$tam; c++ ))
do
	name="slave$c"
	node_name=$(GetElementConfig "['MACHINE_SLAVES']['$name']['node_name']")
	vagrant up $name_name --color >> $LOG_FILE
done

#master
master_name=$(GetElementConfig "['MACHINE_MASTER']['node_name']")
vagrant up $master_name --color >> $LOG_FILE

cd $DIR_PWD

echo "Maquinas levantadas"

##Se actualiza la app
appPath=$DIR_LOCAL/app
if [ -e $appPath ]; then
	
	echo "Preparando la app"
	
	$DIR_BIN/update-app.sh >> $LOG_FILE

	echo "App actualizada"
	
fi

cd $DIR_LOCAL

#master
musr=$(GetElementConfig "['MACHINE_MASTER']['user_name']")
musr_pass=$(GetElementConfig "['MACHINE_MASTER']['pass_user']")
mip=$(GetElementConfig "['MACHINE_MASTER']['ip']")
expect $DIR_BIN/configssh.exp -u $musr -p $musr_pass -h $mip -l ${pathSSH} >> $LOG_FILE

#slaves
for (( c=1; c<=$tam; c++ ))
do
	name="slave$c"
	susr=$(GetElementConfig "['MACHINE_SLAVES']['$name']['user_name']")
	susr_pass=$(GetElementConfig "['MACHINE_SLAVES']['$name']['pass_user']")
	sip=$(GetElementConfig "['MACHINE_SLAVES']['$name']['ip']")
	expect $DIR_BIN/configssh.exp -u $susr -p $susr_pass -h $sip -l ${pathSSH} >> $LOG_FILE
done

echo "Garantizado acceso ssh a las maquinas virtuales"
#############################################################################################
#slaves
for (( c=1; c<=$tam; c++ ))
do
	name="slave$c"
	susr=$(GetElementConfig "['MACHINE_SLAVES']['$name']['user_name']")
	sip=$(GetElementConfig "['MACHINE_SLAVES']['$name']['ip']")
	name_file=$name".json"
	knife solo cook $susr@$sip nodes/$name_file --no-chef-check --no-berkshelf >> $LOG_FILE
done

#master
knife solo cook $musr@$mip nodes/master.json --no-chef-check --no-berkshelf >> $LOG_FILE

echo "Configurando SimpleCA, hostcert y usercert para $musr"

#master
scp nodes/master_initsimpleca.json $musr@$mip:/home/$musr/chef-solo/dna.json
knife solo cook $musr@$mip nodes/master_initsimpleca.json --no-chef-check --no-berkshelf --no-sync >> $LOG_FILE
#slaves
for (( c=1; c<=$tam; c++ )) 
do
	name="slave$c"
	susr=$(GetElementConfig "['MACHINE_SLAVES']['$name']['user_name']")
	sip=$(GetElementConfig "['MACHINE_SLAVES']['$name']['ip']")
	name_file=$name"_initsimplecasecondmachine.json"
	scp nodes/$name_file $susr@$sip:/home/$susr/chef-solo/dna.json
	knife solo cook $susr@$sip nodes/$name_file --no-chef-check --no-berkshelf --no-sync >> $LOG_FILE
done
#master
scp nodes/master_signsimpleca.json $musr@$mip:/home/$musr/chef-solo/dna.json
knife solo cook $musr@$mip nodes/master_signsimpleca.json --no-chef-check --no-berkshelf --no-sync >> $LOG_FILE
#slaves
for (( c=1; c<=$tam; c++ )) 
do
	name="slave$c"
	susr=$(GetElementConfig "['MACHINE_SLAVES']['$name']['user_name']")
	sip=$(GetElementConfig "['MACHINE_SLAVES']['$name']['ip']")
	name_file=$name"_configcertnodes.json"
	scp nodes/$name_file $susr@$sip:/home/$susr/chef-solo/dna.json
	knife solo cook $susr@$sip nodes/$name_file --no-chef-check --no-berkshelf --no-sync >> $LOG_FILE
done

echo "Globus instalado y configurado"

echo "Preparando configuracion de aplicacion"
scp nodes/master_app.json $musr@$mip:/home/$musr/chef-solo/dna.json
knife solo cook $musr@$mip nodes/master_app.json --no-chef-check --no-berkshelf --no-sync >> $LOG_FILE

echo "Aplicación generada"

cd $DIR_PWD

$DIR_BIN/getCredencial.sh >> $LOG_FILE

$DIR_BIN/restart-globus.sh >> $LOG_FILE

$DIR_BIN/clean.sh >> $LOG_FILE

echo "Importe al navegador el archivo usercred.p12 (no tiene contraseña)."
echo "Ingrese al Grid: https://$mip/app/"
echo "email: vagrant@gmail.com"
echo "Contraseña: Vagrant123"
echo ""

