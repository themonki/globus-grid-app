#
# Cookbook Name:: prototipe
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#La carpeta debe de llamarse así
cookbook_file "/tmp/prototipe.tar.gz" do
	source "prototipe.tar.gz"
	owner "vagrant"
	mode 0644
end

execute "crear carpeta html" do
  command "mkdir -p /var/www/html"
  user "root"
  cwd "/tmp/"
  action :run  
end

execute "descomprimir carpeta html" do
  command "tar -xvzf /tmp/prototipe.tar.gz -C /var/www/html"
  user "root"
  cwd "/tmp/"
  action :run  
end

execute "chown apache" do
  command "chown -R apache.apache /var/www/html"
  user "root"
  cwd "/tmp/"
  action :run  
end

execute "permisos de scripts globus" do
  command "chmod +x /var/www/html/PrototipeGTKInterface/scripts/*"
  user "root"
  cwd "/tmp/"
  action :run  
end

