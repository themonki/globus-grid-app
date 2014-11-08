<?php

session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
include_once( PWD_CONTROLADOR . '/login/Login.php' );
is_logged_in();
include_once(PWD_CONTROLADOR . '/templates/TemplateManager.php');
include_once(PWD_CONTROLADOR . '/personal/Edit.php');


$contenidoEditar = new TemplateManager();
$contenidoEditar->plantilla("edit");
$contenidoEditar->asigna_variables(array(
    "MESSAGE_CLASS" => $message_class,
    "MESSAGE" => $message,
    "NAME" => unserialize($_SESSION['user'])->getName(),
    "EMAIL" => unserialize($_SESSION['user'])->getEmail()
));


$contenidoEditarString = $contenidoEditar->muestra();

$contenidoPrincipal = new TemplateManager();
$contenidoPrincipal->plantilla("principal");
$contenidoPrincipal->asigna_variables(array(
    "TITLE_PAGE" => "Editar Datos",
    "SITE_PROTOTIPE" => SITE_PROTOTIPE,
    "SITE_WEB" => SITE_WEB,
    "NAME" => unserialize($_SESSION['user'])->getName(),
    "CONTAINER" => $contenidoEditarString
));
$contenidoPrincipalString = $contenidoPrincipal->muestra();
echo $contenidoPrincipalString;
?>
