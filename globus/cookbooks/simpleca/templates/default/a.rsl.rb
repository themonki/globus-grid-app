&(rsl_substitution = (GRIDFTP_SERVER "gsiftp://<%= node[:host_name] %>:2811"))
 (executable=/bin/ls) (arguments=-alt /tmp/my_echo) 
 (file_stage_in = ($(GRIDFTP_SERVER)/bin/echo /tmp/my_echo)) 
 (file_clean_up=/tmp/my_echo)
