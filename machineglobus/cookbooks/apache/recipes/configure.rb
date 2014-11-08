#configuracion y levantamiento del servicio apache


class Chef
	include Extensions::Platform
end

if platform?("redhat", "centos", "fedora")
	if Extensions::Platform.amd64?
		execute "start apache" do
			command "service httpd start"
			user "root"
			cwd "/tmp"
			action :run  
		end

		execute "chkconfig apache" do
			command "chkconfig --level 23 httpd on"
			user "root"
			cwd "/tmp"
			action :run  
		end
	end
end

execute "stop iptables" do
	command "service iptables stop"
	user "root"
	cwd "/tmp"
	action :run  
end

execute "chkconfig iptables" do
	command "chkconfig iptables off"
	user "root"
	cwd "/tmp"
	action :run  
end
