<?php

session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
header("Location: " . SITE_WEB . "/login/signin.php");
?>
