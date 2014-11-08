####################################################################################################
##para la maquina mg despues de ejecutar la second machine aunque puede que no sea necesario
#dado que se ejcuta el setup-simpleca que usa el myproxy
#hacer un script como vagrant en el ****mg****
#sudo -H -E -u myproxy myproxy-admin-addservice -c "mgwn1.globustest.org" -l mgwn1
#resultado:
#Enter PEM pass phrase:
#Verifying - Enter PEM pass phrase:

#To sign the request
#please enter the password for the CA key: 

#The new signed certificate is at: /var/lib/myproxy/.globus/simpleCA/newcerts/03.pem

#using storage directory /var/lib/myproxy
#Credential stored successfully
#Certificate subject is:
#/O=Grid/OU=GlobusTest/OU=simpleCA-mg.globustest.org/OU=local/CN=mgwn1.globustest.org

######################################################################################################

cookbook_file "/tmp/run-addservice.exp" do
	source "run-addservice.exp"
	owner "vagrant"
end

execute "expect run-addservice" do
	command "expect run-addservice.exp -u #{node[:user_name]} -pu #{node[:pass_user]} -pg globus -h #{node[:host_name]}"
	user "vagrant"
	cwd "/tmp/"
	action :run
end
