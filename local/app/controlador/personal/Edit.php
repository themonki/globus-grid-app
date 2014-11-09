<?php

session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/app/controlador/config.php' );
include_once( PWD_MODEL . '/ModelUser.php' );
include_once( PWD_LOGICA . '/User.php' );
include_once ( PWD_CONTROLADOR . '/login/Login.php' );
$message_class = "none";
$message = "";
if (isset($_POST) && isset($_POST['name']) && trim($_POST['name']) !="") {
    $name = $_POST['name'];
    $password = $_POST['passwordNew']; // encriptado
    $modelUser = new ModelUser();
    $user = $modelUser->selectById(unserialize($_SESSION['user']));

    $user->setName($name);
    if (isset($password) && $password != '') {
        $user->setPassword(md5($password));
    }

    $result = $modelUser->updateById($user);

    if (isset($result) && $result > 0) {
        $message = "Datos actualizados correctamente.";
        $message_class = "success";
        $user = $modelUser->selectById($user);
        setting_Session($user, NULL);
    } else {
        //error
        $message = "Error al actualizar los datos.";
        $message_class = "error";
    }
}
?>
