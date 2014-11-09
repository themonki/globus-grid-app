#configuracion y levantamiento del servicio POSTGRESQL
##RECORDAR QUE ES NECESARIO ORGANIZAR LAS IPTABLES
##http://www.cyberciti.biz/tips/postgres-allow-remote-access-tcp-connection.html


class Chef
	include Extensions::Platform
end

if platform?("redhat", "centos", "fedora")
	if Extensions::Platform.amd64?
	
		cookbook_file "/tmp/pass.sql" do
			source "pass.sql"
			owner "postgres"
		end

		cookbook_file "/tmp/changepasspsql.exp" do
			source "changepasspsql.exp"
			owner "root"
		end

		execute "initdb psql" do
		command "service postgresql initdb"
			user "root"
			cwd "/tmp"
			action :run  
		end

		execute "chkconfig postgresql" do
			command "chkconfig postgresql on"
			user "root"
			cwd "/tmp"
			action :run  
		end

		execute "start psql" do
			command "service postgresql start"
			user "root"
			cwd "/tmp"
			action :run  
		end

		execute "pass sql" do
			command "su postgres -c 'psql -f /tmp/pass.sql'"
			user "root"
			cwd "/tmp"
			action :run  
		end

		execute "pass psql" do
			command "expect changepasspsql.exp -p dbpsglobus2013"
			user "root"
			cwd "/tmp"
			action :run  
		end

		execute "backups pg_hba.conf" do
			command "mv /var/lib/pgsql/data/pg_hba.conf /var/lib/pgsql/data/pg_hba.conf.old"
			user "root"
			cwd "/tmp"
			action :run  
		end

		execute "backups postgresql.conf" do
			command "mv /var/lib/pgsql/data/postgresql.conf /var/lib/pgsql/data/postgresql.conf.old"
			user "root"
			cwd "/tmp"
			action :run  
		end

		cookbook_file "/var/lib/pgsql/data/postgresql.conf" do
			source "postgresql.conf"
			owner "postgres"
			mode 0600
		end

		cookbook_file "/var/lib/pgsql/data/pg_hba.conf" do
			source "pg_hba.conf"
			owner "postgres"
			mode 0600
		end

		execute "restart psql" do
			command "service postgresql restart"
			user "root"
			cwd "/tmp"
			action :run  
		end
	end
end


