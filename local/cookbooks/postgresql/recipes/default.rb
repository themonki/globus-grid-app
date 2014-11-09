##instalar postgres offline

class Chef
	include Extensions::Platform
end

if platform?("redhat", "centos", "fedora")
	if Extensions::Platform.amd64?

		cookbook_file "/tmp/postgresql.tar.gz" do
			source "postgresql.tar.gz"
			owner "vagrant"
		end

		execute "unpack postgresql" do
			command "tar -xvzf postgresql.tar.gz"
			user "vagrant"
			cwd "/tmp"
			action :run  
		end

		execute "install postgresql" do
			command "rpm -Uvh --force *.rpm"
			user "root"
			cwd "/tmp/postgresql"
			action :run  
		end
	end
end

