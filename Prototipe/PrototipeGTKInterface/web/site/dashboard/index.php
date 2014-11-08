<?php

session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
include_once( PWD_CONTROLADOR . '/login/Login.php' );
is_logged_in();
include_once(PWD_CONTROLADOR . '/templates/TemplateManager.php');
include_once(PWD_CONTROLADOR . '/dashboard/Dashboard.php');
include_once( PWD_CONTROLADOR . '/dashboard/TableUserJobs.php' );


$contenidoTableUserJobs = buildTableUserJobs(unserialize($_SESSION['user']));

$contenidoDashboard = new TemplateManager();
$contenidoDashboard->plantilla("dashboard");
$contenidoDashboard->asigna_variables(array(
    "SITE_PROTOTIPE" => SITE_PROTOTIPE,
    "MESSAGE_CLASS" => $message_class,
    "MESSAGE" => $message,
    "NAME_FILE" => $file,
    "TABLEJOBS" => $contenidoTableUserJobs,
    "FILE_CLASS" => $showFileForm,
    "JOB_CLASS" => $showJobForm
));

$contenidoEditarString = $contenidoDashboard->muestra();

$contenidoPrincipal = new TemplateManager();
$contenidoPrincipal->plantilla("principal");
$contenidoPrincipal->asigna_variables(array(
    "TITLE_PAGE" => "Dashboard",
    "SITE_PROTOTIPE" => SITE_PROTOTIPE,
    "SITE_WEB" => SITE_WEB,
    "NAME" => unserialize($_SESSION['user'])->getName(),
    "CONTAINER" => $contenidoEditarString
));
$contenidoPrincipalString = $contenidoPrincipal->muestra();
echo $contenidoPrincipalString;
?>
