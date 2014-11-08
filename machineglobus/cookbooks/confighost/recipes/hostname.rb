#cookbook_file "/etc/hosts" do
#	source "hosts"
#	mode 0755
#	owner "root"
#	group "admin"
#end

if platform?("ubuntu")
	execute "hostname-stop" do
		user "root"
		#group "admin"
		command "service hostname stop"
		action :run
		# http://help.opscode.com/discussions/problems/732-bash-non-zero-exit-status
		returns 1
	end

	template "/etc/hostname" do
		source "hostname.rb"
		mode 0644
		owner "root"
		#group "admin"
		variables(
			:host_name => "#{node[:host_name]}"
		)
	end

	execute "hostname-start" do
		user "root"
		#group "admin"
		command "service hostname start"
		action :run
	end
end


if platform?("redhat", "centos", "fedora")
	#modificacion del hostname de la red
	execute "backup /etc/sysconfig/network" do
		user "root"
		cwd "/tmp"
		command "cp /etc/sysconfig/network /etc/sysconfig/network_backup"
		action :run
	end

	template "/tmp/network" do
		source "network.rb"
		mode 0755
		owner "root"
		variables(
			:host_name => "#{node[:host_name]}"
		)
	end

	execute "move network" do
		user "root"
		cwd "/tmp"
		command "mv network /etc/sysconfig/network"
		action :run
	end

	###################################################################

	execute "hostname update" do
		user "root"
		cwd "/tmp"
		command "hostname #{node[:host_name]}"
		action :run
	end
end
