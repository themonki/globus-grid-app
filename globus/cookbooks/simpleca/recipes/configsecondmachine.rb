

#enviar el firmado
execute "eliminar certificado host" do
	command "rm -rf /etc/grid-security/hostcert.pem"
	user "root"
	cwd "/tmp"
	action :run
end

#enviar el firmado
execute "copiar certificado host firmado" do
	command "cp /tmp/hostsigned.pem /etc/grid-security/hostcert.pem"
	user "root"
	cwd "/tmp"
	action :run
end

#agregar al gridmapfile
#grid-mapfile-add-entry -dn /O=Grid/OU=GlobusTest/OU=simpleCA-mg.globustest.org/CN=host/mgwn1.globustest.org -ln vagrant
execute "gridmapfile vagrant" do
	command "grid-mapfile-add-entry -dn /O=Grid/OU=GlobusTest/OU=simpleCA-#{node[:host_name_master]}/OU=local/CN=#{node[:name]} -ln #{node[:user_name]}"
	user "root"
	cwd "/tmp"
	action :run
end
