##################################################################################################
#para la ****wn1mg**** u otros clientes
#problemas al ejecutar (SOLUCIONADO AL DESACTIVAR EL FIREWALL VER LA RECETA default.rb)
#myproxy-retrieve -s mg -k mgwn1.globustest.org -l mgwn1

#http://www.globus.org/toolkit/docs/5.2/5.2.2/gridftp/admin/#gridftp-config-security-firewalls

#como root
#resultado al ejecutar: 
#Enter MyProxy pass phrase:
#Credentials for mgwn1 have been stored in
#/etc/grid-security/hostcert.pem and
#/etc/grid-security/hostkey.pem.
############################################
#para remover las credenciales:
#como root
#myproxy-destroy -s mg -k mgwn1.globustest.org -l mgwn1
#MyProxy credential 'mgwn1.globustest.org' for user mgwn1 was successfully removed.



############################################
#Now donkey(mgwn1) is set up with host certs, 
#and it trusts the CA of my grid. 
#The last step for root is to create a grid-mapfile for myself(mgwn1) again
#VER EL ARCHIVO EXPECT run-usergrid.exp

##realizar script en expect para esto
#como root
##grid-mapfile-add-entry -dn /O=Grid/OU=GlobusTest/OU=simpleCA-mg.globustest.org/OU=local/CN=VagrantUser -ln vagrant

#resultado:
#Modifying /etc/grid-security/grid-mapfile ...
#/etc/grid-security/grid-mapfile does not exist... Attempting to create /etc/grid-security/grid-mapfile
#New entry:
#"/O=Grid/OU=GlobusTest/OU=simpleCA-mg.globustest.org/OU=local/CN=VagrantUser" vagrant
#(1) entry added


############################################# TESTING ###############################################
#levantar el servicio de gridftp
#como root
#service globus-gridftp-server start


##SE DIO ACCESO SSH DE mgwn1 A mg ## tal vez no es necesario
####TEST ftp

#como vagrant
#myproxy-logon -s mg
#pide la phrase: {globus}

#testiar como vagrant:
#globus-url-copy gsiftp://mgwn1/etc/group gsiftp://mg/tmp/from-mgwn1

##SE OBSERVA EN mg si esta el archivo

###********ENVIAR UN JOB********************

##OBTENEMOS UN rsl file
#como vagrant
#wget http://globus.org/toolkit/docs/5.2/5.2.2/admin/quickstart/a.rsl
#es necesario modificar el archivo****
#ver el archivo a.rsl
#globusrun -f a.rsl -s -r  mg:2119/jobmanager-fork
##GLOBUS RUN NO SE INSTALO EN LA SEGUNDA MAQUINA PORQUE EL TUTORIAL NO LO INDICABA
#http://www.globus.org/toolkit/docs/5.2/5.2.4/admin/quickstart/#quickstart
#este tutorial si lo indica pero es diferente a la hora de establecer los demas parametros de configuracion

##es necesario tambien quitar el firewall

##al ejecutarse el comando anterior el resultado es:

#-rw-r--r-- 1 vagrant vagrant 24136 Mar 22 19:34 /tmp/my_echo


##DONE


#################################################################
cookbook_file "/tmp/run-setupsecondmachine.exp" do
	source "run-setupsecondmachine.exp"
	owner "vagrant"
end

execute "expect run-setupsecondmachine" do
	command "expect run-setupsecondmachine.exp -u #{node[:user_name]} -pu #{node[:pass_user]} -hc #{node[:host_name]} -hs #{node[:host_server]} -n #{node[:name]}"
	user "vagrant"
	cwd "/tmp/"
	action :run
end

###################################################



# levantar el servidor GridFTP

execute "start gridftp server" do
	command "service globus-gridftp-server start"
	user "root"
	cwd "/tmp"
	action :run
end


#levantar GRAM5

execute "start GRAM5" do
	command "service globus-gatekeeper start"
	user "root"
	cwd "/tmp"
	action :run
end






