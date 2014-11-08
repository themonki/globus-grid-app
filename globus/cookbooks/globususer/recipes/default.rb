#
# Cookbook Name:: globususer
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
user "globus" do
  home "/home/globus"
  shell "/bin/bash"
  supports :manage_home => true
end