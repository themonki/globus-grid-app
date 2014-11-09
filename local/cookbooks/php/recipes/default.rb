#instalacion offline de php

class Chef
	include Extensions::Platform
end

if platform?("redhat", "centos", "fedora")
	if Extensions::Platform.amd64?

		cookbook_file "/tmp/php.tar.gz" do
			source "php.tar.gz"
			owner "vagrant"
		end

		execute "unpack php" do
			command "tar -xvzf php.tar.gz"
			user "vagrant"
			cwd "/tmp"
			action :run  
		end

		execute "install php" do
			command "rpm -Uvh --force *.rpm"
			user "root"
			cwd "/tmp/php"
			action :run  
		end
	end
end
