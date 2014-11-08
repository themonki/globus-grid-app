#
# Cookbook Name:: globuspackages
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# http://www.globus.org/toolkit/docs/5.2/5.2.2/admin/install/#id2530418
#
#execute "gridftp" do
#  command "yum -y -q install globus-gridftp"
#  user "root"
#  action :run  
#end
#execute "gram5" do
#  command "yum -y -q install globus-gram5"
#  user "root"
#  action :run  
#end
#execute "osg-ca-certs" do
#  command "yum -y -q install globus-gsi"
#  user "root"
#  action :run  
#end

cookbook_file "/tmp/globuspackages.tar.gz" do
  source "globuspackages.tar.gz"
  owner "vagrant"
end

execute "descomprimir globuspackages" do
  command "tar -xvzf globuspackages.tar.gz"
  user "vagrant"
  cwd "/tmp/"
  action :run  
end

execute "install gram5 gridftp gsi" do
  command "rpm -Uvh --quiet *.rpm"
  user "root"
  cwd "/tmp/globuspackages"
  action :run  
end
