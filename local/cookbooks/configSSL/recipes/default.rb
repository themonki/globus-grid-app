#
# Cookbook Name:: configSSL
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
# 
# Receta para la configuración de los certificados con el apache.


cookbook_file "/tmp/httpd.conf" do
	source "httpd.conf"
	owner "root"
	mode 0644
end

cookbook_file "/tmp/ssl.conf" do
	source "ssl.conf"
	owner "root"
	mode 0644
end

cookbook_file "/tmp/generatep12.exp" do
	source "generatep12.exp"
	owner "root"
end

execute "back up httpd conf" do
	command "mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.old"
	user "root"
	cwd "/tmp"
	action :run
end

execute "back up ssl conf" do
	command "mv /etc/httpd/conf.d/ssl.conf /etc/httpd/conf.d/ssl.conf.old"
	user "root"
	cwd "/tmp"
	action :run
end

execute "mv httpd conf" do
	command "mv /tmp/httpd.conf /etc/httpd/conf/httpd.conf"
	user "root"
	cwd "/tmp"
	action :run
end

execute "mv ssl conf" do
	command "mv /tmp/ssl.conf /etc/httpd/conf.d/ssl.conf"
	user "root"
	cwd "/tmp"
	action :run
end

execute "restart httpd" do
	command "service httpd restart"
	user "root"
	cwd "/tmp"
	action :run
end

###########################################################################
## se genera el archivo p12 para importarlo al navegador
##openssl pkcs12 -export -in /home/vagrant/.globus/usercert.pem -inkey /home/vagrant/.globus/userkey.pem -certfile /home/globus/.globus/simpleCA/cacert.pem -out webcert.p12

execute "run generatep12" do
	command "expect generatep12.exp -i /home/vagrant/.globus/usercert.pem -k /home/vagrant/.globus/userkey.pem -o /home/vagrant/.globus/usercred.p12 -pu vagrant"
	user "root"
	cwd "/tmp"
	action :run
end

execute "chown vagrant" do
	command "chown vagrant.vagrant /home/vagrant/.globus/usercred.p12"
	user "root"
	cwd "/tmp"
	action :run
end

execute "cp usercred" do
	command "cp /home/vagrant/.globus/usercred.p12 /home/vagrant/usercred.p12"
	user "root"
	cwd "/home/vagrant"
	action :run
end

execute "chmod vagrant" do
	command "chmod 400 /home/vagrant/.globus/usercred.p12"
	user "root"
	cwd "/tmp"
	action :run
end

