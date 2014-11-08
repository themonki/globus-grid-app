
#enviar a globus en mg2 el hostcert_request.pem
node[:slaves].each do |slave|
	execute "enviar requesthost" do
		command "scp vagrant@#{slave}:/tmp/hostcert_request.pem /tmp/#{slave}-hostcert_request.pem"
		user "vagrant"
		cwd "/tmp"
		action :run
	end
end

#enviar los certs user de vagrant
node[:slaves].each do |slave|
	execute "sign cert #{slave}" do
		command "sudo -H -E -u globus expect run-grid-ca-sign.exp -p globus -in #{slave}-hostcert_request.pem -out #{slave}-hostsigned.pem -f /tmp/configserver.conf"
		user "vagrant"
		cwd "/tmp"
		action :run
	end
end

#enviar el los certs user de vagrant
node[:slaves].each do |slave|
	execute "scp cert #{slave}" do
		command "scp #{slave}-hostsigned.pem vagrant@#{slave}:/tmp/hostsigned.pem"
		user "vagrant"
		cwd "/tmp"
		action :run
	end
end
