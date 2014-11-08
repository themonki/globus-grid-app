<?php

/**
 * Carga la tabla que muestra los certificados del usuario y se indica cual es 
 * el certificado que esta usando actualmente el usuario en esta sesión.
 */
session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
//include_once( PWD_MODEL . '/ModelRelationUserCert.php' );
include_once( PWD_MODEL . '/ModelCert.php' );
//include_once( PWD_LOGICA . '/RelationUserCert.php' );
include_once( PWD_LOGICA . '/User.php' );
include_once( PWD_LOGICA . '/Cert.php' );

function printTableUserCerts($user) {
    echo buildTableUserCerts($user);
}

function buildTableUserCerts($user) {

    $modelCert = new ModelCert();
    $cert_user = new Cert();
    $cert_user->setIdUser($user->getId());
//    $modelRelationUserCert = new ModelRelationUserCert();
//    $relationUserCert = new RelationUserCert();
//    $relationUserCert->setIdUser($user->getId());

    $data = array();

    $headers = array(
        "",
        array("Id", "Serial", "Issue", "Used")
    );

    $data[] = $headers;

//    $result = $modelRelationUserCert->selectByIdUser($relationUserCert);
    $result = $modelCert->selectByIdUser($cert_user);
    foreach ($result as $cert) {
//    foreach ($result as $ruc) {
//        $modelCert = new ModelCert();
//        $certFind = new Cert();
//        $certFind->setId($ruc->getIdCert());
//        $cert = $modelCert->selectById($certFind);
        $certsData = array(
            isCertUsed($cert), //Es el css clase para dar formatos especiales a la row
            array(
                $cert->getId(),
                $cert->getSerial(),
                $cert->getIssue(),
                isCertUsed($cert)
            )
        );
        $data[] = $certsData;
    }

    $content = "\n<table id='main-table'>\n";
    $count = 0;
    foreach ($data as $row) {
        if ($count == 0) {
            $content .= "<thead>";
        } else if ($count == 1) {
            $content .= "<tbody>";
        }
        $styleLast = ($count != 0 && ($count % 5 == 0)) ? 'lastTableData' : ''; //número de paginas
        $content.= "\t<tr class='$row[0] $styleLast'>\n";
        if ($count == 0) {
            foreach ($row[1] as $d) {//carga los headers
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
        if ($count-1 == 0) {
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

function isCertUsed($cert) {
    if ($_SERVER["SSL_CLIENT_I_DN"] == $cert->getIssue()
            && $_SERVER["SSL_CLIENT_M_SERIAL"] == $cert->getSerial()) {
        return "selected";
    } else {
        return "";
    }
}

?>
