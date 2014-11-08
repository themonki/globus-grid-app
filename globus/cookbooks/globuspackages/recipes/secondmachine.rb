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
execute "gridftp" do
  command "yum -y -q install globus-gridftp"
  user "root"
  action :run  
end

execute "osg-ca-certs" do
  command "yum -y -q install globus-gsi"
  user "root"
  action :run  
end

#YA NO SE UTILIZA SE NECESITA EL GRAM5 PARA LA SEGUNDA MAQUINA
