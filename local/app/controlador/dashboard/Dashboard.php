<?php

session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/app/controlador/config.php' );
include_once ( PWD_CONTROLADOR . '/login/Login.php' );
include_once( PWD_LOGICA . '/Job.php' );
include_once( PWD_MODEL . '/ModelJob.php' );
include_once( PWD_LOGICA . '/User.php' );
include_once( PWD_CONTROLADOR . '/jobSubmission/JobManager.php' );
include_once( PWD_CONTROLADOR . '/utils/DateManager.php' );

$message_class = "none";
$message = "";
$showFileForm = "show";
$showJobForm = "hide";
if (isset($_FILES["fileRSL"]) && isset($_FILES["fileRSL"]["name"]) && trim($_FILES["fileRSL"]["name"]) !== "") {
    if ($_FILES["fileRSL"]["error"] > 0) {
        $message_class = "error";
        $message = "Error al cargar el archivo: " . $_FILES["fileRSL"]["error"];
    } else {
        $file = "/tmp/" . $_FILES["fileRSL"]["name"];
        move_uploaded_file($_FILES["fileRSL"]["tmp_name"], $file);
        $jobManager = new JobManager();
        $result = $jobManager->exe_parse_job($file);
        if (is_Error($result)) {
            //Eliminar archivo
            unlink($file);
            $message_class = "error";
            $message = "Se encontro el siguiente error en el archivo: " . nl2br($result);
        } else {
            //Reacomodar el metodo de tal forma que se almacene el archivo rsl si uno quiere recuperarlo
            $message_class = "success";
            $message = "Se cargo el archivo: " . $_FILES["fileRSL"]["name"];
            $showFileForm = "hide";
            $showJobForm = "show";
        }
    }
}

if (isset($_POST) && isset($_POST['nameJob']) && isset($_POST['nameFile']) && trim($_POST['nameFile']) !== "") {
    $jobManager = new JobManager();
    $result = $jobManager->exe_send_job($_POST["nameFile"], (($_POST['selectJobManager'] == "") ? NULL : $_POST['selectJobManager']));
    if (is_Error($result) || !(strpos($result, 'http') !== false)) {
        $message_class = "error";
        $message = "" . nl2br($result);
    } else {
        $modelJob = new ModelJob();
        $job = $modelJob->selectNextId();
        $job->setName($_POST['nameJob']);
        $job->setIdUser(unserialize($_SESSION['user'])->getId());
        $job->setPath($_POST['nameFile']);
        $job->setDate();
        $job->setContact($result);
        $modelJob->insertId($job);
        $message_class = "success";
        $message = "Job Enviado. id =  " . $job->getId() . ", name = " . $job->getName() . ", contact = " . nl2br($result);
        $showFileForm = "show";
        $showJobForm = "hide";
    }
}

if (isset($_POST) && isset($_POST['deleteButton'])) {

    $jobManager = new JobManager();
    $parse = str_replace(array("\t", "\n", "\r"), "", $_POST["contactJob"]);
    $result = $jobManager->exe_cancel_job($parse);
    if (is_Error($result)) {
        $message_class = "error";
        $message = "" . nl2br($result);
    } else {
        $modelJob = new ModelJob();
        $job = new Job();
        $job->setId($_POST["idJob"]);
        $jobResult = $modelJob->selectById($job);
        $message_class = "success";
        $message = "Job Cancelado. id =  " . $jobResult->getId() . ", name = " . $jobResult->getName() . ", contact = " . $jobResult->getContact();
    }
}

/**
 * Indica si el resultado del job es un error
 * 
 * @param type $result el resultado del job a analizar
 * @return type bool true si contiene error
 */
function is_Error($result) {
    $value = strtoupper($result);
    return strpos($value, 'ERROR') !== false || strpos($value, 'FAIL') !== false;
}

?>
