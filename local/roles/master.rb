name "master"
description "Rol inicial para el master"
run_list "recipe[confighost::hostname]",
	"recipe[confighost::hostconfiguremaster]",
	"recipe[preinstall]", "recipe[postgresql]",
	"recipe[postgresql::configure]",
	"recipe[apache]", "recipe[apache::configure]",
	"recipe[php]", "recipe[php::installdebug]",
	"recipe[repositories]","recipe[globususer]",
	"recipe[globuspackages]", "recipe[osgcacerts]",
	"recipe[security-cacerts::iptables]",
	"recipe[security-cacerts::services]"
