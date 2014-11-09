#!/usr/bin/expect
# -*- mode: tcl -*-
# vi: set ft=tcl :

#script que envia el archivo host generado en el usuario condor
# a la maquina local para luego ser leido por el server o master

set ipmaquinalocal "<%= @ip_maquina_local %>"
set pass "<%= @pass_maquina_local %>"
set user "<%= @user_maquina_local %>"
set path "<%= @path_project_vagrant %>"
#el path de coockbook/files/default

spawn ssh $user@$ipmaquinalocal mkdir -p $path/tmp

expect {
	"*connecting (yes/no)?" {
		send "yes\r"
		exp_continue
	} #primera vez
	"*assword:" {
		send "$pass\r"
		expect "expecting."
		send_user "pass enviado\n"
	}
}

#debe de existir el tmp en donde este el path
spawn scp hosts $user@$ipmaquinalocal:$path/tmp

expect {
	"*connecting (yes/no)?" {
		send "yes\r"
		exp_continue
	} #primera vez
	"*assword:" {
		send "$pass\r"
		expect "expecting."
		send_user "pass enviado\n"
	}
}
#se agrega el host de la maquina al archivo hosts q se envia al server
spawn ssh $user@$ipmaquinalocal cat $path/tmp/hosts >> $path/hosts

expect {
	"*connecting (yes/no)?" {
		send "yes\r"
		exp_continue
	} #primera vez
	"*assword:" {
		send "$pass\r"
		expect "expecting."
		send_user "pass enviado\n"
	}

}

spawn ssh $user@$ipmaquinalocal rm -rf $path/tmp

expect {
	"*connecting (yes/no)?" {
		send "yes\r"
		exp_continue
	} #primera vez
	"*assword:" {
		send "$pass\r"
		expect "expecting."
		send_user "pass enviado\n"
	}
}
