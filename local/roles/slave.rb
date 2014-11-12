name "slave"
description "Rol inicial para los slaves"
run_list "recipe[confighost::hostname]",
		"recipe[confighost::hostconfigurenode]",
		"recipe[preinstall]" ,"recipe[repositories]",
		"recipe[globususer]","recipe[globuspackages]",
		"recipe[security-cacerts::iptables]",
		"recipe[security-cacerts::servicessecondmachine]"
