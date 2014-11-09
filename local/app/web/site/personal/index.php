<?php
session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/app/controlador/config.php' );
include_once( PWD_CONTROLADOR . '/login/Login.php' );
is_logged_in();
include_once( PWD_CONTROLADOR . '/personal/TableUserCerts.php' );
include_once(PWD_CONTROLADOR . '/templates/TemplateManager.php');

$contenidoTableUserCerts = buildTableUserCerts(unserialize($_SESSION['user']));
$contenidoInicial = new TemplateManager();
$contenidoInicial->plantilla("profile");
$contenidoInicial->asigna_variables(array(
    "SITE_APP" => SITE_APP,
    "NAME" => unserialize($_SESSION['user'])->getName(),
    "EMAIL" => unserialize($_SESSION['user'])->getEmail(),
    "TABLEUSERCERTS" => $contenidoTableUserCerts
));
$contenidoInicialString = $contenidoInicial->muestra();

$contenidoPrincipal = new TemplateManager();
$contenidoPrincipal->plantilla("principal");
$contenidoPrincipal->asigna_variables(array(
    "TITLE_PAGE" => "Perfil",
    "SITE_APP" => SITE_APP,
    "SITE_WEB" => SITE_WEB,
    "NAME" => unserialize($_SESSION['user'])->getName(),
    "CONTAINER" => $contenidoInicialString
));
$contenidoPrincipalString = $contenidoPrincipal->muestra();
echo $contenidoPrincipalString;

?>
