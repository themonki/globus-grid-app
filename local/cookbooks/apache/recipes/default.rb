#instalacion offline de apache

class Chef
	include Extensions::Platform
end

if platform?("redhat", "centos", "fedora")
	if Extensions::Platform.amd64?

		cookbook_file "/tmp/apache.tar.gz" do
			source "apache.tar.gz"
			owner "vagrant"
		end

		execute "unpack apache" do
			command "tar -xvzf apache.tar.gz"
			user "vagrant"
			cwd "/tmp"
			action :run  
		end

		execute "install apache" do
			command "rpm -Uvh --force *.rpm"
			user "root"
			cwd "/tmp/apache"
			action :run  
		end
	end
end
