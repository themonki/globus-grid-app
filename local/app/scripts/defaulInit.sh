#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

source /var/www/html/app/scripts/inicializar-variables.sh -k /home/vagrant/.globus/userkey.pem -o /home/vagrant/.globus/proxy -c /home/vagrant/.globus/usercert.pem
