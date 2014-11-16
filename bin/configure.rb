#!/usr/bin/ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

require "rubygems"
require "json"
require 'fileutils'
#Cargar los valores de configuracion
env_file = File.dirname(__FILE__) + "/../etc/env.rb"
default_env_file = ENV['ENV_FILE']
require default_env_file != nil && File.exists?(default_env_file) ? default_env_file : env_file
DEF_PATH = File.dirname(__FILE__) + "/../local/nodes"
FileUtils.mkdir_p DEF_PATH

############ master.json
def master_json(path=DEF_PATH)
	master = {
		"host_name" => MACHINE_MASTER[:host_name],
		"hostslaves" => MACHINE_NAME_SLAVES,
		"alias" => MACHINE_MASTER[:alias],
		"use_share_folder" => USE_SHARE_FOLDER,
		"name"=> "master",
		"chef_environment" => "_default",
		"run_list"=> [
			"role[master]"
		]
	}
	#puts JSON.pretty_generate(master)
	File.open(path + "/master.json","w") do |f|
		f.write(JSON.pretty_generate(master))
	end
end

############ slavei.json
def slavei_json(path=DEF_PATH)
	MACHINE_SLAVES.each do |name, slave|
		slavei = {
			"host_name" => slave[:host_name],
			"alias" => slave[:alias],
			"use_share_folder" => USE_SHARE_FOLDER,
			"name"=> "slave",
			"chef_environment" => "_default",
			"run_list"=> [
				"role[slave]"
			]
		}
		#puts JSON.pretty_generate(slavei)
		File.open(path + "/" + name + ".json","w") do |f|
			f.write(JSON.pretty_generate(slavei))
		end
	end
end

############ master_initsimpleca.json
def master_initsimpleca_json(path=DEF_PATH)
	master_initsimpleca = {
		"slaves"=> MACHINE_NAME_SLAVES,
		"user_name" => MACHINE_MASTER[:user_name],
		"pass_user" => MACHINE_MASTER[:pass_user],
		"name" => MACHINE_MASTER[:name] ,
		"host_name" => MACHINE_MASTER[:host_name],
		"run_list"=> ["recipe[simpleca]" ]
	}
	#puts JSON.pretty_generate(master_initsimpleca)
	File.open(path + "/master_initsimpleca.json","w") do |f|
		f.write(JSON.pretty_generate(master_initsimpleca))
	end
end

############ slavei_initsimplecasecondmachine.json
def slavei_initsimplecasecondmachine_json(path=DEF_PATH)
	MACHINE_SLAVES.each do |name, slave|
		slavei_initsimplecasecondmachine = {
			"user_name" => slave[:user_name],
			"host_name" => slave[:host_name],
			"run_list"=> ["recipe[simpleca::secondmachine]" ]
		}
		#puts JSON.pretty_generate(slavei_initsimplecasecondmachine)
		File.open(path + "/" + name + "_initsimplecasecondmachine.json","w") do |f|
			f.write(JSON.pretty_generate(slavei_initsimplecasecondmachine))
		end
	end
end
############ master_signsimpleca.json
def master_signsimpleca_json(path=DEF_PATH)
	master_signsimpleca = {
		"slaves"=> MACHINE_NAME_SLAVES,
		"run_list"=> ["recipe[simpleca::signcerts]" ]
	}
	#puts JSON.pretty_generate(master_signsimpleca)
	File.open(path + "/master_signsimpleca.json","w") do |f|
		f.write(JSON.pretty_generate(master_signsimpleca))
	end
end
############ slavei_configcertnodes.json
def slavei_configcertnodes_json(path=DEF_PATH)
	MACHINE_SLAVES.each do |name, slave|
		slavei_configcertnodes = {
			"user_name" => slave[:user_name],
			"pass_user" => slave[:pass_user],
			"name" => slave[:name] ,
			"host_name_master" => MACHINE_MASTER[:host_name],
			"run_list"=> ["recipe[simpleca::configsecondmachine]" ]
		}
		#puts JSON.pretty_generate(slavei_configcertnodes)
		File.open(path + "/" + name + "_configcertnodes.json","w") do |f|
			f.write(JSON.pretty_generate(slavei_configcertnodes))
		end
	end
end

############ master_app.json
def master_app_json(path=DEF_PATH)
	master_app = {
		"run_list"=> ["recipe[configSSL]","recipe[database]", "recipe[app]" ]
	}
	#puts JSON.pretty_generate(master_app)
	File.open(path + "/master_app.json","w") do |f|
		f.write(JSON.pretty_generate(master_app))
	end
end

