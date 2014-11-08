
##instalando chef para evitar el prepare


#http://wiki.opscode.com/display/chef/Recipes
#http://www.ruby-doc.org/gems/docs/c/chef-extensions-0.4.0/Chef/Extensions/Platform.html
#http://docs.opscode.com/chef/dsl_recipe.html
#http://wiki.opscode.com/display/chef/Libraries
#http://opscode.com/chef/install.sh
#https://www.opscode.com/chef/download?v=10.16.6&prerelease=false&p=el&pv=6&m=x86_64 La version a instalar de 64 para red hat
#https://www.opscode.com/chef/download?v=10.16.6&prerelease=false&p=el&pv=6&m=i686 para la de 32 bits para red hat
#https://www.opscode.com/chef/download?v=&prerelease=false&p=el&pv=6&m=x86_64 para la version mas reciente para red hat
#http://www.opscode.com/chef/download?v=&prerelease=false&p=ubuntu&pv=12.04&m=i686 para ubuntu 12.04 de 32
#http://www.opscode.com/chef/download?v=&prerelease=false&p=ubuntu&pv=12.04&m=x86_64 para ubuntu 12.04 de 64

class Chef
	include Extensions::Platform
end

if platform?("redhat", "centos", "fedora")
	if Extensions::Platform.amd64?
		#cookbook_file "/tmp/chef-10.16.6-1.el6.x86_64.rpm" do
		#	source "chef-10.16.6-1.el6.x86_64.rpm"
		#	owner "root"
		#end
		cookbook_file "/tmp/chef-11.16.4-1.el6.x86_64.rpm" do
			source "chef-11.16.4-1.el6.x86_64.rpm"
			owner "root"
		end
	end
	if Extensions::Platform.i386?
		#cookbook_file "/tmp/chef-10.16.6-1.el6.i686.rpm" do
		#	source "chef-10.16.6-1.el6.i686.rpm"
		#	owner "root"
		#end
		cookbook_file "/tmp/chef-11.16.4-1.el6.i686.rpm" do
			source "chef-11.16.4-1.el6.i686.rpm"
			owner "root"
		end
	end
	execute "install chef" do
		user "root"
		cwd "/tmp"
		command "rpm -Uvh --quiet chef-*.rpm"
		action :run
	end
end

if platform?("ubuntu")
	if Extensions::Platform.amd64?
		#cookbook_file "/tmp/chef_11.4.0-1.ubuntu.11.04_x86_64.deb" do
		#	source "chef_11.4.0-1.ubuntu.11.04_x86_64.deb"
		#	owner "root"
		#end
		cookbook_file "/tmp/chef_11.16.4-1_amd64.deb" do
			source "chef_11.16.4-1_amd64.deb"
			owner "root"
		end
	end
	if Extensions::Platform.i386?
		#cookbook_file "/tmp/chef_11.4.0-1.ubuntu.11.04_i386.deb" do
		#	source "chef_11.4.0-1.ubuntu.11.04_i386.deb"
		#	owner "root"
		#end
		cookbook_file "/tmp/chef_11.16.4-1_i386.deb" do
			source "chef_11.16.4-1_i386.deb"
			owner "root"
		end
	end
	execute "install chef" do
		user "root"
		cwd "/tmp"
		command "dpkg -i chef_*.deb"
		action :run
	end
end

