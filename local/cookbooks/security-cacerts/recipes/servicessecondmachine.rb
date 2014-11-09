
#################################################################
#mantener los servicios levantados
#http://rm-rf.es/anadir-quitar-servicios-al-inicio-del-sistema-red-hat-centos/
# ver el archivo /etc/inittab

execute "chkconfig globus-gridftp-server" do
	command "chkconfig globus-gridftp-server on"
	user "root"
	cwd "/tmp"
	action :run
end
