#
# Cookbook Name:: simpleca
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#agregando archivos necesarios
cookbook_file "/tmp/run-grid-ca-create.exp" do
	source "run-grid-ca-create.exp"
	owner "globus"
end

cookbook_file "/tmp/run-grid-ca-sign.exp" do
	source "run-grid-ca-sign.exp"
	owner "globus"
end

cookbook_file "/tmp/run-user-request.exp" do
	source "run-user-request.exp"
	owner "vagrant"
end

cookbook_file "/tmp/run-grid-proxy-init.exp" do
	source "run-grid-proxy-init.exp"
	owner "vagrant"
end

cookbook_file "/tmp/configserver.conf" do
	source "configuser.conf"
	owner "globus"
end


cookbook_file "/tmp/configuser.conf" do
	source "configuser.conf"
	owner "globus"
end
#################################################################################
##install simpleca
#permisos a globus sobre /etc/grid-security
execute "chown globus" do
	command "chown -R globus /etc/grid-security"
	user "root"
	cwd "/tmp"
	action :run
end

#instalar simplesa

execute "install simplesa on globus" do
	command "sudo -H -E -u globus expect run-grid-ca-create.exp"
	user "vagrant"
	cwd "/tmp"
	action :run
end

#PUEDE VARIAR
#indicamos los certificados que seran usados para firmar
execute "certificados por defecto" do
	command "grid-default-ca -ca b83525ab"
	user "root"
	cwd "/tmp"
	action :run
end



#################################################################################
##hostcert

#hostcert
execute "request host" do
	command "sudo grid-cert-request -host '#{node[:host_name]}' -force -cn '#{node[:host_name]}'"
	user "vagrant"
	cwd "/tmp"
	action :run
end

#enviar a globus el hostcert_request.pem
execute "enviar requesthost" do
	command "cp /etc/grid-security/hostcert_request.pem /tmp"
	user "vagrant"
	cwd "/tmp"
	action :run
end

#firmar request host
execute "firmar request host" do
	command "sudo -H -E -u globus expect run-grid-ca-sign.exp -p globus -in hostcert_request.pem -out hostsigned.pem -f /tmp/configserver.conf"
	user "vagrant"
	cwd "/tmp"
	action :run
end

#enviar el firmado
execute "eliminar certificado host" do
	command "rm -rf /etc/grid-security/hostcert.pem"
	user "root"
	cwd "/tmp"
	action :run
end

#enviar el firmado
execute "copiar certificado host firmado" do
	command "cp /tmp/hostsigned.pem /etc/grid-security/hostcert.pem"
	user "root"
	cwd "/tmp"
	action :run
end


#################################################################################
##usercert

#request user
#debe de existir dicho usuario #{node[:user_name]} por defecto vagrant
execute "request user" do
	command "sudo -H -E -u #{node[:user_name]} expect run-user-request.exp -p #{node[:pass_user]} -n #{node[:name]}"
	user "vagrant"
	cwd "/tmp"
	action :run
end

#enviar a globus user request
execute "cp request tmp" do
	command "cp /home/vagrant/.globus/usercert_request.pem /tmp"
	user "vagrant"
	cwd "/tmp"
	action :run
end

execute "chown globus" do
	command "sudo chown globus.globus /tmp/usercert_request.pem"
	user "vagrant"
	cwd "/tmp"
	action :run
end

#firmar request user
execute "firmar request host" do
	command "sudo -H -E -u globus expect run-grid-ca-sign.exp  -p globus -in usercert_request.pem -out usersigned.pem -f /tmp/configuser.conf"
	user "vagrant"
	cwd "/tmp"
	action :run
end

#enviar a vagrant user signed
execute "chown vagrant" do
	command "sudo chown vagrant.vagrant /tmp/usersigned.pem"
	user "vagrant"
	cwd "/tmp"
	action :run
end

execute "rm usercert" do
	command "rm /home/vagrant/.globus/usercert.pem"
	user "vagrant"
	cwd "/tmp"
	action :run
end

execute "cp tmp signed" do
	command "cp /tmp/usersigned.pem /home/vagrant/.globus/usercert.pem"
	user "vagrant"
	cwd "/tmp"
	action :run
end

#agregar al gridmapfile
#grid-mapfile-add-entry -dn /O=Grid/OU=GlobusTest/OU=simpleCA-mg2.globustest.org/OU=local/CN=VagrantUser -ln vagrant
execute "gridmapfile vagrant" do
	command "grid-mapfile-add-entry -dn /O=Grid/OU=GlobusTest/OU=simpleCA-#{node[:host_name]}/OU=local/CN=#{node[:name]} -ln #{node[:user_name]}"
	user "root"
	cwd "/tmp"
	action :run
end



#################################################################################
##empaquetar certs

execute "package certs" do
	command "grid-ca-package -r -cadir /home/globus/.globus/simpleCA/"
	user "globus"
	cwd "/home/globus"
	action :run
end

execute "cp rpm certs" do
	command "cp globus-simple-ca-*-1.0-1.el6.noarch.rpm /tmp"
	user "globus"
	cwd "/home/globus"
	action :run
end

execute "chown vagrant" do
	command "sudo chown vagrant.vagrant /tmp/globus-simple-ca-*-1.0-1.el6.noarch.rpm"
	user "vagrant"
	cwd "/tmp"
	action :run
end

#enviar el rpm a todos los esclavos
node[:slaves].each do |slave|
	execute "scp rpm certs #{slave}" do
		command "scp globus-simple-ca-*-1.0-1.el6.noarch.rpm vagrant@#{slave}:/tmp"
		user "vagrant"
		cwd "/tmp"
		action :run
	end
end

#enviar el los certs user de #{node[:user_name]} a vagrant de las otra maquinas
node[:slaves].each do |slave|
	execute "scp pem certs #{slave}" do
		command "scp /home/vagrant/.globus/userkey.pem /home/#{node[:user_name]}/.globus/usercert.pem vagrant@#{slave}:/home/vagrant/"
		user "vagrant"
		cwd "/tmp"
		action :run
	end
end








