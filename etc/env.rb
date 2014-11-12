# -*- mode: ruby -*-
# vi: set ft=ruby :

require "rubygems"
require "json"
config_file = "/globus-grid-app/etc/config.json"
if !File.exists?(config_file)
	config_file = File.dirname(__FILE__) + "/config.json"
end
default_config_file = ENV['CONFIG_FILE']
data = default_config_file != nil && File.exists?(default_config_file) ? JSON.parse(File.read(default_config_file)) : JSON.parse(File.read(config_file))

#Definición de las variables para montar la aplicacion
USE_SHARE_FOLDER = data["USE_SHARE_FOLDER"]
MACHINE_MASTER = {
	:node_name => data["MACHINE_MASTER"]["node_name"],
	:vm_name => data["MACHINE_MASTER"]["vm_name"],
	:ip => data["MACHINE_MASTER"]["ip"],
	:host_name => data["MACHINE_MASTER"]["host_name"],
	:alias => data["MACHINE_MASTER"]["alias"],
	:user_name => data["MACHINE_MASTER"]["user_name"],
	:pass_user => data["MACHINE_MASTER"]["pass_user"],
	:name => data["MACHINE_MASTER"]["name"]
	}
MACHINE_SLAVES = {}
data["MACHINE_SLAVES"].each do |name, slave|
	MACHINE_SLAVES[name] = {}
	slave.each do |key, value|
		if key.eql?"node_name"
			MACHINE_SLAVES[name][:node_name]=value
		elsif key.eql?"vm_name"
			MACHINE_SLAVES[name][:vm_name]=value
		elsif key.eql?"ip"
			MACHINE_SLAVES[name][:ip]=value
		elsif key.eql?"host_name"
			MACHINE_SLAVES[name][:host_name]=value
		elsif key.eql?"alias"
			MACHINE_SLAVES[name][:alias]=value
		elsif key.eql?"user_name"
			MACHINE_SLAVES[name][:user_name]=value
		elsif key.eql?"pass_user"
			MACHINE_SLAVES[name][:pass_user]=value
		elsif key.eql?"name"
			MACHINE_SLAVES[name][:name]=value
		else 
			MACHINE_SLAVES[name][key]=value
		end
	end
end
MACHINE_NAME_SLAVES = []
MACHINE_SLAVES.each do |name, slave|
	MACHINE_NAME_SLAVES << slave[:alias]
end

#puts MACHINE_NAME_SLAVES

#print MACHINE_MASTER[:node_name]
#print "\n"

#MACHINE_SLAVES.each do |name, slave|
#	print slave[:ip]
#	print "\n"
#end

#print MACHINE_SLAVES["slave1"][:host_name]
#print "\n"

#MACHINE_NAME_SLAVES.each do |name|
#	print name
#	print "\n"
#end

#MACHINE_SLAVES = {
#	'slave1' => {
#		:node_name => "mgwn1",
#		:vm_name => "globus-client1",
#		:ip => "172.18.0.22",
#		:host_name => "mgwm1.globustest.org",
#		:alias => "mgwn1"
#	}
#}

