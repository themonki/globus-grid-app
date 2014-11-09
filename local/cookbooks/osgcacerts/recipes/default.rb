#
# Cookbook Name:: osgcacerts
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# https://twiki.grid.iu.edu/bin/view/Documentation/Release3/YumRpmBasics#Installation
#
#execute "osg-ca-certs" do
#  command "yum -y -q install osg-ca-certs"
#  user "root"
#  action :run  
#end

cookbook_file "/tmp/osgcacerts.tar.gz" do
  source "osgcacerts.tar.gz"
  owner "vagrant"
end

execute "descomprimir osgcacerts" do
  command "tar -xvzf osgcacerts.tar.gz"
  user "vagrant"
  cwd "/tmp/"
  action :run  
end

execute "install osgcacerts" do
  command "rpm -Uvh --quiet *.rpm"
  user "root"
  cwd "/tmp/osgcacerts"
  action :run  
end
