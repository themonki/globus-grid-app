<?php

/**
 * PHP Simpe Login
 * @author Resalat Haque
 * @link http://www.w3bees.com/2013/02/php-simple-log-in-example.html
 */
/*
 * Database Configaration 
 * */

define('DB_HOST', 'localhost');
define('DB_USER', 'globus');
define('DB_PASSWORD', 'globus');
define('DB_NAME', 'globusdatabase');

/**
 * PATH PARA REDIRECCIONAR PAGINAS ENTRE OTRAS
 */
define('SITE_PROTOTIPE', '/PrototipeGTKInterface');

define('SITE_WEB', SITE_PROTOTIPE . '/web');

define('SITE_CONTROLADOR', SITE_PROTOTIPE . '/controlador');

define('SITE_PHPSECLIB', SITE_CONTROLADOR . '/phpseclib');

define('SITE_FACHADA', SITE_CONTROLADOR . '/fachada');

define('SITE_TEMPLEATE', SITE_PROTOTIPE . '/templates');

define('SITE_BASH_SCRIPTS', SITE_PROTOTIPE . '/scripts');

/**
 * PATH EN EL SERVIDOR PARA IMPORTACIONES ENTRE OTRAS
 */
define('PWD_PROTOTIPE', $_SERVER['DOCUMENT_ROOT'] . SITE_PROTOTIPE);

define('PWD_CONTROLADOR', PWD_PROTOTIPE . '/controlador');

define('PWD_PHPSECLIB', PWD_CONTROLADOR . '/phpseclib');

define('PWD_FACHADA', PWD_CONTROLADOR . '/fachada');

define('PWD_TEMPLEATE', PWD_PROTOTIPE . '/templates');

define('PWD_LOGICA', PWD_PROTOTIPE . '/logica');

define('PWD_MODEL', PWD_PROTOTIPE . '/model');

define('PWD_BASH_SCRIPTS', PWD_PROTOTIPE . '/scripts');

/**
 * Define variables para la zona horaria
 * En el servidor:
 * mv /etc/localtime /etc/localtime.bak
 * sudo ln -s /usr/share/zoneinfo/America/Bogota /etc/localtime
 */
//date('d \d\e F \d\e Y h:i:s A');
date_default_timezone_set('America/Bogota');
setlocale(LC_ALL, "es_ES");
?>