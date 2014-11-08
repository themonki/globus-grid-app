#
# Cookbook Name:: repositories
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
# 
# Documentation:
# https://twiki.grid.iu.edu/bin/view/Documentation/Release3/YumRpmBasics#Install_the_Yum_Repositories_req
#

cookbook_file "/tmp/epel-release-6-8.noarch.rpm" do
	source "epel-release-6-8.noarch.rpm"
	owner "vagrant"
end 

cookbook_file "/tmp/yum-plugin-priorities-1.1.30-14.el6.noarch.rpm" do
	source "yum-plugin-priorities-1.1.30-14.el6.noarch.rpm"
	owner "vagrant"
end

cookbook_file "/tmp/osg-el6-release-latest.rpm" do
	source "osg-el6-release-latest.rpm"
	owner "vagrant"
end

cookbook_file "/tmp/Globus-repo-config.centos-6-1.noarch.rpm" do
	source "Globus-repo-config.centos-6-1.noarch.rpm"
	owner "vagrant"
end

execute "EPEL repository" do
  #command "rpm -Uvh http://ftp-stud.hs-esslingen.de/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm"
  command "rpm -Uvh --quiet epel-release-6-8.noarch.rpm"
  user "root"
  cwd "/tmp"
  action :run
end

execute "yum-priorities" do
  #command "yum -y install yum-priorities"
  command "rpm -Uvh --quiet yum-plugin-priorities-1.1.30-14.el6.noarch.rpm"
  user "root"
  cwd "/tmp"
  action :run
end



execute "OSG repository" do
  #command "rpm -Uvh http://repo.grid.iu.edu/osg-el6-release-latest.rpm"
  command "rpm -Uvh --quiet osg-el6-release-latest.rpm"
  cwd "/tmp"
  user "root"
  action :run
end

#
# http://www.globus.org/toolkit/docs/5.2/5.2.2/admin/install/#q-prereq
#
#Tal vez no es necesario

execute "Globus repository" do
  #command "rpm -i http://www.globus.org/ftppub/gt5/5.2/stable/packages/rpm/centos/6/x86_64/Globus-repo-config.centos-6-1.noarch.rpm"
  command "rpm -i --quiet Globus-repo-config.centos-6-1.noarch.rpm"
  cwd "/tmp"
  user "root"
  action :run
end
