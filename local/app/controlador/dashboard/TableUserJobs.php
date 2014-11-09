<?php

/**
 * Carga la tabla que muestra los jobs enviados por el usuario y que estan 
 * almacenados en la base de datos.
 */
session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/app/controlador/config.php' );
include_once( PWD_MODEL . '/ModelJob.php' );
include_once( PWD_LOGICA . '/User.php' );
include_once( PWD_LOGICA . '/Job.php' );
include_once( PWD_CONTROLADOR . '/utils/DateManager.php' );

function printTableUserJobs($user) {
    echo buildTableUserJobs($user);
}

function buildTableUserJobs($user) {

    $modelJob = new ModelJob();
    $job_user = new Job();
    $job_user->setIdUser($user->getId());
    $data = array();

    $headers = array(
        "",
        array("Id", "Name", "Date Submission", "Status", "Actions")
    );

    $data[] = $headers;

    $result = $modelJob->selectByIdUserOrderByDate($job_user);
    foreach ($result as $job) {

        $status = str_replace(array("\t", "\n"), "", getStatus($job->getContact()));
        $formActions = getFormActions($job->getId(), $job->getContact(), $status !== 'DONE');

        $jobsData = array(
            '', //Es el css clase para dar formatos especiales a la row
            array(
                $job->getId(),
                $job->getName(),
                DateManager::format_Date($job->getDate(), DateManager::format_date_time_advance),
                $status,
                $formActions
            )
        );
        $data[] = $jobsData;
    }
    //no se sabe pero no aparece el form en el primero  por eso el getFormActions
    $content = getFormActions() . "\n<table id='main-table'>\n";
    $count = 0;
    foreach ($data as $row) {

        if ($count == 0) {
            $content .= "<thead>";
        } else if ($count == 1) {
            $content .= "<tbody>";
        }
        $styleLast = ($count != 0 && ($count % 5 == 0)) ? 'lastTableData' : ''; //número de paginas
        $content.= "\t<tr class='$row[0] $styleLast'>\n";
        if ($count == 0) {//carga los headers
            foreach ($row[1] as $d) {
                $content.= "\t\t<th>\n";
                $content.= "\t\t\t$d\n";
                $content.= "\t\t</th>\n";
            }
            $count++;
        } else if ($count < (count($data))) {//carga los datos
            foreach ($row[1] as $d) {
                $content.= "\t\t<td>\n";
                $content.= "\t\t\t$d\n";
                $content.= "\t\t</td>\n";
            }
            $count++;
        }
        $content.= "\t</tr>\n";
        if ($count - 1 == 0) {
            $content .= "</thead>";
        } else if ($count == sizeof($data)) {
            $content .= "</tbody>";
        }
    }
    if (count($result) <= 0) {
        $numCols = count($data[0][1]);
        $content.= "\t<tr class='noFound'>\n";
        $content.= "\t\t<td colspan='" . $numCols . "'>\n";
        $content.= "\t\t\tNo se encontraron registros.\n";
        $content.= "\t\t</td>\n";
        $content.= "\t</tr>\n";
    }

    $content.= "</table>\n";
    return $content;
}

/**
 * Devulve un formulario para que sea utitilzado para las acciones.
 * @param type $id
 * @param type $contact
 * @return type 
 */
function getFormActions($id = 0, $contact = 0, $cancel = true) {
    if ($id == 0) {//no se sabe pero no aparece el form en el primero
        $formSubmenu = "\n<form class='formActions' method='POST'>\n";
        $formSubmenu .="\t<input type='hidden' value = '" . $id . "' />\n";
        $formSubmenu .="\t<input style='display:none;' class='buttonAction buttonContact' type='button' value=''/>\n";
        $formSubmenu .= "</form>\n";
        return $formSubmenu;
    } else {
        $formSubmenu = "\n<form class='formActions' method='POST'>\n";
        $formSubmenu .="\t<input type='hidden' name='idJob' value = '" . $id . "' />\n";
        $formSubmenu .="\t<input type='hidden' name='contactJob' value = '" . str_replace(array("\t", "\r", "\n"), "", $contact) . "' />\n";
        $formSubmenu .="\t<div class='buttonAction buttonContact tooltip' name='contactButton' >\n";
        $formSubmenu .="\t\t<span>\n\t\t\t<strong>Job Contact: </strong>\n\t\t\t" . str_replace(array("\t", "\r", "\n"), "", $contact) . "\n";
        $formSubmenu .="\t\t</span>\n\t</div>\n";
        if ($cancel == true) {
            $formSubmenu .="\t<input class='buttonAction buttonCancel' name='deleteButton' type='submit' value=''/>\n";
        }
        $formSubmenu .= "</form>\n";
        return $formSubmenu;
    }
}

function getStatus(
$contact = 0) {
    $jobManager = new JobManager();
    $parse = str_replace(array("\t", "\r", "\n"), "", $contact);
    $result = $jobManager->exe_status_job($parse);
    return $result;
}

?>
