
#################################################################
#mantener los servicios levantados
#http://rm-rf.es/anadir-quitar-servicios-al-inicio-del-sistema-red-hat-centos/
# ver el archivo /etc/inittab

execute "chkconfig gram5" do
	command "chkconfig globus-gatekeeper on"
	user "root"
	cwd "/tmp"
	action :run
end	

execute "chkconfig globus-gridftp-server" do
	command "chkconfig globus-gridftp-server on"
	user "root"
	cwd "/tmp"
	action :run
end	

#execute "chkconfig globus-gridftp-sshftp" do
#	command "chkconfig globus-gridftp-sshftp on"
#	user "root"
#	cwd "/tmp"
#	action :run
#end	

#execute "chkconfig myproxy-server" do
#	command "chkconfig myproxy-server on"
#	user "root"
#	cwd "/tmp"
#	action :run
#end


