include_recipe "confighost::getipadd"

if node[:use_share_folder]
	execute "append to hosts" do
		user "vagrant"
		#group "admin"
		cwd "/home/vagrant"
		command "cat /home/vagrant/hosts >> #{node[:slavedata][:path_share_folder]}/hosts"
		action :run
	end
else
	##enviando archivos de automatización de ips
	template "/home/vagrant/send_host_local.exp" do
		source "send_host_local.exp.rb"
		mode 0644
		owner "vagrant"
		#group "admin"
		variables(
			:ip_maquina_local => "#{node[:slavedata][:ip_maquina_local]}",
			:pass_maquina_local => "#{node[:slavedata][:pass_maquina_local]}",
			:user_maquina_local => "#{node[:slavedata][:user_maquina_local]}",
			:path_project_vagrant => "#{node[:slavedata][:path_project_vagrant]}"
		)
	end
	#enviar los host a la maquina local
	execute "send hosts local" do
		user "vagrant"
		#group "admin"
		cwd "/home/vagrant"
		command "expect send_host_local.exp"
		action :run
	end
end

