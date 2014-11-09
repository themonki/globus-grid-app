##instalar las dependencias necesarias para instalar globus
## solo para CentOS-6.3-x86_64-minimal
##esta receta se aplica solo al mg

class Chef
	include Extensions::Platform
end

if platform?("redhat", "centos", "fedora")
	if Extensions::Platform.amd64?

		cookbook_file "/tmp/reposPreinstall.tar.gz" do
			source "reposPreinstall.tar.gz"
			owner "vagrant"
		end

		execute "unpack reposPreinstall" do
			command "tar -xvzf reposPreinstall.tar.gz"
			user "vagrant"
			cwd "/tmp"
			action :run  
		end
		
		execute "ls reposPreinstall" do
			command "ls reposPreinstall"
			user "vagrant"
			cwd "/tmp"
			action :run  
		end

		execute "install dependencies" do
			command "rpm -Uvh --force *.rpm"
			user "root"
			cwd "/tmp/reposPreinstall/Pglobus-x86_64"
			action :run  
		end
	end
end



