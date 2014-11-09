#
# https://help.ubuntu.com/8.04/serverguide/C/mysql.html
#
#http://dev.antoinesolutions.com/mysql

class Chef
	include Extensions::Platform
end

if platform?("redhat", "centos", "fedora")
	if Extensions::Platform.amd64?

		execute "sed" do
			user "root"
			cwd "/tmp"
			command "sed -e 's/^bind.*/bind-address = 172.19.0.2/' /etc/my.cnf > /tmp/my.cnf"
			action :run
		end

		execute "move my.cnf" do
			user "root"
			cwd "/tmp"
			command "mv /tmp/my.cnf /etc/my.cnf"
			action :run
		end
	
		execute "chkconfig mysql" do
			user "root"
			cwd "/tmp"
			command "chkconfig --level 23 mysqld on"
			action :run
		end

		execute "restart-mysql" do
			user "root"
			cwd "/tmp"
			command "/etc/init.d/mysqld restart"
			action :run
		end
  end
end
