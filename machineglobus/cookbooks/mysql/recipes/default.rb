#instalacion offline de mysql


class Chef
	include Extensions::Platform
end

if platform?("redhat", "centos", "fedora")
	if Extensions::Platform.amd64?
		cookbook_file "/tmp/mysql.tar.gz" do
			source "mysql.tar.gz"
			owner "vagrant"
		end

		execute "unpack mysql" do
			command "tar -xvzf mysql.tar.gz"
			user "vagrant"
			cwd "/tmp"
			action :run
		end

		execute "install mysql" do
			command "rpm -Uvh --force *.rpm"
			user "root"
			cwd "/tmp/mysql"
			action :run
		end
	end
end
