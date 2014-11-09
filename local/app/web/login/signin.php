<?php

/**
 * PHP Simpe Login
 * @author Resalat Haque
 * @link http://www.w3bees.com/2013/02/php-simple-log-in-example.html
 */
session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/app/controlador/config.php' );

include_once( PWD_CONTROLADOR . '/login/Signin.php' );

include_once(PWD_CONTROLADOR . '/templates/TemplateManager.php');
if ($_GET['value'] && $_GET['value']==3) {
    $msg = getErrorMSG($_GET['value']);
    $msgshow = "error";
}
$contenidoLogin = new TemplateManager();
$contenidoLogin->plantilla("signin");
$contenidoLogin->asigna_variables(array(
    "SITE_APP" => SITE_APP,
    "msg" => $msg,
    "msgshow" => $msgshow
));
$contenidoLoginString = $contenidoLogin->muestra();
echo $contenidoLoginString;
?>
