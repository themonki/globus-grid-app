#instalacion offline de xdebug-2.2.3
class Chef
	include Extensions::Platform
end

if platform?("redhat", "centos", "fedora")
	if Extensions::Platform.amd64?

		cookbook_file "/tmp/xdebug.tar.gz" do
			source "xdebug.tar.gz"
			owner "vagrant"
		end
		
		cookbook_file "/tmp/xdebug_configure.txt" do
			source "xdebug_configure.txt"
			owner "vagrant"
		end

		execute "unpack xdebug" do
			command "tar -xvzf xdebug.tar.gz"
			user "vagrant"
			cwd "/tmp"
			action :run  
		end

		execute "run phpize" do
			command "phpize"
			user "root"
			cwd "/tmp/xdebug"
			action :run  
		end
		
		execute "run configure" do
			command "./configure --enable-xdebug"
			user "root"
			cwd "/tmp/xdebug"
			action :run  
		end
		
		execute "run make" do
			command "make"
			user "root"
			cwd "/tmp/xdebug"
			action :run  
		end
		
		execute "run make install" do
			command "make install"
			user "root"
			cwd "/tmp/xdebug"
			action :run  
		end
		
		execute "configure xdebug" do
			command "cat xdebug_configure.txt >> /etc/php.ini"
			user "root"
			cwd "/tmp"
			action :run  
		end
	end
end
