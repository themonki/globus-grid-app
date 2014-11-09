#
# Cookbook Name:: database
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "mkdir database" do
	command "mkdir -p /tmp/database"
	user "vagrant"
	cwd "/tmp"
	action :run
end

cookbook_file "/tmp/database/basedatos.sql" do
	source "basedatos.sql"
	owner "postgres"
	mode 0666
end

cookbook_file "/tmp/database/datamodel.sql" do
	source "datamodel.sql"
	owner "postgres"
	mode 0666
end

cookbook_file "/tmp/database/registros.sql" do
	source "registros.sql"
	owner "postgres"
	mode 0666
end

cookbook_file "/tmp/database/run-inicializardb.exp" do
	source "run-inicializardb.exp"
	owner "vagrant"
	mode 0666
end

execute "run inicializardb" do
	command "expect run-inicializardb.exp -pp dbpsglobus2013 -ps globus -s localhost -dp template1 -ds globusdatabase -pm /tmp/database/datamodel.sql	-pd /tmp/database/basedatos.sql -pr /tmp/database/registros.sql"
	user "vagrant"
	cwd "/tmp/database"
	action :run
end
