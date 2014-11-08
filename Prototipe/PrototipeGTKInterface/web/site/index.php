<?php

/**
 * PHP Simpe Login
 * @author Resalat Haque
 * @link http://www.w3bees.com/2013/02/php-simple-log-in-example.html
 */
session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
include_once( PWD_CONTROLADOR . '/login/Login.php' );

is_logged_in();

include_once(PWD_CONTROLADOR . '/templates/TemplateManager.php');

$contenidoInicial = new TemplateManager();
$contenidoInicial->plantilla("inicio");
$contenidoInicial->asigna_variables(array(
    "NAME" => unserialize($_SESSION['user'])->getName()
));
$contenidoInicialString = $contenidoInicial->muestra();

$contenidoPrincipal = new TemplateManager();
$contenidoPrincipal->plantilla("principal");
$contenidoPrincipal->asigna_variables(array(
    "TITLE_PAGE" => "Inicio",
    "SITE_PROTOTIPE" => SITE_PROTOTIPE,
    "SITE_WEB" => SITE_WEB,
    "NAME" => unserialize($_SESSION['user'])->getName(),
    "CONTAINER" => $contenidoInicialString
));
$contenidoPrincipalString = $contenidoPrincipal->muestra();
echo $contenidoPrincipalString;

?>