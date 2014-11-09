#############################
# http://lifeofageekadmin.com/install-tomcat-7-java-1-7-centos-6-rhel-6/
# http://seriousbirder.com/blogs/how-to-install-tomcat-7-on-centos-6/
# Install Tomcat 7 on /opt
#
#############################


cookbook_file "/etc/init.d/tomcat-inst1" do
	source "tomcat-inst1"
	mode 0755
	owner "root"
end

cookbook_file "/tmp/apache-tomcat-7.tar.gz" do
	source "apache-tomcat-7.tar.gz"
	mode 0600
	owner "root"
end

cookbook_file "/tmp/tomcat-users.xml" do
	source "tomcat-users.xml"
	mode 0600
	owner "root"
end

#tomcat-inst1 para multiples instancias
execute "mkdir /opt/tomcat/tomcat-inst1" do
	user "root"
	cwd "/tmp"
	command "mkdir -p /opt/tomcat/tomcat-inst1"
	action :run
end


execute "tar apache-tomcar.tar.gz" do
	user "root"
	cwd "/opt/tomcat/tomcat-inst1"
	command "tar -xvzf /tmp/apache-tomcat-7.tar.gz"
	action :run
end

execute "ls tomcat-current" do
	user "root"
	cwd "/opt/tomcat/tomcat-inst1"
	command "ln -sf apache-tomcat-7 tomcat-current"
	action :run
end

execute "create user tomcat" do
	user "root"
	cwd "/opt/tomcat/tomcat-inst1"
	command 'useradd -u 520 -c "Tomcat Service Account" -d /opt/tomcat -m -s /bin/bash tomcat'
	action :run
end

execute "chown tomcat" do
	user "root"
	cwd "/opt"
	command "chown -R tomcat:tomcat tomcat"
	action :run
end

execute "chkconfig tomcat" do
	user "root"
	cwd "/opt"
	command "chkconfig --levels 345 tomcat-inst1 on"
	action :run
end


execute "backup tomcat-users" do
	user "root"
	cwd "/opt/tomcat/tomcat-inst1/tomcat-current/conf"
	command "mv tomcat-users.xml tomcat-users.xml.orig"
	action :run
end

execute "mv tomcat-users new" do
	user "root"
	cwd "/opt/tomcat/tomcat-inst1/tomcat-current/conf"
	command "mv /tmp/tomcat-users.xml ."
	action :run
end

execute "chown tomcat-user.xml" do
	user "root"
	cwd "/opt/tomcat/tomcat-inst1/tomcat-current/conf"
	command "chown -R tomcat:tomcat tomcat-users.xml"
	action :run
end

execute "start tomcat" do
	user "root"
	cwd "/tmp"
	command "/etc/init.d/tomcat-inst1 start"
	action :run
end





