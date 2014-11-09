cookbook_file "/tmp/jdk-7u3-linux-x64.tar.gz" do
	source "jdk-7u3-linux-x64.tar.gz"
	mode 0600
	owner "root"
end
execute "uncompress jdk" do
	user "root"
	cwd "/usr/local"
	command "tar xfz /tmp/jdk-7u3-linux-x64.tar.gz"
	action :run
end
cookbook_file "/tmp/append2profile" do
	source "append2profile"
	mode 0600
	owner "root"
end
execute "cat profile" do
	user "root"
	cwd "/etc"
	command "cat /tmp/append2profile >> profile"
	action :run
end
execute "ln java" do
	user "root"
	command "ln -sf /usr/local/jdk1.7.0_03/bin/java /usr/bin/java"
	action :run
end
